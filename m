From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: read ahead xattr & direct node
 blocks
Date: Sat, 27 Jan 2018 11:46:09 +0800
Message-ID: <d34ecc57-dc83-c010-fe65-6cc5a0965ffa@huawei.com>
References: <1516958585-9454-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efHRr-0006xi-9r
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 03:46:35 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efHRp-0007dJ-Jy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 03:46:35 +0000
In-Reply-To: <1516958585-9454-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2018/1/26 17:23, Yunlei He wrote:
> This patch read ahead xattr & direct node blocks
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fsck/fsck.c | 59 ++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 6c1b9a7..29a712c 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -621,6 +621,31 @@ unmatched:
>  	child->state |= FSCK_UNMATCHED_EXTENT;
>  }
>  
> +void fsck_reada_node_block(struct f2fs_sb_info *sbi, u32 nid)
> +{
> +	struct node_info ni;
> +
> +	if (nid != 0 && IS_VALID_NID(sbi, nid)) {
> +		get_node_info(sbi, nid, &ni);
> +		if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
> +			dev_reada_block(ni.blk_addr);
> +	}
> +}
> +
> +void fsck_reada_all_direct_node_blocks(struct f2fs_sb_info *sbi,
> +						struct f2fs_node *node_blk)
> +{
> +	int i;
> +
> +	for (i = 0; i < NIDS_PER_BLOCK; i++) {
> +		u32 nid = le32_to_cpu(node_blk->in.nid[i]);
> +
> +		if (nid == 0x0)
> +			continue;

In fsck_reada_node_block, we have already checked all conditions that we
should skip doing readahead, here I think we can just be relaxed to remove
above check.

> +		fsck_reada_node_block(sbi, nid);
> +	}
> +}
> +
>  /* start with valid nid and blkaddr */
>  void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		enum FILE_TYPE ftype, struct f2fs_node *node_blk,
> @@ -680,15 +705,6 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		}
>  	}
>  
> -	if (fsck_chk_xattr_blk(sbi, nid,
> -			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt) &&
> -			c.fix_on) {
> -		node_blk->i.i_xattr_nid = 0;
> -		need_fix = 1;
> -		FIX_MSG("Remove xattr block: 0x%x, x_nid = 0x%x",
> -				nid, le32_to_cpu(node_blk->i.i_xattr_nid));
> -	}
> -
>  	if (ftype == F2FS_FT_CHRDEV || ftype == F2FS_FT_BLKDEV ||
>  			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
>  		goto check;
> @@ -737,16 +753,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  	}
>  
>  	/* readahead node blocks */
> +	if (le32_to_cpu(node_blk->i.i_xattr_nid))

Ditto.

> +		fsck_reada_node_block(sbi,
> +				le32_to_cpu(node_blk->i.i_xattr_nid));
>  	for (idx = 0; idx < 5; idx++) {
>  		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
> -
> -		if (nid != 0 && IS_VALID_NID(sbi, nid)) {
> -			struct node_info ni;
> -
> -			get_node_info(sbi, nid, &ni);
> -			if (IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
> -				dev_reada_block(ni.blk_addr);
> -		}
> +		fsck_reada_node_block(sbi, nid);
>  	}
>  
>  	/* init extent info */
> @@ -778,6 +790,15 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		}
>  	}
>  
> +	if (fsck_chk_xattr_blk(sbi, nid,
> +			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt) &&
> +			c.fix_on) {
> +		node_blk->i.i_xattr_nid = 0;
> +		need_fix = 1;
> +		FIX_MSG("Remove xattr block: 0x%x, x_nid = 0x%x",
> +				nid, le32_to_cpu(node_blk->i.i_xattr_nid));
> +	}
> +
>  	/* check node blocks in inode */
>  	for (idx = 0; idx < 5; idx++) {
>  		nid_t i_nid = le32_to_cpu(node_blk->i.i_nid[idx]);
> @@ -997,6 +1018,8 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
>  	int need_fix = 0, ret;
>  	int i = 0;
>  
> +	fsck_reada_all_direct_node_blocks(sbi, node_blk);
> +
>  	for (i = 0; i < NIDS_PER_BLOCK; i++) {
>  		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
>  			goto skip;
> @@ -1037,6 +1060,8 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
>  	int i = 0;
>  	int need_fix = 0, ret = 0;
>  
> +	fsck_reada_all_direct_node_blocks(sbi, node_blk);
> +
>  	for (i = 0; i < NIDS_PER_BLOCK; i++) {
>  		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
>  			goto skip;

How about keeping the order:

1. check data blocks
2. readahead xattr block
3. fsck xattr block
4. readahead {d,id,did}node block
5. fsck {d,id,did}node block

With above order, I expect we can avoid unneeded readahead before
sub-directory iterated traversing or encountering error.

Thanks,

> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
