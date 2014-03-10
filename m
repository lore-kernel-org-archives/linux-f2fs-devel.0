From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: update start nid only once each circle
Date: Mon, 10 Mar 2014 11:26:11 +0900
Message-ID: <1394418371.3870.87.camel@kjgkr>
References: <5319A2CC.3090206@cn.fujitsu.com>
 <001301cf3ac4$3220b8c0$96622a40$@samsung.com> <531D161C.8080001@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <531D161C.8080001@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Chao Yu <chao2.yu@samsung.com>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi all,

I'll handle them all by myself.
Thank you for the contribution. :)

2014-03-10 (=EC=9B=94), 09:32 +0800, Gu Zheng:
> On 03/08/2014 07:46 PM, Chao Yu wrote:
>=20
> > Hi Gu,
> >=20
> >> -----Original Message-----
> >> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> >> Sent: Friday, March 07, 2014 6:43 PM
> >> To: Kim
> >> Cc: linux-kernel; f2fs
> >> Subject: [f2fs-dev] [PATCH 1/5] f2fs: update start nid only once e=
ach circle
> >>
> >>
> >> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> >=20
> > Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> >=20
> >> ---
> >>  fs/f2fs/node.c |    6 +++++-
> >>  1 files changed, 5 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index 8c14110..9653096 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -1875,11 +1875,15 @@ void destroy_node_manager(struct f2fs_sb_i=
nfo *sbi)
> >>  	while ((found =3D __gang_lookup_nat_cache(nm_i,
> >>  					nid, NATVEC_SIZE, natvec))) {
> >>  		unsigned idx;
> >> +
> >> +		nid =3D nat_get_nid(natvec[found - 1]) + 1;
> >> +
> >>  		for (idx =3D 0; idx < found; idx++) {
> >>  			struct nat_entry *e =3D natvec[idx];
> >=20
> > Could we replace argument 'e' with 'natvec[idx]'? then we could rem=
ove 'e' and
> > brace here.
>=20
> Agree. More neat with this cleanup.
>=20
> Regards,
> Gu
>=20
> >=20
> > Thanks.
> >=20
> >> -			nid =3D nat_get_nid(e) + 1;
> >> +
> >>  			__del_from_nat_cache(nm_i, e);
> >>  		}
> >> +
> >>  	}
> >>  	f2fs_bug_on(nm_i->nat_cnt);
> >>  	write_unlock(&nm_i->nat_tree_lock);
> >> --
> >> 1.7.7
> >>
> >>
> >> ------------------------------------------------------------------=
------------
> >> Subversion Kills Productivity. Get off Subversion & Make the Move =
to Perforce.
> >> With Perforce, you get hassle-free workflows. Merge that actually =
works.
> >> Faster operations. Version large binaries.  Built-in WAN optimizat=
ion and the
> >> freedom to use Git, Perforce or both. Make the move to Perforce.
> >> http://pubads.g.doubleclick.net/gampad/clk?id=3D122218951&iu=3D/41=
40/ostg.clktrk
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >=20
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Jaegeuk Kim
Samsung
