From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: merge meta writes as many possible
Date: Mon, 12 Oct 2015 16:18:02 +0800
Message-ID: <020d01d104c6$9e04de90$da0e9bb0$@samsung.com>
References: <1443804470-2541-1-git-send-email-jaegeuk@kernel.org>
 <COL402-EAS4024BEB16A6A59FCB1671A9AB370@phx.gbl>
 <20151006232029.GA18417@jaegeuk-mac02.mot.com>
 <COL402-EAS16204160218AFFC2BABD01AAB360@phx.gbl>
 <20151009002859.GA36104@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20151009002859.GA36104@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, October 09, 2015 8:29 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: merge meta writes as many possible
> 
> Hi Chao,
> 
> [snip]
> 
> > > > >  	struct writeback_control wbc = {
> > > > > @@ -277,6 +277,11 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
> > > > >  		for (i = 0; i < nr_pages; i++) {
> > > > >  			struct page *page = pvec.pages[i];
> > > > >
> > > > > +			if (prev == LONG_MAX)
> > > > > +				prev = page->index - 1;
> > > > > +			if (nr_to_write != LONG_MAX && page->index != prev + 1)
> >
> > If we reach this condition, should we break the 'while' loop outside?
> > Because it's not possible to meet the page with 'prev + 1' index in any
> > page vec found afterward.
> 
> Alright, I fixed this too.
> 
> >
> > > >
> > > > Does this mean we only writeback consecutive meta page of SSA region? If these meta
> > > > pages are updated randomly (in collapse range or insert range case), we will writeback
> > > > very few meta pages in one round of flush, it may cause low performance since FTL will
> > > > do the force GC on our meta page update region if we writeback meta pages in one segment
> > > > repeatly.
> > >
> > > I don't think this would degrade the performance pretty much. Rather than that,
> > > as the above traces, I could see more possitive impact on IO patterns when I
> > > gave some delay on flushing meta pages. (I got the traces when copying kernel
> > > source tree.) Moreover, the amount of the meta page writes is relatively lower
> > > than other data types.
> >
> > Previously I only track collapse/insert case, so I'm just worry about those corner
> > cases. Today I track the normal case, the trace info looks good to me! :)
> >
> > >
> > > > IMO, when the distribution of dirty SSA pages are random, at least we should writeback
> > > > all dirty meta pages in SSA region which align to our segment size under block plug.
> > > >
> > > > One more thing is that I found in xfstest tests/generic/019 always cause inconsistent
> > > > between ssa info and meta info of inode (i_blocks != total_blk_cnt). The reason of the
> > > > problem is in ->falloc::collapse, we will update ssa meta page and node page info
> > > > together, however, unfortunately ssa meta page is writeback by kworker, node page will
> > > > no longer be persisted since fail_make_request made f2fs flagged as CP_ERROR_FLAG.
> > > >
> > > > So writeback SSA pages leads the potential risk of producing consistent issue. I think
> > > > there are some ways can fix this:
> > > > 1) don't writeback SSA pages in kworker, but side-effect is more memory will be cost
> > > > since cp is executed, of course, periodical cp can fix the memory cost issue.
> > > > 2) add some tag in somewhere, we can recover the ssa info with dnode page, but this is
> > > > really a big change.
> > > >
> > > > How do you think? Any better idea?
> > >
> > > Good catch!
> > > I think we can allocate a new block address for this case like the below patch.
> > >
> > > From 4979a1cbd7c718cff946cb421fbc0763a3dbd0df Mon Sep 17 00:00:00 2001
> > > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Date: Tue, 6 Oct 2015 15:41:58 -0700
> > > Subject: [PATCH] f2fs: avoid SSA corruption when replacing block addresses
> > >
> > > If block addresses are pointed by the previous checkpoint, we should not update
> > > the SSA when replacing block addresses by f2fs_collapse_range.
> > >
> > > This patch allocates a new block address if there is an exising block address.
> >
> > This patch doesn't fix that issue, because SSA block related to new_blkaddr will
> > be overwritten, not the one related to old_blkaddr.
> > So still I can reproduce the issue after applying this patch.
> 
> Urg, right.
> 
> I wrote a different patch to resolve this issue.
> Actually, I think there is a hole that new_address can be allocated to other
> thread after initial truncation.
> I've been running xfstests and fsstress for a while.
> Could you also check this patch?

Nice work! That's the right answer. generic/019 no longer complain now. :)

Thanks,

> 
> >From d4ef8031de39f4139bb848f9002167da897d962d Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 7 Oct 2015 12:28:41 -0700
> Subject: [PATCH] f2fs: fix SSA updates resulting in corruption
> 
> The f2fs_collapse_range and f2fs_insert_range changes the block addresses
> directly. But that can cause uncovered SSA updates.
> In that case, we need to give up to change the block addresses and do buffered
> writes to keep filesystem consistency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  11 +++
>  fs/f2fs/file.c    | 205 +++++++++++++++++++++++++-----------------------------
>  fs/f2fs/segment.c |  33 ++++++++-
>  3 files changed, 136 insertions(+), 113 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f05ae22..6f2310c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1233,6 +1233,16 @@ static inline unsigned int valid_inode_count(struct f2fs_sb_info *sbi)
>  	return sbi->total_valid_inode_count;
>  }
> 
> +static inline void f2fs_copy_page(struct page *src, struct page *dst)
> +{
> +	char *src_kaddr = kmap(src);
> +	char *dst_kaddr = kmap(dst);
> +
> +	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
> +	kunmap(dst);
> +	kunmap(src);
> +}
> +
>  static inline void f2fs_put_page(struct page *page, int unlock)
>  {
>  	if (!page)
> @@ -1754,6 +1764,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *);
>  int create_flush_cmd_control(struct f2fs_sb_info *);
>  void destroy_flush_cmd_control(struct f2fs_sb_info *);
>  void invalidate_blocks(struct f2fs_sb_info *, block_t);
> +bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
>  void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
>  void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
>  void release_discard_addrs(struct f2fs_sb_info *);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6d3cfd5..8d5583b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -826,86 +826,100 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	return ret;
>  }
> 
> -static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
> +static int __exchange_data_block(struct inode *inode, pgoff_t src,
> +					pgoff_t dst, bool full)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct dnode_of_data dn;
> -	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> -	int ret = 0;
> -
> -	for (; end < nrpages; start++, end++) {
> -		block_t new_addr, old_addr;
> -
> -		f2fs_lock_op(sbi);
> +	block_t new_addr;
> +	bool do_replace = false;
> +	int ret;
> 
> -		set_new_dnode(&dn, inode, NULL, NULL, 0);
> -		ret = get_dnode_of_data(&dn, end, LOOKUP_NODE_RA);
> -		if (ret && ret != -ENOENT) {
> -			goto out;
> -		} else if (ret == -ENOENT) {
> -			new_addr = NULL_ADDR;
> -		} else {
> -			new_addr = dn.data_blkaddr;
> -			truncate_data_blocks_range(&dn, 1);
> -			f2fs_put_dnode(&dn);
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	ret = get_dnode_of_data(&dn, src, LOOKUP_NODE_RA);
> +	if (ret && ret != -ENOENT) {
> +		return ret;
> +	} else if (ret == -ENOENT) {
> +		new_addr = NULL_ADDR;
> +	} else {
> +		new_addr = dn.data_blkaddr;
> +		if (!is_checkpointed_data(sbi, new_addr)) {
> +			dn.data_blkaddr = NULL_ADDR;
> +			/* do not invalidate this block address */
> +			set_data_blkaddr(&dn);
> +			f2fs_update_extent_cache(&dn);
> +			do_replace = true;
>  		}
> +		f2fs_put_dnode(&dn);
> +	}
> 
> -		if (new_addr == NULL_ADDR) {
> -			set_new_dnode(&dn, inode, NULL, NULL, 0);
> -			ret = get_dnode_of_data(&dn, start, LOOKUP_NODE_RA);
> -			if (ret && ret != -ENOENT) {
> -				goto out;
> -			} else if (ret == -ENOENT) {
> -				f2fs_unlock_op(sbi);
> -				continue;
> -			}
> +	if (new_addr == NULL_ADDR)
> +		return full ? truncate_hole(inode, dst, dst + 1) : 0;
> 
> -			if (dn.data_blkaddr == NULL_ADDR) {
> -				f2fs_put_dnode(&dn);
> -				f2fs_unlock_op(sbi);
> -				continue;
> -			} else {
> -				truncate_data_blocks_range(&dn, 1);
> -			}
> +	if (do_replace) {
> +		struct page *ipage = get_node_page(sbi, inode->i_ino);
> +		struct node_info ni;
> 
> -			f2fs_put_dnode(&dn);
> -		} else {
> -			struct page *ipage;
> +		if (IS_ERR(ipage)) {
> +			ret = PTR_ERR(ipage);
> +			goto err_out;
> +		}
> 
> -			ipage = get_node_page(sbi, inode->i_ino);
> -			if (IS_ERR(ipage)) {
> -				ret = PTR_ERR(ipage);
> -				goto out;
> -			}
> +		set_new_dnode(&dn, inode, ipage, NULL, 0);
> +		ret = f2fs_reserve_block(&dn, dst);
> +		if (ret)
> +			goto err_out;
> 
> -			set_new_dnode(&dn, inode, ipage, NULL, 0);
> -			ret = f2fs_reserve_block(&dn, start);
> -			if (ret)
> -				goto out;
> +		truncate_data_blocks_range(&dn, 1);
> 
> -			old_addr = dn.data_blkaddr;
> -			if (old_addr != NEW_ADDR && new_addr == NEW_ADDR) {
> -				dn.data_blkaddr = NULL_ADDR;
> -				f2fs_update_extent_cache(&dn);
> -				invalidate_blocks(sbi, old_addr);
> +		get_node_info(sbi, dn.nid, &ni);
> +		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
> +				ni.version, true);
> +		f2fs_put_dnode(&dn);
> +	} else {
> +		struct page *psrc, *pdst;
> +
> +		psrc = get_lock_data_page(inode, src);
> +		if (IS_ERR(psrc))
> +			return PTR_ERR(psrc);
> +		pdst = get_new_data_page(inode, NULL, dst, false);
> +		if (IS_ERR(pdst)) {
> +			f2fs_put_page(psrc, 1);
> +			return PTR_ERR(pdst);
> +		}
> +		f2fs_copy_page(psrc, pdst);
> +		set_page_dirty(pdst);
> +		f2fs_put_page(pdst, 1);
> +		f2fs_put_page(psrc, 1);
> 
> -				dn.data_blkaddr = new_addr;
> -				set_data_blkaddr(&dn);
> -			} else if (new_addr != NEW_ADDR) {
> -				struct node_info ni;
> +		return truncate_hole(inode, src, src + 1);
> +	}
> +	return 0;
> 
> -				get_node_info(sbi, dn.nid, &ni);
> -				f2fs_replace_block(sbi, &dn, old_addr, new_addr,
> -							ni.version, true);
> -			}
> +err_out:
> +	if (!get_dnode_of_data(&dn, src, LOOKUP_NODE)) {
> +		dn.data_blkaddr = new_addr;
> +		set_data_blkaddr(&dn);
> +		f2fs_update_extent_cache(&dn);
> +		f2fs_put_dnode(&dn);
> +	}
> +	return ret;
> +}
> 
> -			f2fs_put_dnode(&dn);
> -		}
> +static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> +	int ret = 0;
> +
> +	for (; end < nrpages; start++, end++) {
> +		f2fs_balance_fs(sbi);
> +		f2fs_lock_op(sbi);
> +		ret = __exchange_data_block(inode, end, start, true);
>  		f2fs_unlock_op(sbi);
> +		if (ret)
> +			break;
>  	}
> -	return 0;
> -out:
> -	f2fs_unlock_op(sbi);
>  	return ret;
>  }
> 
> @@ -944,7 +958,12 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t
> len)
>  	if (ret)
>  		return ret;
> 
> +	/* write out all moved pages, if possible */
> +	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> +	truncate_pagecache(inode, offset);
> +
>  	new_size = i_size_read(inode) - len;
> +	truncate_pagecache(inode, new_size);
> 
>  	ret = truncate_blocks(inode, new_size, true);
>  	if (!ret)
> @@ -1067,7 +1086,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t
> len)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	pgoff_t pg_start, pg_end, delta, nrpages, idx;
>  	loff_t new_size;
> -	int ret;
> +	int ret = 0;
> 
>  	new_size = i_size_read(inode) + len;
>  	if (new_size > inode->i_sb->s_maxbytes)
> @@ -1105,57 +1124,19 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t
> len)
>  	nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> 
>  	for (idx = nrpages - 1; idx >= pg_start && idx != -1; idx--) {
> -		struct dnode_of_data dn;
> -		struct page *ipage;
> -		block_t new_addr, old_addr;
> -
>  		f2fs_lock_op(sbi);
> -
> -		set_new_dnode(&dn, inode, NULL, NULL, 0);
> -		ret = get_dnode_of_data(&dn, idx, LOOKUP_NODE_RA);
> -		if (ret && ret != -ENOENT) {
> -			goto out;
> -		} else if (ret == -ENOENT) {
> -			goto next;
> -		} else if (dn.data_blkaddr == NULL_ADDR) {
> -			f2fs_put_dnode(&dn);
> -			goto next;
> -		} else {
> -			new_addr = dn.data_blkaddr;
> -			truncate_data_blocks_range(&dn, 1);
> -			f2fs_put_dnode(&dn);
> -		}
> -
> -		ipage = get_node_page(sbi, inode->i_ino);
> -		if (IS_ERR(ipage)) {
> -			ret = PTR_ERR(ipage);
> -			goto out;
> -		}
> -
> -		set_new_dnode(&dn, inode, ipage, NULL, 0);
> -		ret = f2fs_reserve_block(&dn, idx + delta);
> -		if (ret)
> -			goto out;
> -
> -		old_addr = dn.data_blkaddr;
> -		f2fs_bug_on(sbi, old_addr != NEW_ADDR);
> -
> -		if (new_addr != NEW_ADDR) {
> -			struct node_info ni;
> -
> -			get_node_info(sbi, dn.nid, &ni);
> -			f2fs_replace_block(sbi, &dn, old_addr, new_addr,
> -							ni.version, true);
> -		}
> -		f2fs_put_dnode(&dn);
> -next:
> +		ret = __exchange_data_block(inode, idx, idx + delta, false);
>  		f2fs_unlock_op(sbi);
> +		if (ret)
> +			break;
>  	}
> 
> -	i_size_write(inode, new_size);
> -	return 0;
> -out:
> -	f2fs_unlock_op(sbi);
> +	/* write out all moved pages, if possible */
> +	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> +	truncate_pagecache(inode, offset);
> +
> +	if (!ret)
> +		i_size_write(inode, new_size);
>  	return ret;
>  }
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1d86a35..581a9af 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -768,6 +768,30 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
>  	mutex_unlock(&sit_i->sentry_lock);
>  }
> 
> +bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
> +{
> +	struct sit_info *sit_i = SIT_I(sbi);
> +	unsigned int segno, offset;
> +	struct seg_entry *se;
> +	bool is_cp = false;
> +
> +	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
> +		return true;
> +
> +	mutex_lock(&sit_i->sentry_lock);
> +
> +	segno = GET_SEGNO(sbi, blkaddr);
> +	se = get_seg_entry(sbi, segno);
> +	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> +
> +	if (f2fs_test_bit(offset, se->ckpt_valid_map))
> +		is_cp = true;
> +
> +	mutex_unlock(&sit_i->sentry_lock);
> +
> +	return is_cp;
> +}
> +
>  /*
>   * This function should be resided under the curseg_mutex lock
>   */
> @@ -1370,7 +1394,14 @@ static void __f2fs_replace_block(struct f2fs_sb_info *sbi,
>  	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
>  	__add_sum_entry(sbi, type, sum);
> 
> -	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
> +	if (!recover_curseg)
> +		update_sit_entry(sbi, new_blkaddr, 1);
> +	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
> +		update_sit_entry(sbi, old_blkaddr, -1);
> +
> +	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
> +	locate_dirty_segment(sbi, GET_SEGNO(sbi, new_blkaddr));
> +
>  	locate_dirty_segment(sbi, old_cursegno);
> 
>  	if (recover_curseg) {
> --
> 2.1.1
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

