From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [RFC PATCH v2 3/4] f2fs-tools: unify the writeback
 of superblock
Date: Tue, 28 Aug 2018 22:18:05 +0800
Message-ID: <2b38013f-45e9-77ad-890c-34bee969636e@huawei.com>
References: <20180814065616.33278-1-zhengjunling@huawei.com>
 <20180814065616.33278-3-zhengjunling@huawei.com>
 <bd136c6e-f0fc-c8ca-a843-cce1e185e849@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fuepD-00019r-BJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 14:18:31 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuep7-0010m2-KW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 14:18:31 +0000
In-Reply-To: <bd136c6e-f0fc-c8ca-a843-cce1e185e849@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/28 21:47, Chao Yu wrote:
> On 2018/8/14 14:56, Junling Zheng wrote:
>> Introduce __write_superblock() to support updating specified one
>> superblock or both, thus we can wrapper it in update_superblock() and
>> f2fs_write_super_block to unify all places where sb needs to be updated.
>>
>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>> ---
>> v1 -> v2:
>>  - if dev_write_block failed, add some notes and free buf to avoid memory leak.
>>  fsck/fsck.h        |  2 +-
>>  fsck/mount.c       | 74 +++++++++++-----------------------------------
>>  fsck/resize.c      | 20 ++-----------
>>  include/f2fs_fs.h  | 35 ++++++++++++++++++++++
>>  mkfs/f2fs_format.c | 19 +-----------
>>  5 files changed, 56 insertions(+), 94 deletions(-)
>>
>> diff --git a/fsck/fsck.h b/fsck/fsck.h
>> index 6042e68..e3490e6 100644
>> --- a/fsck/fsck.h
>> +++ b/fsck/fsck.h
>> @@ -178,7 +178,7 @@ extern void move_curseg_info(struct f2fs_sb_info *, u64, int);
>>  extern void write_curseg_info(struct f2fs_sb_info *);
>>  extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
>>  extern void write_checkpoint(struct f2fs_sb_info *);
>> -extern void write_superblock(struct f2fs_super_block *);
>> +extern void update_superblock(struct f2fs_super_block *, int);
>>  extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
>>  extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
>>  
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 58ef3e6..e7ceb8d 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -476,7 +476,7 @@ void print_sb_state(struct f2fs_super_block *sb)
>>  }
>>  
>>  static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>> -							u64 offset)
>> +							enum SB_ADDR sb_addr)
>>  {
>>  	u32 segment0_blkaddr = get_sb(segment0_blkaddr);
>>  	u32 cp_blkaddr = get_sb(cp_blkaddr);
>> @@ -542,14 +542,11 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>>  			segment_count_main << log_blocks_per_seg);
>>  		return -1;
>>  	} else if (main_end_blkaddr < seg_end_blkaddr) {
>> -		int err;
>> -
>>  		set_sb(segment_count, (main_end_blkaddr -
>>  				segment0_blkaddr) >> log_blocks_per_seg);
>>  
>> -		err = dev_write(sb, offset, sizeof(struct f2fs_super_block));
>> -		MSG(0, "Info: Fix alignment: %s, start(%u) end(%u) block(%u)\n",
>> -			err ? "failed": "done",
>> +		update_superblock(sb, 1 << sb_addr);
>> +		MSG(0, "Info: Fix alignment: start(%u) end(%u) block(%u)\n",
>>  			main_blkaddr,
>>  			segment0_blkaddr +
>>  				(segment_count << log_blocks_per_seg),
>> @@ -558,7 +555,7 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>>  	return 0;
>>  }
>>  
>> -int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>> +int sanity_check_raw_super(struct f2fs_super_block *sb, enum SB_ADDR sb_addr)
>>  {
>>  	unsigned int blocksize;
>>  
>> @@ -600,30 +597,24 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>>  	if (get_sb(segment_count) > F2FS_MAX_SEGMENT)
>>  		return -1;
>>  
>> -	if (sanity_check_area_boundary(sb, offset))
>> +	if (sanity_check_area_boundary(sb, sb_addr))
>>  		return -1;
>>  	return 0;
>>  }
>>  
>> -int validate_super_block(struct f2fs_sb_info *sbi, int block)
>> +int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
>>  {
>> -	u64 offset;
>>  	char buf[F2FS_BLKSIZE];
>>  
>>  	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
>>  
>> -	if (block == 0)
>> -		offset = F2FS_SUPER_OFFSET;
>> -	else
>> -		offset = F2FS_BLKSIZE + F2FS_SUPER_OFFSET;
>> -
>> -	if (dev_read_block(buf, block))
>> +	if (dev_read_block(buf, sb_addr))
>>  		return -1;
>>  
>>  	memcpy(sbi->raw_super, buf + F2FS_SUPER_OFFSET,
>>  					sizeof(struct f2fs_super_block));
>>  
>> -	if (!sanity_check_raw_super(sbi->raw_super, offset)) {
>> +	if (!sanity_check_raw_super(sbi->raw_super, sb_addr)) {
>>  		/* get kernel version */
>>  		if (c.kd >= 0) {
>>  			dev_read_version(c.version, 0, VERSION_LEN);
>> @@ -642,13 +633,9 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>>  		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
>>  					c.sb_version, c.version);
>>  		if (memcmp(c.sb_version, c.version, VERSION_LEN)) {
>> -			int ret;
>> -
>>  			memcpy(sbi->raw_super->version,
>>  						c.version, VERSION_LEN);
>> -			ret = dev_write(sbi->raw_super, offset,
>> -					sizeof(struct f2fs_super_block));
>> -			ASSERT(ret >= 0);
>> +			update_superblock(sbi->raw_super, 1 << sb_addr);
>>  
>>  			c.auto_fix = 0;
>>  			c.fix_on = 1;
>> @@ -659,7 +646,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>>  
>>  	free(sbi->raw_super);
>>  	sbi->raw_super = NULL;
>> -	MSG(0, "\tCan't find a valid F2FS superblock at 0x%x\n", block);
>> +	MSG(0, "\tCan't find a valid F2FS superblock at 0x%x\n", sb_addr);
>>  
>>  	return -EINVAL;
>>  }
>> @@ -2230,21 +2217,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>>  	ASSERT(ret >= 0);
>>  }
>>  
>> -void write_superblock(struct f2fs_super_block *new_sb)
>> +void update_superblock(struct f2fs_super_block *new_sb, int sb_mask)
>>  {
>> -	int index, ret;
>> -	u_int8_t *buf;
>> -
>> -	buf = calloc(BLOCK_SZ, 1);
>> -	ASSERT(buf);
>> -
>> -	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
>> -	for (index = 0; index < 2; index++) {
>> -		ret = dev_write_block(buf, index);
>> -		ASSERT(ret >= 0);
>> -	}
>> -	free(buf);
>> -	DBG(0, "Info: Done to rebuild superblock\n");
>> +	ASSERT(__write_superblock(new_sb, sb_mask));
> 
> ASSERT(!__write_superbloc());?
> 

:( I'm so sorry for not having tested fully.

I'll send a new version after testing them.

Sorry again.

> Thanks,
> 
>> +	DBG(0, "Info: Done to update superblock\n");
>>  }
>>  
>>  void build_nat_area_bitmap(struct f2fs_sb_info *sbi)



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
