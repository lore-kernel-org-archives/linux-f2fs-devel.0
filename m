From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/1] No need to do recovery if there is no available CP
Date: Tue, 05 Nov 2013 13:48:06 +0900
Message-ID: <1383626886.14041.65.camel@kjgkr>
References: <1383491301-11460-1-git-send-email-huajun.li.lee@gmail.com>
 <1383528253.14041.53.camel@kjgkr>
 <CA+v9cxZrDJ0GRLGyzsiPo1p1mPDZHvERnHqrKHSEKQ9+M+pMLg@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CA+v9cxZrDJ0GRLGyzsiPo1p1mPDZHvERnHqrKHSEKQ9+M+pMLg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Huajun Li <huajun.li@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

2013-11-04 (=EC=9B=94), 23:40 +0800, Huajun Li:
> Hi Jaegeuk,
>=20
> On Mon, Nov 4, 2013 at 9:24 AM, Jaegeuk Kim <jaegeuk.kim@samsung.com>=
 wrote:
> > 2013-11-03 (=EC=9D=BC), 23:08 +0800, Huajun Li:
> >> From: Huajun Li <huajun.li@intel.com>
> >>
> >> Normally we expect an empty partition after formatting by
> >> mkfs.f2fs. But in this case, when we format a dirty partition and =
mount
> >> it again. The former file will be recovered and available again! a=
nd
> >> kernel log shows a recovery procedure is evoked.
> >> This patch adds a new flag CP_EXIST_FLAG to indicate whether is a
> >> available CP, and do recovery only when this flag is set.
> >
> > IMO, mkfs.f2fs should do the right thing to avoid this.
> > If storage does not support discard, mkfs.f2fs can simply address t=
he
> > problem by writing one node block with zeros to prevent this.
> >
> Yes, mkfs.f2fs should do this definitely. :)
>=20
> > And, if you introduce a new flag, mkfs.f2fs should do the same thin=
g,
> > which means that mkfs.f2fs also needs to set the CP_EXIST_FLAG.
> > So then, it could not fix the bug.
> >
> > How do you think?
>=20
> IMO, mkfs.f2fs doesn't need to set CP_EXIST_FLAG. This flag indicates
> there exists an available CP, so an new formatted partition don't nee=
d
> set the flag since there is no CP on it yet.


Ah, what I concern is that mkfs.f2fs writes a valid CP so that it shoul=
d
set the flag.


> On the other hand, while mounting a partition, we need to do recovery
> only if there is CP on the partition. So this flag may be helpful,
> right?

If there is no valid CP, f2fs never goes to recover path.
So, I doubt the necessity of that flag. :)

Thanks,

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
