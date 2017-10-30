From: Fan Li <fanofcode.li@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: add a function to move nid
Date: Mon, 30 Oct 2017 19:50:01 +0800
Message-ID: <001101d35175$54987f20$fdc97d60$@samsung.com>
References: <CGME20171028110400epcas1p2cd8fd0105884f449b5116b1ee9cf6092@epcas1p2.samsung.com>
        <000001d34fdc$7d461260$77d23720$@samsung.com>
        <70867f4c-e865-2acb-472a-8f24a7588d91@kernel.org>
        <20171030093026.GB26880@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171030093026.GB26880@jaegeuk-macbookpro.roam.corp.google.com>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Chao Yu' <chao@kernel.org>
Cc: 'Chao Yu' <yuchao0@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, October 30, 2017 5:30 PM
> To: Chao Yu
> Cc: Fan Li; 'Chao Yu'; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: add a function to move nid
> 
> On 10/28, Chao Yu wrote:
> > On 2017/10/28 19:03, Fan Li wrote:
> > > This patch add a new function to move nid from one state to another.
> > > Move operation is heavily used, by adding a new function for it we
> > > can cut down some branches from several flow.
> > >
> > >
> > > Signed-off-by: Fan li <fanofcode.li@samsung.com>
> > > ---
> > >  fs/f2fs/node.c | 51
> > > ++++++++++++++++++++++++++++++---------------------
> > >  1 file changed, 30 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index ac629d6..8116b50
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -1763,15 +1763,13 @@ static struct free_nid
> > > *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,  }
> > >
> > >  static int __insert_free_nid(struct f2fs_sb_info *sbi,
> > > -			struct free_nid *i, enum nid_state state, bool new)
> > > +			struct free_nid *i, enum nid_state state)
> > >  {
> > >  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> > >
> > > -	if (new) {
> > > -		int err = radix_tree_insert(&nm_i->free_nid_root, i->nid, i);
> > > -		if (err)
> > > -			return err;
> > > -	}
> > > +	int err = radix_tree_insert(&nm_i->free_nid_root, i->nid, i);
> > > +	if (err)
> > > +		return err;
> > >
> > >  	f2fs_bug_on(sbi, state != i->state);
> > >  	nm_i->nid_cnt[state]++;
> > > @@ -1781,7 +1779,7 @@ static int __insert_free_nid(struct
> > > f2fs_sb_info *sbi,  }
> > >
> > >  static void __remove_free_nid(struct f2fs_sb_info *sbi,
> > > -			struct free_nid *i, enum nid_state state, bool reuse)
> > > +			struct free_nid *i, enum nid_state state)
> > >  {
> > >  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> > >
> > > @@ -1789,8 +1787,23 @@ static void __remove_free_nid(struct f2fs_sb_info *sbi,
> > >  	nm_i->nid_cnt[state]--;
> > >  	if (state == FREE_NID)
> > >  		list_del(&i->list);
> > > -	if (!reuse)
> > > -		radix_tree_delete(&nm_i->free_nid_root, i->nid);
> > > +	radix_tree_delete(&nm_i->free_nid_root, i->nid); }
> > > +
> > > +static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
> > > +			enum nid_state org_state, enum nid_state dst_state) {
> > > +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> > > +
> > > +	f2fs_bug_on(sbi, org_state != i->state);
> > > +	i->state = dst_state;
> > > +	nm_i->nid_cnt[org_state]--;
> > > +	nm_i->nid_cnt[dst_state]++;
> > > +
> > > +	if (org_state == FREE_NID)
> >
> > Welcome back to community, Fan. :)
> >
> > Minor, how about "if (dst_stat == PREALLOC_NID)" ?
> 
> How about this?
> 
> switch (dst_state) {
> 	case PREALLOC_NID:
> 		list_del(&i->list);
> 		break;
> 	case FREE_NID:
> 		list_add_tail(&i->list, &nm_i->free_nid_list);
> 		break;
> 	default:
> 		BUG_ON(1);
> };
> 

I had thought about it, the reason why I finally chose the current version is because 
" dst_state== PREALLOC_NID" implies that all states other than PREALLOC_NID
are in a list, so we need to call list_del.
Of course it's true now, but in the future if we add more states which aren't in a list,
it would be harder for us to track this branch to modify it since it's not related to 
FREE_NID explicitly.

However the difference is trivial, if you think it's not a big deal, it's fine by me.

> >
> > Otherwise this patch looks good to me, anyway, you can add:
> >
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >
> > Thanks,
> >
> > > +		list_del(&i->list);
> > > +	else if (dst_state == FREE_NID)
> > > +		list_add_tail(&i->list, &nm_i->free_nid_list);
> > >  }
> > >
> > >  /* return if the nid is recognized as free */ @@ -1850,7 +1863,7 @@
> > > static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
> > >  		}
> > >  	}
> > >  	ret = true;
> > > -	err = __insert_free_nid(sbi, i, FREE_NID, true);
> > > +	err = __insert_free_nid(sbi, i, FREE_NID);
> > >  err_out:
> > >  	spin_unlock(&nm_i->nid_list_lock);
> > >  	radix_tree_preload_end();
> > > @@ -1869,7 +1882,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
> > >  	spin_lock(&nm_i->nid_list_lock);
> > >  	i = __lookup_free_nid_list(nm_i, nid);
> > >  	if (i && i->state == FREE_NID) {
> > > -		__remove_free_nid(sbi, i, FREE_NID, false);
> > > +		__remove_free_nid(sbi, i, FREE_NID);
> > >  		need_free = true;
> > >  	}
> > >  	spin_unlock(&nm_i->nid_list_lock);
> > > @@ -2080,9 +2093,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
> > >  					struct free_nid, list);
> > >  		*nid = i->nid;
> > >
> > > -		__remove_free_nid(sbi, i, FREE_NID, true);
> > > -		i->state = PREALLOC_NID;
> > > -		__insert_free_nid(sbi, i, PREALLOC_NID, false);
> > > +		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
> > >  		nm_i->available_nids--;
> > >
> > >  		update_free_nid_bitmap(sbi, *nid, false, false); @@ -2108,7
> > > +2119,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
> > >  	spin_lock(&nm_i->nid_list_lock);
> > >  	i = __lookup_free_nid_list(nm_i, nid);
> > >  	f2fs_bug_on(sbi, !i);
> > > -	__remove_free_nid(sbi, i, PREALLOC_NID, false);
> > > +	__remove_free_nid(sbi, i, PREALLOC_NID);
> > >  	spin_unlock(&nm_i->nid_list_lock);
> > >
> > >  	kmem_cache_free(free_nid_slab, i); @@ -2131,12 +2142,10 @@ void
> > > alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
> > >  	f2fs_bug_on(sbi, !i);
> > >
> > >  	if (!available_free_memory(sbi, FREE_NIDS)) {
> > > -		__remove_free_nid(sbi, i, PREALLOC_NID, false);
> > > +		__remove_free_nid(sbi, i, PREALLOC_NID);
> > >  		need_free = true;
> > >  	} else {
> > > -		__remove_free_nid(sbi, i, PREALLOC_NID, true);
> > > -		i->state = FREE_NID;
> > > -		__insert_free_nid(sbi, i, FREE_NID, false);
> > > +		__move_free_nid(sbi, i, PREALLOC_NID, FREE_NID);
> > >  	}
> > >
> > >  	nm_i->available_nids++;
> > > @@ -2167,7 +2176,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
> > >  				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
> > >  			break;
> > >
> > > -		__remove_free_nid(sbi, i, FREE_NID, false);
> > > +		__remove_free_nid(sbi, i, FREE_NID);
> > >  		kmem_cache_free(free_nid_slab, i);
> > >  		nr_shrink--;
> > >  	}
> > > @@ -2746,7 +2755,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
> > >  	/* destroy free nid list */
> > >  	spin_lock(&nm_i->nid_list_lock);
> > >  	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
> > > -		__remove_free_nid(sbi, i, FREE_NID, false);
> > > +		__remove_free_nid(sbi, i, FREE_NID);
> > >  		spin_unlock(&nm_i->nid_list_lock);
> > >  		kmem_cache_free(free_nid_slab, i);
> > >  		spin_lock(&nm_i->nid_list_lock);
> > >
