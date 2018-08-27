From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] build: declare that libf2fs_format uses the
 blkid library
Date: Mon, 27 Aug 2018 12:04:59 -0400
Message-ID: <20180827160459.GH2311@thunk.org>
References: <20180824072632.23608-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fuK0v-0000l7-Mf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 16:05:13 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuK0o-00Fm7T-Vg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 16:05:13 +0000
Content-Disposition: inline
In-Reply-To: <20180824072632.23608-1-tytso@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Ping?  This bug was noticed when I was repackaging f2fs-tools for
Debian.  The problem is that libf2fs_format references the blkid
library, and Debian's shared library auditing tools noticed the
missing library dependency.

					- Ted

On Fri, Aug 24, 2018 at 03:26:32AM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  mkfs/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index 32996ba..cae2f93 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -12,7 +12,7 @@ lib_LTLIBRARIES = libf2fs_format.la
>  libf2fs_format_la_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c
>  libf2fs_format_la_CFLAGS = -DWITH_BLKDISCARD
>  libf2fs_format_la_CPPFLAGS = -I$(top_srcdir)/include
> -libf2fs_format_la_LDFLAGS = -luuid -L$(top_builddir)/lib -lf2fs \
> +libf2fs_format_la_LDFLAGS = -lblkid -luuid -L$(top_builddir)/lib -lf2fs \
>  	-version-info $(FMT_CURRENT):$(FMT_REVISION):$(FMT_AGE)
>  
>  install-exec-hook:
> -- 
> 2.18.0.rc0
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
