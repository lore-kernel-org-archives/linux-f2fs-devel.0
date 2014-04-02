From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: avoid free slab cache under spinlock
Date: Wed, 02 Apr 2014 08:52:29 +0800
Message-ID: <000d01cf4e0d$fe278d20$fa76a760$@samsung.com>
References: <000001cf4aff$295d4cd0$7c17e670$@samsung.com>
 <1396353865.12401.2.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1396353865.12401.2.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kim,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Tuesday, April 01, 2014 8:04 PM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel=
=2Eorg;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid free slab cache under=
 spinlock
>=20
> Hi Chao,
>=20
> One minor thing as below.
>=20
> 2014-03-29 (=ED=86=A0), 11:29 +0800, Chao Yu:
> > Move kmem_cache_free out of spinlock protection region for better p=
erformance.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c |   27 +++++++++++++++++----------
> >  fs/f2fs/node.c       |   15 ++++++++++++++-
> >  2 files changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index a80be51..d877f46 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -347,10 +347,11 @@ void remove_orphan_inode(struct f2fs_sb_info =
*sbi, nid_t ino)
> >  	list_for_each_entry(orphan, head, list) {
> >  		if (orphan->ino =3D=3D ino) {
> >  			list_del(&orphan->list);
> > -			kmem_cache_free(orphan_entry_slab, orphan);
> >  			f2fs_bug_on(sbi->n_orphans =3D=3D 0);
> >  			sbi->n_orphans--;
> > -			break;
> > +			spin_unlock(&sbi->orphan_inode_lock);
> > +			kmem_cache_free(orphan_entry_slab, orphan);
> > +			return;
> >  		}
> >  	}
> >  	spin_unlock(&sbi->orphan_inode_lock);
> > @@ -577,6 +578,7 @@ void set_dirty_dir_page(struct inode *inode, st=
ruct page *page)
> >  {
> >  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> >  	struct dir_inode_entry *new;
> > +	int ret =3D 0;
> >
> >  	if (!S_ISDIR(inode->i_mode))
> >  		return;
> > @@ -586,12 +588,13 @@ void set_dirty_dir_page(struct inode *inode, =
struct page *page)
> >  	INIT_LIST_HEAD(&new->list);
> >
> >  	spin_lock(&sbi->dir_inode_lock);
> > -	if (__add_dirty_inode(inode, new))
> > -		kmem_cache_free(inode_entry_slab, new);
> > -
> > +	ret =3D __add_dirty_inode(inode, new);
> >  	inode_inc_dirty_dents(inode);
> >  	SetPagePrivate(page);
> >  	spin_unlock(&sbi->dir_inode_lock);
> > +
> > +	if (ret)
> > +		kmem_cache_free(inode_entry_slab, new);
> >  }
> >
> >  void add_dirty_dir_inode(struct inode *inode)
> > @@ -599,20 +602,22 @@ void add_dirty_dir_inode(struct inode *inode)
> >  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> >  	struct dir_inode_entry *new =3D
> >  			f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
> > +	int ret =3D 0;
> >
> >  	new->inode =3D inode;
> >  	INIT_LIST_HEAD(&new->list);
> >
> >  	spin_lock(&sbi->dir_inode_lock);
> > -	if (__add_dirty_inode(inode, new))
> > -		kmem_cache_free(inode_entry_slab, new);
> > +	ret =3D __add_dirty_inode(inode, new);
> >  	spin_unlock(&sbi->dir_inode_lock);
> > +
> > +	if (ret)
> > +		kmem_cache_free(inode_entry_slab, new);
> >  }
> >
> >  void remove_dirty_dir_inode(struct inode *inode)
> >  {
> >  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> > -
> >  	struct list_head *this, *head;
> >
> >  	if (!S_ISDIR(inode->i_mode))
> > @@ -630,13 +635,15 @@ void remove_dirty_dir_inode(struct inode *ino=
de)
> >  		entry =3D list_entry(this, struct dir_inode_entry, list);
> >  		if (entry->inode =3D=3D inode) {
> >  			list_del(&entry->list);
> > -			kmem_cache_free(inode_entry_slab, entry);
> >  			stat_dec_dirty_dir(sbi);
> > -			break;
> > +			spin_unlock(&sbi->dir_inode_lock);
> > +			kmem_cache_free(inode_entry_slab, entry);
> > +			goto done;
> >  		}
> >  	}
> >  	spin_unlock(&sbi->dir_inode_lock);
> >
> > +done:
> >  	/* Only from the recovery routine */
> >  	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT)) {
> >  		clear_inode_flag(F2FS_I(inode), FI_DELAY_IPUT);
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index eced8d7..0021056 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1314,7 +1314,6 @@ static void __del_from_free_nid_list(struct f=
2fs_nm_info *nm_i,
> >  {
> >  	list_del(&i->list);
> >  	radix_tree_delete(&nm_i->free_nid_root, i->nid);
> > -	kmem_cache_free(free_nid_slab, i);
> >  }
> >
> >  static int add_free_nid(struct f2fs_nm_info *nm_i, nid_t nid, bool=
 build)
> > @@ -1361,13 +1360,19 @@ static int add_free_nid(struct f2fs_nm_info=
 *nm_i, nid_t nid, bool
> build)
> >  static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)
> >  {
> >  	struct free_nid *i;
> > +	bool need_free =3D false;
> > +
> >  	spin_lock(&nm_i->free_nid_list_lock);
> >  	i =3D __lookup_free_nid_list(nm_i, nid);
> >  	if (i && i->state =3D=3D NID_NEW) {
> >  		__del_from_free_nid_list(nm_i, i);
> >  		nm_i->fcnt--;
> > +		need_free =3D true;
> >  	}
> >  	spin_unlock(&nm_i->free_nid_list_lock);
> > +
> > +	if (need_free)
> > +		kmem_cache_free(free_nid_slab, i);
> >  }
> >
> >  static void scan_nat_page(struct f2fs_nm_info *nm_i,
> > @@ -1492,6 +1497,8 @@ void alloc_nid_done(struct f2fs_sb_info *sbi,=
 nid_t nid)
> >  	f2fs_bug_on(!i || i->state !=3D NID_ALLOC);
> >  	__del_from_free_nid_list(nm_i, i);
> >  	spin_unlock(&nm_i->free_nid_list_lock);
> > +
> > +	kmem_cache_free(free_nid_slab, i);
> >  }
> >
> >  /*
> > @@ -1501,6 +1508,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sb=
i, nid_t nid)
> >  {
> >  	struct f2fs_nm_info *nm_i =3D NM_I(sbi);
> >  	struct free_nid *i;
> > +	bool need_free =3D false;
> >
> >  	if (!nid)
> >  		return;
> > @@ -1510,11 +1518,15 @@ void alloc_nid_failed(struct f2fs_sb_info *=
sbi, nid_t nid)
> >  	f2fs_bug_on(!i || i->state !=3D NID_ALLOC);
> >  	if (!available_free_memory(nm_i, FREE_NIDS)) {
> >  		__del_from_free_nid_list(nm_i, i);
> > +		need_free =3D true;
> >  	} else {
> >  		i->state =3D NID_NEW;
> >  		nm_i->fcnt++;
> >  	}
> >  	spin_unlock(&nm_i->free_nid_list_lock);
> > +
> > +	if (need_free)
> > +		kmem_cache_free(free_nid_slab, i);
> >  }
> >
> >  void recover_node_page(struct f2fs_sb_info *sbi, struct page *page=
,
> > @@ -1926,6 +1938,7 @@ void destroy_node_manager(struct f2fs_sb_info=
 *sbi)
> >  		f2fs_bug_on(i->state =3D=3D NID_ALLOC);
> >  		__del_from_free_nid_list(nm_i, i);
> >  		nm_i->fcnt--;
> > +		kmem_cache_free(free_nid_slab, i);
>=20
> It seems that we need to do this too.
>=20
>                spin_unlock(&nm_i->free_nid_list_lock);
>                kmem_cache_free(free_nid_slab, i);
>                spin_lock(&nm_i->free_nid_list_lock);
>=20
> Right?

You're right, I will send patch v2.
Thanks for your review.

>=20
> >  	}
> >  	f2fs_bug_on(nm_i->fcnt);
> >  	spin_unlock(&nm_i->free_nid_list_lock);
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
