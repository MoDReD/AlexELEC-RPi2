################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="cairo"
PKG_VERSION="1.12.16"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://cairographics.org/"
PKG_URL="http://cairographics.org/releases/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib freetype fontconfig libpng pixman"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libs"
PKG_SHORTDESC="cairo: Multi-platform 2D graphics library"
PKG_LONGDESC="Cairo is a vector graphics library with cross-device output support. Currently supported output targets include the X Window System and in-memory image buffers. PostScript and PDF file output is planned. Cairo is designed to produce identical output on all output media while taking advantage of display hardware acceleration when available."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET=" \
	ac_cv_func_posix_getpwuid_r=yes \
	glib_cv_stack_grows=no \
	glib_cv_uscore=no \
	ac_cv_func_strtod=yes \
	ac_fsusage_space=yes \
	fu_cv_sys_stat_statfs2_bsize=yes \
	ac_cv_func_closedir_void=no \
	ac_cv_func_getloadavg=no \
	ac_cv_lib_util_getloadavg=no \
	ac_cv_lib_getloadavg_getloadavg=no \
	ac_cv_func_getgroups=yes \
	ac_cv_func_getgroups_works=yes \
	ac_cv_func_chown_works=yes \
	ac_cv_have_decl_euidaccess=no \
	ac_cv_func_euidaccess=no \
	ac_cv_have_decl_strnlen=yes \
	ac_cv_func_strnlen_working=yes \
	ac_cv_func_lstat_dereferences_slashed_symlink=yes \
	ac_cv_func_lstat_empty_string_bug=no \
	ac_cv_func_stat_empty_string_bug=no \
	vb_cv_func_rename_trailing_slash_bug=no \
	ac_cv_have_decl_nanosleep=yes \
	jm_cv_func_nanosleep_works=yes \
	gl_cv_func_working_utimes=yes \
	ac_cv_func_utime_null=yes \
	ac_cv_have_decl_strerror_r=yes \
	ac_cv_func_strerror_r_char_p=no \
	jm_cv_func_svid_putenv=yes \
	ac_cv_func_getcwd_null=yes \
	ac_cv_func_getdelim=yes \
	ac_cv_func_mkstemp=yes \
	utils_cv_func_mkstemp_limitations=no \
	utils_cv_func_mkdir_trailing_slash_bug=no \
	jm_cv_func_gettimeofday_clobber=no \
	gl_cv_func_working_readdir=yes \
	jm_ac_cv_func_link_follows_symlink=no \
	utils_cv_localtime_cache=no \
	ac_cv_struct_st_mtim_nsec=no \
	gl_cv_func_tzset_clobber=no \
	gl_cv_func_getcwd_null=yes \
	gl_cv_func_getcwd_path_max=yes \
	ac_cv_func_fnmatch_gnu=yes \
	am_getline_needs_run_time_check=no \
	am_cv_func_working_getline=yes \
	gl_cv_func_mkdir_trailing_slash_bug=no \
	gl_cv_func_mkstemp_limitations=no \
	ac_cv_func_working_mktime=yes \
	jm_cv_func_working_re_compile_pattern=yes \
	ac_use_included_regex=no \
	gl_cv_c_restrict=no \
    --enable-shared \
    --disable-static \
	--enable-trace=no \
	--enable-interpreter=no \
    --disable-silent-rules \
    --disable-directfb \
    --disable-gtk-doc \
    --enable-largefile \
    --enable-ft \
    --enable-fc \
    --enable-ps \
    --enable-pdf \
    --enable-svg \
    --disable-vg \
    --enable-png \
    --disable-gl \
    --disable-gobject \
    --disable-glesv2 \
    --disable-xlib \
    --disable-xcb \
    --without-x \
    --disable-xlib-xrender \
    --enable-script \
    --disable-tee \
    --disable-xml \
    --disable-gcov \
    --disable-valgrind \
    --disable-qt \
    --disable-quartz \
    --disable-quartz-font \
    --disable-quartz-image \
    --disable-win32 \
    --disable-win32-font \
    --disable-skia \
    --disable-os2 \
    --disable-beos \
    --disable-cogl \
    --disable-drm \
    --disable-drm-xr \
    --disable-gallium \
    --disable-xcb-drm \
    --disable-egl \
    --disable-glx \
    --disable-wgl \
    --disable-test-surfaces \
    --enable-pthread \
    --enable-atomic \
    --disable-full-testing \
    --disable-symbol-lookup \
    --enable-some-floating-point \
    --with-gnu-ld"
