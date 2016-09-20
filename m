From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/6] f2fs: introduce cp_lock to protect updating of
 ckpt_flags
Date: Tue, 20 Sep 2016 09:47:20 +0800
Message-ID: <3fee1539-3d32-12e0-6565-f1851a18b08f@huawei.com>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
 <1474212608-6930-4-git-send-email-chao@kernel.org>
 <20160919214903.GB68913@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160919214903.GB68913@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/9/20 5:49, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Sun, Sep 18, 2016 at 11:30:06PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> This patch introduces spinlock to protect updating process of ckpt_flags
>> field in struct f2fs_checkpoint, it avoids incorrectly updating in race
>> condition.
> 
> So, I'm seeing a race condition between f2fs_stop_checkpoint(),
> write_checkpoint(), and f2fs_fill_super().
> 
> How about just adding f2fs_lock_op() in f2fs_stop_checkpoint()?

I'm afraid there will be a potential deadlock here:

Thread A				Thread B
- write_checkpoint
 - block_operations
  - f2fs_lock_all
 - do_checkpoint
 - wait_on_all_pages_writeback
					- f2fs_write_end_io
					 - f2fs_stop_checkpoint
					  - f2fs_lock_op
					 - end_page_writeback
					 - atomic_dec_and_test
					 - wake_up

Right?

Thanks,

> 
> Thanks,
> 
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 24 ++++++++++++------------
>>  fs/f2fs/f2fs.h       | 29 +++++++++++++++++++++--------
>>  fs/f2fs/recovery.c   |  2 +-
>>  fs/f2fs/segment.c    |  4 ++--
>>  fs/f2fs/super.c      |  5 +++--
>>  5 files changed, 39 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index df56a43..0338f8c 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -28,7 +28,7 @@ struct kmem_cache *inode_entry_slab;
>>  
>>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>>  {
>> -	set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
>> +	set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>  	sbi->sb->s_flags |= MS_RDONLY;
>>  	if (!end_io)
>>  		f2fs_flush_merged_bios(sbi);
>> @@ -571,7 +571,7 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>  	block_t start_blk, orphan_blocks, i, j;
>>  	int err;
>>  
>> -	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
>> +	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
>>  		return 0;
>>  
>>  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
>> @@ -595,7 +595,7 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>  		f2fs_put_page(page, 1);
>>  	}
>>  	/* clear Orphan Flag */
>> -	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
>> +	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>>  	return 0;
>>  }
>>  
>> @@ -1054,9 +1054,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>  	/* 2 cp  + n data seg summary + orphan inode blocks */
>>  	data_sum_blocks = npages_for_summary_flush(sbi, false);
>>  	if (data_sum_blocks < NR_CURSEG_DATA_TYPE)
>> -		set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
>> +		set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG);
>>  	else
>> -		clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
>> +		clear_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG);
>>  
>>  	orphan_blocks = GET_ORPHAN_BLOCKS(orphan_num);
>>  	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
>> @@ -1072,22 +1072,22 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>  				orphan_blocks);
>>  
>>  	if (cpc->reason == CP_UMOUNT)
>> -		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
>> +		set_ckpt_flags(sbi, CP_UMOUNT_FLAG);
>>  	else
>> -		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
>> +		clear_ckpt_flags(sbi, CP_UMOUNT_FLAG);
>>  
>>  	if (cpc->reason == CP_FASTBOOT)
>> -		set_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
>> +		set_ckpt_flags(sbi, CP_FASTBOOT_FLAG);
>>  	else
>> -		clear_ckpt_flags(ckpt, CP_FASTBOOT_FLAG);
>> +		clear_ckpt_flags(sbi, CP_FASTBOOT_FLAG);
>>  
>>  	if (orphan_num)
>> -		set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
>> +		set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>>  	else
>> -		clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
>> +		clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>>  
>>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>> -		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>> +		set_ckpt_flags(sbi, CP_FSCK_FLAG);
>>  
>>  	/* update SIT/NAT bitmap */
>>  	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index c30f744b..b615f3f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -814,6 +814,7 @@ struct f2fs_sb_info {
>>  
>>  	/* for checkpoint */
>>  	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
>> +	spinlock_t cp_lock;			/* for flag in ckpt */
>>  	struct inode *meta_inode;		/* cache meta blocks */
>>  	struct mutex cp_mutex;			/* checkpoint procedure lock */
>>  	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
>> @@ -1083,24 +1084,36 @@ static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
>>  	return le64_to_cpu(cp->checkpoint_ver);
>>  }
>>  
>> -static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
>> +static inline bool is_set_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
>>  {
>> +	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>>  	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
>> +
>>  	return ckpt_flags & f;
>>  }
>>  
>> -static inline void set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
>> +static inline void set_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
>>  {
>> -	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
>> +	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>> +	unsigned int ckpt_flags;
>> +
>> +	spin_lock(&sbi->cp_lock);
>> +	ckpt_flags = le32_to_cpu(cp->ckpt_flags);
>>  	ckpt_flags |= f;
>>  	cp->ckpt_flags = cpu_to_le32(ckpt_flags);
>> +	spin_unlock(&sbi->cp_lock);
>>  }
>>  
>> -static inline void clear_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
>> +static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
>>  {
>> -	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
>> +	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>> +	unsigned int ckpt_flags;
>> +
>> +	spin_lock(&sbi->cp_lock);
>> +	ckpt_flags = le32_to_cpu(cp->ckpt_flags);
>>  	ckpt_flags &= (~f);
>>  	cp->ckpt_flags = cpu_to_le32(ckpt_flags);
>> +	spin_unlock(&sbi->cp_lock);
>>  }
>>  
>>  static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
>> @@ -1148,8 +1161,8 @@ static inline bool __remain_node_summaries(int reason)
>>  
>>  static inline bool __exist_node_summaries(struct f2fs_sb_info *sbi)
>>  {
>> -	return (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG) ||
>> -			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_FASTBOOT_FLAG));
>> +	return (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG) ||
>> +			is_set_ckpt_flags(sbi, CP_FASTBOOT_FLAG));
>>  }
>>  
>>  /*
>> @@ -1851,7 +1864,7 @@ static inline int f2fs_readonly(struct super_block *sb)
>>  
>>  static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
>>  {
>> -	return is_set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
>> +	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>  }
>>  
>>  static inline bool is_dot_dotdot(const struct qstr *str)
>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>> index ad748e5..37d99d2 100644
>> --- a/fs/f2fs/recovery.c
>> +++ b/fs/f2fs/recovery.c
>> @@ -649,7 +649,7 @@ out:
>>  			invalidate_mapping_pages(META_MAPPING(sbi),
>>  							blkaddr, blkaddr);
>>  
>> -		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
>> +		set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>  		mutex_unlock(&sbi->cp_mutex);
>>  	} else if (need_writecp) {
>>  		struct cp_control cpc = {
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 101b58f..dc68f30 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1825,7 +1825,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
>>  	int type = CURSEG_HOT_DATA;
>>  	int err;
>>  
>> -	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
>> +	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG)) {
>>  		int npages = npages_for_summary_flush(sbi, true);
>>  
>>  		if (npages >= 2)
>> @@ -1922,7 +1922,7 @@ static void write_normal_summaries(struct f2fs_sb_info *sbi,
>>  
>>  void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
>>  {
>> -	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG))
>> +	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG))
>>  		write_compacted_summaries(sbi, start_blk);
>>  	else
>>  		write_normal_summaries(sbi, start_blk, CURSEG_HOT_DATA);
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 555217f..f809729 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -735,7 +735,7 @@ static void f2fs_put_super(struct super_block *sb)
>>  	 * clean checkpoint again.
>>  	 */
>>  	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
>> -			!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG)) {
>> +			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
>>  		struct cp_control cpc = {
>>  			.reason = CP_UMOUNT,
>>  		};
>> @@ -1477,6 +1477,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>>  	mutex_init(&sbi->umount_mutex);
>>  	mutex_init(&sbi->wio_mutex[NODE]);
>>  	mutex_init(&sbi->wio_mutex[DATA]);
>> +	spin_lock_init(&sbi->cp_lock);
>>  
>>  #ifdef CONFIG_F2FS_FS_ENCRYPTION
>>  	memcpy(sbi->key_prefix, F2FS_KEY_DESC_PREFIX,
>> @@ -1818,7 +1819,7 @@ try_onemore:
>>  		 * previous checkpoint was not done by clean system shutdown.
>>  		 */
>>  		if (bdev_read_only(sb->s_bdev) &&
>> -				!is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG)) {
>> +				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
>>  			err = -EROFS;
>>  			goto free_kobj;
>>  		}
>> -- 
>> 2.7.2
> 
> .
> 
