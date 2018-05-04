From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Integer overflows in f2fs fiilesystem
Date: Fri, 4 May 2018 16:56:11 +0800
Message-ID: <d0933271-acc2-89ae-3f25-63e2f850766e@huawei.com>
References: <CA+ygN1JOedPvFekTVW8fHXJHPR11RU674oP4H6_ZbNurHCNX-g@mail.gmail.com>
 <20180427070211.GA4734@kroah.com>
 <CA+55aFwczQeO-nL=zcSHkZT3jjRiG4xfWgemzZ0AW4v=cK7Arg@mail.gmail.com>
 <20180428023228.GA10595@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFz3v1CNPUTbxQiReaZ6fF4nEuEJbHO6J0bMTWSovpS9NQ@mail.gmail.com>
 <20180428042635.GB19897@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fEWVv-0006pn-Sw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 08:56:27 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fEWVt-008BMk-9E
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 08:56:27 +0000
In-Reply-To: <20180428042635.GB19897@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, Silvio Cesare <silvio.cesare@gmail.com>

On 2018/4/28 12:26, Jaegeuk Kim wrote:
> On 04/28, Linus Torvalds wrote:
>> On Fri, Apr 27, 2018 at 7:32 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>>> +       blocks_per_seg = 1 << le32_to_cpu(raw_super->log_blocks_per_seg);
>>
>> This can overflow and do random things.
> 
> Actually it is always 512 by the existing check above.
> 
>>
>>> +       if (segment_count < segs_per_sec * total_sections) {
>>
>> The multiply can overflow. Which might not matter in this context, since
>> the resulting value will be smaller than the non-overflowed "real" value,
>> so it makes the check _stricter_ in the error case, but I think that it
>> might be good to verify the two values you are multiplying before doing the
>> multiply..
> 
> Ah, yes.
> 
>>
>>> +       if (segment_count > F2FS_MAX_SEGMENT ||
>>> +                               segment_count < F2FS_MIN_SEGMENTS) {
>> ...
>>> +       if ((segment_count << 9) > le32_to_cpu(raw_super->block_count)) {
>>
>> The "segment_count << 9" will overflow when segment_count ==
>> F2FS_MAX_SEGMENT.
> 
> Right.
> 
>>
>>> +       if ((le32_to_cpu(raw_super->extension_count) +
>>> +                       raw_super->hot_ext_count) > F2FS_MAX_EXTENSION) {
>>
>> The addition could overflow.
> 
> Yup.
> 
>>
>>> +       if (le32_to_cpu(raw_super->cp_payload) >
>>> +                               (blocks_per_seg - F2FS_CP_PACKS)) {
>>
>> You haven't checked 'blocks_per_seg', so this subtraction could underflow.
>>
>> But if you add checks for the whole "log_blocks_per_seg" (to handle that
>> first "shift can overflow" issue), you'll fix this one too, I think.
>>
>> You just need to make sure that log_blocks_per_seg >=1 and <= 31. But there
>> may be other limits that I didn't notice.
>>
>> I didn't really read it all that carefully, so I might have missed
>> something. The above is from just a quick scan.
> 
> Thank you. How about this?
> 
>>From a1bc37e10c645e351a6d2b65704d630bde882d8d Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 27 Apr 2018 19:03:22 -0700
> Subject: [PATCH] f2fs: enhance sanity_check_raw_super() to avoid potential
>  overflows
> 
> In order to avoid the below overflow issue, we should have checked the
> boundaries in superblock before reaching out to allocation. As Linux suggested,
> the right place should be sanity_check_raw_super().
> 
> Dr Silvio Cesare of InfoSect reported:
> 
> There are integer overflows with using the cp_payload superblock field in the
> f2fs filesystem potentially leading to memory corruption.
> 
> include/linux/f2fs_fs.h
> 
> struct f2fs_super_block {
> ...
>         __le32 cp_payload;
> 
> fs/f2fs/f2fs.h
> 
> typedef u32 block_t;    /*
>                          * should not change u32, since it is the on-disk block
>                          * address format, __le32.
>                          */
> ...
> 
> static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
> {
>         return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
> }
> 
> fs/f2fs/checkpoint.c
> 
>         block_t start_blk, orphan_blocks, i, j;
> ...
>         start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
>         orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
> 
> +++ integer overflows
> 
> ...
>         unsigned int cp_blks = 1 + __cp_payload(sbi);
> ...
>         sbi->ckpt = kzalloc(cp_blks * blk_size, GFP_KERNEL);
> 
> +++ integer overflow leading to incorrect heap allocation.
> 
>         int cp_payload_blks = __cp_payload(sbi);
> ...
>         ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
>                         orphan_blocks);
> 
> +++ sign bug and integer overflow
> 
> ...
>         for (i = 1; i < 1 + cp_payload_blks; i++)
> 
> +++ integer overflow
> 
> ...
> 
>       sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
>                         NR_CURSEG_TYPE - __cp_payload(sbi)) *
>                                 F2FS_ORPHANS_PER_BLOCK;
> 
> +++ integer overflow
> 
> Reported-by: Greg KH <greg@kroah.com>
> Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

+Cc f2fs mailing list

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/super.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a2432b9747eb..c8e5fe5d71fe 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2135,6 +2135,8 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
>  static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  				struct buffer_head *bh)
>  {
> +	block_t segment_count, segs_per_sec, secs_per_zone;
> +	block_t total_sections, blocks_per_seg;
>  	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
>  					(bh->b_data + F2FS_SUPER_OFFSET);
>  	struct super_block *sb = sbi->sb;
> @@ -2191,6 +2193,72 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		return 1;
>  	}
>  
> +	segment_count = le32_to_cpu(raw_super->segment_count);
> +	segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
> +	secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
> +	total_sections = le32_to_cpu(raw_super->section_count);
> +
> +	/* blocks_per_seg should be 512, given the above check */
> +	blocks_per_seg = 1 << le32_to_cpu(raw_super->log_blocks_per_seg);
> +
> +	if (segment_count > F2FS_MAX_SEGMENT ||
> +				segment_count < F2FS_MIN_SEGMENTS) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Invalid segment count (%u)",
> +			segment_count);
> +		return 1;
> +	}
> +
> +	if (total_sections > segment_count ||
> +			total_sections < F2FS_MIN_SEGMENTS ||
> +			segs_per_sec > segment_count || !segs_per_sec) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Invalid segment/section count (%u, %u x %u)",
> +			segment_count, total_sections, segs_per_sec);
> +		return 1;
> +	}
> +
> +	if ((segment_count / segs_per_sec) < total_sections) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Small segment_count (%u < %u * %u)",
> +			segment_count, segs_per_sec, total_sections);
> +		return 1;
> +	}
> +
> +	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong segment_count / block_count (%u > %u)",
> +			segment_count, le32_to_cpu(raw_super->block_count));
> +		return 1;
> +	}
> +
> +	if (secs_per_zone > total_sections) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong secs_per_zone (%u > %u)",
> +			secs_per_zone, total_sections);
> +		return 1;
> +	}
> +	if (le32_to_cpu(raw_super->extension_count) > F2FS_MAX_EXTENSION ||
> +			raw_super->hot_ext_count > F2FS_MAX_EXTENSION ||
> +			(le32_to_cpu(raw_super->extension_count) +
> +			raw_super->hot_ext_count) > F2FS_MAX_EXTENSION) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Corrupted extension count (%u + %u > %u)",
> +			le32_to_cpu(raw_super->extension_count),
> +			raw_super->hot_ext_count,
> +			F2FS_MAX_EXTENSION);
> +		return 1;
> +	}
> +
> +	if (le32_to_cpu(raw_super->cp_payload) >
> +				(blocks_per_seg - F2FS_CP_PACKS)) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Insane cp_payload (%u > %u)",
> +			le32_to_cpu(raw_super->cp_payload),
> +			blocks_per_seg - F2FS_CP_PACKS);
> +		return 1;
> +	}
> +
>  	/* check reserved ino info */
>  	if (le32_to_cpu(raw_super->node_ino) != 1 ||
>  		le32_to_cpu(raw_super->meta_ino) != 2 ||
> @@ -2203,13 +2271,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		return 1;
>  	}
>  
> -	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
> -		f2fs_msg(sb, KERN_INFO,
> -			"Invalid segment count (%u)",
> -			le32_to_cpu(raw_super->segment_count));
> -		return 1;
> -	}
> -
>  	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
>  	if (sanity_check_area_boundary(sbi, bh))
>  		return 1;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
