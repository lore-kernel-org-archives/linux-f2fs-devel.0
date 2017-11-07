From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid endless loop in funtion
 f2fs_sync_inode_meta
Date: Mon, 6 Nov 2017 18:54:58 -0800
Message-ID: <20171107025458.GJ88544@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510021438-23206-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eBu2c-0004KG-Jq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 02:55:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eBu2a-00013G-Ri
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 02:55:06 +0000
Content-Disposition: inline
In-Reply-To: <1510021438-23206-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: ning.jia@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 11/07, Yunlei He wrote:
> One inode may be evicted without removing from global dirty list,
> which will cause endless loop in funtion f2fs_sync_inode_meta.

I think this was resolved by:

   f2fs: avoid stale fi->gdirty_list pointer

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/inode.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 9684d535..ce1f87d 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -532,6 +532,13 @@ void f2fs_evict_inode(struct inode *inode)
>  
>  	if (err)
>  		update_inode_page(inode);
> +
> +	if (unlikely(is_inode_flag_set(inode, FI_DIRTY_INODE))) {
> +		f2fs_inode_synced(inode);
> +		f2fs_msg(sbi->sb, KERN_WARNING, "correct inode status to avoid "
> +				"endless loop, since inode writeback flow is broken");
> +		f2fs_bug_on(sbi, 1);
> +	}
>  	dquot_free_inode(inode);
>  	sb_end_intwrite(inode->i_sb);
>  no_delete:
> @@ -541,6 +548,19 @@ void f2fs_evict_inode(struct inode *inode)
>  	stat_dec_inline_dir(inode);
>  	stat_dec_inline_inode(inode);
>  
> +	if (unlikely(is_inode_flag_set(inode, FI_DIRTY_INODE))) {
> +		sb_start_intwrite(inode->i_sb);
> +		update_inode_page(inode);
> +		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
> +			f2fs_inode_synced(inode);
> +			f2fs_msg(sbi->sb, KERN_WARNING,
> +				"inode info is inconsistent since "
> +				"inode evicts before we writeback it");
> +		}
> +		sb_end_intwrite(inode->i_sb);
> +		f2fs_bug_on(sbi, 1);
> +	}
> +
>  	if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG)))
>  		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
>  	else
> -- 
> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
