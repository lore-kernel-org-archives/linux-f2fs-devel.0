From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le
 in, find_in_block
Date: Fri, 4 Jul 2014 23:25:35 -0700
Message-ID: <20140705062535.GA35486@jmac.local>
References: <53A950F9.907@cn.fujitsu.com>
 <20140702103059.GA26619@jmac.local>
 <53B52CEA.8080407@cn.fujitsu.com>
 <20140704053619.GA32528@jmac.local>
 <001301cf9750$5e897bc0$1b9c7340$@samsung.com>
 <53B65FF9.9030204@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53B65FF9.9030204@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: =?utf-8?B?J+ydtOywveunjCc=?= <cm224.lee@samsung.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, Chao Yu <chao2.yu@samsung.com>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>, 'fsdevel' <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

To Changman,

Just for sure, can you reproduce this issue in the x86 machine with pro=
per
benchmarks? (i.e., test_bit_le vs. find_next_bit_le)

To all,

I cautiously suspect that the performances might be different when proc=
essing
f2fs_find_entry, since L1/L2 cache misses due to the intermediate routi=
nes like
matching strings can make some effect on it.

But, IMO, it is still worth to investigate this issue and contemplate h=
ow to
detect all ones or not.

Ah, one solution may be using 2 bytes from the reserved space, total 3,=
 to
indicate how many valid dentries are stored in the dentry block.

Any ideas?

Thanks,

On Fri, Jul 04, 2014 at 04:04:09PM +0800, Gu Zheng wrote:
> Hi Yu,
> Thanks.
> On 07/04/2014 02:21 PM, Chao Yu wrote:
>=20
> > Hi Jaegeuk, Gu, Changman
> >=20
> >> -----Original Message-----
> >> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> >> Sent: Friday, July 04, 2014 1:36 PM
> >> To: Gu Zheng
> >> Cc: f2fs; fsdevel; =EC=9D=B4=EC=B0=BD=EB=A7=8C; =E4=BF=9E
> >> Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than te=
st_bit_le in, find_in_block
> >>
> >> Well, how about testing with many ones in the bit streams?
> >> Thanks,
> >>
> >> On Thu, Jul 03, 2014 at 06:14:02PM +0800, Gu Zheng wrote:
> >>> Hi Jaegeuk, Changman
> >>>
> >>> Just a simple test, not very sure it can address
> >>> our qualm.
> >>>
> >>> Bitmap size:216(the same as f2fs dentry_bits).
> >>> CPU: Intel i5 x86_64.
> >>>
> >>> Time counting based on tsc(the less the fast).
> >>> [Index of 1]	find_next_bit_le	test_bit_le
> >>> 0		20			117
> >>> 1		20			114
> >>> 2		20			113
> >>> 3		20			139
> >>> 4		22			121
> >>> 5		22			118
> >>> 6		22			115
> >>> 8		22			112
> >>> 9		22			106
> >>> 10		22			105
> >>> 11		22			100
> >>> 16		22			98
> >>> 48		22			97
> >>> 80		27			95
> >>> 104		27			92
> >>> 136		32			95
> >>> 160		32			92
> >>> 184		32			90
> >>> 200		27			87
> >>> 208		35			84
> >>>
> >>> According to the result, find_next_bit_le is always
> >>> better than test_bit_le, though there may be some
> >>> noise, but I think the result is clear.
> >>> Hope it can help us.:)
> >>> ps.The sample is attached too.
> >>>
> >>> Thanks,
> >>> Gu
> >=20
> > I hope this could provide some help for this patch.
> >=20
> > I modify Gu's code like this, and add few test case:
> >=20
> > static void test_bit_search_speed(void)
> > {
> > 	unsigned long flags;
> > 	uint64_t tsc_s_b1, tsc_s_e1, tsc_s_b2, tsc_s_e2;
> > 	int i, j, pos;
> > 	const void *bit_addr;
> >=20
> > 	local_irq_save(flags);
> > 	preempt_disable();
> > =09
> > 	printk("find_next_bit	test_bit_le\n");
> >=20
> > 	for (i =3D 0; i < 24; i++) {
> >=20
> > 		bit_addr =3D &bitmaps[i];
> >=20
> > 		tsc_s_b1 =3D rdtsc();
> >=20
> > 		for (j =3D 0, pos =3D 0; j < 1000; j++, pos =3D 0)
> > 			while (pos < 216)
> > 				pos =3D find_next_bit_le(bit_addr, 216, pos) + 1;
> >=20
> > 		mb();
> > 		tsc_s_e1 =3D rdtsc();
> > 		tsc_s_e1 -=3D tsc_s_b1;
> > 		do_div(tsc_s_e1, 1000);
> >=20
> > 		tsc_s_b2 =3D rdtsc();
> >=20
> > 		for (j =3D 0, pos =3D 0; j < 1000; j++, pos =3D 0)
> > 			while (pos < 216)
> > 				test_bit_le(pos++, bit_addr);
> >=20
> > 		mb();
> > 		tsc_s_e2 =3D rdtsc();
> > 		tsc_s_e2 -=3D tsc_s_b2;
> > 		do_div(tsc_s_e2, 1000);
> >=20
> > 		printk("%-16llu %-16llu\n", tsc_s_e1, tsc_s_e2);
> > 	}
> >=20
> > 	preempt_enable();
> > 	local_irq_restore(flags);
> > }
> > case: 11111111 11111111
> > 		{255, 255, 255, 255, 255, 255, 255,
> > 		 255, 255, 255, 255, 255, 255, 255,
> > 		 255, 255, 255, 255, 255, 255, 255,
> > 		 255, 255, 255, 255, 255, 255},
> > case: 10101010 10101010
> > 		{170, 170, 170, 170, 170, 170, 170,
> > 		 170, 170, 170, 170, 170, 170, 170,
> > 		 170, 170, 170, 170, 170, 170, 170,
> > 		 170, 170, 170, 170, 170, 170},
> > case: 11111111 00000000
> > 		{255, 0, 255, 0, 255, 0, 255,
> > 		 0, 255, 0, 255, 0, 255, 0,
> > 		 255, 0, 255, 0, 255, 0, 255,
> > 		 0, 255, 0, 255, 0, 255},
> > case: 00001111 00001111
> > 		 {15, 15, 15, 15, 15, 15, 15,
> > 		 15, 15, 15, 15, 15, 15, 15,
> > 		 15, 15, 15, 15, 15, 15, 15,
> > 		 15, 15, 15, 15, 15, 15}
> >=20
> > and here are test result in my env. (Ubuntu vm, 768MB, i3-3220)
> > It seems find_next_bit works not so bad as I thought.
> >=20
> > find_next_bit    test_bit_le
> > 73               4209
> > 62               1271
> > 69               1585
> > 50               2031
> > 67               2255
> > 82               2261
> > 52               4007
> > 79               2159
> > 50               2043
> > 55               2215
> > 53               2393
> > 72               3784
> > 76               1879
> > 61               2562
> > 70               2702
> > 62               2489
> > 56               2307
> > 54               2063
> > 51               2258
> > 69               2712
> > 4133             3989  -- case: 11111111 11111111
> > 2370             3024  -- case: 10101010 10101010
> > 2608             2413  -- case: 11111111 00000000
> > 2457             2506  -- case: 00001111 00001111
>=20
> The time cost of test_bit_le shakes violently, it should be
> very smooth according to the test case, maybe it has relation
> to your vm env.
>=20
> To Jaegeuk,
> Following test result is walking a bitmap via find_next_bit_le
> and test_bit_le.
> (Front 7 are random bitmaps, last four are cases from Yu, see
> attached sample for detail):
>=20
> find_next_bit_le    test_bit_le
>=20
>      3615                3492=20
>      2640                3492=20
>      2431                3492=20
>      1957                3494=20
>      2160                3492=20
>      1933                3495=20
>      1096                3492=20
>=20
>      8078                3492=20
>      3732                3492=20
>      4237                3493=20
>      3824                3492
>=20
> Thanks,
> Gu=20
>=20
> >=20
> > .
> >=20
>=20
>=20

> #include <linux/module.h>
>=20
> __u8 bitmaps[11][27] =3D {
> 		{1, 123, 2, 3, 127, 200, 100,
> 		 123, 23, 13, 78, 42, 123, 50,
> 		 123, 56, 198, 0, 58, 22, 19,
> 		 123, 23, 13, 78, 42, 123},
> 		{2, 0, 0, 0, 0, 0, 0,
> 		 123, 23, 13, 78, 42, 123, 50,
> 		 123, 56, 198, 0, 58, 22, 19,
> 		 23, 123, 2, 34, 123, 12},
> 		{4, 0, 0, 0, 0, 0, 0,
> 		 123, 56, 198, 0, 58, 22, 19,
> 		 123, 23, 13, 78, 42, 123,
> 		 0, 0, 0, 34, 45, 29},
> 		{8, 0, 0, 0, 0, 0, 0,
> 		 1, 123, 2, 3, 127, 200, 100,
> 		 123, 23, 13, 78, 42, 123, 50,
> 		 0, 0, 0, 0, 0, 0},
> 		{16, 0, 0, 0, 0, 0, 0,
> 		 8, 78, 0, 0, 23, 0, 213,
> 		 0, 12, 0, 45, 0, 109, 111,
> 		 231, 11, 11, 88, 77, 99},
> 		{32, 0, 0, 0, 0, 0, 0,
> 		 8, 78, 0, 0, 23, 0, 213,
> 		 0, 12, 0, 45, 0, 109, 111,
> 		 231, 11, 11, 88, 77, 99},
> 		{64, 0, 0, 0, 0, 0, 0,
> 		 8, 78, 0, 0, 23, 0, 213,
> 		 0, 12, 0, 45, 0, 109, 111,
> 		 0, 0, 0, 0, 0, 0},
> 		{255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255},
> 		{170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170},
> 		{255, 0, 255, 0, 255, 0, 255,
> 		 0, 255, 0, 255, 0, 255, 0,
> 		 255, 0, 255, 0, 255, 0, 255,
> 		 0, 255, 0, 255, 0, 255},
> 		 {15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15}
> 		};
>=20
> uint64_t rdtsc(void) {
> uint32_t lo, hi;
> __asm__ __volatile__ ("rdtsc" : "=3Da" (lo), "=3Dd" (hi));
> return (uint64_t)hi << 32 | lo;
> }
>=20
> static void test_bit_search_speed(void)
> {
> 	unsigned long flags;
> 	uint64_t tsc_s, tsc_diff;
> 	int i, j, pos;
> 	const void *bit_addr;
>=20
> 	local_irq_save(flags);
> 	preempt_disable();
>=20
> 	printk("find_next_bit_le    test_bit_le\n");
>=20
> 	for (i =3D 0; i < 11; i++) {
> 		bit_addr =3D &bitmaps[i];
>=20
> 		pos =3D 0;
> 		tsc_s =3D rdtsc();
>=20
> 		for (j =3D 0; j < 1000; j++, pos =3D 0)
> 			while (pos < 216)
> 				pos =3D find_next_bit_le(bit_addr, 216, pos) + 1;
> 		mb();
> 		tsc_diff =3D (rdtsc() - tsc_s)/1000;
>=20
> 		printk("%8llu", tsc_diff);
>=20
> 		pos =3D 0;
> 		tsc_s =3D rdtsc();
>=20
> 		for (j =3D 0; j < 1000; j++, pos =3D 0)
> 			while (pos < 216)
> 				test_bit_le(pos++, bit_addr);
>=20
> 		mb();
> 		tsc_diff =3D (rdtsc() - tsc_s)/1000;
>=20
> 		printk("%20llu \n", tsc_diff);
> 	}
>=20
> 	preempt_enable();
> 	local_irq_restore(flags);
> }
>=20
> static int __init start_test(void) {
> 	test_bit_search_speed();
> 	return 0;
> }
>=20
> static void __exit exit_test(void) {
>=20
> }
>=20
> module_init(start_test);
> module_exit(exit_test);
>=20
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Gu Zheng");


--=20
Jaegeuk Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
