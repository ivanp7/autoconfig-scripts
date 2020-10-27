#ifdef _WINDOW_CONFIG

/* default window dimensions (overwritten via -g option): */
enum {
	WIN_WIDTH  = 800,
	WIN_HEIGHT = 600
};

/* colors and font are configured with 'background', 'foreground' and
 * 'font' X resource properties.
 * See X(7) section Resources and xrdb(1) for more information.
 */

#endif
#ifdef _IMAGE_CONFIG

/* levels (in percent) to use when zooming via '-' and '+':
 * (first/last value is used as min/max zoom level)
 */
static const float zoom_levels[] = {
    1.0, 5.0, 12.5, 25.0, 33.3, 40.0, 50.0, 66.6, 75.0, 80.0, 90.0, 
    100.0, 125.0, 150.0, 175.0, 200.0, 250.0, 300.0, 350.0, 400.0, 
    500.0, 600.0, 700.0, 800.0, 900.0, 1000.0
};

/* default slideshow delay (in sec, overwritten via -S option): */
enum { SLIDESHOW_DELAY = 5 };

/* gamma correction: the user-visible ranges [-GAMMA_RANGE, 0] and
 * (0, GAMMA_RANGE] are mapped to the ranges [0, 1], and (1, GAMMA_MAX].
 * */
static const double GAMMA_MAX   = 10.0;
static const int    GAMMA_RANGE = 32;

/* command i_scroll pans image 1/PAN_FRACTION of screen width/height */
static const int PAN_FRACTION = 5;

/* if false, pixelate images at zoom level != 100%,
 * toggled with 'a' key binding
 */
static const bool ANTI_ALIAS = true;

/* if true, use a checkerboard background for alpha layer,
 * toggled with 'A' key binding
 */
static const bool ALPHA_LAYER = false;

#endif
#ifdef _THUMBS_CONFIG

/* thumbnail sizes in pixels (width == height): */
static const int thumb_sizes[] = { 32, 64, 96, 128, 160, 192, 224, 256, 384, 512 };

/* thumbnail size at startup, index into thumb_sizes[]: */
static const int THUMB_SIZE = 4;

#endif
#ifdef _MAPPINGS_CONFIG

/* keyboard mappings for image and thumbnail mode: */
static const keymap_t keys[] = {
	/* modifiers    key               function              argument */
	{ 0,            24, /*XK_q,*/             g_quit,               None },
	{ 0,            36, /*XK_Return,*/        g_switch_mode,        None },
	{ 0,            41, /*XK_f,*/             g_toggle_fullscreen,  None },
	{ 0,            56, /*XK_b,*/             g_toggle_bar,         None },
	{ ControlMask,  53, /*XK_x,*/             g_prefix_external,    None },
	{ 0,            42, /*XK_g,*/             g_first,              None },
	{ ShiftMask,    42, /*XK_G,*/             g_n_or_last,          None },
	{ 0,            27, /*XK_r,*/             g_reload_image,       None },
	{ ShiftMask,    40, /*XK_D,*/             g_remove_image,       None },
	{ ControlMask,  43, /*XK_h,*/             g_scroll_screen,      DIR_LEFT },
	{ ControlMask,  113, /*XK_Left,*/          g_scroll_screen,      DIR_LEFT },
	{ ControlMask,  44, /*XK_j,*/             g_scroll_screen,      DIR_DOWN },
	{ ControlMask,  116, /*XK_Down,*/          g_scroll_screen,      DIR_DOWN },
	{ ControlMask,  45, /*XK_k,*/             g_scroll_screen,      DIR_UP },
	{ ControlMask,  111, /*XK_Up,*/            g_scroll_screen,      DIR_UP },
	{ ControlMask,  46, /*XK_l,*/             g_scroll_screen,      DIR_RIGHT },
	{ ControlMask,  114, /*XK_Right,*/         g_scroll_screen,      DIR_RIGHT },
	{ ShiftMask,    21, /*XK_plus,*/          g_zoom,               +1 },
	{ 0,            86, /*XK_KP_Add,*/        g_zoom,               +1 },
	{ 0,            20, /*XK_minus,*/         g_zoom,               -1 },
	{ 0,            82, /*XK_KP_Subtract,*/   g_zoom,               -1 },
	{ 0,            58, /*XK_m,*/             g_toggle_image_mark,  None },
	{ ShiftMask,    58, /*XK_M,*/             g_mark_range,         None },
	{ ControlMask,  58, /*XK_m,*/             g_reverse_marks,      None },
	{ ControlMask,  30, /*XK_u,*/             g_unmark_all,         None },
	{ ShiftMask,    57, /*XK_N,*/             g_navigate_marked,    +1 },
	{ ShiftMask,    33, /*XK_P,*/             g_navigate_marked,    -1 },
	{ ShiftMask,    34, /*XK_braceleft,*/     g_change_gamma,       -1 },
	{ ShiftMask,    35, /*XK_braceright,*/    g_change_gamma,       +1 },
	{ ControlMask,  42, /*XK_g,*/             g_change_gamma,        0 },

	{ 0,            43, /*XK_h,*/             t_move_sel,           DIR_LEFT },
	{ 0,            113, /*XK_Left,*/          t_move_sel,           DIR_LEFT },
	{ 0,            44, /*XK_j,*/             t_move_sel,           DIR_DOWN },
	{ 0,            116, /*XK_Down,*/          t_move_sel,           DIR_DOWN },
	{ 0,            45, /*XK_k,*/             t_move_sel,           DIR_UP },
	{ 0,            111, /*XK_Up,*/            t_move_sel,           DIR_UP },
	{ 0,            46, /*XK_l,*/             t_move_sel,           DIR_RIGHT },
	{ 0,            114, /*XK_Right,*/         t_move_sel,           DIR_RIGHT },
	{ ShiftMask,    27, /*XK_R,*/             t_reload_all,         None },

	{ 0,            57, /*XK_n,*/             i_navigate,           +1 },
	{ 0,            57, /*XK_n,*/             i_scroll_to_edge,     DIR_LEFT | DIR_UP },
	{ 0,            65, /*XK_space,*/         i_navigate,           +1 },
	{ 0,            33, /*XK_p,*/             i_navigate,           -1 },
	{ 0,            33, /*XK_p,*/             i_scroll_to_edge,     DIR_LEFT | DIR_UP },
	{ 0,            22, /*XK_BackSpace,*/     i_navigate,           -1 },
	{ 0,            35, /*XK_bracketright,*/  i_navigate,           +10 },
	{ 0,            34, /*XK_bracketleft,*/   i_navigate,           -10 },
	{ ControlMask,  15, /*XK_6,*/             i_alternate,          None },
	{ ControlMask,  57, /*XK_n,*/             i_navigate_frame,     +1 },
	{ ControlMask,  33, /*XK_p,*/             i_navigate_frame,     -1 },
	{ ControlMask,  65, /*XK_space,*/         i_toggle_animation,   None },
	{ 0,            43, /*XK_h,*/             i_scroll,             DIR_LEFT },
	{ 0,            113, /*XK_Left,*/          i_scroll,             DIR_LEFT },
	{ 0,            44, /*XK_j,*/             i_scroll,             DIR_DOWN },
	{ 0,            116, /*XK_Down,*/          i_scroll,             DIR_DOWN },
	{ 0,            45, /*XK_k,*/             i_scroll,             DIR_UP },
	{ 0,            111, /*XK_Up,*/            i_scroll,             DIR_UP },
	{ 0,            46, /*XK_l,*/             i_scroll,             DIR_RIGHT },
	{ 0,            114, /*XK_Right,*/         i_scroll,             DIR_RIGHT },
	{ ShiftMask,    43, /*XK_H,*/             i_scroll_to_edge,     DIR_LEFT },
	{ ShiftMask,    44, /*XK_J,*/             i_scroll_to_edge,     DIR_DOWN },
	{ ShiftMask,    45, /*XK_K,*/             i_scroll_to_edge,     DIR_UP },
	{ ShiftMask,    46, /*XK_L,*/             i_scroll_to_edge,     DIR_RIGHT },
	{ 0,            21, /*XK_equal,*/         i_set_zoom,           100 },
	{ 0,            25, /*XK_w,*/             i_fit_to_win,         SCALE_DOWN },
	{ ShiftMask,    25, /*XK_W,*/             i_fit_to_win,         SCALE_FIT },
	{ 0,            26, /*XK_e,*/             i_fit_to_win,         SCALE_WIDTH },
	{ ShiftMask,    26, /*XK_E,*/             i_fit_to_win,         SCALE_HEIGHT },
	{ ShiftMask,    59, /*XK_less,*/          i_rotate,             DEGREE_270 },
	{ ShiftMask,    60, /*XK_greater,*/       i_rotate,             DEGREE_90 },
	{ ShiftMask,    61, /*XK_question,*/      i_rotate,             DEGREE_180 },
	{ ShiftMask,    51, /*XK_bar,*/           i_flip,               FLIP_HORIZONTAL },
	{ ShiftMask,    20, /*XK_underscore,*/    i_flip,               FLIP_VERTICAL },
	{ 0,            38, /*XK_a,*/             i_toggle_antialias,   None },
	{ ShiftMask,    38, /*XK_A,*/             i_toggle_alpha,       None },
	{ 0,            39, /*XK_s,*/             i_slideshow,          None },
};

/* mouse button mappings for image mode: */
static const button_t buttons[] = {
	/* modifiers    button            function              argument */
	{ 0,            1,                i_cursor_navigate,    None },
	{ 0,            2,                i_drag,               DRAG_RELATIVE },
	{ 0,            3,                g_switch_mode,        None },
	{ 0,            4,                g_zoom,               +1 },
	{ 0,            5,                g_zoom,               -1 },
};

#endif
