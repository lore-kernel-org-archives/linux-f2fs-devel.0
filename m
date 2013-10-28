From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V2] f2fs: check all ones or zeros bitmap with
 bitops for better mount performance
Date: Mon, 28 Oct 2013 15:07:11 +0800
Message-ID: <000201ced3ac$799274c0$6cb75e40$@samsung.com>
References: <000401ced092$28087a90$78196fb0$@samsung.com>
 <003501ced384$31fb7530$95f25f90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <003501ced384$31fb7530$95f25f90$@samsung.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: =?utf-8?B?J+ydtOywveunjCc=?= <cm224.lee@samsung.com>, jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Lee,

> -----Original Message-----
> From: =EC=9D=B4=EC=B0=BD=EB=A7=8C [mailto:cm224.lee@samsung.com]
> Sent: Monday, October 28, 2013 10:20 AM
> To: 'Chao Yu'; jaegeuk.kim@samsung.com
> Cc: linux-fsdevel@vger.kernel.org; '=E8=B0=AD=E5=A7=9D'; linux-kernel=
@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: RE: [f2fs-dev] [PATCH V2] f2fs: check all ones or zeros bitm=
ap with
> bitops for better mount performance
>=20
> To check whether bitmap are all zeros or all ones, I think memcmp is =
more
> neat.
> But I don't know exactly performance gap between memcmp and
> find_next_bit.

With the result of my test, find_next_bit takes less time than memcmp.
If we could use {test, set, clear}_bit_le intead of f2fs_{test, set, cl=
ear}_bit, the following patch
could be used for better performance.
This one is better than the V2 patch for performance with mixed bitmap =
in my test.

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7f94d78..32153eb
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -544,7 +544,8 @@ static inline void check_block_count(struct f2fs_sb=
_info *sbi,
        struct f2fs_sm_info *sm_info =3D SM_I(sbi);
        unsigned int end_segno =3D sm_info->segment_count - 1;
        int valid_blocks =3D 0;
-       int i;
+       int i, cur_pos =3D 0, next_pos;
+       bool is_valid;
=20
        /* check segment usage */
        BUG_ON(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg);
@@ -553,9 +554,21 @@ static inline void check_block_count(struct f2fs_s=
b_info *sbi,
        BUG_ON(segno > end_segno);
=20
        /* check bitmap with valid block count */
-       for (i =3D 0; i < sbi->blocks_per_seg; i++)
-               if (f2fs_test_bit(i, raw_sit->valid_map))
-                       valid_blocks++;
+       cur_pos =3D 0;
+       is_valid =3D test_bit_le(0, raw_sit->valid_map) ? true : false;
+       do {
+               if (is_valid) {
+                       next_pos =3D find_next_zero_bit_le(&raw_sit->va=
lid_map,
+                                       sbi->blocks_per_seg,
+                                       cur_pos);
+                       valid_blocks +=3D next_pos - cur_pos;
+               } else
+                       next_pos =3D find_next_bit_le(&raw_sit->valid_m=
ap,
+                                       sbi->blocks_per_seg,
+                                       cur_pos);
+               cur_pos =3D next_pos;
+               is_valid =3D !is_valid;
+       } while (cur_pos < sbi->blocks_per_seg);
        BUG_ON(GET_SIT_VBLOCKS(raw_sit) !=3D valid_blocks);
 }
>=20
>=20
> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Thursday, October 24, 2013 5:21 PM
> To: jaegeuk.kim@samsung.com
> Cc: linux-fsdevel@vger.kernel.org; '=E8=B0=AD=E5=A7=9D'; linux-kernel=
@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH V2] f2fs: check all ones or zeros bitmap w=
ith bitops
> for better mount performance
>=20
> Previously, check_block_count check valid_map with bit data type in c=
ommon
> scenario that sit has all ones or zeros bitmap, it makes low mount
> performance.
> So let's check the special bitmap with integer data type instead of t=
he bit one.
>=20
> v2:
>     use find_next_bit_le/find_next_zero_bit_le for better performance=
 and
> readable as Jaegeuk suggested.
>=20
> Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Signed-off-by: Tan Shu <shu.tan@samsung.com>
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.h |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index 7f94d78..d25=
b6af
> 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -552,6 +552,23 @@ static inline void check_block_count(struct
> f2fs_sb_info *sbi,
>  	/* check boundary of a given segment number */
>  	BUG_ON(segno > end_segno);
>=20
> +	/* check all ones or zeros valid_map */
> +	if (GET_SIT_VBLOCKS(raw_sit) =3D=3D 0) {
> +		int pos =3D find_next_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					0);
> +		if (pos !=3D sbi->blocks_per_seg)
> +			BUG();
> +		return;
> +	} else if (GET_SIT_VBLOCKS(raw_sit) =3D=3D sbi->blocks_per_seg) {
> +		int pos =3D find_next_zero_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					0);
> +		if (pos !=3D sbi->blocks_per_seg)
> +			BUG();
> +		return;
> +	}
> +
>  	/* check bitmap with valid block count */
>  	for (i =3D 0; i < sbi->blocks_per_seg; i++)
>  		if (f2fs_test_bit(i, raw_sit->valid_map))
> --
> 1.7.9.5
>=20
>=20
> ---------------------------------------------------------------------=
---------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the m=
ost from
> the latest Intel processors and coprocessors. See abstracts and regis=
ter >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D60135991&iu=3D/4140/o=
stg.clktr
> k
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
