From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: refactor bio-related operations
Date: Wed, 04 Dec 2013 16:22:12 +0800
Message-ID: <001201cef0ca$0d669610$2833c230$@samsung.com>
References: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
 <1385972847.2417.113.camel@kjgkr>
 <001101cef0b6$562766e0$027634a0$@samsung.com> <1386144643.2417.148.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1386144643.2417.148.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, =?UTF-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Wednesday, December 04, 2013 4:11 PM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.=
net; linux-fsdevel@vger.kernel.org; =E8=B0=AD=E5=A7=9D
> Subject: RE: [f2fs-dev] [PATCH v2] f2fs: refactor bio-related operati=
ons
>=20
> Hi,
>=20
> > > +	if (btype =3D=3D META)
> > > +		rw |=3D REQ_META;
> > > +
> > > +	if (is_read_io(rw)) {
> > > +		if (sync)
> > > +			rw |=3D READ_SYNC;
> > > +		submit_bio(rw, io->bio);
> > > +		trace_f2fs_submit_read_bio(sbi->sb, rw, type, io->bio);
> > > +		io->bio =3D NULL;
> > > +		return;
> > > +	}
> > > +
> > > +	if (sync)
> > > +		rw |=3D WRITE_SYNC;
> >
> > rw =3D WRITE_SYNC; ?
>=20
> No, since it removes the REQ_META.
> See above.

Ah, you're right, Thanks.

>=20
> >
> > > +	if (type >=3D META_FLUSH)
> > > +		rw |=3D WRITE_FLUSH_FUA;
> >
> > rw =3D WRITE_FLUSH_FUA; ?
> >
> > > +
> > > +	/*
> > > +	 * META_FLUSH is only from the checkpoint procedure, and we sho=
uld wait
> > > +	 * this metadata bio for FS consistency.
> > > +	 */
> > > +	if (type =3D=3D META_FLUSH) {
> > > +		DECLARE_COMPLETION_ONSTACK(wait);
> > > +		io->bio->bi_private =3D &wait;
> > > +		submit_bio(rw, io->bio);
> > > +		wait_for_completion(&wait);
> > > +	} else {
> > > +		submit_bio(rw, io->bio);
> > > +	}
> > > +	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
> > > +	io->bio =3D NULL;
> > > +}
> >
> > [snip]
> >
> > Thanks,
> > Yu
> >
>=20
> --
> Jaegeuk Kim
> Samsung
