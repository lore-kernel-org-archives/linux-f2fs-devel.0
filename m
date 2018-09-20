From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2 v2] f2fs: avoid f2fs_bug_on if
 f2fs_get_meta_page_nofail got EIO
Date: Thu, 20 Sep 2018 14:46:56 -0700
Message-ID: <20180920214656.GE35918@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180918021805.85032-2-jaegeuk@kernel.org>
 <20180918175648.GE91945@jaegeuk-macbookpro.roam.corp.google.com>
 <9813f294-3e09-ee2d-56f0-6bb476e88a5a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1g36mu-0002li-Va
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:47:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g36ms-003Olg-Sz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:47:04 +0000
Content-Disposition: inline
In-Reply-To: <9813f294-3e09-ee2d-56f0-6bb476e88a5a@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 09/20, Chao Yu wrote:
> On 2018/9/19 1:56, Jaegeuk Kim wrote:
> > This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
> > xfstests/generic/475.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > Change log from v1:
> >  - propagate errno
> >  - drop sum_pages
> > 
> >  fs/f2fs/checkpoint.c | 10 +++++-----
> >  fs/f2fs/f2fs.h       |  2 +-
> >  fs/f2fs/gc.c         |  9 +++++++++
> >  fs/f2fs/node.c       | 32 ++++++++++++++++++++++++--------
> >  fs/f2fs/recovery.c   |  2 ++
> >  fs/f2fs/segment.c    |  3 +++
> >  6 files changed, 44 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 01e0d8f5bbbe..1ddf332ce4b2 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -119,11 +119,8 @@ struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
> >  		if (PTR_ERR(page) == -EIO &&
> >  				++count <= DEFAULT_RETRY_IO_COUNT)
> >  			goto retry;
> > -
> >  		f2fs_stop_checkpoint(sbi, false);
> > -		f2fs_bug_on(sbi, 1);
> >  	}
> > -
> >  	return page;
> >  }
> >  
> > @@ -1512,7 +1509,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	ckpt->checkpoint_ver = cpu_to_le64(++ckpt_ver);
> >  
> >  	/* write cached NAT/SIT entries to NAT/SIT area */
> > -	f2fs_flush_nat_entries(sbi, cpc);
> > +	err = f2fs_flush_nat_entries(sbi, cpc);
> > +	if (err)
> > +		goto stop;
> 
> To make sure, if partial NAT pages become dirty, flush them back to device
> outside checkpoint() is not harmful, right?

I think so.

> 
> > +
> >  	f2fs_flush_sit_entries(sbi, cpc);
> >  
> >  	/* unlock all the fs_lock[] in do_checkpoint() */
> > @@ -1521,7 +1521,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  		f2fs_release_discard_addrs(sbi);
> >  	else
> >  		f2fs_clear_prefree_segments(sbi, cpc);
> > -
> > +stop:
> >  	unblock_operations(sbi);
> >  	stat_inc_cp_count(sbi->stat_info);
> >  
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index a0c868127a7c..29021dbc8f2a 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2895,7 +2895,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
> >  int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
> >  int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >  			unsigned int segno, struct f2fs_summary_block *sum);
> > -void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> > +int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> >  int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
> >  void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
> >  int __init f2fs_create_node_manager_caches(void);
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 4bcc8a59fdef..c7d14282dbf4 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1070,6 +1070,15 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >  	/* reference all summary page */
> >  	while (segno < end_segno) {
> >  		sum_page = f2fs_get_sum_page(sbi, segno++);
> > +		if (IS_ERR(sum_page)) {
> > +			end_segno = segno - 1;
> > +			for (segno = start_segno; segno < end_segno; segno++) {
> > +				sum_page = find_get_page(META_MAPPING(sbi),
> > +						GET_SUM_BLOCK(sbi, segno));
> > +				f2fs_put_page(sum_page, 0);
> 
> find_get_page() will add one more reference on page, so we need to call
> f2fs_put_page(sum_page, 0) twice.

Done.

> 
> Thanks,
> 
> > +			}
> > +			return PTR_ERR(sum_page);
> > +		}
> >  		unlock_page(sum_page);
> >  	}
> >  
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index fa2381c0bc47..79b6fee354f7 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -126,6 +126,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
> >  
> >  	/* get current nat block page with lock */
> >  	src_page = get_current_nat_page(sbi, nid);
> > +	if (IS_ERR(src_page))
> > +		return src_page;
> >  	dst_page = f2fs_grab_meta_page(sbi, dst_off);
> >  	f2fs_bug_on(sbi, PageDirty(src_page));
> >  
> > @@ -2265,15 +2267,19 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
> >  						nm_i->nat_block_bitmap)) {
> >  			struct page *page = get_current_nat_page(sbi, nid);
> >  
> > -			ret = scan_nat_page(sbi, page, nid);
> > -			f2fs_put_page(page, 1);
> > +			if (IS_ERR(page)) {
> > +				ret = PTR_ERR(page);
> > +			} else {
> > +				ret = scan_nat_page(sbi, page, nid);
> > +				f2fs_put_page(page, 1);
> > +			}
> >  
> >  			if (ret) {
> >  				up_read(&nm_i->nat_tree_lock);
> >  				f2fs_bug_on(sbi, !mount);
> >  				f2fs_msg(sbi->sb, KERN_ERR,
> >  					"NAT is corrupt, run fsck to fix it");
> > -				return -EINVAL;
> > +				return ret;
> >  			}
> >  		}
> >  
> > @@ -2700,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> >  		__clear_bit_le(nat_index, nm_i->full_nat_bits);
> >  }
> >  
> > -static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> > +static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >  		struct nat_entry_set *set, struct cp_control *cpc)
> >  {
> >  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> > @@ -2724,6 +2730,9 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >  		down_write(&curseg->journal_rwsem);
> >  	} else {
> >  		page = get_next_nat_page(sbi, start_nid);
> > +		if (IS_ERR(page))
> > +			return PTR_ERR(page);
> > +
> >  		nat_blk = page_address(page);
> >  		f2fs_bug_on(sbi, !nat_blk);
> >  	}
> > @@ -2769,12 +2778,13 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >  		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
> >  		kmem_cache_free(nat_entry_set_slab, set);
> >  	}
> > +	return 0;
> >  }
> >  
> >  /*
> >   * This function is called during the checkpointing process.
> >   */
> > -void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > +int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  {
> >  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> > @@ -2784,6 +2794,7 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	unsigned int found;
> >  	nid_t set_idx = 0;
> >  	LIST_HEAD(sets);
> > +	int err = 0;
> >  
> >  	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
> >  	if (enabled_nat_bits(sbi, cpc)) {
> > @@ -2793,7 +2804,7 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	}
> >  
> >  	if (!nm_i->dirty_nat_cnt)
> > -		return;
> > +		return 0;
> >  
> >  	down_write(&nm_i->nat_tree_lock);
> >  
> > @@ -2816,11 +2827,16 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	}
> >  
> >  	/* flush dirty nats in nat entry set */
> > -	list_for_each_entry_safe(set, tmp, &sets, set_list)
> > -		__flush_nat_entry_set(sbi, set, cpc);
> > +	list_for_each_entry_safe(set, tmp, &sets, set_list) {
> > +		err = __flush_nat_entry_set(sbi, set, cpc);
> > +		if (err)
> > +			break;
> > +	}
> >  
> >  	up_write(&nm_i->nat_tree_lock);
> >  	/* Allow dirty nats by node block allocation in write_begin */
> > +
> > +	return err;
> >  }
> >  
> >  static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 56d34193a74b..ba678efe7cad 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -355,6 +355,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
> >  	}
> >  
> >  	sum_page = f2fs_get_sum_page(sbi, segno);
> > +	if (IS_ERR(sum_page))
> > +		return PTR_ERR(sum_page);
> >  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
> >  	sum = sum_node->entries[blkoff];
> >  	f2fs_put_page(sum_page, 1);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index aa96a371aaf8..ab7386a7e9d3 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2487,6 +2487,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
> >  	__next_free_blkoff(sbi, curseg, 0);
> >  
> >  	sum_page = f2fs_get_sum_page(sbi, new_segno);
> > +	f2fs_bug_on(sbi, IS_ERR(sum_page));
> >  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
> >  	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
> >  	f2fs_put_page(sum_page, 1);
> > @@ -3971,6 +3972,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
> >  
> >  			se = &sit_i->sentries[start];
> >  			page = get_current_sit_page(sbi, start);
> > +			if (IS_ERR(page))
> > +				return PTR_ERR(page);
> >  			sit_blk = (struct f2fs_sit_block *)page_address(page);
> >  			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
> >  			f2fs_put_page(page, 1);
> > 
