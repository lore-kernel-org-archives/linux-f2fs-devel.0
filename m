From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: [PATCH] f2fs: handle newly created page when revoking inmem
 pages
Date: Wed, 10 Jan 2018 07:22:03 +0000
Message-ID: <20180110072203epcms1p5590a9b8441e94174b461172222424455@epcms1p5>
References: <aec4e374-a245-590e-8350-d1e1ada3b705@huawei.com>
        <1515552234-27964-1-git-send-email-daeho.jeong@samsung.com>
        <CGME20180110024336epcas2p1003559800e7f1e59a79496fc5b79cf04@epcms1p5>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aec4e374-a245-590e-8350-d1e1ada3b705@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

> Original=C2=A0intention=C2=A0here=C2=A0is=C2=A0to=C2=A0recover=C2=A0statu=
s=C2=A0to=C2=A0the=C2=A0timing=C2=A0before=0D=0A>=20committing=C2=A0atomic=
=C2=A0write.=C2=A0As=C2=A0at=C2=A0that=C2=A0timing=C2=A0blkaddr=C2=A0in=C2=
=A0dnode=C2=A0should=C2=A0be=0D=0A>=20cur->old_addr(NEW_ADDR),=C2=A0so=C2=
=A0we=C2=A0need=C2=A0to=C2=A0change=C2=A0to=C2=A0call:=0D=0A=C2=A0=0D=0A>=
=20f2fs_update_data_blkaddr(&dn,=C2=A0NEW_ADDR);=0D=0A=0D=0AOk,=20I'll=20ch=
ange=20NULL_ADDR=20to=20NEW_ADDR.=0D=0A=0D=0AThanks,=0D=0A=C2=A0=0D=0A>=20O=
therwise,=C2=A0metadata=C2=A0will=C2=A0become=C2=A0inconsistent,=C2=A0becau=
se=C2=A0blkaddr=C2=A0value=C2=A0is=0D=0A>=20NULL_ADDR=C2=A0means=C2=A0that=
=C2=A0current=C2=A0block=C2=A0is=C2=A0not=C2=A0preallocated,=C2=A0but=0D=0A=
>=20total_valid_block_count=C2=A0has=C2=A0already=C2=A0been=C2=A0updated.=
=C2=A0Right?=0D=0A=C2=A0=0D=0A>=20Thanks,=0D=0A=C2=A0=0D=0A=0D=0A=C2=A0=0D=
=0A=C2=A0
