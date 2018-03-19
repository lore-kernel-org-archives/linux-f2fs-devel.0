From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] mkfs.f2fs: update extension lists
Date: Mon, 19 Mar 2018 11:42:33 +0800
Message-ID: <1988f12a-351a-c137-2fc3-b68ce0aefc31@huawei.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1exlhA-0001hQ-7U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:42:48 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1exlh5-005aVD-0B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:42:48 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 703F7A9FA15C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Mar 2018 11:42:33 +0800 (CST)
In-Reply-To: <20180317150257.123927-1-qkrwngud825@gmail.com>
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

Hi Park,

On 2018/3/17 23:02, Park Ju Hyung wrote:
> Those formats are large in size and rarely updated.
> 
> Formats such as tar and zip were intentionally excluded as
> those are capable of random updates.
> 
> (Added from vlc, p7zip and running
> 'find . -type f -size +1M |
>     while read FILE; do echo ${FILE##*.}; done |
>     sort | uniq -c | sort -nr'
> manually)

Do you run this script in android environment to get the cold type?

Actually, I doubt that '+1M' condition can't indicate that the file is cold or
not, and after run this script in my cell phone, I didn't see so many type as
your patch adds.

If that is a common cold file type list that user may not do random updates in
the file after its creation, I suggest that we can add one common list instead
of changing old one controlled by mkfs option, anyway, to use which one, the
option can be decided by user.

Thanks,

> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  mkfs/f2fs_format.c | 86 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 22 deletions(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 65692bb..3c7ce16 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -37,34 +37,76 @@ struct f2fs_checkpoint *cp;
>  
>  static unsigned int quotatype_bits = 0;
>  
> -const char *media_ext_lists[] = {
> -	"jpg",
> -	"gif",
> -	"png",
> +const char *cold_ext_lists[] = {
> +	/* video */
>  	"avi",
>  	"divx",
> -	"mp4",
> -	"mp3",
> -	"3gp",
> -	"wmv",
> -	"wma",
> -	"mpeg",
> +	"flv",
> +	"m2ts",
> +	"m4p",
> +	"m4v",
>  	"mkv",
>  	"mov",
> -	"asx",
> -	"asf",
> -	"wmx",
> -	"svi",
> -	"wvx",
> -	"wm",
> +	"mp4",
> +	"mpeg",
> +	"mpeg4",
>  	"mpg",
> -	"mpe",
> -	"rm",
>  	"ogg",
> +	"ogm",
> +	"ogv",
> +	"ts",
> +	"vob",
> +	"wmb",
> +	"wmv",
> +	"webm",
> +
> +	/* audio */
> +	"aac",
> +	"ac3",
> +	"dts",
> +	"flac",
> +	"m4a",
> +	"mka",
> +	"mp3",
> +	"oga",
> +	"wav",
> +	"wma",
> +
> +	/* image */
> +	"bmp",
> +	"gif",
> +	"jpg",
>  	"jpeg",
> -	"video",
> -	"apk",	/* for android system */
> -	"so",	/* for android system */
> +	"png",
> +	"svg",
> +	"webp",
> +
> +	/* archive */
> +	"7z",
> +	"a",
> +	"deb",
> +	"gz",
> +	"gzip",
> +	"iso",
> +	"jar",
> +	"lzma",
> +	"rar",
> +	"tgz",
> +	"txz",
> +	"udf",
> +	"xz",
> +
> +	/* other */
> +	"pdf",
> +	"ttf",
> +	"ttc",
> +
> +	/* android */
> +	"apk",
> +	"exo", // YouTube
> +	"odex", // Android RunTime
> +	"vdex", // Android RunTime
> +	"so",
>  	NULL
>  };
>  
> @@ -74,7 +116,7 @@ const char *hot_ext_lists[] = {
>  };
>  
>  const char **default_ext_list[] = {
> -	media_ext_lists,
> +	cold_ext_lists,
>  	hot_ext_lists
>  };
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
