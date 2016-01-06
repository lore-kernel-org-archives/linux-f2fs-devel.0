From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/3] f2fs: cover more area with nat_tree_lock
Date: Wed, 06 Jan 2016 11:57:23 +0800
Message-ID: <010a01d14836$73842910$5a8c7b30$@samsung.com>
References: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
	<1451784366-14261-2-git-send-email-jaegeuk@kernel.org>
	<00a201d1479c$3e48be40$bada3ac0$@samsung.com>
	<20160105175755.GB2618@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aGfEp-0001Kb-EX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 03:58:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aGfEm-0006RJ-Tv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 03:58:19 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0I02ELIJ0OPY70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jan 2016 12:58:08 +0900 (KST)
In-reply-to: <20160105175755.GB2618@jaegeuk>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, January 06, 2016 1:58 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: cover more area with nat_tree_lock
> 
> Hi Chao,
> 
> On Tue, Jan 05, 2016 at 05:33:31PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Sunday, January 03, 2016 9:26 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 2/3] f2fs: cover more area with nat_tree_lock
> > >
> > > There was a subtle bug on nat cache management which incurs wrong nid allocation
> > > or wrong block addresses when try_to_free_nats is triggered heavily.
> > > This patch enlarges the previous coverage of nat_tree_lock to avoid data race.
> >
> > Have you figured out how this happen? I'm curious about this issue,
> > since still I can't reproduce it and find any clue by reviewing code
> > so far.
> 
> It's very very subtle bug. I got one panic after 2-days fsstress execution with
> flushing caches very frequently.
> The possible scenario was to mix a lot of directory operations, f2fs's shrinking
> path, and fsyncing files.
> 
> And, the suspicious functions are
>  - try_to_free_nats,
>  - f2fs_find_entry->get_node_page->get_node_info->cache_nat_entry
>  - fsync->checkpoint->flush_nat_entries
>  - build_free_nids

Thanks for your detailed explanation and clues. :)

After I investigate just now, I found one possible case:

- get_node_info
  1. miss cache in nat cache, because valid & dirty nat entry is exist in
     journal cache of curseg
  2. miss cache in journal cache of curseg, because concurrent checkpoint
     merge journal cache into nat cache before flushing.
  3. checkpoint flush valid nat entry (blkaddr is NULL) from nat cache
     to journal cache, and add it to free nid cache.
  4. try_to_free_nats free the clean nat entry in cache.
  5. get old nat entry(blkaddr is non-NULL, last valid one is store in
     journal of curseg) after get_current_nat_page, we update nat cache
     with old nat entry.

Is that right?

Thanks,

> 
> I guess there is somewhat data race to grab and release nat cache entries when
> flush_nat_entries is doing, since f2fs_find_entry is not covered by
> f2fs_lock_op.
> 
> A good thing is that, with this patch, I couldn't get any bug again for 4 days;
> still running tho.
> 
> Nevertheless, I couldn't describe this precisely, since I couldn't specify the
> real root-cause.
> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/node.c | 29 ++++++++++++-----------------
> > >  1 file changed, 12 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > index 669c44e..4dab09f 100644
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -262,13 +262,11 @@ static void cache_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
> > >  {
> > >  	struct nat_entry *e;
> > >
> > > -	down_write(&nm_i->nat_tree_lock);
> > >  	e = __lookup_nat_cache(nm_i, nid);
> > >  	if (!e) {
> > >  		e = grab_nat_entry(nm_i, nid);
> > >  		node_info_from_raw_nat(&e->ni, ne);
> > >  	}
> > > -	up_write(&nm_i->nat_tree_lock);
> > >  }
> > >
> > >  static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
> > > @@ -380,6 +378,8 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info
> > > *ni)
> > >
> > >  	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
> > >
> > > +	down_write(&nm_i->nat_tree_lock);
> > > +
> > >  	/* Check current segment summary */
> > >  	mutex_lock(&curseg->curseg_mutex);
> > >  	i = lookup_journal_in_cursum(sum, NAT_JOURNAL, nid, 0);
> > > @@ -400,6 +400,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info
> > > *ni)
> > >  cache:
> > >  	/* cache nat entry */
> > >  	cache_nat_entry(NM_I(sbi), nid, &ne);
> > > +	up_write(&nm_i->nat_tree_lock);
> > >  }
> > >
> > >  /*
> > > @@ -1459,13 +1460,10 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool
> build)
> > >
> > >  	if (build) {
> > >  		/* do not add allocated nids */
> > > -		down_read(&nm_i->nat_tree_lock);
> > >  		ne = __lookup_nat_cache(nm_i, nid);
> > > -		if (ne &&
> > > -			(!get_nat_flag(ne, IS_CHECKPOINTED) ||
> > > +		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
> > >  				nat_get_blkaddr(ne) != NULL_ADDR))
> > >  			allocated = true;
> > > -		up_read(&nm_i->nat_tree_lock);
> > >  		if (allocated)
> > >  			return 0;
> > >  	}
> > > @@ -1551,6 +1549,8 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
> > >  	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
> > >  							META_NAT, true);
> > >
> > > +	down_read(&nm_i->nat_tree_lock);
> > > +
> > >  	while (1) {
> > >  		struct page *page = get_current_nat_page(sbi, nid);
> > >
> > > @@ -1579,6 +1579,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
> > >  			remove_free_nid(nm_i, nid);
> > >  	}
> > >  	mutex_unlock(&curseg->curseg_mutex);
> > > +	up_read(&nm_i->nat_tree_lock);
> > >
> > >  	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
> > >  					nm_i->ra_nid_pages, META_NAT, false);
> > > @@ -1861,14 +1862,12 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
> > >
> > >  		raw_ne = nat_in_journal(sum, i);
> > >
> > > -		down_write(&nm_i->nat_tree_lock);
> > >  		ne = __lookup_nat_cache(nm_i, nid);
> > >  		if (!ne) {
> > >  			ne = grab_nat_entry(nm_i, nid);
> > >  			node_info_from_raw_nat(&ne->ni, &raw_ne);
> > >  		}
> > >  		__set_nat_cache_dirty(nm_i, ne);
> > > -		up_write(&nm_i->nat_tree_lock);
> > >  	}
> > >  	update_nats_in_cursum(sum, -i);
> > >  	mutex_unlock(&curseg->curseg_mutex);
> > > @@ -1902,7 +1901,6 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> > >  	struct f2fs_nat_block *nat_blk;
> > >  	struct nat_entry *ne, *cur;
> > >  	struct page *page = NULL;
> > > -	struct f2fs_nm_info *nm_i = NM_I(sbi);
> > >
> > >  	/*
> > >  	 * there are two steps to flush nat entries:
> > > @@ -1939,12 +1937,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> > >  			raw_ne = &nat_blk->entries[nid - start_nid];
> > >  		}
> > >  		raw_nat_from_node_info(raw_ne, &ne->ni);
> > > -
> > > -		down_write(&NM_I(sbi)->nat_tree_lock);
> > >  		nat_reset_flag(ne);
> > >  		__clear_nat_cache_dirty(NM_I(sbi), ne);
> > > -		up_write(&NM_I(sbi)->nat_tree_lock);
> > > -
> > >  		if (nat_get_blkaddr(ne) == NULL_ADDR)
> > >  			add_free_nid(sbi, nid, false);
> > >  	}
> > > @@ -1956,9 +1950,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> > >
> > >  	f2fs_bug_on(sbi, set->entry_cnt);
> > >
> > > -	down_write(&nm_i->nat_tree_lock);
> > >  	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
> > > -	up_write(&nm_i->nat_tree_lock);
> > >  	kmem_cache_free(nat_entry_set_slab, set);
> > >  }
> > >
> > > @@ -1978,6 +1970,9 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
> > >
> > >  	if (!nm_i->dirty_nat_cnt)
> > >  		return;
> > > +
> > > +	down_write(&nm_i->nat_tree_lock);
> > > +
> > >  	/*
> > >  	 * if there are no enough space in journal to store dirty nat
> > >  	 * entries, remove all entries from journal and merge them
> > > @@ -1986,7 +1981,6 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
> > >  	if (!__has_cursum_space(sum, nm_i->dirty_nat_cnt, NAT_JOURNAL))
> > >  		remove_nats_in_journal(sbi);
> > >
> > > -	down_write(&nm_i->nat_tree_lock);
> > >  	while ((found = __gang_lookup_nat_set(nm_i,
> > >  					set_idx, SETVEC_SIZE, setvec))) {
> > >  		unsigned idx;
> > > @@ -1995,12 +1989,13 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
> > >  			__adjust_nat_entry_set(setvec[idx], &sets,
> > >  							MAX_NAT_JENTRIES(sum));
> > >  	}
> > > -	up_write(&nm_i->nat_tree_lock);
> > >
> > >  	/* flush dirty nats in nat entry set */
> > >  	list_for_each_entry_safe(set, tmp, &sets, set_list)
> > >  		__flush_nat_entry_set(sbi, set);
> > >
> > > +	up_write(&nm_i->nat_tree_lock);
> > > +
> > >  	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
> > >  }
> > >
> > > --
> > > 2.6.3
> > >
> > >
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
