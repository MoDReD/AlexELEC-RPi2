################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mysql"
PKG_VERSION="5.1.67"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mysql.com"
PKG_URL="http://app.nidc.kr/mysql/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib ncurses libressl mysql:host"
PKG_PRIORITY="optional"
PKG_SECTION="database"
PKG_SHORTDESC="mysql: A database server"
PKG_LONGDESC="MySQL is a SQL (Structured Query Language) database server. SQL is the most popular database language in the world. MySQL is a client server implementation that consists of a server daemon mysqld and many different client programs/libraries."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

TARGET_CFLAGS="$TARGET_CFLAGS -fPIC -DPIC -I$SYSROOT_PREFIX/usr/include/ncurses"

PKG_CONFIGURE_OPTS_HOST="--with-zlib-dir=$ROOT/$TOOLCHAIN"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_c_stack_direction=-1 \
                           ac_cv_sys_restartable_syscalls=yes \
                           --localstatedir=/storage/database \
                           --with-unix-socket-path=/var/tmp/mysql.socket \
                           --with-tcp-port=3306 \
                           --enable-static \
                           --disable-shared \
						   --with-ssl=$SYSROOT_PREFIX/usr/lib \
                           --with-low-memory \
                           --enable-largefile \
                           --with-big-tables \
                           --with-mysqld-user=root \
                           --with-extra-charsets=all \
                           --with-charset=utf8 \
                           --with-collation=utf8_unicode_ci \
                           --with-pthread \
                           --with-named-thread-libs=-lpthread \
                           --enable-thread-safe-client \
                           --enable-assembler \
                           --enable-local-infile \
                           --without-debug \
                           --without-docs \
                           --without-man \
                           --with-readline \
                           --without-libwrap \
                           --without-pstack \
                           --without-embedded-server \
                           --without-libedit \
                           --with-query-cache \
                           --without-plugin-partition \
                           --without-plugin-daemon_example \
                           --without-plugin-ftexample \
                           --without-plugin-archive \
                           --without-plugin-blackhole \
                           --without-plugin-example \
                           --without-plugin-federated \
                           --without-plugin-ibmdb2i \
                           --without-plugin-innobase \
                           --without-plugin-innodb_plugin \
                           --without-plugin-ndbcluster"

make_host() {
  make -C include my_config.h
  make -C mysys libmysys.a
  make -C strings libmystrings.a
  make -C dbug factorial
  make -C vio libvio.a
  make -C dbug libdbug.a
  make -C regex libregex.a
  make -C sql gen_lex_hash
  make -C scripts comp_sql
  make -C extra comp_err
}

makeinstall_host() {
  cp -PR dbug/factorial $ROOT/$TOOLCHAIN/bin/mysql-factorial
  cp -PR sql/gen_lex_hash $ROOT/$TOOLCHAIN/bin/mysql-gen_lex_hash
  cp -PR scripts/comp_sql $ROOT/$TOOLCHAIN/bin/mysql-comp_sql
  cp -PR extra/comp_err $ROOT/$TOOLCHAIN/bin/mysql-comp_err
}

post_makeinstall_target() {
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$SYSROOT_PREFIX/usr/include/mysql\'|" scripts/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$SYSROOT_PREFIX/usr/lib/mysql\'|" scripts/mysql_config
  cp scripts/mysql_config $SYSROOT_PREFIX/usr/bin
  ln -sf $SYSROOT_PREFIX/usr/bin/mysql_config $ROOT/$TOOLCHAIN/bin/mysql_config

  for i in `ls -d $SYSROOT_PREFIX/usr/lib/mysql/*.a`; do 
    ln -v -sf $i $SYSROOT_PREFIX/usr/lib
  done

  rm -rf $INSTALL/usr/mysql-test
  rm -rf $INSTALL/usr/sql-bench

  cp -P $PKG_DIR/scripts/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config/mysql
    cp $PKG_DIR/config/my.cnf $INSTALL/usr/config/mysql
  cp -P $PKG_DIR/config/mysql_secure_installation.sql $INSTALL/usr/share/mysql
}

post_install() {
  mkdir -p $INSTALL/usr/config/mysql/conf.d
  ln -sf /storage/.config/mysql $INSTALL/etc/mysql

  enable_service mysqld.service
}