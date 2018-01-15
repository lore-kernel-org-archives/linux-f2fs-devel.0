From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: expand scalability of nat bitmap
Date: Mon, 15 Jan 2018 11:47:50 +0800
Message-ID: <3f71d25e-620a-b49b-e260-ab62cf050551@huawei.com>
References: <3f2ab769-8af7-5317-ba29-03a95130786b@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eavl1-000679-0W
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jan 2018 03:48:23 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eavky-0000Rs-T7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jan 2018 03:48:22 +0000
In-Reply-To: <3f2ab769-8af7-5317-ba29-03a95130786b@aol.com>
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
To: "gaoxiang (P)" <gaoxiang25@huawei.com>
Cc: Gao Xiang <hsiangkao@aol.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Xiang Gao,

On 2018/1/13 19:16, Gao Xiang wrote:
> Hi Chao,
> 
> 
> On 2018/01/12 18:24, Chao Yu wrote:
> 
>> Previously, our total node number (nat_bitmap) and total nat segment count
>> will not monotonously increase along with image size, and max nat_bitmap size
>> is limited by "CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1", it is
>> with bad scalability when user wants to create more inode/node in larger image.
>>
>> So this patch tries to relieve the limitation, by default, limitting total nat
>> entry number with 20% of total block number.
>>
>> Before:
>> image_size(GB)	nat_bitmap	sit_bitmap	nat_segment	sit_segment
>> 16		3836		64		36		2
>> 32		3836		64		72		2
>> 64		3772		128		116		4
>> 128		3708		192		114		6
>> 256		3580		320		110		10
>> 512		3260		640		100		20
>> 1024		2684		1216		82		38
>> 2048		1468		2432		44		76
>> 4096		3900		4800		120		150
>>
>> After:
>> image_size(GB)	nat_bitmap	sit_bitmap	nat_segment	sit_segment
>> 16		256		64		8		2
>> 32		512		64		16		2
>> 64		960		128		30		4
>> 128		1856		192		58		6
>> 256		3712		320		116		10
>> 512		7424		640		232		20
>> 1024		14787		1216		462		38
>> 2048		29504		2432		922		76
>> 4096		59008		4800		1844		150
>>
>> Signed-off-by: Chao Yu <yuchao0@...>
>> ---
>>   fsck/resize.c      | 31 ++++++++++++++-----------------
>>   include/f2fs_fs.h  |  6 ++++--
>>   mkfs/f2fs_format.c | 35 ++++++++++++++---------------------
>>   3 files changed, 32 insertions(+), 40 deletions(-)
>>
>> diff --git a/fsck/resize.c b/fsck/resize.c
>> index 143ad5d3c0a1..7613c7df4893 100644
>> --- a/fsck/resize.c
>> +++ b/fsck/resize.c
>> @@ -16,7 +16,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>   	u_int32_t sit_segments, diff, total_meta_segments;
>>   	u_int32_t total_valid_blks_available;
>>   	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
>> -	u_int32_t max_nat_bitmap_size, max_nat_segments;
>> +	u_int32_t max_nat_bitmap_size;
>>   	u_int32_t segment_size_bytes = 1 << (get_sb(log_blocksize) +
>>   					get_sb(log_blocks_per_seg));
>>   	u_int32_t blks_per_seg = 1 << get_sb(log_blocks_per_seg);
>> @@ -47,7 +47,8 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>   			get_sb(segment_count_sit))) * blks_per_seg;
>>   	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
>>   					NAT_ENTRY_PER_BLOCK);
>> -	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
>> +	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat) *
>> +					DEFAULT_NAT_ENTRY_RATIO / 100);
>>   
>>   	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
>>   				get_sb(log_blocks_per_seg)) / 8;
>> @@ -56,25 +57,21 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>   	else
>>   		max_sit_bitmap_size = sit_bitmap_size;
>>   
>> -	/*
>> -	 * It should be reserved minimum 1 segment for nat.
>> -	 * When sit is too large, we should expand cp area. It requires more pages for cp.
>> -	 */
>> -	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
>> -		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
>> -		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
>> +	max_nat_bitmap_size = (get_sb(segment_count_nat) <<
>> +					get_sb(log_blocks_per_seg)) / 8;
> segment_count_nat would not exceed (CHECKSUM_OFFSET - sizeof(struct 
> f2fs_checkpoint) + 1) * 8 >> get_sb(log_blocks_per_seg) (align-down), I 
> think.
> In my mind, the nat version bitmap is only located in cp page...
> So segment_count_nat has a fixed up bound limitation...

If we want to support large nid bitmap, we need to break this rule, as
nat_bitmap size may exceed "CHECKSUM_OFFSET - sizeof(struct
f2fs_checkpoint) + 1".

> 
>> +
>> +	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
>> +
>> +	/* use cp_payload if free space of f2fs_checkpoint is not enough */
>> +	if (max_sit_bitmap_size + max_nat_bitmap_size >
>> +					MAX_BITMAP_SIZE_IN_CKPT) {
>> +		u_int32_t diff =  max_sit_bitmap_size + max_nat_bitmap_size -
>> +							MAX_BITMAP_SIZE_IN_CKPT;
> I looked up the f2fs source code, in __bitmap_ptr
> 
> if payload is used, the whole payload will be used for sit bitmap.

Oh, I missed to change it. Please check v2.

Thanks,

> 
> Therefore, I mean would it be u_int32_t diff = max_sit_bitmap_size?
> 
> or modify definition in f2fs.h?
> 
>> +		set_sb(cp_payload, F2FS_BLK_ALIGN(diff));
>>   	} else {
>> -		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
>> -			- max_sit_bitmap_size;
>>   		set_sb(cp_payload, 0);
>>   	}
>>   
>> -	max_nat_segments = (max_nat_bitmap_size * 8) >>
>> -					get_sb(log_blocks_per_seg);
>> -
>> -	if (get_sb(segment_count_nat) > max_nat_segments)
>> -		set_sb(segment_count_nat, max_nat_segments);
>> -
>>   	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
>>   
>>   	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) +
>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>> index 4739085ed98f..77e53dfea474 100644
>> --- a/include/f2fs_fs.h
>> +++ b/include/f2fs_fs.h
>> @@ -657,8 +657,8 @@ struct f2fs_checkpoint {
>>   	unsigned char sit_nat_version_bitmap[1];
>>   } __attribute__((packed));
>>   
>> -#define MAX_SIT_BITMAP_SIZE_IN_CKPT	\
>> -	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
>> +#define MAX_BITMAP_SIZE_IN_CKPT	\
>> +	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1)
>>   
>>   /*
>>    * For orphan inode management
>> @@ -846,6 +846,8 @@ struct f2fs_node {
>>   #define NAT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_nat_entry))
>>   #define NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
>>   
>> +#define DEFAULT_NAT_ENTRY_RATIO		20
>> +
>>   #ifdef ANDROID_WINDOWS_HOST
>>   #pragma pack(1)
>>   #endif
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index a13000184300..90363370031e 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -157,7 +157,7 @@ static int f2fs_prepare_super_block(void)
>>   	u_int64_t zone_align_start_offset, diff;
>>   	u_int64_t total_meta_zones, total_meta_segments;
>>   	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
>> -	u_int32_t max_nat_bitmap_size, max_nat_segments;
>> +	u_int32_t max_nat_bitmap_size;
>>   	u_int32_t total_zones;
>>   	u_int32_t next_ino;
>>   	enum quota_type qtype;
>> @@ -272,7 +272,8 @@ static int f2fs_prepare_super_block(void)
>>   	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
>>   			NAT_ENTRY_PER_BLOCK);
>>   
>> -	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
>> +	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat) *
>> +					DEFAULT_NAT_ENTRY_RATIO / 100);
>>   	/*
>>   	 * The number of node segments should not be exceeded a "Threshold".
>>   	 * This number resizes NAT bitmap area in a CP page.
>> @@ -286,29 +287,21 @@ static int f2fs_prepare_super_block(void)
>>   	else
>>   		max_sit_bitmap_size = sit_bitmap_size;
>>   
>> -	/*
>> -	 * It should be reserved minimum 1 segment for nat.
>> -	 * When sit is too large, we should expand cp area. It requires more
>> -	 * pages for cp.
>> -	 */
>> -	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
>> -		max_nat_bitmap_size = CHECKSUM_OFFSET -
>> -				sizeof(struct f2fs_checkpoint) + 1;
>> -		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
>> +	max_nat_bitmap_size = (get_sb(segment_count_nat) <<
>> +					log_blks_per_seg) / 8;
>> +
>> +	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
>> +
>> +	/* use cp_payload if free space of f2fs_checkpoint is not enough */
>> +	if (max_sit_bitmap_size + max_nat_bitmap_size >
>> +					MAX_BITMAP_SIZE_IN_CKPT) {
>> +		u_int32_t diff =  max_sit_bitmap_size + max_nat_bitmap_size -
>> +							MAX_BITMAP_SIZE_IN_CKPT;
> 
> The same as above. :)
> 
> 
> 
> Thanks,
> 
>> +		set_sb(cp_payload, F2FS_BLK_ALIGN(diff));
>>   	} else {
>> -		max_nat_bitmap_size =
>> -			CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
>> -			- max_sit_bitmap_size;
>>   		set_sb(cp_payload, 0);
>>   	}
>>   
>> -	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
>> -
>> -	if (get_sb(segment_count_nat) > max_nat_segments)
>> -		set_sb(segment_count_nat, max_nat_segments);
>> -
>> -	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
>> -
>>   	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
>>   			c.blks_per_seg);
>>   
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
>>
>>
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
