#include <X11/XF86keysym.h>
/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "cascadiacode:size=13" , "JetBrainsMonoMediumNerdFont:size=14"};
//static const char dmenufont[]       = "monospace:size=10";
//
static const char COLOR_NORM_FG[]     = "#bbbbbb";
static const char COLOR_NORM_BG[]     = "#2E3440";
static const char COLOR_NORM_BORDER[] = "#434C5E";

static const char COLOR_SEL_FG[]      = "#bbbbbb";
static const char COLOR_SEL_BG[]      = "#5E81AC";
static const char COLOR_SEL_BORDER[]  = "#bbbbbb";

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { COLOR_NORM_FG, COLOR_NORM_BG , COLOR_NORM_BORDER },
	[SchemeSel]  = { COLOR_SEL_FG , COLOR_SEL_BG  , COLOR_SEL_BORDER  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "firefox",  NULL,       NULL,       1 << 1,       0,           -1 },
  { "vlc",      NULL,       NULL,       1 << 3,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	//{ "[]=",      tile },    /* first entry is default */
	//{ "><>",      NULL },    /* no layout function means floating behavior */
	//{ "[M]",      monocle },
  
  { "[0]",      tile },    /* first entry is default */
  { "[1]",      NULL },    /* no layout function means floating behavior */
  { "[2]",      monocle },
};

/* key definitions */
#define CTRL    ControlMask
#define ALTKEY  Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */

static const char *dmenucmd[]         = { "dmenu_run", "-p", "Run :", NULL };
static const char *termcmd[]          = { "term", NULL };
static const char *lockcmd[]          = { "slock", NULL };
static const char *shutdowncmd[]      = { "Ashutdown", NULL };
static const char *rebootcmd[]        = { "Areboot", NULL };
/* brightness */
static const char *brightness_up[]    = { "xbacklight", "-inc", "5", NULL };
static const char *brightness_down[]  = { "xbacklight", "-dec", "5", NULL };
/* audio */
static const char *audio_up[]         = { "pamixer", "-i", "5", NULL };
static const char *audio_down[]       = { "pamixer", "-d", "5", NULL };
static const char *audio_mute[]       = { "pamixer", "-t", NULL };
/* browser */
//static const char *browser[]          = { "firefox", NULL };
//static const char *messenger[]        = { "firefox", "--new-tab", "gmail.com", NULL };

static Key keys[] = {
  /* modifier                     key        function        argument */
  { MODKEY,                       XK_d,       spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_Return,  spawn,          {.v = termcmd } },
  
  { MODKEY,                       XK_b,       togglebar,      {0} },
  
  { MODKEY,                       XK_j,       focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,       focusstack,     {.i = -1 } },
  
  { MODKEY,                       XK_i,       incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_o,       incnmaster,     {.i = -1 } },
  
  { MODKEY,                       XK_h,       setmfact,       {.f = -0.01} },
  { MODKEY,                       XK_l,       setmfact,       {.f = +0.01} },
  
  { MODKEY|ShiftMask,             XK_Return,  zoom,           {0} },
  { MODKEY,                       XK_Tab,     view,           {0} },
  { MODKEY,                       XK_q,       killclient,     {0} },
  
  { MODKEY,                       XK_t,       setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,       setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,       setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_space,   setlayout,      {0} },
  
  { MODKEY|ShiftMask,             XK_space,   togglefloating, {0} },
  { MODKEY,                       XK_agrave,       view,           {.ui = ~0 } },
  { MODKEY|ShiftMask,             XK_agrave,       tag,            {.ui = ~0 } },
  
  { MODKEY,                       XK_comma,   focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period,  focusmon,       {.i = +1 } },
  
  { MODKEY|ShiftMask,             XK_comma,   tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period,  tagmon,         {.i = +1 } },
  
  { ALTKEY,                       XK_j,       setgaps,        {.i = -2 } },
  { ALTKEY,                       XK_k,       setgaps,        {.i = +2 } },
  { ALTKEY,                       XK_agrave,  setgaps,        {.i = 0  } },
  
  TAGKEYS(                        XK_ampersand,                       0)
  TAGKEYS(                        XK_eacute,                          1)
  TAGKEYS(                        XK_quotedbl,                        2)
  TAGKEYS(                        XK_apostrophe,                      3)
  TAGKEYS(                        XK_parenleft,                       4)
  TAGKEYS(                        XK_minus,                           5)
  TAGKEYS(                        XK_egrave,                          6)
  TAGKEYS(                        XK_underscore,                      7)
  TAGKEYS(                        XK_ccedilla,                        8)
  //TAGKEYS(                        XK_agrave,                          9)
  
  { ALTKEY|CTRL,             XK_q,      quit,            {0} },
  { ALTKEY|CTRL,             XK_s,      spawn,           {.v = shutdowncmd } },
  { ALTKEY|CTRL,             XK_r,      spawn,           {.v = rebootcmd } },

  { MODKEY,                       XK_x,  spawn,          {.v = lockcmd } },

  //{ 0,                       XF86XK_WWW,                spawn,          {.v = browser } },
  //{ 0,                       XF86XK_Messenger,          spawn,          {.v = messenger } },
  { 0,                       XF86XK_AudioRaiseVolume,   spawn,          {.v = audio_up } },
  { 0,                       XF86XK_AudioLowerVolume,   spawn,          {.v = audio_down } },
  { 0,                       XF86XK_AudioMute,          spawn,          {.v = audio_mute } },
  { 0,                       XF86XK_MonBrightnessUp,    spawn,          {.v = brightness_up } },
  { 0,                       XF86XK_MonBrightnessDown,  spawn,          {.v = brightness_down } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

