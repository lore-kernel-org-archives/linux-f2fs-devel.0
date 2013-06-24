From: Ryan Wang <openspace.wang@gmail.com>
Subject: [f2fs-dev] configure failed even through libuuid is installed
Date: Mon, 24 Jun 2013 13:35:14 +0800
Message-ID: <CAPxxNQk+bmtbhM9E9BiNtGqLfhPO1f1Ju02cYj5KPPz5qRkB9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <openspace.wang@gmail.com>) id 1UqzQv-0007AR-Uk
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Jun 2013 05:35:22 +0000
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UqzQt-0002cl-Sp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Jun 2013 05:35:21 +0000
Received: by mail-oa0-f46.google.com with SMTP id h1so11449972oag.19
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 23 Jun 2013 22:35:14 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk.kim@samsung.com

Hi,


I wanted to try f2fs on my box, but failed at the installation phase.

OS: RHEL6.4
auto tools:
          autoconf-2.69.tar.gz
          automake-1.13.tar.gz
          libtool-2.4.2.tar.gz

libuuid is installed:
========================
/usr/include/uuid
/usr/include/uuid/uuid.h
/usr/lib64/libuuid.a
/usr/lib64/libuuid.so
/usr/lib64/pkgconfig/uuid.pc
/usr/share/man/man3/uuid.3.gz
/usr/share/man/man3/uuid_clear.3.gz
/usr/share/man/man3/uuid_compare.3.gz
/usr/share/man/man3/uuid_copy.3.gz
/usr/share/man/man3/uuid_generate.3.gz
/usr/share/man/man3/uuid_generate_random.3.gz
/usr/share/man/man3/uuid_generate_time.3.gz
/usr/share/man/man3/uuid_is_null.3.gz
/usr/share/man/man3/uuid_parse.3.gz
/usr/share/man/man3/uuid_time.3.gz
/usr/share/man/man3/uuid_unparse.3.gz

./configure outputs:
========================
# autoreconf --install
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `build-aux'.
libtoolize: copying file `build-aux/ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
libtoolize: copying file `m4/libtool.m4'
libtoolize: copying file `m4/ltoptions.m4'
libtoolize: copying file `m4/ltsugar.m4'
libtoolize: copying file `m4/ltversion.m4'
libtoolize: copying file `m4/lt~obsolete.m4'
configure.ac:50: installing 'build-aux/config.guess'
configure.ac:50: installing 'build-aux/config.sub'
configure.ac:36: installing 'build-aux/install-sh'
configure.ac:36: installing 'build-aux/missing'
lib/Makefile.am: installing 'build-aux/depcomp'
[root@benlp1 f2fs-tools]# ./configure
checking for .git... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking how to create a pax tar archive... gnutar
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for fcntl.h... yes
checking for mntent.h... yes
checking for stdlib.h... (cached) yes
checking for string.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/ioctl.h... yes
checking for sys/mount.h... yes
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking build system type... powerpc64-unknown-linux-gnu
checking host system type... powerpc64-unknown-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /bin/sed
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1966080
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert powerpc64-unknown-linux-gnu file names to
powerpc64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert powerpc64-unknown-linux-gnu file names to
toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... no
checking if : is a manifest tool... no
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld -m elf64ppc) supports
shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for ldconfig... /sbin/ldconfig
./configure: line 12339: syntax error near unexpected token `libuuid,'
./configure: line 12339: `PKG_CHECK_MODULES(libuuid, uuid)'


Regards,
Ryan

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
