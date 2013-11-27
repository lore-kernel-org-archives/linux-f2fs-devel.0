From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: remove unneeded code in punch_hole
Date: Wed, 27 Nov 2013 13:25:37 +0800
Message-ID: <002e01ceeb31$44c21ce0$ce4656a0$@samsung.com>
References: <000201cee760$58df9f10$0a9edd30$@samsung.com>
 <1385529248.2417.19.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1385529248.2417.19.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>, fanofcode.li@samsung.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Wednesday, November 27, 2013 1:14 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D; fanofcode.li@sa=
msung.com
> Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneeded code in punch_h=
ole
>=20
> Got it.
>=20
> But, with this patch, we can also remove the parameter, int mode, in
> punch_hole().
> If no objection, I'll fix that in your patch.
> Thanks,

Right, we should remove it.
Thanks!

>=20
> 2013-11-22 (=EA=B8=88), 16:52 +0800, Chao Yu:
> > Because FALLOC_FL_PUNCH_HOLE flag must be ORed with FALLOC_FL_KEEP_=
SIZE
> > in fallocate, so we could remove the useless 'keep size' branch cod=
e which
> > will never be excuted in punch_hole.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > Signed-off-by: Fan Li <fanofcode.li@samsung.com>
> > ---
> >  fs/f2fs/file.c |    6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 7d714f4..0087d2a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -499,12 +499,6 @@ static int punch_hole(struct inode *inode, lof=
f_t offset, loff_t len, int mode)
> >  		}
> >  	}
> >
> > -	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> > -		i_size_read(inode) <=3D (offset + len)) {
> > -		i_size_write(inode, offset);
> > -		mark_inode_dirty(inode);
> > -	}
> > -
> >  	return ret;
> >  }
> >
>=20
> --
> Jaegeuk Kim
> Samsung
