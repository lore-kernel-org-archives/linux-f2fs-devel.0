From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] f2fs: check segment type in __f2fs_replace_block
Date: Wed, 3 Jan 2018 23:10:54 -0800
Message-ID: <20180104071054.GD54234@jaegeuk-macbookpro.roam.corp.google.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
 <1515049322-29555-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515049322-29555-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Yunlong Song wrote:
> In some case, the node blocks has wrong blkaddr whose segment type is
> NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
> the xattr range. Since fsck.f2fs does not check the recovery nodes, this
> will cause __f2fs_replace_block change the curseg of node and do the
> update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
> result, when recovery process write checkpoint and sync nodes, the
> next_blkoff of curseg is used in the segment bit map, then it will
> cause f2fs_bug_on. So let's check segment type in __f2fs_replace_block.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 890d483..50575d5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2720,6 +2720,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  	type = se->type;
>  
>  	down_write(&SM_I(sbi)->curseg_lock);
> +	f2fs_bug_on(sbi, se->valid_blocks && !IS_DATASEG(type));

Let me just move this below like this and start some tests.

...

+       f2fs_bug_on(sbi, !IS_DATASEG(type));
        curseg = CURSEG_I(sbi, type);

>  
>  	if (!recover_curseg) {
>  		/* for recovery flow */
> -- 
> 1.8.5.2
