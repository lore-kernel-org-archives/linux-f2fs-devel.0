From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Wed, 17 Apr 2019 17:41:04 +0800
Message-ID: <c91943d3-8dbb-ca08-97c8-6e2d37392e70@huawei.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hGh49-0004Yf-GH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:41:17 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGh48-00CG9c-1U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:41:17 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id ECCC6EFD2E0F45D4ED16
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 17:41:07 +0800 (CST)
In-Reply-To: <20190416064355.29712-2-qkrwngud825@gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 2019/4/16 14:43, Park Ju Hyung wrote:
> Following extensions are removed:
>  - divx: deprecated video format and it's usually wrapped with avi
>  - asf: deprecated streaming format
>  - asx: redirecting file to asf(small)
>  - wmx: redirecting file to wma/wmv(small)
>  - rm: deprecated media container
>  - video: unused
>  - wv: unpopular audio format from 1998
> 
> The extensions list is limited to 64 and those don't deserve to be
> on this space-precious list.
> 
> Common prefixes are introduced and are checked with
> https://en.wikipedia.org/wiki/List_of_filename_extensions
> to avoid treating possible hot files as cold:
>  - mp: covers mp3, mp4, mpeg, mpg
>  - wm: covers wma, wmb, wmv
>  - og: covers oga, ogg, ogm, ogv
>  - jp: covers jpg, jpeg, jp2
> 
> Following extensions are added:
>  - webm: extremely popular free media container format from Google
>          VP8/VP9/AV1 and Vorbis/Opus is often wrapped with this container
>  - wav: uncompressed audio format, commonly used with voice recorders
>  - svg: vector image format commonly used in web
>  - webp: free lossy image format commonly used in web
>  - jar: Java archive file
>  - deb: Debian software package
>  - iso: disk image file
>  - gz: gzip compressed file, unable to randomly update
>  - xz: xz compressed file, unable to randomly update
>  - zst: zstd compressed file, unable to randomly update
>  - pdf: PDF document
>  - pyc: Python bytecode automatically generated when
>         executing python to run .py files
>  - ttc, ttf: font files
>  - cnt: image alias files commonly used in Android apps
>  - exo: EXO player's cache files, commonly used in Android's YouTube app
>  - odex, vdex: Android RunTime files found in /data/app/*/oat
> 
> Total entries on the list changed from 34 to 36.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  mkfs/f2fs_format.c | 50 ++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 0ae0df3..4560611 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -38,48 +38,54 @@ struct f2fs_checkpoint *cp;
>  static unsigned int quotatype_bits = 0;
>  
>  const char *media_ext_lists[] = {
> +	/* common prefix */
> +	"mp", // Covers mp3, mp4, mpeg, mpg
> +	"wm", // Covers wma, wmb, wmv
> +	"og", // Covers oga, ogg, ogm, ogv
> +	"jp", // Covers jpg, jpeg, jp2

Actually, kernel will compare each character of extension in list with file's
extension, rather than prefix, could you confirm that? :)

Thanks,

> +
>  	/* video */
>  	"avi",
> -	"divx",
>  	"m4v",
>  	"m4p",
> -	"mp4",
> -	"wmv",
> -	"mpeg",
>  	"mkv",
>  	"mov",
> -	"asx",
> -	"asf",
> -	"wmx",
> -	"svi",
> -	"wvx",
> -	"wm",
> -	"mpg",
> -	"mpe",
> -	"rm",
> -	"video",
> +	"webm",
>  
>  	/* audio */
> +	"wav",
>  	"m4a",
> -	"mp3",
>  	"3gp",
> -	"wma",
> -	"wv",
> -	"ogg",
>  	"opus",
>  	"flac",
>  
>  	/* image */
> -	"jpeg",
> -	"jpg",
>  	"gif",
>  	"png",
> -
> -	/* other */
> +	"svg",
> +	"webp",
> +
> +	/* archives */
> +	"jar",
> +	"deb",
> +	"iso",
> +	"gz",
> +	"xz",
> +	"zst",
> +
> +	/* others */
> +	"pdf",
> +	"pyc", // Python bytecode
> +	"ttc",
> +	"ttf",
>  	"exe",
>  
>  	/* android */
>  	"apk",
> +	"cnt", // Image alias
> +	"exo", // YouTube
> +	"odex", // Android RunTime
> +	"vdex", // Android RunTime
>  	"so",
>  
>  	NULL
> 
