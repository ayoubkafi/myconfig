/* user and group to drop privileges to */
static const char *user  = "ayoub";
static const char *group = "ayoub";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#5E81AC",   /* during input */
	[FAILED] = "#ff0000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
