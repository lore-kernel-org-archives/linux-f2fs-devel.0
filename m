From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: change segment to section in
 f2fs_ioc_gc_range
Date: Thu, 25 Oct 2018 09:46:50 +0800
Message-ID: <1dedda7c-edf5-82ae-787b-c2276e7c7275@huawei.com>
References: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gFUjs-0002oB-7q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Oct 2018 01:47:08 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gFUjp-00EgAL-Si
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Oct 2018 01:47:08 +0000
In-Reply-To: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 2018/10/24 22:35, Yunlong Song wrote:
> f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
> blocks of section each time, so fix it from segment to section.

I'm okay with this change, BTW, I notice that I need to change it to use
sbi->blocks_per_seg * sbi->migration_granularity in my patchset if this
patch being merged firstly.

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 88b1246..8c06724 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2155,7 +2155,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
>  	}
>  
>  	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
> -	range.start += sbi->blocks_per_seg;
> +	range.start += sbi->blocks_per_seg * sbi->segs_per_sec;

use BLKS_PER_SEC() for cleanup?

>  	if (range.start <= end)
>  		goto do_more;
>  out:
> 
