From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: Add several media formats + exe
Date: Sun, 15 Jul 2018 11:51:06 +0900
Message-ID: <20180715025106.GF11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180714180805.11633-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1feX82-0004kP-Jt
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 02:51:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1feX81-008mQB-5k
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 15 Jul 2018 02:51:18 +0000
Content-Disposition: inline
In-Reply-To: <20180714180805.11633-1-rosenp@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

I queued this.
Thanks, Rosen.

On 07/14, Rosen Penev wrote:
> These media formats are currently in use.
> 
> exe is useful if storing various Windows utilities on the drive.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  mkfs/f2fs_format.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 1a2deae..5245d68 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -43,6 +43,9 @@ const char *media_ext_lists[] = {
>  	"png",
>  	"avi",
>  	"divx",
> +	"m4a",
> +	"m4v",
> +	"m4p",
>  	"mp4",
>  	"mp3",
>  	"3gp",
> @@ -56,15 +59,19 @@ const char *media_ext_lists[] = {
>  	"wmx",
>  	"svi",
>  	"wvx",
> +	"wv",
>  	"wm",
>  	"mpg",
>  	"mpe",
>  	"rm",
>  	"ogg",
> +	"opus",
> +	"flac",
>  	"jpeg",
>  	"video",
>  	"apk",	/* for android system */
>  	"so",	/* for android system */
> +	"exe",
>  	NULL
>  };
>  
> -- 
> 2.17.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
