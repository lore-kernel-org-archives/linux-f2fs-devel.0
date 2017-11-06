From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RESEND] f2fs: modify the procedure of scan
 free nid
Date: Mon, 6 Nov 2017 19:07:44 +0800
Message-ID: <be3f5b51-8df5-8c36-9c46-ceeb0b3c13ce@huawei.com>
References: <CGME20171103073249epcas1p4a6e7f7875d21ec575efd593c3b5bd970@epcas1p4.samsung.com>
 <001101d35475$f33d8b40$d9b8a1c0$@samsung.com>
 <f83b866a-b755-c3b8-b321-0ce1e91acb6f@huawei.com>
 <001a01d3548e$d3b06b80$7b114280$@samsung.com>
 <b5269e32-b8a4-f9fb-145d-e2106431fbc1@kernel.org>
 <000e01d356ce$5d3e6be0$17bb43a0$@samsung.com>
 <011233d9-77b4-e517-2b82-bc7c5fc61d46@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1eBfGY-0004zJ-En
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 11:08:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eBfGV-0001r9-8l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 11:08:30 +0000
In-Reply-To: <011233d9-77b4-e517-2b82-bc7c5fc61d46@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk
 Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/6 18:42, Chao Yu wrote:
> On 2017/11/6 15:09, Fan Li wrote:
>>
>>
>>> -----Original Message-----
>>> From: Chao Yu [mailto:chao@kernel.org]
>>> Sent: Friday, November 03, 2017 9:16 PM
>>> To: Fan Li; 'Chao Yu'; 'Jaegeuk Kim'
>>> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>>> Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: modify the procedure of scan free nid
>>>
>>> On 2017/11/3 18:29, Fan Li wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Chao Yu [mailto:yuchao0@huawei.com]
>>>>> Sent: Friday, November 03, 2017 4:54 PM
>>>>> To: Fan Li; 'Chao Yu'; 'Jaegeuk Kim'
>>>>> Cc: linux-kernel@vger.kernel.org;
>>>>> linux-f2fs-devel@lists.sourceforge.net
>>>>> Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: modify the procedure of
>>>>> scan free nid
>>>>>
>>>>> On 2017/11/3 15:31, Fan Li wrote:
>>>>>> In current version, we preserve 8 pages of nat blocks as free nids,
>>>>>> we build bitmaps for it and use them to allocate nids until its
>>>>>> number drops below NAT_ENTRY_PER_BLOCK.
>>>>>>
>>>>>> After that, we have a problem, scan_free_nid_bits will scan the same
>>>>>> 8 pages trying to find more free nids, but in most cases the free
>>>>>> nids in these bitmaps are already in free list, scan them won't get
>>>>>> us any new nids.
>>>>>> Further more, after scan_free_nid_bits, the scan is over if
>>>>>> nid_cnt[FREE_NID] != 0.
>>>>>> It causes that we scan the same pages over and over again, and no
>>>>>> new free nids are found until nid_cnt[FREE_NID]==0. While the
>>>>>> scanned pages increase, the problem grows worse.
>>>>>>
>>>>>> This patch mark the range where new free nids could exist and keep
>>>>>> scan for free nids until nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK.
>>>>>> The new vairable first_scan_block marks the start of the range, it's
>>>>>> initialized with NEW_ADDR, which means all free nids before
>>>>>> next_scan_nid are already in free list; and use next_scan_nid as the
>>>>>> end of the range since all free nids which are scanned in
>>>>>> scan_free_nid_bits must be smaller next_scan_nid.
>>>>>
>>>>> Think over again, IMO, we can add an variable for stating total count
>>>>> of free nids in bitamp, if there is no free nid, just
>>>> skipping scanning all
>>>>> existed bitmap.
>>>>>
>>>>> And if there is only few free nid scattered in bitmap, the cost will
>>>>> be limited because we will skip scanning
>>>> nm_i::free_nid_bitmap if
>>>>> nm_i::free_nid_count is zero. Once we find one free nid, let's skip out.
>>>>>
>>>>> Since there shouldn't be very heavy overhead for CPU during traveling
>>>>> nm_i::nat_block_bitmap, I expect below change could be more simple for maintaining and being with the same effect.
>>>>>
>>>>> How do you think?
>>>>>
>>>>
>>>> I think if you need this to work, check total_bitmap_free_nid may not be sufficient enough.
>>>> The problem this patch presents is  that even all the free nids are
>>>> already in the free list, we still scan all the pages.
>>>> The scan proceeds once free nid count is below NAT_ENTRY_PER_BLOCK.
>>>> So in most cases, there are still free nids in the bitmap during the
>>>> scan, and current codes will check every one of them to see if they are actually in free list.
>>>> If only check total_bitmap_free_nid == 0 won't take this overhead away.
>>>
>>> Oh, you could see that, we have added free_nid_count in each NAT block's free_nid_bitmap bitmap, before scan the bitmap, we will
>> make
>>> sure there is at least one free nid.
>>>
>>> scan_free_nid_bits()
>>> 	for (i = 0; i < nm_i->nat_blocks; i++) {
>>> 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
>>> 			continue;
>>> 		if (!nm_i->free_nid_count[i])
>>> 			continue;
>> Do you mean  free_nid_count here?
>> I thought free_nid_count only represents how many nats are marked free in bitmap of one block.
> 
> Right.
> 
>>
>> To my understanding, even a nat is already in the free list, it will still have a bit marked as free in 
>> free_nid_bitmap and a count in free_nid_count.
>> That means if free_nid_count != 0, and there are marked bits in the bitmap, the free nats in this
>> block could still  be all in the free list.
> 
> Yes.
> 
>> The purpose of scan is to find new nats and add them to free list, go through the nats which are
>> already in the free list isn't what we want.
>> And in xfstest, under most cases scan_free_nid_bits runs, all free nats are indeed in the free list.
> 
> Could you test that diff to check whether we will scan free_nid_bitmap
> which indicates there are free nids, but can not add any of them into
> free list due to they already are there.
> 
> -		if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
> +		if (nm_i->nid_cnt[FREE_NID])
> 
> Due to above change, I expect that will be eliminated...

Please check and test this diff:

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8df2ce9a1356..ff0ce3a4ceab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -729,6 +729,7 @@ struct f2fs_nm_info {
 	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
 	unsigned char *nat_block_bitmap;
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
+	unsigned int total_bitmap_free_nid;	/* total free nid count in bitmap */

 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fef5c68886b1..33ee1302dbe1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1911,10 +1911,13 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 	else
 		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);

-	if (set)
+	if (set) {
 		nm_i->free_nid_count[nat_ofs]++;
-	else if (!build)
+		nm_i->total_bitmap_free_nid++;
+	} else if (!build) {
 		nm_i->free_nid_count[nat_ofs]--;
+		nm_i->total_bitmap_free_nid--;
+	}
 }

 static void scan_nat_page(struct f2fs_sb_info *sbi,
@@ -1958,6 +1961,9 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)

 	down_read(&nm_i->nat_tree_lock);

+	if (!nm_i->total_bitmap_free_nid)
+		goto out;
+
 	for (i = 0; i < nm_i->nat_blocks; i++) {
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
@@ -1972,7 +1978,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
 			add_free_nid(sbi, nid, true);

-			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
+			if (nm_i->nid_cnt[FREE_NID])
 				goto out;
 		}
 	}
@@ -2012,6 +2018,10 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		return;

 	if (!mount) {
+		/* if there are free nids in list, allocate them in prior */
+		if (sync && nm_i->nid_cnt[FREE_NID])
+			return;
+
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);

Thanks,

> 
> Thanks,
> 
>>
>>> 		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
>>> 			nid_t nid;
>>>
>>> 			if (!test_bit_le(idx, nm_i->free_nid_bitmap[i]))
>>> 				continue;
>>>
>>> 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>>> 			add_free_nid(sbi, nid, true);
>>>
>>> 			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>>> 				goto out;
>>> 		}
>>> 	}
>>>
>>> And In that diff, we have changed the exiting condition, once we have grabbed one free nid, stop building.
>>>
>>>>> -			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>>>>> +			if (nm_i->nid_cnt[FREE_NID])
>>>>>  				goto out;
>>>
>>>
>>> So with that simple change, only overhead here is we need to travel nat_block_bitmap all the time when total_bitmap_free_nid is
>> nonzero,
>>> but I think that would not be an critical issue here.
>>>
>>>>
>>>> I considered a lot of ways to fix this problem before I submit this
>>>> patch, One of my idea is quite similar to yours, but I use "if
>>>> (total_bitmap_free_nid == nm_i->nid_cnt[FREE_NID])" to decide whether
>>>> skip or not.
>>>
>>> Hmm.. can we confirm that if there is no free nid in all bitmap, we can skip the unneeded scanning? Anyway, I think you can write
>> a patch to
>>> fix that first?
>>> More like that diff.
>>>
>>>> If you insist, I can submit this simpler one instead, but some follow
>>>> upgrade would be unavailable, for example, use smaller granularity for
>>>> tracking last-scanned-position that we talked about.> I know sometimes
>>>> I can be obsessed with the performance, I usually choose the faster
>>>> way over simpler ones. If you think it's too much, please tell me, I'm
>>>> sure we can find some middle ground.
>>>
>>> Yup, I think that's why you're the expert of algorithm, I have no doubt about that. :)
>>>
>>> IMO, instead of reducing cpu overhead without simple change, I prefer the one can reducing IO, e.g. if NAT block contains maximum
>> count
>>> free nids, we can load these nids first, after they were been allocated, in checkpoint, we can write these nat entries into one
>> NAT block. On
>>> the contrary, if we load free nids with same count from different NAT blocks, in checkpoint, maybe we will write them into more
>> NAT blocks.
>>>
>>> Thanks,
>>>
>>>>
>>>> Thank you
>>>>
>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
>>>>> cb3f10bc8723..238d95e89dec 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -729,6 +729,7 @@ struct f2fs_nm_info {
>>>>>  	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
>>>>>  	unsigned char *nat_block_bitmap;
>>>>>  	unsigned short *free_nid_count;	/* free nid count of NAT block */
>>>>> +	unsigned int total_bitmap_free_nid;	/* total free nid count in bitmap */
>>>>>
>>>>>  	/* for checkpoint */
>>>>>  	char *nat_bitmap;		/* NAT bitmap pointer */
>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index
>>>>> fef5c68886b1..e4861908a396 100644
>>>>> --- a/fs/f2fs/node.c
>>>>> +++ b/fs/f2fs/node.c
>>>>> @@ -1911,10 +1911,13 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>>>>>  	else
>>>>>  		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>>>>>
>>>>> -	if (set)
>>>>> +	if (set) {
>>>>>  		nm_i->free_nid_count[nat_ofs]++;
>>>>> -	else if (!build)
>>>>> +		nm_i->total_bitmap_free_nid++;
>>>>> +	} else if (!build) {
>>>>>  		nm_i->free_nid_count[nat_ofs]--;
>>>>> +		nm_i->total_bitmap_free_nid--;
>>>>> +	}
>>>>>  }
>>>>>
>>>>>  static void scan_nat_page(struct f2fs_sb_info *sbi, @@ -1958,6
>>>>> +1961,9 @@ static void scan_free_nid_bits(struct f2fs_sb_info
>>>> *sbi)
>>>>>
>>>>>  	down_read(&nm_i->nat_tree_lock);
>>>>>
>>>>> +	if (!nm_i->total_bitmap_free_nid)
>>>>> +		goto out;
>>>>> +
>>>>>  	for (i = 0; i < nm_i->nat_blocks; i++) {
>>>>>  		if (!test_bit_le(i, nm_i->nat_block_bitmap))
>>>>>  			continue;
>>>>> @@ -1972,7 +1978,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>>>>  			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>>>>>  			add_free_nid(sbi, nid, true);
>>>>>
>>>>> -			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>>>>> +			if (nm_i->nid_cnt[FREE_NID])
>>>>>  				goto out;
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Signed-off-by: Fan li <fanofcode.li@samsung.com>
>>>>>> ---
>>>>>>  fs/f2fs/f2fs.h |  1 +
>>>>>>  fs/f2fs/node.c | 42 +++++++++++++++++++++++++++++++++++-------
>>>>>>  2 files changed, 36 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index e0ef31c..ae1cf91
>>>>>> 100644
>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>> @@ -705,6 +705,7 @@ struct f2fs_nm_info {
>>>>>>  	nid_t max_nid;			/* maximum possible node ids */
>>>>>>  	nid_t available_nids;		/* # of available node ids */
>>>>>>  	nid_t next_scan_nid;		/* the next nid to be scanned */
>>>>>> +	block_t first_scan_block;       /* the first NAT block to be scanned */
>>>>>>  	unsigned int ram_thresh;	/* control the memory footprint */
>>>>>>  	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
>>>>>>  	unsigned int dirty_nats_ratio;	/* control dirty nats ratio threshold */
>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 3d0d1be..f921e0c
>>>>>> 100644
>>>>>> --- a/fs/f2fs/node.c
>>>>>> +++ b/fs/f2fs/node.c
>>>>>> @@ -1812,7 +1812,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>>  	struct free_nid *i, *e;
>>>>>>  	struct nat_entry *ne;
>>>>>> -	int err = -EINVAL;
>>>>>> +	int need_free = 1;
>>>>>>  	bool ret = false;
>>>>>>
>>>>>>  	/* 0 nid should not be used */
>>>>>> @@ -1863,13 +1863,25 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
>>>>>>  		}
>>>>>>  	}
>>>>>>  	ret = true;
>>>>>> -	err = __insert_free_nid(sbi, i, FREE_NID);
>>>>>> +	need_free = __insert_free_nid(sbi, i, FREE_NID);
>>>>>>  err_out:
>>>>>>  	spin_unlock(&nm_i->nid_list_lock);
>>>>>>  	radix_tree_preload_end();
>>>>>>  err:
>>>>>> -	if (err)
>>>>>> +	if (need_free)
>>>>>>  		kmem_cache_free(free_nid_slab, i);
>>>>>> +	/*
>>>>>> +	 * For nid that should be free but not in the free
>>>>>> +	 * structure, update the scan range in hope of adding
>>>>>> +	 * it in the next scan.
>>>>>> +	 */
>>>>>> +	if (!ret || need_free < 0) {
>>>>>> +		block_t tmp_block = NAT_BLOCK_OFFSET(nid);
>>>>>> +
>>>>>> +		if (tmp_block < nm_i->first_scan_block)
>>>>>> +			nm_i->first_scan_block = tmp_block;
>>>>>> +	}
>>>>>> +
>>>>>>  	return ret;
>>>>>>  }
>>>>>>
>>>>>> @@ -1950,10 +1962,17 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>>>>  	struct f2fs_journal *journal = curseg->journal;
>>>>>>  	unsigned int i, idx;
>>>>>> +	unsigned int max_blocks = NAT_BLOCK_OFFSET(nm_i->next_scan_nid);
>>>>>>
>>>>>> -	down_read(&nm_i->nat_tree_lock);
>>>>>> +	/* every free nid in blocks scanned previously is in the free list */
>>>>>> +	if (nm_i->first_scan_block == NEW_ADDR)
>>>>>> +		return;
>>>>>>
>>>>>> -	for (i = 0; i < nm_i->nat_blocks; i++) {
>>>>>> +	if (max_blocks == 0)
>>>>>> +		max_blocks = nm_i->nat_blocks;
>>>>>> +
>>>>>> +	down_read(&nm_i->nat_tree_lock);
>>>>>> +	for (i = nm_i->first_scan_block; i < max_blocks; i++) {
>>>>>>  		if (!test_bit_le(i, nm_i->nat_block_bitmap))
>>>>>>  			continue;
>>>>>>  		if (!nm_i->free_nid_count[i])
>>>>>> @@ -1967,10 +1986,13 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>>>>>>  			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>>>>>>  			add_free_nid(sbi, nid, true);
>>>>>>
>>>>>> -			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
>>>>>> +			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS) {
>>>>>> +				nm_i->first_scan_block = i;
>>>>>>  				goto out;
>>>>>> +			}
>>>>>>  		}
>>>>>>  	}
>>>>>> +	nm_i->first_scan_block = NEW_ADDR;
>>>>>>  out:
>>>>>>  	down_read(&curseg->journal_rwsem);
>>>>>>  	for (i = 0; i < nats_in_cursum(journal); i++) { @@ -2010,7 +2032,7
>>>>>> @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>>>>>>  		/* try to find free nids in free_nid_bitmap */
>>>>>>  		scan_free_nid_bits(sbi);
>>>>>>
>>>>>> -		if (nm_i->nid_cnt[FREE_NID])
>>>>>> +		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
>>>>>>  			return;
>>>>>>  	}
>>>>>>
>>>>>> @@ -2163,6 +2185,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>>>>>>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>>>>  	struct free_nid *i, *next;
>>>>>>  	int nr = nr_shrink;
>>>>>> +	nid_t min_nid = nm_i->max_nid;
>>>>>>
>>>>>>  	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>>>>>>  		return 0;
>>>>>> @@ -2176,11 +2199,15 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
>>>>>>  				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
>>>>>>  			break;
>>>>>>
>>>>>> +		if (i->nid < min_nid)
>>>>>> +			min_nid = i->nid;
>>>>>>  		__remove_free_nid(sbi, i, FREE_NID);
>>>>>>  		kmem_cache_free(free_nid_slab, i);
>>>>>>  		nr_shrink--;
>>>>>>  	}
>>>>>>  	spin_unlock(&nm_i->nid_list_lock);
>>>>>> +	if (min_nid != nm_i->max_nid)
>>>>>> +		nm_i->first_scan_block = NAT_BLOCK_OFFSET(min_nid);
>>>>>>  	mutex_unlock(&nm_i->build_lock);
>>>>>>
>>>>>>  	return nr - nr_shrink;
>>>>>> @@ -2674,6 +2701,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>>>>>  	init_rwsem(&nm_i->nat_tree_lock);
>>>>>>
>>>>>>  	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
>>>>>> +	nm_i->first_scan_block = NEW_ADDR;
>>>>>>  	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
>>>>>>  	version_bitmap = __bitmap_ptr(sbi, NAT_BITMAP);
>>>>>>  	if (!version_bitmap)
>>>>>>
>>>>>
>>>>
>>>>
>>
>>
>>
>> .
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
