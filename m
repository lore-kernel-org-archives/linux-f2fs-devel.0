From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3] f2fs: check filename length in
 recover_dentry
Date: Mon, 23 Dec 2013 10:28:52 +0800
Message-ID: <002101ceff86$d50072c0$7f015840$@samsung.com>
References: <000001cefe33$b62a0f40$227e2dc0$@samsung.com>
 <1387761931.2101.289.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387761931.2101.289.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kim,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Monday, December 23, 2013 9:26 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: check filename length in re=
cover_dentry
>=20
> 2013-12-21 (=ED=86=A0), 18:01 +0800, Chao Yu:
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
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/dir.c      |    3 ---
> >  fs/f2fs/recovery.c |    5 +++++
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > index 0cc26ba..3f3b661 100644
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
> > index a3f4542..fdd175b 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -62,6 +62,11 @@ static int recover_dentry(struct page *ipage, st=
ruct inode *inode)
> >
> >  	name.len =3D le32_to_cpu(raw_inode->i_namelen);
> >  	name.name =3D raw_inode->i_name;
> > +
> > +	if (unlikely(name.len > F2FS_NAME_LEN)) {
> > +		err =3D -ENAMETOOLONG;
> > +		goto out;
> > +	}
>=20
> Have you seen this before?

Not yet.

> This is a trivial bug case, so, if you have got this bug, we should f=
ix
> the bug first instead of adding any workaround patch.

What I worry about is that not only f2fs bug lead to this trivial probl=
em,
but also other program with operation in raw disk could do this.

> Let's add WARN_ON() at least.

Alright.
Thanks.

> Thanks,
>=20
> >  retry:
> >  	de =3D f2fs_find_entry(dir, &name, &page);
> >  	if (de && inode->i_ino =3D=3D le32_to_cpu(de->ino))
>=20
> --
> Jaegeuk Kim
> Samsung
