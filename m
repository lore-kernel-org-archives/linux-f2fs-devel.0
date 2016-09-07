From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: forbid to do fstrim if fs has some
	error
Date: Wed, 7 Sep 2016 21:24:31 +0800
Message-ID: <177e0232-b89b-1540-f315-c1ca6a92e3ba@kernel.org>
References: <1472696079-7063-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bhcqO-0000HB-GF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 13:24:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bhcqN-0001WM-HX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 13:24:48 +0000
In-Reply-To: <1472696079-7063-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

Hi Yunlei,

On 2016/9/1 10:14, Yunlei He wrote:
> This patch skip fstrim if sbi set SBI_NEED_FSCK flag
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 93c5e26..1b62213 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1353,6 +1353,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  	if (end <= MAIN_BLKADDR(sbi))
>  		goto out;
>  
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> +		goto out;

IMO, it's better to check this condition in f2fs_ioc_fstrim, and return error
number to user, such as EIO?

Thanks,

> +
>  	/* start/end segment number in main_area */
>  	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
>  	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
> 

------------------------------------------------------------------------------
