From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le
 in, find_in_block
Date: Fri, 4 Jul 2014 16:04:09 +0800
Message-ID: <53B65FF9.9030204@cn.fujitsu.com>
References: <53A950F9.907@cn.fujitsu.com> <20140702103059.GA26619@jmac.local> <53B52CEA.8080407@cn.fujitsu.com> <20140704053619.GA32528@jmac.local> <001301cf9750$5e897bc0$1b9c7340$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070406080701060601070502"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <001301cf9750$5e897bc0$1b9c7340$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, =?UTF-8?B?J+ydtOywveunjCc=?= <cm224.lee@samsung.com>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>, 'fsdevel' <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

--------------070406080701060601070502
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Yu,
Thanks.
On 07/04/2014 02:21 PM, Chao Yu wrote:

> Hi Jaegeuk, Gu, Changman
> 
>> -----Original Message-----
>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>> Sent: Friday, July 04, 2014 1:36 PM
>> To: Gu Zheng
>> Cc: f2fs; fsdevel; 이창만; 俞
>> Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le in, find_in_block
>>
>> Well, how about testing with many ones in the bit streams?
>> Thanks,
>>
>> On Thu, Jul 03, 2014 at 06:14:02PM +0800, Gu Zheng wrote:
>>> Hi Jaegeuk, Changman
>>>
>>> Just a simple test, not very sure it can address
>>> our qualm.
>>>
>>> Bitmap size:216(the same as f2fs dentry_bits).
>>> CPU: Intel i5 x86_64.
>>>
>>> Time counting based on tsc(the less the fast).
>>> [Index of 1]	find_next_bit_le	test_bit_le
>>> 0		20			117
>>> 1		20			114
>>> 2		20			113
>>> 3		20			139
>>> 4		22			121
>>> 5		22			118
>>> 6		22			115
>>> 8		22			112
>>> 9		22			106
>>> 10		22			105
>>> 11		22			100
>>> 16		22			98
>>> 48		22			97
>>> 80		27			95
>>> 104		27			92
>>> 136		32			95
>>> 160		32			92
>>> 184		32			90
>>> 200		27			87
>>> 208		35			84
>>>
>>> According to the result, find_next_bit_le is always
>>> better than test_bit_le, though there may be some
>>> noise, but I think the result is clear.
>>> Hope it can help us.:)
>>> ps.The sample is attached too.
>>>
>>> Thanks,
>>> Gu
> 
> I hope this could provide some help for this patch.
> 
> I modify Gu's code like this, and add few test case:
> 
> static void test_bit_search_speed(void)
> {
> 	unsigned long flags;
> 	uint64_t tsc_s_b1, tsc_s_e1, tsc_s_b2, tsc_s_e2;
> 	int i, j, pos;
> 	const void *bit_addr;
> 
> 	local_irq_save(flags);
> 	preempt_disable();
> 	
> 	printk("find_next_bit	test_bit_le\n");
> 
> 	for (i = 0; i < 24; i++) {
> 
> 		bit_addr = &bitmaps[i];
> 
> 		tsc_s_b1 = rdtsc();
> 
> 		for (j = 0, pos = 0; j < 1000; j++, pos = 0)
> 			while (pos < 216)
> 				pos = find_next_bit_le(bit_addr, 216, pos) + 1;
> 
> 		mb();
> 		tsc_s_e1 = rdtsc();
> 		tsc_s_e1 -= tsc_s_b1;
> 		do_div(tsc_s_e1, 1000);
> 
> 		tsc_s_b2 = rdtsc();
> 
> 		for (j = 0, pos = 0; j < 1000; j++, pos = 0)
> 			while (pos < 216)
> 				test_bit_le(pos++, bit_addr);
> 
> 		mb();
> 		tsc_s_e2 = rdtsc();
> 		tsc_s_e2 -= tsc_s_b2;
> 		do_div(tsc_s_e2, 1000);
> 
> 		printk("%-16llu %-16llu\n", tsc_s_e1, tsc_s_e2);
> 	}
> 
> 	preempt_enable();
> 	local_irq_restore(flags);
> }
> case: 11111111 11111111
> 		{255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255, 255,
> 		 255, 255, 255, 255, 255, 255},
> case: 10101010 10101010
> 		{170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170, 170,
> 		 170, 170, 170, 170, 170, 170},
> case: 11111111 00000000
> 		{255, 0, 255, 0, 255, 0, 255,
> 		 0, 255, 0, 255, 0, 255, 0,
> 		 255, 0, 255, 0, 255, 0, 255,
> 		 0, 255, 0, 255, 0, 255},
> case: 00001111 00001111
> 		 {15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15, 15,
> 		 15, 15, 15, 15, 15, 15}
> 
> and here are test result in my env. (Ubuntu vm, 768MB, i3-3220)
> It seems find_next_bit works not so bad as I thought.
> 
> find_next_bit    test_bit_le
> 73               4209
> 62               1271
> 69               1585
> 50               2031
> 67               2255
> 82               2261
> 52               4007
> 79               2159
> 50               2043
> 55               2215
> 53               2393
> 72               3784
> 76               1879
> 61               2562
> 70               2702
> 62               2489
> 56               2307
> 54               2063
> 51               2258
> 69               2712
> 4133             3989  -- case: 11111111 11111111
> 2370             3024  -- case: 10101010 10101010
> 2608             2413  -- case: 11111111 00000000
> 2457             2506  -- case: 00001111 00001111

The time cost of test_bit_le shakes violently, it should be
very smooth according to the test case, maybe it has relation
to your vm env.

To Jaegeuk,
Following test result is walking a bitmap via find_next_bit_le
and test_bit_le.
(Front 7 are random bitmaps, last four are cases from Yu, see
attached sample for detail):

find_next_bit_le    test_bit_le

     3615                3492 
     2640                3492 
     2431                3492 
     1957                3494 
     2160                3492 
     1933                3495 
     1096                3492 

     8078                3492 
     3732                3492 
     4237                3493 
     3824                3492

Thanks,
Gu 

> 
> .
> 



--------------070406080701060601070502
Content-Type: text/plain; name="bit_test_mod.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bit_test_mod.c"

I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgoKX191OCBiaXRtYXBzWzExXVsyN10gPSB7CgkJ
ezEsIDEyMywgMiwgMywgMTI3LCAyMDAsIDEwMCwKCQkgMTIzLCAyMywgMTMsIDc4LCA0Miwg
MTIzLCA1MCwKCQkgMTIzLCA1NiwgMTk4LCAwLCA1OCwgMjIsIDE5LAoJCSAxMjMsIDIzLCAx
MywgNzgsIDQyLCAxMjN9LAoJCXsyLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAxMjMsIDIzLCAx
MywgNzgsIDQyLCAxMjMsIDUwLAoJCSAxMjMsIDU2LCAxOTgsIDAsIDU4LCAyMiwgMTksCgkJ
IDIzLCAxMjMsIDIsIDM0LCAxMjMsIDEyfSwKCQl7NCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkg
MTIzLCA1NiwgMTk4LCAwLCA1OCwgMjIsIDE5LAoJCSAxMjMsIDIzLCAxMywgNzgsIDQyLCAx
MjMsCgkJIDAsIDAsIDAsIDM0LCA0NSwgMjl9LAoJCXs4LCAwLCAwLCAwLCAwLCAwLCAwLAoJ
CSAxLCAxMjMsIDIsIDMsIDEyNywgMjAwLCAxMDAsCgkJIDEyMywgMjMsIDEzLCA3OCwgNDIs
IDEyMywgNTAsCgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXsxNiwgMCwgMCwgMCwgMCwgMCwg
MCwKCQkgOCwgNzgsIDAsIDAsIDIzLCAwLCAyMTMsCgkJIDAsIDEyLCAwLCA0NSwgMCwgMTA5
LCAxMTEsCgkJIDIzMSwgMTEsIDExLCA4OCwgNzcsIDk5fSwKCQl7MzIsIDAsIDAsIDAsIDAs
IDAsIDAsCgkJIDgsIDc4LCAwLCAwLCAyMywgMCwgMjEzLAoJCSAwLCAxMiwgMCwgNDUsIDAs
IDEwOSwgMTExLAoJCSAyMzEsIDExLCAxMSwgODgsIDc3LCA5OX0sCgkJezY0LCAwLCAwLCAw
LCAwLCAwLCAwLAoJCSA4LCA3OCwgMCwgMCwgMjMsIDAsIDIxMywKCQkgMCwgMTIsIDAsIDQ1
LCAwLCAxMDksIDExMSwKCQkgMCwgMCwgMCwgMCwgMCwgMH0sCgkJezI1NSwgMjU1LCAyNTUs
IDI1NSwgMjU1LCAyNTUsIDI1NSwKCQkgMjU1LCAyNTUsIDI1NSwgMjU1LCAyNTUsIDI1NSwg
MjU1LAoJCSAyNTUsIDI1NSwgMjU1LCAyNTUsIDI1NSwgMjU1LCAyNTUsCgkJIDI1NSwgMjU1
LCAyNTUsIDI1NSwgMjU1LCAyNTV9LAoJCXsxNzAsIDE3MCwgMTcwLCAxNzAsIDE3MCwgMTcw
LCAxNzAsCgkJIDE3MCwgMTcwLCAxNzAsIDE3MCwgMTcwLCAxNzAsIDE3MCwKCQkgMTcwLCAx
NzAsIDE3MCwgMTcwLCAxNzAsIDE3MCwgMTcwLAoJCSAxNzAsIDE3MCwgMTcwLCAxNzAsIDE3
MCwgMTcwfSwKCQl7MjU1LCAwLCAyNTUsIDAsIDI1NSwgMCwgMjU1LAoJCSAwLCAyNTUsIDAs
IDI1NSwgMCwgMjU1LCAwLAoJCSAyNTUsIDAsIDI1NSwgMCwgMjU1LCAwLCAyNTUsCgkJIDAs
IDI1NSwgMCwgMjU1LCAwLCAyNTV9LAoJCSB7MTUsIDE1LCAxNSwgMTUsIDE1LCAxNSwgMTUs
CgkJIDE1LCAxNSwgMTUsIDE1LCAxNSwgMTUsIDE1LAoJCSAxNSwgMTUsIDE1LCAxNSwgMTUs
IDE1LCAxNSwKCQkgMTUsIDE1LCAxNSwgMTUsIDE1LCAxNX0KCQl9OwoKdWludDY0X3QgcmR0
c2Modm9pZCkgewp1aW50MzJfdCBsbywgaGk7Cl9fYXNtX18gX192b2xhdGlsZV9fICgicmR0
c2MiIDogIj1hIiAobG8pLCAiPWQiIChoaSkpOwpyZXR1cm4gKHVpbnQ2NF90KWhpIDw8IDMy
IHwgbG87Cn0KCnN0YXRpYyB2b2lkIHRlc3RfYml0X3NlYXJjaF9zcGVlZCh2b2lkKQp7Cgl1
bnNpZ25lZCBsb25nIGZsYWdzOwoJdWludDY0X3QgdHNjX3MsIHRzY19kaWZmOwoJaW50IGks
IGosIHBvczsKCWNvbnN0IHZvaWQgKmJpdF9hZGRyOwoKCWxvY2FsX2lycV9zYXZlKGZsYWdz
KTsKCXByZWVtcHRfZGlzYWJsZSgpOwoKCXByaW50aygiZmluZF9uZXh0X2JpdF9sZSAgICB0
ZXN0X2JpdF9sZVxuIik7CgoJZm9yIChpID0gMDsgaSA8IDExOyBpKyspIHsKCQliaXRfYWRk
ciA9ICZiaXRtYXBzW2ldOwoKCQlwb3MgPSAwOwoJCXRzY19zID0gcmR0c2MoKTsKCgkJZm9y
IChqID0gMDsgaiA8IDEwMDA7IGorKywgcG9zID0gMCkKCQkJd2hpbGUgKHBvcyA8IDIxNikK
CQkJCXBvcyA9IGZpbmRfbmV4dF9iaXRfbGUoYml0X2FkZHIsIDIxNiwgcG9zKSArIDE7CgkJ
bWIoKTsKCQl0c2NfZGlmZiA9IChyZHRzYygpIC0gdHNjX3MpLzEwMDA7CgoJCXByaW50aygi
JThsbHUiLCB0c2NfZGlmZik7CgoJCXBvcyA9IDA7CgkJdHNjX3MgPSByZHRzYygpOwoKCQlm
b3IgKGogPSAwOyBqIDwgMTAwMDsgaisrLCBwb3MgPSAwKQoJCQl3aGlsZSAocG9zIDwgMjE2
KQoJCQkJdGVzdF9iaXRfbGUocG9zKyssIGJpdF9hZGRyKTsKCgkJbWIoKTsKCQl0c2NfZGlm
ZiA9IChyZHRzYygpIC0gdHNjX3MpLzEwMDA7CgoJCXByaW50aygiJTIwbGx1IFxuIiwgdHNj
X2RpZmYpOwoJfQoKCXByZWVtcHRfZW5hYmxlKCk7Cglsb2NhbF9pcnFfcmVzdG9yZShmbGFn
cyk7Cn0KCnN0YXRpYyBpbnQgX19pbml0IHN0YXJ0X3Rlc3Qodm9pZCkgewoJdGVzdF9iaXRf
c2VhcmNoX3NwZWVkKCk7CglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgX19leGl0IGV4aXRf
dGVzdCh2b2lkKSB7Cgp9Cgptb2R1bGVfaW5pdChzdGFydF90ZXN0KTsKbW9kdWxlX2V4aXQo
ZXhpdF90ZXN0KTsKCk1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKTU9EVUxFX0FVVEhPUigiR3Ug
WmhlbmciKTsK
--------------070406080701060601070502--
