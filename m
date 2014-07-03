From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le
 in, find_in_block
Date: Thu, 3 Jul 2014 18:14:02 +0800
Message-ID: <53B52CEA.8080407@cn.fujitsu.com>
References: <53A950F9.907@cn.fujitsu.com> <20140702103059.GA26619@jmac.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------020602090002020205070706"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20140702103059.GA26619@jmac.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?7J207LC966eM?= <cm224.lee@samsung.com>, =?UTF-8?B?5L+e6LaF?= <chao2.yu@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

--------------020602090002020205070706
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Jaegeuk, Changman

Just a simple test, not very sure it can address
our qualm.

Bitmap size:216(the same as f2fs dentry_bits).
CPU: Intel i5 x86_64.

Time counting based on tsc(the less the fast).
[Index of 1]	find_next_bit_le	test_bit_le
0		20			117
1		20			114
2		20			113
3		20			139
4		22			121
5		22			118
6		22			115
8		22			112
9		22			106
10		22			105
11		22			100
16		22			98
48		22			97
80		27			95	
104		27			92
136		32			95
160		32			92
184		32			90
200		27			87
208		35			84

According to the result, find_next_bit_le is always
better than test_bit_le, though there may be some
noise, but I think the result is clear.
Hope it can help us.:)
ps.The sample is attached too.

Thanks,
Gu
On 07/02/2014 06:30 PM, Jaegeuk Kim wrote:

> Thanks Changman for reminding this. :)
> 
> If there are a lot of ones in the bit stream, find_next_bit_le would cause some
> overhead to translate the bits.
> 
> However, it would be effective to use find_next_bit_le if the bit stream looks
> like 0000000001.
> 
> Well, IMO the former case would be a little bit more common.
> 
> Gu,
> Can you provide some performance numbers wrt this?
> 
> On Tue, Jun 24, 2014 at 06:20:41PM +0800, Gu Zheng wrote:
>> Use find_next_bit_le rather than test_bit_le to improve search speed
>> lightly.
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> ---
>>  fs/f2fs/dir.c |   43 +++++++++++++++++++++----------------------
>>  1 files changed, 21 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 3edd561..ba510fb 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -93,42 +93,41 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
>>  			const char *name, size_t namelen, int *max_slots,
>>  			f2fs_hash_t namehash, struct page **res_page)
>>  {
>> -	struct f2fs_dir_entry *de;
>> -	unsigned long bit_pos = 0;
>> +	unsigned long bit_pos = 0, bit_start = 0;
>>  	struct f2fs_dentry_block *dentry_blk = kmap(dentry_page);
>>  	const void *dentry_bits = &dentry_blk->dentry_bitmap;
>> -	int max_len = 0;
>>  
>> -	while (bit_pos < NR_DENTRY_IN_BLOCK) {
>> -		if (!test_bit_le(bit_pos, dentry_bits)) {
>> -			if (bit_pos == 0)
>> -				max_len = 1;
>> -			else if (!test_bit_le(bit_pos - 1, dentry_bits))
>> -				max_len++;
>> -			bit_pos++;
>> -			continue;
>> +	while (bit_start < NR_DENTRY_IN_BLOCK) {
>> +		struct f2fs_dir_entry *de;
>> +		int max_len = 0;
>> +
>> +		bit_pos = find_next_bit_le(dentry_bits,
>> +					NR_DENTRY_IN_BLOCK, bit_start);
>> +
>> +		max_len = bit_pos - bit_start;
>> +		if (max_len > *max_slots) {
>> +			*max_slots = max_len;
>> +			max_len = 0;
>>  		}
>> +
>> +		if (bit_pos >= NR_DENTRY_IN_BLOCK)
>> +			break;
>> +
>>  		de = &dentry_blk->dentry[bit_pos];
>>  		if (early_match_name(name, namelen, namehash, de)) {
>>  			if (!memcmp(dentry_blk->filename[bit_pos],
>>  							name, namelen)) {
>>  				*res_page = dentry_page;
>> -				goto found;
>> +				return de;
>>  			}
>>  		}
>> -		if (max_len > *max_slots) {
>> -			*max_slots = max_len;
>> -			max_len = 0;
>> -		}
>> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>> +
>> +		bit_start = bit_pos
>> +				+ GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>>  	}
>>  
>> -	de = NULL;
>>  	kunmap(dentry_page);
>> -found:
>> -	if (max_len > *max_slots)
>> -		*max_slots = max_len;
>> -	return de;
>> +	return NULL;
>>  }
>>  
>>  static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>> -- 
>> 1.7.7
> 



--------------020602090002020205070706
Content-Type: text/plain; name="bit_test_mod.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bit_test_mod.c"

I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgoKX191OCBiaXRtYXBzWzIwXVsyN10gPSB7CgkJ
ezEsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAs
IDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXsyLCAwLCAwLCAwLCAw
LCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAw
LAoJCSAwLCAwLCAwLCAwLCAwLCAwfSwKCQl7NCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwg
MCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwg
MCwgMCwgMH0sCgkJezgsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAs
IDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXsx
NiwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMSwKCQkgMCwgMCwg
MCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMH0sCgkJezMyLCAwLCAwLCAwLCAw
LCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAw
LAoJCSAwLCAwLCAwLCAwLCAwLCAwfSwKCQl7NjQsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAs
IDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAs
IDAsIDAsIDB9LAoJCXswLCAxLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAw
LCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwfSwKCQl7
MCwgMiwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwg
MCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMH0sCgkJezAsIDQsIDAsIDAsIDAs
IDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAs
CgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXswLCA4LCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAw
LCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAw
LCAwLCAwfSwKCQl7MCwgMCwgMSwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwg
MCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMH0sCgkJezAs
IDAsIDAsIDAsIDAsIDAsIDEsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAs
IDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXswLCAwLCAwLCAwLCAwLCAw
LCAwLAoJCSAwLCAwLCAwLCAxLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJ
CSAwLCAwLCAwLCAwLCAwLCAwfSwKCQl7MCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwg
MCwgMCwgMCwgMCwgMSwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwg
MCwgMH0sCgkJezAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAs
CgkJIDAsIDAsIDAsIDEsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDB9LAoJCXswLCAw
LCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAw
LCAwLCAwLCAxLAoJCSAwLCAwLCAwLCAwLCAwLCAwfSwKCQl7MCwgMCwgMCwgMCwgMCwgMCwg
MCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkgMCwgMCwgMCwgMCwgMCwgMCwgMCwKCQkg
MCwgMCwgMSwgMCwgMCwgMH0sCgkJezAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAs
IDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDAsIDAsIDAsCgkJIDAsIDAsIDAsIDAsIDEs
IDB9LAoJCXswLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJ
CSAwLCAwLCAwLCAwLCAwLCAwLCAwLAoJCSAwLCAwLCAwLCAwLCAwLCAxfQoJCX07Cgp1aW50
NjRfdCByZHRzYyh2b2lkKSB7CnVpbnQzMl90IGxvLCBoaTsKX19hc21fXyBfX3ZvbGF0aWxl
X18gKCJyZHRzYyIgOiAiPWEiIChsbyksICI9ZCIgKGhpKSk7CnJldHVybiAodWludDY0X3Qp
aGkgPDwgMzIgfCBsbzsKfQoKc3RhdGljIHZvaWQgdGVzdF9iaXRfc2VhcmNoX3NwZWVkKHZv
aWQpCnsKCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cgl1aW50NjRfdCB0c2NfcywgdHNjX2RpZmY7
CglpbnQgaSwgaiwgcG9zOwoJY29uc3Qgdm9pZCAqYml0X2FkZHI7CgoJbG9jYWxfaXJxX3Nh
dmUoZmxhZ3MpOwoJcHJlZW1wdF9kaXNhYmxlKCk7CgoJZm9yIChpID0gMDsgaSA8IDIwOyBp
KyspIHsKCQlwcmludGsoIlRlc3QgYml0bWFwICVkLi4uIFxuIiwgaSk7CgoJCWJpdF9hZGRy
ID0gJmJpdG1hcHNbaV07CgoJCXRzY19zID0gcmR0c2MoKTsKCgkJZm9yIChqID0gMDsgaiA8
IDEwMDA7IGorKykKCQkJZmluZF9uZXh0X2JpdF9sZShiaXRfYWRkciwgMjE2LCAwKTsKCgkJ
dHNjX2RpZmYgPSAocmR0c2MoKSAtIHRzY19zKS8xMDAwOwoKCQlwcmludGsoImZpbmRfbmV4
dF9iaXRfbGU6ICVsbHUgXG4iLCB0c2NfZGlmZik7CgoJCXBvcyA9IDA7CgkJdHNjX3MgPSBy
ZHRzYygpOwoKCQlmb3IgKGogPSAwOyBqIDwgMTAwMDsgaisrKQoJCQl3aGlsZSAoIXRlc3Rf
Yml0X2xlKHBvcysrLCBiaXRfYWRkcikpOwoKCQl0c2NfZGlmZiA9IChyZHRzYygpIC0gdHNj
X3MpLzEwMDA7CgoJCXByaW50aygidGVzdF9iaXRfbGUgICAgIDogJWxsdSBcbiIsIHRzY19k
aWZmKTsKCX0KCglwcmVlbXB0X2VuYWJsZSgpOwoJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3Mp
Owp9CgpzdGF0aWMgaW50IF9faW5pdCBzdGFydF90ZXN0KHZvaWQpIHsKCXRlc3RfYml0X3Nl
YXJjaF9zcGVlZCgpOwoJcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIF9fZXhpdCBleGl0X3Rl
c3Qodm9pZCkgewoKfQoKbW9kdWxlX2luaXQoc3RhcnRfdGVzdCk7Cm1vZHVsZV9leGl0KGV4
aXRfdGVzdCk7CgpNT0RVTEVfTElDRU5TRSgiR1BMIik7Ck1PRFVMRV9BVVRIT1IoIkd1IFpo
ZW5nIik7Cg==
--------------020602090002020205070706--
