From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs-tool-1.7.0 build error
Date: Fri, 29 Jul 2016 10:22:26 -0700
Message-ID: <20160729172226.GA9499@jaegeuk>
References: <e617e773-35c8-8eff-e7fe-0c1c798c1213@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bTBUb-00063A-D6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Jul 2016 17:22:37 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bTBUa-0002yE-6J
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Jul 2016 17:22:37 +0000
Content-Disposition: inline
In-Reply-To: <e617e773-35c8-8eff-e7fe-0c1c798c1213@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Perfect Gentleman <perfect007gentleman@gmail.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hello,

I've fixed up right away.

Thanks,

On Fri, Jul 29, 2016 at 11:22:24AM +0700, Perfect Gentleman wrote:
>  >>> Source configured.
>  >>> Compiling source in 
> /tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999 ...
> make -j7
> make  all-recursive
> make[1]: Entering directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999'
> Making all in man
> make[2]: Entering directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999/man'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999/man'
> Making all in lib
> make[2]: Entering directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999/lib'
> /bin/sh ../libtool  --tag=CC   --mode=compile x86_64-pc-linux-gnu-gcc 
> -DHAVE_CONFIG_H -I. -I..  -I../include -Wall -march=native -mtune=native 
> -O2 -pipe -fomit-frame-pointer -fno-stack-protector -c -o 
> libf2fs_la-libf2fs.lo `test -f 'libf2fs.c' || echo './'`libf2fs.c
> /bin/sh ../libtool  --tag=CC   --mode=compile x86_64-pc-linux-gnu-gcc 
> -DHAVE_CONFIG_H -I. -I..  -I../include -Wall -march=native -mtune=native 
> -O2 -pipe -fomit-frame-pointer -fno-stack-protector -c -o 
> libf2fs_la-libf2fs_io.lo `test -f 'libf2fs_io.c' || echo './'`libf2fs_io.c
> /bin/sh ../libtool  --tag=CC   --mode=compile x86_64-pc-linux-gnu-gcc 
> -DHAVE_CONFIG_H -I. -I..  -I../include -Wall -march=native -mtune=native 
> -O2 -pipe -fomit-frame-pointer -fno-stack-protector -c -o 
> libf2fs_la-zbc.lo `test -f 'zbc.c' || echo './'`zbc.c
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c zbc.c  -fPIC -DPIC -o 
> .libs/libf2fs_la-zbc.o
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c libf2fs_io.c  -fPIC -DPIC 
> -o .libs/libf2fs_la-libf2fs_io.o
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c libf2fs.c  -fPIC -DPIC -o 
> .libs/libf2fs_la-libf2fs.o
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c libf2fs_io.c -o 
> libf2fs_la-libf2fs_io.o >/dev/null 2>&1
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c zbc.c -o libf2fs_la-zbc.o 
>  >/dev/null 2>&1
> libtool: compile:  x86_64-pc-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.. 
> -I../include -Wall -march=native -mtune=native -O2 -pipe 
> -fomit-frame-pointer -fno-stack-protector -c libf2fs.c -o 
> libf2fs_la-libf2fs.o >/dev/null 2>&1
> /bin/sh ../libtool  --tag=CC   --mode=link x86_64-pc-linux-gnu-gcc -Wall 
> -march=native -mtune=native -O2 -pipe -fomit-frame-pointer 
> -fno-stack-protector -version-info 0:2:1 -Wl,-O1 -Wl,--as-needed -o 
> libf2fs.la -rpath /lib64 libf2fs_la-libf2fs.lo libf2fs_la-libf2fs_io.lo 
> libf2fs_la-zbc.lo
> libtool:   error: AGE '1' is greater than the current interface number '0'
> libtool:   error: '0:2:1' is not valid version information
> make[2]: *** [Makefile:411: libf2fs.la] Error 1
> make[2]: Leaving directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999/lib'
> make[1]: *** [Makefile:415: all-recursive] Error 1
> make[1]: Leaving directory 
> '/tmp/portage/sys-fs/f2fs-tools-9999/work/f2fs-tools-9999'
> make: *** [Makefile:347: all] Error 2
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
