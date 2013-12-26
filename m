From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3 V2] f2fs: check filename length in
 recover_dentry
Date: Thu, 26 Dec 2013 10:53:39 +0800
Message-ID: <000001cf01e5$c9e8a7c0$5db9f740$@samsung.com>
References: <002201ceff8c$efbd2da0$cf3788e0$@samsung.com>
 <1388012129.2101.302.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1388012129.2101.302.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Thursday, December 26, 2013 6:55 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3 V2] f2fs: check filename length in=
 recover_dentry
>=20
> Hi,
>=20
> 2013-12-23 (=EC=9B=94), 11:12 +0800, Chao Yu:
> > In current flow, we will get Null return value of f2fs_find_entry i=
n
> > recover_dentry when name.len is bigger than F2FS_NAME_LEN, and then=
 we
> > still add this inode into its dir entry.
> > To avoid this situation, we must check filename length before we us=
e it.
> >
> > Another point is that we could remove the code of checking filename=
 length
> > In f2fs_find_entry, because f2fs_lookup will be called previously t=
o ensure of
> > validity of filename length.
>=20
> The f2fs_find_entry is called by f2fs_unlink and f2fs_rename too.

As I check code and test, f2fs_unlink and f2fs_rename is protected by
f2fs_lookup well.
Oldfile/newfile/deletedfile name length is check previously in f2fs_loo=
kup.

> So, you can't remove this, instead it'd be better remove it from
> f2fs_lookup.

I think verification of filename length could not be removed from looku=
p.
Ever you remove it, we could create file in f2fs device with filename l=
ength
that vfs not supported.
In my test, kernel seems not be stable after that kind of file created =
in f2fs.

> Thanks,
>=20
> >
> > V2:
> >  o add WARN_ON() as Jaegeuk Kim suggested.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/dir.c      |    3 ---
> >  fs/f2fs/recovery.c |    6 ++++++
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 07ad850..f0b4630 100644
> > --- a/fs/f2fs/dir.c
> > +++ b/fs/f2fs/dir.c
> > @@ -190,9 +190,6 @@ struct f2fs_dir_entry *f2fs_find_entry(struct i=
node *dir,
> >  	unsigned int max_depth;
> >  	unsigned int level;
> >
> > -	if (unlikely(namelen > F2FS_NAME_LEN))
> > -		return NULL;
> > -
> >  	if (npages =3D=3D 0)
> >  		return NULL;
> >
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index a3f4542..4d411a2 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -62,6 +62,12 @@ static int recover_dentry(struct page *ipage, st=
ruct inode *inode)
> >
> >  	name.len =3D le32_to_cpu(raw_inode->i_namelen);
> >  	name.name =3D raw_inode->i_name;
> > +
> > +	if (unlikely(name.len > F2FS_NAME_LEN)) {
> > +		WARN_ON(1);
> > +		err =3D -ENAMETOOLONG;
> > +		goto out;
> > +	}
> >  retry:
> >  	de =3D f2fs_find_entry(dir, &name, &page);
> >  	if (de && inode->i_ino =3D=3D le32_to_cpu(de->ino))
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
