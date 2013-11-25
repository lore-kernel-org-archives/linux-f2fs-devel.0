From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: adds a tracepoint for submit_read_page
Date: Mon, 25 Nov 2013 09:29:23 +0800
Message-ID: <000d01cee97d$e381ee10$aa85ca30$@samsung.com>
References: <001e01cee5cc$3d118310$b7348930$@samsung.com>
 <1385262534.26319.88.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1385262534.26319.88.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Sunday, November 24, 2013 11:09 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: adds a tracepoint for submi=
t_read_page
>=20
> Hi,
>=20
> We need to avoid redundancy as much as possible.
> So, how about this patch?

Ah, It's more neat!
Thanks. :)


> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Sunday, November 24, 2013 11:51 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: adds a tracepoint for f2fs_=
submit_read_bio
>=20
> Hi,
>=20
> Again, this tracepoint alos can be integrated with write_bios like th=
is.

Alright, Thanks!

Regards,
Yu

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
