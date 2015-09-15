From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: optimize code of
 f2fs_update_extent_tree_range
Date: Tue, 15 Sep 2015 11:36:46 -0700
Message-ID: <20150915183646.GA82556@jaegeuk-mac02>
References: <001901d0eba5$88749fa0$995ddee0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zbv66-0000jk-3J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 18:36:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zbv64-0003sj-G8 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 18:36:54 +0000
Content-Disposition: inline
In-Reply-To: <001901d0eba5$88749fa0$995ddee0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Fan,

On Thu, Sep 10, 2015 at 04:48:22PM +0800, Fan Li wrote:
> Fix 3 potential problems:
> 1. when largest extent needs to be invalidated, it will be reset in
>    __drop_largest_extent, which makes __is_extent_same after always
>    return false, and largest extent unchanged. Now we update it properly.
> 
> 2. when extent is split and the latter part remains in tree, next_en
>    should be the latter part instead of next extent of original extent.
>    It will cause merge failure if there is in-place update, although
>    there is not, I think this fix will still makes codes less ambiguous.
> 
> 3. now we update extent in range, fofs may not be on the largest 
>     extent if the new extent overlaps with it. so add a new function 
>     to drop largest extent properly.
> 
> This patch also simpfies codes of invalidating extents, and optimizes
> the procedues that split extent into two.
> 
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/extent_cache.c |  161 +++++++++++++++++++++---------------------------
>  1 file changed, 70 insertions(+), 91 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 997ac86..cbd1108 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -163,6 +163,15 @@ static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
>  		largest->len = 0;
>  }
> 
> +static void __drop_largest_extent_range(struct inode *inode,
> +						pgoff_t fofs, unsigned int len)
> +{
> +	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
> +
> +	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs)
> +		largest->len = 0;
> +}
> +
>  void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
>  {
>  	if (!f2fs_may_extent_tree(inode))
> @@ -399,7 +408,7 @@ unsigned int f2fs_update_extent_tree_range(struct inode *inode,
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct extent_tree *et = F2FS_I(inode)->extent_tree;
> -	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
> +	struct extent_node *en = NULL, *en1 = NULL;
>  	struct extent_node *prev_en = NULL, *next_en = NULL;
>  	struct extent_info ei, dei, prev;
>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> @@ -419,8 +428,11 @@ unsigned int f2fs_update_extent_tree_range(struct inode *inode,
>  	prev = et->largest;
>  	dei.len = 0;
> 
> -	/* we do not guarantee that the largest extent is cached all the time */
> -	__drop_largest_extent(inode, fofs);
> +	/*
> +	 * drop largest extent before lookup, in case it's already
> +	 * been shrunk from extent tree
> +	 */
> +	__drop_largest_extent_range(inode, fofs, len);

Could you write for the above fix as a sepearte patch?

> 
>  	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
>  	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
> @@ -441,114 +453,81 @@ unsigned int f2fs_update_extent_tree_range(struct inode *inode,
> 
>  	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
>  	while (en) {
> -		struct rb_node *node;
> +		struct rb_node *node = NULL;
> +		int parts = 0;	/* # of parts current extent split into */
> +		unsigned int org_end;
> 
>  		if (pos >= end)
>  			break;
> 
>  		dei = en->ei;
> -		en1 = en2 = NULL;
> +		next_en = en1 = NULL;
> 
> -		node = rb_next(&en->rb_node);
> +		f2fs_bug_on(sbi, pos < dei.fofs || pos >= dei.fofs + dei.len);
> 
> -		/*
> -		 * 2.1 there are four cases when we invalidate blkaddr in extent
> -		 * node, |V: valid address, X: will be invalidated|
> -		 */
> -		/* case#1, invalidate right part of extent node |VVVVVXXXXX| */
> -		if (pos > dei.fofs && end >= dei.fofs + dei.len) {
> +		if (pos > dei.fofs && pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
>  			en->ei.len = pos - dei.fofs;
> +			parts = 1;
> +		}
> 
> -			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
> -				__detach_extent_node(sbi, et, en);
> -				insert_p = NULL;
> -				insert_parent = NULL;
> -				goto update;
> +		org_end = dei.fofs + dei.len;
> +		if (end < org_end &&
> +			org_end - end >= F2FS_MIN_EXTENT_LEN) {
> +			if (parts) {
> +				set_extent_info(&ei, end,
> +						end - dei.fofs + dei.blk,
> +						org_end - end);
> +				en1 = __insert_extent_tree(sbi, et, &ei,
> +							NULL, NULL);
> +				next_en = en1;

Here, don't we need to set prev_en like:
                                prev_en = en;

Thanks,

> +			} else {
> +				en->ei.fofs = end;
> +				en->ei.blk += end - dei.fofs;
> +				en->ei.len -= end - dei.fofs;
> +				next_en = en;
>  			}
> -
> -			if (__is_extent_same(&dei, &et->largest))
> -				et->largest = en->ei;
> -			goto next;
> +			parts++;
>  		}
> 
> -		/* case#2, invalidate left part of extent node |XXXXXVVVVV| */
> -		if (pos <= dei.fofs && end < dei.fofs + dei.len) {
> -			en->ei.fofs = end;
> -			en->ei.blk += end - dei.fofs;
> -			en->ei.len -= end - dei.fofs;
> -
> -			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
> -				__detach_extent_node(sbi, et, en);
> -				insert_p = NULL;
> -				insert_parent = NULL;
> -				goto update;
> -			}
> +		if (!next_en) {
> +			node = rb_next(&en->rb_node);
> +			next_en = node ?
> +				rb_entry(node, struct extent_node, rb_node)
> +				: NULL;
> +		}
> 
> -			if (__is_extent_same(&dei, &et->largest))
> +		if (parts) {
> +			if (en->ei.len > et->largest.len)
>  				et->largest = en->ei;
> -			goto next;
> +		} else {
> +			__detach_extent_node(sbi, et, en);
>  		}
> 
> -		__detach_extent_node(sbi, et, en);
> -
>  		/*
> -		 * if we remove node in rb-tree, our parent node pointer may
> -		 * point the wrong place, discard them.
> +		 * if original extent is split into zero or two parts, extent
> +		 * tree has been altered by deletion or insertion, therefore
> +		 * invalidate pointers regard to tree.
>  		 */
> -		insert_p = NULL;
> -		insert_parent = NULL;
> -
> -		/* case#3, invalidate entire extent node |XXXXXXXXXX| */
> -		if (pos <= dei.fofs && end >= dei.fofs + dei.len) {
> -			if (__is_extent_same(&dei, &et->largest))
> -				et->largest.len = 0;
> -			goto update;
> +		if (parts != 1) {
> +			insert_p = NULL;
> +			insert_parent = NULL;
>  		}
> 
> -		/*
> -		 * case#4, invalidate data in the middle of extent node
> -		 * |VVVXXXXVVV|
> -		 */
> -		if (dei.len > F2FS_MIN_EXTENT_LEN) {
> -			unsigned int endofs;
> -
> -			/*  insert left part of split extent into cache */
> -			if (pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
> -				set_extent_info(&ei, dei.fofs, dei.blk,
> -							pos - dei.fofs);
> -				en1 = __insert_extent_tree(sbi, et, &ei,
> -								NULL, NULL);
> -			}
> -
> -			/* insert right part of split extent into cache */
> -			endofs = dei.fofs + dei.len;
> -			if (endofs - end >= F2FS_MIN_EXTENT_LEN) {
> -				set_extent_info(&ei, end,
> -						end - dei.fofs + dei.blk,
> -						endofs - end);
> -				en2 = __insert_extent_tree(sbi, et, &ei,
> -								NULL, NULL);
> -			}
> -		}
> -update:
> -		/* 2.2 update in global extent list */
> +		/* update in global extent list */
>  		spin_lock(&sbi->extent_lock);
> -		if (en && !list_empty(&en->list))
> +		if (!parts && !list_empty(&en->list))
>  			list_del(&en->list);
>  		if (en1)
>  			list_add_tail(&en1->list, &sbi->extent_list);
> -		if (en2)
> -			list_add_tail(&en2->list, &sbi->extent_list);
>  		spin_unlock(&sbi->extent_lock);
> 
> -		/* 2.3 release extent node */
> -		if (en)
> +		/* release extent node */
> +		if (!parts)
>  			kmem_cache_free(extent_node_slab, en);
> -next:
> -		en = node ? rb_entry(node, struct extent_node, rb_node) : NULL;
> -		next_en = en;
> -		if (en)
> -			pos = en->ei.fofs;
> +
> +		en = next_en;
> +		if (next_en)
> +			pos = next_en->ei.fofs;
>  	}
> 
>  update_extent:
> @@ -557,10 +536,10 @@ update_extent:
>  		struct extent_node *den = NULL;
> 
>  		set_extent_info(&ei, fofs, blkaddr, len);
> -		en3 = __try_merge_extent_node(sbi, et, &ei, &den,
> +		en1 = __try_merge_extent_node(sbi, et, &ei, &den,
>  							prev_en, next_en);
> -		if (!en3)
> -			en3 = __insert_extent_tree(sbi, et, &ei,
> +		if (!en1)
> +			en1 = __insert_extent_tree(sbi, et, &ei,
>  						insert_p, insert_parent);
> 
>  		/* give up extent_cache, if split and small updates happen */
> @@ -572,11 +551,11 @@ update_extent:
>  		}
> 
>  		spin_lock(&sbi->extent_lock);
> -		if (en3) {
> -			if (list_empty(&en3->list))
> -				list_add_tail(&en3->list, &sbi->extent_list);
> +		if (en1) {
> +			if (list_empty(&en1->list))
> +				list_add_tail(&en1->list, &sbi->extent_list);
>  			else
> -				list_move_tail(&en3->list, &sbi->extent_list);
> +				list_move_tail(&en1->list, &sbi->extent_list);
>  		}
>  		if (den && !list_empty(&den->list))
>  			list_del(&den->list);
> --
> 1.7.9.5

------------------------------------------------------------------------------
