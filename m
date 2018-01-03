From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: check segment type before recover data
Date: Wed, 3 Jan 2018 12:04:01 -0800
Message-ID: <20180103200401.GC30014@jaegeuk-macbookpro.roam.corp.google.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 12/30, Yunlong Song wrote:
> In some case, the node blocks has wrong blkaddr whose segment type is
> NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
> the xattr range. Since fsck.f2fs does not check the recovery nodes, this
> will cause __f2fs_replace_block change the curseg of node and do the
> update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
> result, when recovery process write checkpoint and sync nodes, the
> next_blkoff of curseg is used in the segment bit map, then it will
> cause f2fs_bug_on. So let's check the segment type before recover data,
> and stop recover if it is not in DATA segment.

Then, why not checking this in __f2fs_replace_block()? And, you can do this,
only if se->valid_blocks != 0 at this point.

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/recovery.c | 3 ++-
>  fs/f2fs/segment.h  | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 7d63faf..e8fee4a 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -478,7 +478,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  		}
>  
>  		/* dest is valid block, try to recover from src to dest */
> -		if (is_valid_blkaddr(sbi, dest, META_POR)) {
> +		if (is_valid_blkaddr(sbi, dest, META_POR) &&
> +			is_data_blkaddr(sbi, dest)) {
>  
>  			if (src == NULL_ADDR) {
>  				err = reserve_new_block(&dn);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 71a2aaa..5c5a215 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -115,6 +115,9 @@
>  #define SECTOR_TO_BLOCK(sectors)					\
>  	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
>  
> +#define is_data_blkaddr(sbi, blkaddr)	\
> +	(IS_DATASEG(get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr))->type))
> +
>  /*
>   * indicate a block allocation direction: RIGHT and LEFT.
>   * RIGHT means allocating new sections towards the end of volume.
> -- 
> 1.8.5.2
