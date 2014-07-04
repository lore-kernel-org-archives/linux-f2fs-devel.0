From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le
 in, find_in_block
Date: Thu, 3 Jul 2014 22:36:19 -0700
Message-ID: <20140704053619.GA32528@jmac.local>
References: <53A950F9.907@cn.fujitsu.com>
 <20140702103059.GA26619@jmac.local>
 <53B52CEA.8080407@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53B52CEA.8080407@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?utf-8?B?7J207LC966eM?= <cm224.lee@samsung.com>, =?utf-8?B?5L+e6LY=?= <chao2.yu@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Well, how about testing with many ones in the bit streams?
Thanks,

On Thu, Jul 03, 2014 at 06:14:02PM +0800, Gu Zheng wrote:
> Hi Jaegeuk, Changman
> 
> Just a simple test, not very sure it can address
> our qualm.
> 
> Bitmap size:216(the same as f2fs dentry_bits).
> CPU: Intel i5 x86_64.
> 
> Time counting based on tsc(the less the fast).
> [Index of 1]	find_next_bit_le	test_bit_le
> 0		20			117
> 1		20			114
> 2		20			113
> 3		20			139
> 4		22			121
> 5		22			118
> 6		22			115
> 8		22			112
> 9		22			106
> 10		22			105
> 11		22			100
> 16		22			98
> 48		22			97
> 80		27			95	
> 104		27			92
> 136		32			95
> 160		32			92
> 184		32			90
> 200		27			87
> 208		35			84
> 
> According to the result, find_next_bit_le is always
> better than test_bit_le, though there may be some
> noise, but I think the result is clear.
> Hope it can help us.:)
> ps.The sample is attached too.
> 
> Thanks,
> Gu
> On 07/02/2014 06:30 PM, Jaegeuk Kim wrote:
> 
> > Thanks Changman for reminding this. :)
> > 
> > If there are a lot of ones in the bit stream, find_next_bit_le would cause some
> > overhead to translate the bits.
> > 
> > However, it would be effective to use find_next_bit_le if the bit stream looks
> > like 0000000001.
> > 
> > Well, IMO the former case would be a little bit more common.
> > 
> > Gu,
> > Can you provide some performance numbers wrt this?
> > 
> > On Tue, Jun 24, 2014 at 06:20:41PM +0800, Gu Zheng wrote:
> >> Use find_next_bit_le rather than test_bit_le to improve search speed
> >> lightly.
> >>
> >> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> >> ---
> >>  fs/f2fs/dir.c |   43 +++++++++++++++++++++----------------------
> >>  1 files changed, 21 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >> index 3edd561..ba510fb 100644
> >> --- a/fs/f2fs/dir.c
> >> +++ b/fs/f2fs/dir.c
> >> @@ -93,42 +93,41 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
> >>  			const char *name, size_t namelen, int *max_slots,
> >>  			f2fs_hash_t namehash, struct page **res_page)
> >>  {
> >> -	struct f2fs_dir_entry *de;
> >> -	unsigned long bit_pos = 0;
> >> +	unsigned long bit_pos = 0, bit_start = 0;
> >>  	struct f2fs_dentry_block *dentry_blk = kmap(dentry_page);
> >>  	const void *dentry_bits = &dentry_blk->dentry_bitmap;
> >> -	int max_len = 0;
> >>  
> >> -	while (bit_pos < NR_DENTRY_IN_BLOCK) {
> >> -		if (!test_bit_le(bit_pos, dentry_bits)) {
> >> -			if (bit_pos == 0)
> >> -				max_len = 1;
> >> -			else if (!test_bit_le(bit_pos - 1, dentry_bits))
> >> -				max_len++;
> >> -			bit_pos++;
> >> -			continue;
> >> +	while (bit_start < NR_DENTRY_IN_BLOCK) {
> >> +		struct f2fs_dir_entry *de;
> >> +		int max_len = 0;
> >> +
> >> +		bit_pos = find_next_bit_le(dentry_bits,
> >> +					NR_DENTRY_IN_BLOCK, bit_start);
> >> +
> >> +		max_len = bit_pos - bit_start;
> >> +		if (max_len > *max_slots) {
> >> +			*max_slots = max_len;
> >> +			max_len = 0;
> >>  		}
> >> +
> >> +		if (bit_pos >= NR_DENTRY_IN_BLOCK)
> >> +			break;
> >> +
> >>  		de = &dentry_blk->dentry[bit_pos];
> >>  		if (early_match_name(name, namelen, namehash, de)) {
> >>  			if (!memcmp(dentry_blk->filename[bit_pos],
> >>  							name, namelen)) {
> >>  				*res_page = dentry_page;
> >> -				goto found;
> >> +				return de;
> >>  			}
> >>  		}
> >> -		if (max_len > *max_slots) {
> >> -			*max_slots = max_len;
> >> -			max_len = 0;
> >> -		}
> >> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> >> +
> >> +		bit_start = bit_pos
> >> +				+ GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> >>  	}
> >>  
> >> -	de = NULL;
> >>  	kunmap(dentry_page);
> >> -found:
> >> -	if (max_len > *max_slots)
> >> -		*max_slots = max_len;
> >> -	return de;
> >> +	return NULL;
> >>  }
> >>  
> >>  static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> >> -- 
> >> 1.7.7
> > 
> 
> 

> #include <linux/module.h>
> 
> __u8 bitmaps[20][27] = {
> 		{1, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{2, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{4, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{8, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{16, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 1,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{32, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{64, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 1, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 2, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 4, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 8, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 1, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 1,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 1, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 1,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 1, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 1,
> 		 0, 0, 0, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 1, 0, 0, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 1, 0},
> 		{0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 0, 0,
> 		 0, 0, 0, 0, 0, 1}
> 		};
> 
> uint64_t rdtsc(void) {
> uint32_t lo, hi;
> __asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
> return (uint64_t)hi << 32 | lo;
> }
> 
> static void test_bit_search_speed(void)
> {
> 	unsigned long flags;
> 	uint64_t tsc_s, tsc_diff;
> 	int i, j, pos;
> 	const void *bit_addr;
> 
> 	local_irq_save(flags);
> 	preempt_disable();
> 
> 	for (i = 0; i < 20; i++) {
> 		printk("Test bitmap %d... \n", i);
> 
> 		bit_addr = &bitmaps[i];
> 
> 		tsc_s = rdtsc();
> 
> 		for (j = 0; j < 1000; j++)
> 			find_next_bit_le(bit_addr, 216, 0);
> 
> 		tsc_diff = (rdtsc() - tsc_s)/1000;
> 
> 		printk("find_next_bit_le: %llu \n", tsc_diff);
> 
> 		pos = 0;
> 		tsc_s = rdtsc();
> 
> 		for (j = 0; j < 1000; j++)
> 			while (!test_bit_le(pos++, bit_addr));
> 
> 		tsc_diff = (rdtsc() - tsc_s)/1000;
> 
> 		printk("test_bit_le     : %llu \n", tsc_diff);
> 	}
> 
> 	preempt_enable();
> 	local_irq_restore(flags);
> }
> 
> static int __init start_test(void) {
> 	test_bit_search_speed();
> 	return 0;
> }
> 
> static void __exit exit_test(void) {
> 
> }
> 
> module_init(start_test);
> module_exit(exit_test);
> 
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Gu Zheng");


-- 
Jaegeuk Kim
