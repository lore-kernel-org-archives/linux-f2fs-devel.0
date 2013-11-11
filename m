From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 1/1] No need to do recovery if there is no available CP
Date: Mon, 11 Nov 2013 13:33:09 +0900
Message-ID: <1384144389.14041.86.camel@kjgkr>
References: <1383491301-11460-1-git-send-email-huajun.li.lee@gmail.com>
 <1383528253.14041.53.camel@kjgkr>
 <CA+v9cxZrDJ0GRLGyzsiPo1p1mPDZHvERnHqrKHSEKQ9+M+pMLg@mail.gmail.com>
 <1383626886.14041.65.camel@kjgkr>
 <CA+v9cxYvHAyfE32sHe2Q-kvP8R_L-aeOa8SFxy2UuuWPxeLy6w@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CA+v9cxYvHAyfE32sHe2Q-kvP8R_L-aeOa8SFxy2UuuWPxeLy6w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Huajun Li <huajun.li@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

2013-11-05 (=ED=99=94), 21:28 +0800, Huajun Li:
> Hi Jaegeuk,
>=20
> Got it, and nice to fix it in mkfs.f2fs.
>=20
> Thanks,
> --Huajun
> On Tue, Nov 5, 2013 at 12:48 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com=
> wrote:
> > Hi Huajun,
> >
> > 2013-11-04 (=EC=9B=94), 23:40 +0800, Huajun Li:
> >> Hi Jaegeuk,
> >>
> >> On Mon, Nov 4, 2013 at 9:24 AM, Jaegeuk Kim <jaegeuk.kim@samsung.c=
om> wrote:
> >> > 2013-11-03 (=EC=9D=BC), 23:08 +0800, Huajun Li:
> >> >> From: Huajun Li <huajun.li@intel.com>
> >> >>
> >> >> Normally we expect an empty partition after formatting by
> >> >> mkfs.f2fs. But in this case, when we format a dirty partition a=
nd mount
> >> >> it again. The former file will be recovered and available again=
! and
> >> >> kernel log shows a recovery procedure is evoked.
> >> >> This patch adds a new flag CP_EXIST_FLAG to indicate whether is=
 a
> >> >> available CP, and do recovery only when this flag is set.
> >> >
> >> > IMO, mkfs.f2fs should do the right thing to avoid this.
> >> > If storage does not support discard, mkfs.f2fs can simply addres=
s the
> >> > problem by writing one node block with zeros to prevent this.
> >> >

WRT the below issue, I made a patch for mkfs.f2fs.
If possible, could you test and write a valid patch?
Thanks,

---
 mkfs/f2fs_format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 8234b00..18ded79 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -788,7 +788,12 @@ static int f2fs_write_root_inode(void)
=20
 	memset(raw_node, 0xff, sizeof(struct f2fs_node));
=20
-	main_area_node_seg_blk_offset +=3D F2FS_BLKSIZE;
+	/* avoid power-off-recovery based on roll-forward policy */
+	main_area_node_seg_blk_offset =3D le32_to_cpu(super_block.main_blkadd=
r);
+	main_area_node_seg_blk_offset +=3D config.cur_seg[CURSEG_WARM_NODE] *
+					config.blks_per_seg;
+        main_area_node_seg_blk_offset *=3D blk_size_bytes;
+
 	if (dev_write(raw_node, main_area_node_seg_blk_offset, F2FS_BLKSIZE))
{
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
 		return -1;
--=20
1.8.4.474.g128a96c


--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
