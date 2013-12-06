From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/5 V2] f2fs: add unlikely() macro for compiler
 optimization
Date: Fri, 06 Dec 2013 12:27:24 +0800
Message-ID: <000201cef23b$9c0f1730$d42d4590$@samsung.com>
References: <000001cef19a$a4bed330$ee3c7990$@samsung.com>
 <1386303123.2101.18.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1386303123.2101.18.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Friday, December 06, 2013 12:12 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> Subject: Re: [f2fs-dev] [PATCH 2/5 V2] f2fs: add unlikely() macro for=
 compiler optimization
>=20
> Hi,
>=20
> Just in case, if you agreed the following comments, I'll fix those an=
d
> merge the patch by myself.
> Thanks,

Agreed, thanks.

>=20
> 2013-12-05 (=EB=AA=A9), 17:15 +0800, Chao Yu:
> > As we know, some of our branch condition will rarely be true. So we=
 could add
> > 'unlikely' to let compiler optimize these code, by this way we coul=
d drop
> > unneeded 'jump' assemble code to improve performance.
> >
> > change log:
> >  o add *unlikely* as many as possible across the whole source files=
 at once
> >    suggested by Jaegeuk Kim.
> >
> > Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c |   10 +++++-----
> >  fs/f2fs/data.c       |    4 ++--
> >  fs/f2fs/dir.c        |    4 ++--
> >  fs/f2fs/f2fs.h       |    8 ++++----
> >  fs/f2fs/node.c       |   16 ++++++++--------
> >  fs/f2fs/segment.h    |    2 +-
> >  6 files changed, 22 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 38f4a224..6580808 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -82,8 +82,8 @@ static int f2fs_write_meta_page(struct page *page=
,
> >  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> >
> >  	/* Should not write any meta pages, if any IO error was occurred =
*/
> > -	if (wbc->for_reclaim || sbi->por_doing ||
> > -			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)) {
> > +	if (unlikely(wbc->for_reclaim || sbi->por_doing ||
> > +			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG))) {
>=20
> 	if (unlikely(sbi->por_doing || is_set_ckpt_flags(F2FS_CKPT(sbi),
> CP_ERROR_FLAG)))
> 		goto redirty_out;
> 	if (wbc->for_reclaim)
> 		goto redirty_out;
>=20
> redirty_out:
> >  		dec_page_count(sbi, F2FS_DIRTY_META);
> >  		wbc->pages_skipped++;
> >  		set_page_dirty(page);
> > @@ -137,7 +137,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, =
enum page_type type,
> >  		nr_pages =3D pagevec_lookup_tag(&pvec, mapping, &index,
> >  				PAGECACHE_TAG_DIRTY,
> >  				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
> > -		if (nr_pages =3D=3D 0)
> > +		if (unlikely(nr_pages =3D=3D 0))
> >  			break;
> >
> >  		for (i =3D 0; i < nr_pages; i++) {
> > @@ -150,7 +150,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, =
enum page_type type,
> >  				unlock_page(page);
> >  				break;
> >  			}
> > -			if (nwritten++ >=3D nr_to_write)
> > +			if (unlikely(nwritten++ >=3D nr_to_write))
>=20
> nwritten++;
>=20
> if (unlikely(nwritten >=3D nr_to_write))
>=20
>=20
> >  				break;
> >  		}
> >  		pagevec_release(&pvec);
> > @@ -200,7 +200,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *s=
bi)
> >  	max_orphans =3D (sbi->blocks_per_seg - 2 - NR_CURSEG_TYPE)
> >  				* F2FS_ORPHANS_PER_BLOCK;
> >  	mutex_lock(&sbi->orphan_inode_mutex);
> > -	if (sbi->n_orphans >=3D max_orphans)
> > +	if (unlikely(sbi->n_orphans >=3D max_orphans))
> >  		err =3D -ENOSPC;
> >  	else
> >  		sbi->n_orphans++;
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 4e2fc09..2ce5a9e 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -251,7 +251,7 @@ int reserve_new_block(struct dnode_of_data *dn)
> >
> >  	if (is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC))
> >  		return -EPERM;
> > -	if (!inc_valid_block_count(sbi, dn->inode, 1))
> > +	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
> >  		return -ENOSPC;
> >
> >  	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node)=
;
> > @@ -711,7 +711,7 @@ static int f2fs_write_data_page(struct page *pa=
ge,
> >
> >  	zero_user_segment(page, offset, PAGE_CACHE_SIZE);
> >  write:
> > -	if (sbi->por_doing) {
> > +	if (unlikely(sbi->por_doing)) {
> >  		err =3D AOP_WRITEPAGE_ACTIVATE;
> >  		goto redirty_out;
> >  	}
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 594fc1b..0cc26ba 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -190,7 +190,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct i=
node *dir,
> >  	unsigned int max_depth;
> >  	unsigned int level;
> >
> > -	if (namelen > F2FS_NAME_LEN)
> > +	if (unlikely(namelen > F2FS_NAME_LEN))
> >  		return NULL;
> >
> >  	if (npages =3D=3D 0)
> > @@ -461,7 +461,7 @@ int __f2fs_add_link(struct inode *dir, const st=
ruct qstr *name, struct inode *in
> >  	}
> >
> >  start:
> > -	if (current_depth =3D=3D MAX_DIR_HASH_DEPTH)
> > +	if (unlikely(current_depth =3D=3D MAX_DIR_HASH_DEPTH))
> >  		return -ENOSPC;
> >
> >  	/* Increase the depth, if required */
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 10eca02..dca18b3 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -574,7 +574,7 @@ static inline void f2fs_unlock_all(struct f2fs_=
sb_info *sbi)
> >  static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t =
nid)
> >  {
> >  	WARN_ON((nid >=3D NM_I(sbi)->max_nid));
> > -	if (nid >=3D NM_I(sbi)->max_nid)
> > +	if (unlikely(nid >=3D NM_I(sbi)->max_nid))
> >  		return -EINVAL;
> >  	return 0;
> >  }
> > @@ -600,7 +600,7 @@ static inline bool inc_valid_block_count(struct=
 f2fs_sb_info *sbi,
> >  	spin_lock(&sbi->stat_lock);
> >  	valid_block_count =3D
> >  		sbi->total_valid_block_count + (block_t)count;
> > -	if (valid_block_count > sbi->user_block_count) {
> > +	if (unlikely(valid_block_count > sbi->user_block_count)) {
> >  		spin_unlock(&sbi->stat_lock);
> >  		return false;
> >  	}
> > @@ -719,13 +719,13 @@ static inline bool inc_valid_node_count(struc=
t f2fs_sb_info *sbi,
> >  	spin_lock(&sbi->stat_lock);
> >
> >  	valid_block_count =3D sbi->total_valid_block_count + 1;
> > -	if (valid_block_count > sbi->user_block_count) {
> > +	if (unlikely(valid_block_count > sbi->user_block_count)) {
> >  		spin_unlock(&sbi->stat_lock);
> >  		return false;
> >  	}
> >
> >  	valid_node_count =3D sbi->total_valid_node_count + 1;
> > -	if (valid_node_count > sbi->total_node_count) {
> > +	if (unlikely(valid_node_count > sbi->total_node_count)) {
> >  		spin_unlock(&sbi->stat_lock);
> >  		return false;
> >  	}
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 5e2588f..48cbf76 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -94,7 +94,7 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi=
, int nid)
> >  	int i;
> >
> >  	for (i =3D 0; i < FREE_NID_PAGES; i++, nid +=3D NAT_ENTRY_PER_BLO=
CK) {
> > -		if (nid >=3D nm_i->max_nid)
> > +		if (unlikely(nid >=3D nm_i->max_nid))
> >  			nid =3D 0;
> >  		index =3D current_nat_addr(sbi, nid);
> >
> > @@ -1160,7 +1160,7 @@ int wait_on_node_pages_writeback(struct f2fs_=
sb_info *sbi, nid_t ino)
> >  			struct page *page =3D pvec.pages[i];
> >
> >  			/* until radix tree lookup accepts end_index */
> > -			if (page->index > end)
> > +			if (unlikely(page->index > end))
> >  				continue;
> >
> >  			if (ino && ino_of_node(page) =3D=3D ino) {
> > @@ -1190,7 +1190,7 @@ static int f2fs_write_node_page(struct page *=
page,
> >  	block_t new_addr;
> >  	struct node_info ni;
> >
> > -	if (sbi->por_doing)
> > +	if (unlikely(sbi->por_doing))
> >  		goto redirty_out;
> >
> >  	wait_on_page_writeback(page);
> > @@ -1326,7 +1326,7 @@ static int add_free_nid(struct f2fs_nm_info *=
nm_i, nid_t nid, bool build)
> >  		return -1;
> >
> >  	/* 0 nid should not be used */
> > -	if (nid =3D=3D 0)
> > +	if (unlikely(nid =3D=3D 0))
> >  		return 0;
> >
> >  	if (build) {
> > @@ -1379,7 +1379,7 @@ static void scan_nat_page(struct f2fs_nm_info=
 *nm_i,
> >
> >  	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
> >
> > -		if (start_nid >=3D nm_i->max_nid)
> > +		if (unlikely(start_nid >=3D nm_i->max_nid))
> >  			break;
> >
> >  		blk_addr =3D le32_to_cpu(nat_blk->entries[i].block_addr);
> > @@ -1413,7 +1413,7 @@ static void build_free_nids(struct f2fs_sb_in=
fo *sbi)
> >  		f2fs_put_page(page, 1);
> >
> >  		nid +=3D (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
> > -		if (nid >=3D nm_i->max_nid)
> > +		if (unlikely(nid >=3D nm_i->max_nid))
> >  			nid =3D 0;
> >
> >  		if (i++ =3D=3D FREE_NID_PAGES)
> > @@ -1447,7 +1447,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_=
t *nid)
> >  	struct free_nid *i =3D NULL;
> >  	struct list_head *this;
> >  retry:
> > -	if (sbi->total_valid_node_count + 1 >=3D nm_i->max_nid)
> > +	if (unlikely(sbi->total_valid_node_count + 1 >=3D nm_i->max_nid))
> >  		return false;
> >
> >  	spin_lock(&nm_i->free_nid_list_lock);
> > @@ -1557,7 +1557,7 @@ int recover_inode_page(struct f2fs_sb_info *s=
bi, struct page *page)
> >  	new_ni =3D old_ni;
> >  	new_ni.ino =3D ino;
> >
> > -	if (!inc_valid_node_count(sbi, NULL))
> > +	if (unlikely(!inc_valid_node_count(sbi, NULL)))
> >  		WARN_ON(1);
> >  	set_node_addr(sbi, &new_ni, NEW_ADDR);
> >  	inc_valid_inode_count(sbi);
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 26812fc..ea56376 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -457,7 +457,7 @@ static inline bool has_not_enough_free_secs(str=
uct f2fs_sb_info *sbi, int freed)
> >  	int node_secs =3D get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> >  	int dent_secs =3D get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> >
> > -	if (sbi->por_doing)
> > +	if (unlikely(sbi->por_doing))
> >  		return false;
> >
> >  	return ((free_sections(sbi) + freed) <=3D (node_secs + 2 * dent_s=
ecs +
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
