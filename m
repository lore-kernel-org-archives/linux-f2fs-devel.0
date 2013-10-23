From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: check all ones or zeros bitmap with
 integer data type for better mount performance
Date: Wed, 23 Oct 2013 11:23:52 +0800
Message-ID: <000001cecf9f$7113b630$533b2290$@samsung.com>
References: <000701cecf09$2b2a2280$817e6780$@samsung.com>
 <1382444612.992.67.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1382444612.992.67.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, Kim:

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Tuesday, October 22, 2013 8:24 PM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel=
=2Eorg;
> linux-kernel@vger.kernel.org; =E8=B0=AD=E5=A7=9D
> Subject: Re: [f2fs-dev] [PATCH] f2fs: check all ones or zeros bitmap =
with integer
> data type for better mount performance
>=20
> Hi,
>=20
> 2013-10-22 (=ED=99=94), 17:28 +0800, Chao Yu:
> > Previously, check_block_count check valid_map with bit data type in
> > common scenario that sit has all ones or zeros bitmap, it makes low
> > mount performance.
> > So let's check the special bitmap with integer data type instead of
> > the bit one.
> >
> > Signed-off-by: Tan Shu <shu.tan@samsung.com>
> > Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/segment.h |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
> > 7f94d78..d43ab9f 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -543,6 +543,7 @@ static inline void check_block_count(struct
> > f2fs_sb_info *sbi,  {
> >  	struct f2fs_sm_info *sm_info =3D SM_I(sbi);
> >  	unsigned int end_segno =3D sm_info->segment_count - 1;
> > +	int *valid_map =3D (int *)raw_sit->valid_map;
> >  	int valid_blocks =3D 0;
> >  	int i;
> >
> > @@ -552,6 +553,19 @@ static inline void check_block_count(struct
> > f2fs_sb_info *sbi,
> >  	/* check boundary of a given segment number */
> >  	BUG_ON(segno > end_segno);
> >
> > +	/* check all ones or zeros valid_map */
> > +	if (GET_SIT_VBLOCKS(raw_sit) =3D=3D 0) {
> > +		for (i =3D 0; i < SIT_VBLOCK_MAP_SIZE / sizeof(int); i++)
>=20
> We cannot guarantee all the time that SIT_VBLOCK_MAP_SIZE is multiple=
 of
> sizeof(int).
Well, It's really large changes for f2fs if SIT_VBLOCK_MAP_SIZE value i=
s being modified.

> How about using memcmp() with __u8?
Do you mean that we can alloc all zeros or ones memory in SIT_VBLOCK_MA=
P_SIZE size,
then memcmp() it with sit bitmap by __u8?

>=20
> > +			if (unlikely(valid_map[i] !=3D 0))
> > +				BUG();
> > +		return;
> > +	} else if (GET_SIT_VBLOCKS(raw_sit) =3D=3D sbi->blocks_per_seg) {
> > +		for (i =3D 0; i < SIT_VBLOCK_MAP_SIZE / sizeof(int); i++)
> > +			if (unlikely(valid_map[i] !=3D -1))
> > +				BUG();
> > +		return;
> > +	}
> > +
> >  	/* check bitmap with valid block count */
> >  	for (i =3D 0; i < sbi->blocks_per_seg; i++)
> >  		if (f2fs_test_bit(i, raw_sit->valid_map))
> > ---
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-fsdevel" in the body of a message to majordomo@vger.kernel.or=
g
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
