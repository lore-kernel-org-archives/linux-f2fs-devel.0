From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 5/5] f2fs: check the node block address of newly
 allocated nid
Date: Mon, 24 Aug 2015 17:38:37 +0800
Message-ID: <001901d0de50$c3b40810$4b1c1830$@samsung.com>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
 <1439887589-35190-5-git-send-email-jaegeuk@kernel.org>
 <01bb01d0db28$61844ea0$248cebe0$@samsung.com>
 <20150820153523.GA42028@jaegeuk-mac02.mot-mobility.com>
 <021501d0dc0f$d365f900$7a31eb00$@samsung.com>
 <BLU436-SMTP23321A93A08CF5FB1E72680AB650@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <BLU436-SMTP23321A93A08CF5FB1E72680AB650@phx.gbl>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Chao Yu [mailto:yuchaochina@hotmail.com]
> Sent: Friday, August 21, 2015 11:00 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; linux-fsdevel@vger.kernel.org; linux-kernel@vger.ker=
nel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: check the node block addres=
s of newly allocated nid
>=20
> > On Aug 21, 2015, at 8:48 PM, Chao Yu <chao2.yu@samsung.com> wrote:
> >
> > Hi Jaegeuk,
> >
> >> -----Original Message-----
> >> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> >> Sent: Thursday, August 20, 2015 11:35 PM
> >> To: Chao Yu
> >> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> >> linux-f2fs-devel@lists.sourceforge.net
> >> Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: check the node block add=
ress of newly allocated
> nid
> >>
> >> On Thu, Aug 20, 2015 at 05:12:03PM +0800, Chao Yu wrote:
> >>> Hi Jaegeuk,
> >>>
> >>>> -----Original Message-----
> >>>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> >>>> Sent: Tuesday, August 18, 2015 4:46 PM
> >>>> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> >>>> linux-f2fs-devel@lists.sourceforge.net
> >>>> Cc: Jaegeuk Kim
> >>>> Subject: [f2fs-dev] [PATCH 5/5] f2fs: check the node block addre=
ss of newly allocated nid
> >>>>
> >>>> This patch adds a routine which checks the block address of newl=
y allocated nid.
> >>>> If an nid has already allocated by other thread due to subtle da=
ta races, it
> >>>> will result in filesystem corruption.
> >>>> So, it needs to check whether its block address was already allo=
cated or not
> >>>> in prior to nid allocation as the last chance.
> >>>>
> >>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>> ---
> >>>> fs/f2fs/node.c | 9 +++++++++
> >>>> 1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >>>> index 3cc32b8..6bef5a2 100644
> >>>> --- a/fs/f2fs/node.c
> >>>> +++ b/fs/f2fs/node.c
> >>>> @@ -1573,6 +1573,8 @@ retry:
> >>>>
> >>>> 	/* We should not use stale free nids created by build_free_nids=
 */
> >>>> 	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
> >>>> +		struct node_info ni;
> >>>> +
> >>>> 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
> >>>> 		list_for_each_entry(i, &nm_i->free_nid_list, list)
> >>>> 			if (i->state =3D=3D NID_NEW)
> >>>> @@ -1583,6 +1585,13 @@ retry:
> >>>> 		i->state =3D NID_ALLOC;
> >>>> 		nm_i->fcnt--;
> >>>> 		spin_unlock(&nm_i->free_nid_list_lock);
> >>>> +
> >>>> +		/* check nid is allocated already */
> >>>> +		get_node_info(sbi, *nid, &ni);
> >>>> +		if (ni.blk_addr !=3D NULL_ADDR) {
> >>>
> >>> I didn't get it, why free nid is with non-NULL blkaddr?
> >>> Could you please explain more about this?
> >>
> >> As I wrote in the description, I've been suffering from wrongly ad=
ded free nids
> >> which results in fs corruption. I suspect somewhat race condition =
in
> >> build_free_nids, but it is very subtle to figure out exactly.
> >> So, I wrote this patch to fix that.
> >>
> >> The concern would be performance regarding to cold cache miss at a=
n NAT entry.
> >> However, I expect that it would be tolerable since get_node_info w=
ill be called
> >> after alloc_nid later.
> >
> > After investigating, I think I can reproduce this bug:
> >
> > 1. touch a (nid =3D 4) & touch b (nid =3D 5)
> > 2. sync
> > 3. rm a & rm b
> > a) rm a to make next_scan_nid =3D 4.
> > b) I change the logical of f2fs code making remove_inode_page faile=
d when
> > file b is being removed, so file b's nat entry is not set dirty;
> > 4. sync
> > 5. touch 1815 files
> > 6. echo 3 > /proc/sys/vm/drop_caches
> > drop clean nat entry of inode (nid:5), it makes we can pass blkaddr
> > verification in add_free_nid:
> > 	if (build) {
> > 		/* do not add allocated nids */
> >
> > 7. touch c
> > because there is no free nids in cache, we try to build cache by tw=
o steps:
> > a) build nids by loading from nat pages;
> > b) build nids by loading from curseg and try to unload nids which h=
as valid
> > blkaddr in curseg.
> >
> > unfortunately, our build operation is not atomic, so after step a),=
 nid:5
>=20
> After rethinking about this issue on the way coming back home, I find=
 that
> it seems not right here, because we will try to check build_lock stat=
us in
> on_build_free_nids, allocation will not happen during building free n=
id
> cache. I missed that previously.
>=20
> Sorry for my wrong conclusion, please ignore them. :(
>=20
> I=E2=80=99d like to reinvestigate this issue.

I reinvestigate this issue and find one possible call path for reproduc=
ing this
issue, and I wrote patches for fxing, can you please help to review the=
 following
patches?

Thanks,
