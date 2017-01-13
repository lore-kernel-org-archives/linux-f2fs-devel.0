From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] Add a configure option for SELinux support
Date: Fri, 13 Jan 2017 11:05:35 -0800
Message-ID: <20170113190535.GA1301@jaegeuk.local>
References: <20170113080202.GA5766@rbox.ravenex.space>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cS7AZ-00031D-6w
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jan 2017 19:05:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cS7AX-0005Fg-LT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jan 2017 19:05:47 +0000
Content-Disposition: inline
In-Reply-To: <20170113080202.GA5766@rbox.ravenex.space>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sergey Kvachonok <ravenexp@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Merged, thank you for the patch.

On 01/13, Sergey Kvachonok wrote:
> ./configure --without-selinux :: unconditionally disable SELinux support
> 
> ./configure --with-selinux :: enable SELinux support and abort if
> libselinux is not found
> 
> When no configure option is specified the current libselinux
> autodetection behaviour is preserved.
> 
> Signed-off-by: Sergey Kvachonok <ravenexp@gmail.com>
> ---
>  configure.ac | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8781af1..b855afe 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -45,6 +45,12 @@ AC_CHECK_HEADERS_ONCE([
>  	sys/mount.h
>  ])
>  
> +# Test configure options.
> +AC_ARG_WITH([selinux],
> +	AS_HELP_STRING([--without-selinux],
> +	  [Ignore presence of libselinux and disable selinux support])
> +)
> +
>  # Checks for programs.
>  AC_PROG_CC
>  AC_PROG_LIBTOOL
> @@ -54,9 +60,19 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
>  
>  # Checks for libraries.
>  PKG_CHECK_MODULES([libuuid], [uuid])
> -PKG_CHECK_MODULES([libselinux], [libselinux],
> +
> +AS_IF([test "x$with_selinux" != "xno"],
> +	[PKG_CHECK_MODULES([libselinux], [libselinux],
> +	                   [have_selinux=yes], [have_selinux=no])],
> +	[have_selinux=no]
> +)
> +
> +AS_IF([test "x$have_selinux" = "xyes"],
>  	[AC_DEFINE([HAVE_LIBSELINUX], [1], [Use libselinux])],
> -	[AC_MSG_NOTICE([libselinux not found])])
> +	[AS_IF([test "x$with_selinux" = "xyes"],
> +		[AC_MSG_ERROR([selinux support requested but libselinux not found])]
> +	)]
> +)
>  
>  # Checks for header files.
>  AC_CHECK_HEADERS([linux/fs.h linux/blkzoned.h fcntl.h mntent.h stdlib.h string.h \
> -- 
> 2.11.0
> 
> 
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
