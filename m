From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 14/18] f2fs crypto: add filename encryption
 for f2fs_lookup
Date: Sun, 10 May 2015 22:12:49 -0700
Message-ID: <20150511051249.GA7675@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-14-git-send-email-jaegeuk@kernel.org>
 <55501980.7040206@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55501980.7040206@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: hujianyang <hujianyang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Hujianynag,

I just fixed it up, and rebased the dev branch.
Could you check them out?

Thanks,

On Mon, May 11, 2015 at 10:52:48AM +0800, hujianyang wrote:
> Hi Jaegeuk,
>=20
> While compiling git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk=
/f2fs.git
> branch dev(commit 5af6e74892a f2fs crypto: remove checking key contex=
t during lookup),
> I saw an error:
>=20
> fs/f2fs/dir.c: In function =E2=80=98find_in_level=E2=80=99:
> fs/f2fs/dir.c:163: error: unknown field =E2=80=98len=E2=80=99 specifi=
ed in initializer
> fs/f2fs/dir.c:163: warning: excess elements in struct initializer
> fs/f2fs/dir.c:163: warning: (near initialization for =E2=80=98name=E2=
=80=99)
>=20
> I think it's related to this patch.
> If there is anything wrong in my configuration, please let me know.
>=20
> Thanks,
> Hu
>=20
>=20
>=20
> On 2015/5/9 12:20, Jaegeuk Kim wrote:
> > This patch implements filename encryption support for f2fs_lookup.
> >=20
> > Note that, f2fs_find_entry should be outside of f2fs_(un)lock_op().
> >=20
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/dir.c    | 79 ++++++++++++++++++++++++++++++++------------=
------------
> >  fs/f2fs/f2fs.h   |  9 ++++---
> >  fs/f2fs/inline.c |  9 ++++---
> >  3 files changed, 56 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index ab6455d..5e10d9d 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -76,20 +76,10 @@ static unsigned long dir_block_index(unsigned i=
nt level,
> >  	return bidx;
> >  }
> > =20
> > -static bool early_match_name(size_t namelen, f2fs_hash_t namehash,
> > -				struct f2fs_dir_entry *de)
> > -{
> > -	if (le16_to_cpu(de->name_len) !=3D namelen)
> > -		return false;
> > -
> > -	if (de->hash_code !=3D namehash)
> > -		return false;
> > -
> > -	return true;
> > -}
> > -
> >  static struct f2fs_dir_entry *find_in_block(struct page *dentry_pa=
ge,
> > -				struct qstr *name, int *max_slots,
> > +				struct f2fs_filename *fname,
> > +				f2fs_hash_t namehash,
> > +				int *max_slots,
> >  				struct page **res_page)
> >  {
> >  	struct f2fs_dentry_block *dentry_blk;
> > @@ -99,8 +89,7 @@ static struct f2fs_dir_entry *find_in_block(struc=
t page *dentry_page,
> >  	dentry_blk =3D (struct f2fs_dentry_block *)kmap(dentry_page);
> > =20
> >  	make_dentry_ptr(NULL, &d, (void *)dentry_blk, 1);
> > -	de =3D find_target_dentry(name, max_slots, &d);
> > -
> > +	de =3D find_target_dentry(fname, namehash, max_slots, &d);
> >  	if (de)
> >  		*res_page =3D dentry_page;
> >  	else
> > @@ -114,13 +103,15 @@ static struct f2fs_dir_entry *find_in_block(s=
truct page *dentry_page,
> >  	return de;
> >  }
> > =20
> > -struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *=
max_slots,
> > -						struct f2fs_dentry_ptr *d)
> > +struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *fn=
ame,
> > +			f2fs_hash_t namehash, int *max_slots,
> > +			struct f2fs_dentry_ptr *d)
> >  {
> >  	struct f2fs_dir_entry *de;
> >  	unsigned long bit_pos =3D 0;
> > -	f2fs_hash_t namehash =3D f2fs_dentry_hash(name);
> >  	int max_len =3D 0;
> > +	struct f2fs_str de_name =3D FSTR_INIT(NULL, 0);
> > +	struct f2fs_str *name =3D &fname->disk_name;
> > =20
> >  	if (max_slots)
> >  		*max_slots =3D 0;
> > @@ -132,8 +123,18 @@ struct f2fs_dir_entry *find_target_dentry(stru=
ct qstr *name, int *max_slots,
> >  		}
> > =20
> >  		de =3D &d->dentry[bit_pos];
> > -		if (early_match_name(name->len, namehash, de) &&
> > -			!memcmp(d->filename[bit_pos], name->name, name->len))
> > +
> > +		/* encrypted case */
> > +		de_name.name =3D d->filename[bit_pos];
> > +		de_name.len =3D le16_to_cpu(de->name_len);
> > +
> > +		/* show encrypted name */
> > +		if (fname->hash) {
> > +			if (de->hash_code =3D=3D fname->hash)
> > +				goto found;
> > +		} else if (de_name.len =3D=3D name->len &&
> > +			de->hash_code =3D=3D namehash &&
> > +			!memcmp(de_name.name, name->name, name->len))
> >  			goto found;
> > =20
> >  		if (max_slots && max_len > *max_slots)
> > @@ -155,16 +156,21 @@ found:
> >  }
> > =20
> >  static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> > -			unsigned int level, struct qstr *name,
> > -			f2fs_hash_t namehash, struct page **res_page)
> > +					unsigned int level,
> > +					struct f2fs_filename *fname,
> > +					struct page **res_page)
> >  {
> > -	int s =3D GET_DENTRY_SLOTS(name->len);
> > +	struct qstr name =3D FSTR_TO_QSTR(&fname->disk_name);
> > +	int s =3D GET_DENTRY_SLOTS(name.len);
> >  	unsigned int nbucket, nblock;
> >  	unsigned int bidx, end_block;
> >  	struct page *dentry_page;
> >  	struct f2fs_dir_entry *de =3D NULL;
> >  	bool room =3D false;
> >  	int max_slots;
> > +	f2fs_hash_t namehash;
> > +
> > +	namehash =3D f2fs_dentry_hash(&name);
> > =20
> >  	f2fs_bug_on(F2FS_I_SB(dir), level > MAX_DIR_HASH_DEPTH);
> > =20
> > @@ -183,7 +189,8 @@ static struct f2fs_dir_entry *find_in_level(str=
uct inode *dir,
> >  			continue;
> >  		}
> > =20
> > -		de =3D find_in_block(dentry_page, name, &max_slots, res_page);
> > +		de =3D find_in_block(dentry_page, fname, namehash, &max_slots,
> > +								res_page);
> >  		if (de)
> >  			break;
> > =20
> > @@ -211,30 +218,34 @@ struct f2fs_dir_entry *f2fs_find_entry(struct=
 inode *dir,
> >  {
> >  	unsigned long npages =3D dir_blocks(dir);
> >  	struct f2fs_dir_entry *de =3D NULL;
> > -	f2fs_hash_t name_hash;
> >  	unsigned int max_depth;
> >  	unsigned int level;
> > +	struct f2fs_filename fname;
> > +	int err;
> > =20
> >  	*res_page =3D NULL;
> > =20
> > -	if (f2fs_has_inline_dentry(dir))
> > -		return find_in_inline_dir(dir, child, res_page);
> > +	err =3D f2fs_fname_setup_filename(dir, child, 1, &fname);
> > +	if (err)
> > +		return NULL;
> > +
> > +	if (f2fs_has_inline_dentry(dir)) {
> > +		de =3D find_in_inline_dir(dir, &fname, res_page);
> > +		goto out;
> > +	}
> > =20
> >  	if (npages =3D=3D 0)
> > -		return NULL;
> > +		goto out;
> > =20
> > -	name_hash =3D f2fs_dentry_hash(child);
> >  	max_depth =3D F2FS_I(dir)->i_current_depth;
> > =20
> >  	for (level =3D 0; level < max_depth; level++) {
> > -		de =3D find_in_level(dir, level, child, name_hash, res_page);
> > +		de =3D find_in_level(dir, level, &fname, res_page);
> >  		if (de)
> >  			break;
> >  	}
> > -	if (!de && F2FS_I(dir)->chash !=3D name_hash) {
> > -		F2FS_I(dir)->chash =3D name_hash;
> > -		F2FS_I(dir)->clevel =3D level - 1;
> > -	}
> > +out:
> > +	f2fs_fname_free_filename(&fname);
> >  	return de;
> >  }
> > =20
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 963616f..6898331 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1584,8 +1584,9 @@ struct dentry *f2fs_get_parent(struct dentry =
*child);
> >   */
> >  extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
> >  void set_de_type(struct f2fs_dir_entry *, umode_t);
> > -struct f2fs_dir_entry *find_target_dentry(struct qstr *, int *,
> > -			struct f2fs_dentry_ptr *);
> > +
> > +struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *,
> > +			f2fs_hash_t, int *, struct f2fs_dentry_ptr *);
> >  bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_p=
tr *,
> >  			unsigned int, struct f2fs_str *);
> >  void do_make_empty_dir(struct inode *, struct inode *,
> > @@ -1931,8 +1932,8 @@ int f2fs_convert_inline_page(struct dnode_of_=
data *, struct page *);
> >  int f2fs_convert_inline_inode(struct inode *);
> >  int f2fs_write_inline_data(struct inode *, struct page *);
> >  bool recover_inline_data(struct inode *, struct page *);
> > -struct f2fs_dir_entry *find_in_inline_dir(struct inode *, struct q=
str *,
> > -							struct page **);
> > +struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
> > +				struct f2fs_filename *, struct page **);
> >  struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, stru=
ct page **);
> >  int make_empty_inline_dir(struct inode *inode, struct inode *, str=
uct page *);
> >  int f2fs_add_inline_entry(struct inode *, const struct qstr *, str=
uct inode *,
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index dd51d3f..38e75fb 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -284,23 +284,26 @@ process_inline:
> >  }
> > =20
> >  struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
> > -				struct qstr *name, struct page **res_page)
> > +			struct f2fs_filename *fname, struct page **res_page)
> >  {
> >  	struct f2fs_sb_info *sbi =3D F2FS_SB(dir->i_sb);
> >  	struct f2fs_inline_dentry *inline_dentry;
> > +	struct qstr name =3D FSTR_TO_QSTR(&fname->disk_name);
> >  	struct f2fs_dir_entry *de;
> >  	struct f2fs_dentry_ptr d;
> >  	struct page *ipage;
> > +	f2fs_hash_t namehash;
> > =20
> >  	ipage =3D get_node_page(sbi, dir->i_ino);
> >  	if (IS_ERR(ipage))
> >  		return NULL;
> > =20
> > +	namehash =3D f2fs_dentry_hash(&name);
> > +
> >  	inline_dentry =3D inline_data_addr(ipage);
> > =20
> >  	make_dentry_ptr(NULL, &d, (void *)inline_dentry, 2);
> > -	de =3D find_target_dentry(name, NULL, &d);
> > -
> > +	de =3D find_target_dentry(fname, namehash, NULL, &d);
> >  	unlock_page(ipage);
> >  	if (de)
> >  		*res_page =3D ipage;
> >=20
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
