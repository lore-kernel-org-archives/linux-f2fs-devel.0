From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev 3/5] f2fs: Add a new function: f2fs_reserve_block()
Date: Mon, 28 Oct 2013 21:28:16 +0900
Message-ID: <1382963296.992.108.camel@kjgkr>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
 <1382716919-23345-4-git-send-email-huajun.li.lee@gmail.com>
 <1382962607.992.104.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382962607.992.104.camel@kjgkr>
Sender: linux-kernel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

2013-10-28 (=EC=9B=94), 21:16 +0900, Jaegeuk Kim:
Hi,

>=20
> 2013-10-26 (=ED=86=A0), 00:01 +0800, Huajun Li:
> > From: Huajun Li <huajun.li@intel.com>
> >=20
> > Add the function f2fs_reserve_block() to easily reserve new blocks.
> >=20
> > Signed-off-by: Huajun Li <huajun.li@intel.com>
> > Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
> > Signed-off-by: Weihong Xu <weihong.xu@intel.com>
> > ---
> >  fs/f2fs/data.c |   29 ++++++++++++++++++-----------
> >  fs/f2fs/f2fs.h |    1 +
> >  2 files changed, 19 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index c8887d8..7b31911 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -64,6 +64,23 @@ int reserve_new_block(struct dnode_of_data *dn)
> >  	return 0;
> >  }
> > =20
> > +int f2fs_reserve_block(struct inode *inode,
> > +		       struct dnode_of_data *dn, pgoff_t index)
>=20

We don't need to get dnode_of_data from parameters, since it is
used by this function only.

>=20
> > +{
> > +	int err;

+        struct dnode_of_data dn;

>=20
> > +
> > +	set_new_dnode(dn, inode, NULL, NULL, 0);
> > +	err =3D get_dnode_of_data(dn, index, ALLOC_NODE);
> > +	if (err)
> > +		return err;
> > +	if (dn->data_blkaddr =3D=3D NULL_ADDR)
> > +		err =3D reserve_new_block(dn);
> > +
> > +	f2fs_put_dnode(dn);
> > +
> > +	return err;
> > +}
> > +
>=20

--=20
Jaegeuk Kim
Samsung
