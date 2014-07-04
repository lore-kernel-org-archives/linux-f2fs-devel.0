From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le in,
 find_in_block
Date: Fri, 04 Jul 2014 14:21:54 +0800
Message-ID: <001301cf9750$5e897bc0$1b9c7340$@samsung.com>
References: <53A950F9.907@cn.fujitsu.com> <20140702103059.GA26619@jmac.local>
 <53B52CEA.8080407@cn.fujitsu.com> <20140704053619.GA32528@jmac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20140704053619.GA32528@jmac.local>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, =?UTF-8?B?J+ydtOywveunjCc=?= <cm224.lee@samsung.com>, 'Gu Zheng' <guz.fnst@cn.fujitsu.com>
Cc: 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>, 'fsdevel' <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk, Gu, Changman

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, July 04, 2014 1:36 PM
> To: Gu Zheng
> Cc: f2fs; fsdevel; =EC=9D=B4=EC=B0=BD=EB=A7=8C; =E4=BF=9E
> Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_=
bit_le in, find_in_block
>=20
> Well, how about testing with many ones in the bit streams?
> Thanks,
>=20
> On Thu, Jul 03, 2014 at 06:14:02PM +0800, Gu Zheng wrote:
> > Hi Jaegeuk, Changman
> >
> > Just a simple test, not very sure it can address
> > our qualm.
> >
> > Bitmap size:216(the same as f2fs dentry_bits).
> > CPU: Intel i5 x86_64.
> >
> > Time counting based on tsc(the less the fast).
> > [Index of 1]	find_next_bit_le	test_bit_le
> > 0		20			117
> > 1		20			114
> > 2		20			113
> > 3		20			139
> > 4		22			121
> > 5		22			118
> > 6		22			115
> > 8		22			112
> > 9		22			106
> > 10		22			105
> > 11		22			100
> > 16		22			98
> > 48		22			97
> > 80		27			95
> > 104		27			92
> > 136		32			95
> > 160		32			92
> > 184		32			90
> > 200		27			87
> > 208		35			84
> >
> > According to the result, find_next_bit_le is always
> > better than test_bit_le, though there may be some
> > noise, but I think the result is clear.
> > Hope it can help us.:)
> > ps.The sample is attached too.
> >
> > Thanks,
> > Gu

I hope this could provide some help for this patch.

I modify Gu's code like this, and add few test case:

static void test_bit_search_speed(void)
{
	unsigned long flags;
	uint64_t tsc_s_b1, tsc_s_e1, tsc_s_b2, tsc_s_e2;
	int i, j, pos;
	const void *bit_addr;

	local_irq_save(flags);
	preempt_disable();
=09
	printk("find_next_bit	test_bit_le\n");

	for (i =3D 0; i < 24; i++) {

		bit_addr =3D &bitmaps[i];

		tsc_s_b1 =3D rdtsc();

		for (j =3D 0, pos =3D 0; j < 1000; j++, pos =3D 0)
			while (pos < 216)
				pos =3D find_next_bit_le(bit_addr, 216, pos) + 1;

		mb();
		tsc_s_e1 =3D rdtsc();
		tsc_s_e1 -=3D tsc_s_b1;
		do_div(tsc_s_e1, 1000);

		tsc_s_b2 =3D rdtsc();

		for (j =3D 0, pos =3D 0; j < 1000; j++, pos =3D 0)
			while (pos < 216)
				test_bit_le(pos++, bit_addr);

		mb();
		tsc_s_e2 =3D rdtsc();
		tsc_s_e2 -=3D tsc_s_b2;
		do_div(tsc_s_e2, 1000);

		printk("%-16llu %-16llu\n", tsc_s_e1, tsc_s_e2);
	}

	preempt_enable();
	local_irq_restore(flags);
}
case: 11111111 11111111
		{255, 255, 255, 255, 255, 255, 255,
		 255, 255, 255, 255, 255, 255, 255,
		 255, 255, 255, 255, 255, 255, 255,
		 255, 255, 255, 255, 255, 255},
case: 10101010 10101010
		{170, 170, 170, 170, 170, 170, 170,
		 170, 170, 170, 170, 170, 170, 170,
		 170, 170, 170, 170, 170, 170, 170,
		 170, 170, 170, 170, 170, 170},
case: 11111111 00000000
		{255, 0, 255, 0, 255, 0, 255,
		 0, 255, 0, 255, 0, 255, 0,
		 255, 0, 255, 0, 255, 0, 255,
		 0, 255, 0, 255, 0, 255},
case: 00001111 00001111
		 {15, 15, 15, 15, 15, 15, 15,
		 15, 15, 15, 15, 15, 15, 15,
		 15, 15, 15, 15, 15, 15, 15,
		 15, 15, 15, 15, 15, 15}

and here are test result in my env. (Ubuntu vm, 768MB, i3-3220)
It seems find_next_bit works not so bad as I thought.

find_next_bit    test_bit_le
73               4209
62               1271
69               1585
50               2031
67               2255
82               2261
52               4007
79               2159
50               2043
55               2215
53               2393
72               3784
76               1879
61               2562
70               2702
62               2489
56               2307
54               2063
51               2258
69               2712
4133             3989  -- case: 11111111 11111111
2370             3024  -- case: 10101010 10101010
2608             2413  -- case: 11111111 00000000
2457             2506  -- case: 00001111 00001111

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
