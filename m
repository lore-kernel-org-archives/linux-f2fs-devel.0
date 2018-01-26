From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: support passing down write hints
 given by users to block layer
Date: Fri, 26 Jan 2018 10:10:22 +0800
Message-ID: <2707f6af-8add-5d75-ea21-c1a689011fb6@huawei.com>
References: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
 <1516618149-1495-2-git-send-email-hyc.lee@gmail.com>
 <f7873ebb-adf5-f8c5-ede2-4427c83285aa@kernel.org>
 <5A694538.9080007@gmail.com>
 <2a4c1cb0-f692-b752-988b-5fcc17a32013@huawei.com>
 <5A6A6C47.1060304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5A6A6C47.1060304@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/26 7:46, Hyunchul Lee wrote:
> On 01/25/2018 05:01 PM, Chao Yu wrote:
>> Hi Hyunchul,
>>
>> On 2018/1/25 10:47, Hyunchul Lee wrote:
>>> Hi Chao,
>>>
>>> On 01/25/2018 12:32 AM, Chao Yu wrote:
>>>> On 2018/1/22 18:49, Hyunchul Lee wrote:
>>>>> From: Hyunchul Lee <cheol.lee@lge.com>
>>>>>
>>>>> Add the 'whint_mode' mount option that controls which write
>>>>> hints are passed down to block layer. There are "off" and
>>>>> "user-based" mode. The default mode is "off".
>>>>>
>>>>> 1) whint_mode=user-based. F2FS tries to pass down hints given
>>>>> by users.
>>>>
>>>> Minor,
>>>>
>>>> 1) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET
>>>>
>>>> 2) whint_mode=user-based. F2FS tries to pass down hints given by users.
>>>> ...
>>>>
>>>
>>> Okay, I will reflect this.
>>>
>>>> How about changing all comments and codes with above order?
>>>>
>>>>>
>>>>> User                  F2FS                     Block
>>>>> ----                  ----                     -----
>>>>>                       META                     WRITE_LIFE_NOT_SET
>>>>>                       HOT_NODE                 "
>>>>>                       WARM_NODE                "
>>>>>                       COLD_NODE                "
>>>>> ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
>>>>> extension list        "                        "
>>>>>
>>>>> -- buffered io
>>>>> WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
>>>>> WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
>>>>> WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
>>>>> WRITE_LIFE_NONE       "                        "
>>>>> WRITE_LIFE_MEDIUM     "                        "
>>>>> WRITE_LIFE_LONG       "                        "
>>>>>
>>>>> -- direct io
>>>>> WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
>>>>> WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
>>>>> WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
>>>>> WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
>>>>> WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
>>>>> WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
>>>>>
>>>>> 2) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
>>>>>
>>>>> Many thanks to Chao Yu and Jaegeuk Kim for comments to
>>>>> implement this patch.
>>>>>
>>>>> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
>>>>> ---
>>>>>  fs/f2fs/data.c    | 27 ++++++++++++++++++++-----
>>>>>  fs/f2fs/f2fs.h    |  9 +++++++++
>>>>>  fs/f2fs/segment.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  fs/f2fs/super.c   | 24 +++++++++++++++++++++-
>>>>>  4 files changed, 113 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 6cba74e..c76ddc2 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -175,15 +175,22 @@ static bool __same_bdev(struct f2fs_sb_info *sbi,
>>>>>   */
>>>>>  static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>>>>>  				struct writeback_control *wbc,
>>>>> -				int npages, bool is_read)
>>>>> +				int npages, bool is_read,
>>>>> +				enum page_type type, enum temp_type temp)
>>>>>  {
>>>>>  	struct bio *bio;
>>>>>  
>>>>>  	bio = f2fs_bio_alloc(sbi, npages, true);
>>>>>  
>>>>>  	f2fs_target_device(sbi, blk_addr, bio);
>>>>> -	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
>>>>> -	bio->bi_private = is_read ? NULL : sbi;
>>>>> +	if (is_read) {
>>>>> +		bio->bi_end_io = f2fs_read_end_io;
>>>>> +		bio->bi_private = NULL;
>>>>> +	} else {
>>>>> +		bio->bi_end_io = f2fs_write_end_io;
>>>>> +		bio->bi_private = sbi;
>>>>> +		bio->bi_write_hint = io_type_to_rw_hint(sbi, type, temp);
>>>>> +	}
>>>>>  	if (wbc)
>>>>>  		wbc_init_bio(wbc, bio);
>>>>>  
>>>>> @@ -382,7 +389,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>>>>  
>>>>>  	/* Allocate a new bio */
>>>>>  	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
>>>>> -				1, is_read_io(fio->op));
>>>>> +				1, is_read_io(fio->op), fio->type, fio->temp);
>>>>>  
>>>>>  	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>>>>>  		bio_put(bio);
>>>>> @@ -445,7 +452,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>  			goto out_fail;
>>>>>  		}
>>>>>  		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
>>>>> -						BIO_MAX_PAGES, false);
>>>>> +						BIO_MAX_PAGES, false,
>>>>> +						fio->type, fio->temp);
>>>>>  		io->fio = *fio;
>>>>>  	}
>>>>>  
>>>>> @@ -2287,10 +2295,12 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>>>>  {
>>>>>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>>>>>  	struct inode *inode = mapping->host;
>>>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>  	size_t count = iov_iter_count(iter);
>>>>>  	loff_t offset = iocb->ki_pos;
>>>>>  	int rw = iov_iter_rw(iter);
>>>>>  	int err;
>>>>> +	enum rw_hint hint;
>>>>>  
>>>>>  	err = check_direct_IO(inode, iter, offset);
>>>>>  	if (err)
>>>>> @@ -2301,11 +2311,18 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>>>>  
>>>>>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>>>>>  
>>>>> +	if (rw == WRITE && sbi->whint_mode == WHINT_MODE_OFF) {
>>>>> +		hint = iocb->ki_hint;
>>>>> +		iocb->ki_hint = WRITE_LIFE_NOT_SET;
>>>>> +	}
>>>>
>>>> In f2fs_preallocate_blocks, we should wrap original iocb->ki_hint with
>>>> WRITE_LIFE_NOT_SET under WHINT_MODE_OFF mode?
>>>>
>>> In f2fs_preallocate_blocks, we should keep the original iocb->ki_hint to 
>>> select proper segments. So I think f2fs_direct_IO is the best place
>>> before submiting io.
>>
>> Oh, right.
>>
>> How about using temporary variable to store sbi->whint_mode? so that we
>> won't be affected by sbi->whint_mode changing.
>>
> 
> Yes, We need this.
> 
>> And could you please check to make sure all .temp assignment being covered?
>>
> 
> I have checked all .temp assignments. But for read operations, this variable

I've checked that too, there is nothing was missing.

One more thing, our whint_mode is completely based on active six type logs,
once some of them is close due to user configuration, write IO hint will be
messed up, so what about just enabling WHINT_MODE_OFF mode if active log
number is two or four?

And we need to adjust rw_hint_to_seg_type to be aware of active log number?

> is not used to determine write hints. so it is not initialized in this case.

I think that's OK.

Thanks,

> 
> Thanks,
> 
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>> Thanks,
>>>>
>>>>> +
>>>>>  	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
>>>>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
>>>>>  	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
>>>>>  
>>>>>  	if (rw == WRITE) {
>>>>> +		if (sbi->whint_mode == WHINT_MODE_OFF)
>>>>> +			iocb->ki_hint = hint;
>>>>>  		if (err > 0) {
>>>>>  			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
>>>>>  									err);
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index b7ba496..d7c2797 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -1035,6 +1035,11 @@ enum {
>>>>>  	MAX_TIME,
>>>>>  };
>>>>>  
>>>>> +enum {
>>>>> +	WHINT_MODE_OFF,		/* not pass down write hints */
>>>>> +	WHINT_MODE_USER,	/* try to pass down hints given by users */
>>>>> +};
>>>>> +
>>>>>  struct f2fs_sb_info {
>>>>>  	struct super_block *sb;			/* pointer to VFS super block */
>>>>>  	struct proc_dir_entry *s_proc;		/* proc entry */
>>>>> @@ -1218,6 +1223,8 @@ struct f2fs_sb_info {
>>>>>  	char *s_qf_names[MAXQUOTAS];
>>>>>  	int s_jquota_fmt;			/* Format of quota to use */
>>>>>  #endif
>>>>> +	/* For which write hints are passed down to block layer */
>>>>> +	int whint_mode;
>>>>>  };
>>>>>  
>>>>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>>>> @@ -2766,6 +2773,8 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>>>>>  int __init create_segment_manager_caches(void);
>>>>>  void destroy_segment_manager_caches(void);
>>>>>  int rw_hint_to_seg_type(enum rw_hint hint);
>>>>> +enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi, enum page_type type,
>>>>> +				enum temp_type temp);
>>>>>  
>>>>>  /*
>>>>>   * checkpoint.c
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index e5739ce..8bc1fc1 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -2458,6 +2458,62 @@ int rw_hint_to_seg_type(enum rw_hint hint)
>>>>>  	}
>>>>>  }
>>>>>  
>>>>> +/* This returns write hints for each segment type. This hints will be
>>>>> + * passed down to block layer. There are 2 mapping tables which depend on
>>>>> + * the mount option 'whint'.
>>>>> + *
>>>>> + * 1) whint_mode=user-based. F2FS tries to pass down hints given by users.
>>>>> + *
>>>>> + * User                  F2FS                     Block
>>>>> + * ----                  ----                     -----
>>>>> + *                       META                     WRITE_LIFE_NOT_SET
>>>>> + *                       HOT_NODE                 "
>>>>> + *                       WARM_NODE                "
>>>>> + *                       COLD_NODE                "
>>>>> + * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
>>>>> + * extension list        "                        "
>>>>> + *
>>>>> + * -- buffered io
>>>>> + * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
>>>>> + * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
>>>>> + * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
>>>>> + * WRITE_LIFE_NONE       "                        "
>>>>> + * WRITE_LIFE_MEDIUM     "                        "
>>>>> + * WRITE_LIFE_LONG       "                        "
>>>>> + *
>>>>> + * -- direct io
>>>>> + * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
>>>>> + * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
>>>>> + * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
>>>>> + * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
>>>>> + * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
>>>>> + * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
>>>>> + *
>>>>> + * 2) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>>>>> +				enum page_type type, enum temp_type temp)
>>>>> +{
>>>>> +	if (sbi->whint_mode == WHINT_MODE_USER) {
>>>>> +		if (type == DATA) {
>>>>> +			switch (temp) {
>>>>> +			case COLD:
>>>>> +				return WRITE_LIFE_EXTREME;
>>>>> +			case HOT:
>>>>> +				return WRITE_LIFE_SHORT;
>>>>> +			default:
>>>>> +				return WRITE_LIFE_NOT_SET;
>>>>> +			}
>>>>> +		} else {
>>>>> +			return WRITE_LIFE_NOT_SET;
>>>>> +		}
>>>>> +	} else {
>>>>> +		return WRITE_LIFE_NOT_SET;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>>  static int __get_segment_type_2(struct f2fs_io_info *fio)
>>>>>  {
>>>>>  	if (fio->type == DATA)
>>>>> @@ -2645,6 +2701,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
>>>>>  	struct f2fs_io_info fio = {
>>>>>  		.sbi = sbi,
>>>>>  		.type = META,
>>>>> +		.temp = HOT,
>>>>
>>>> Could you check to make sure all .temp being covered?
>>>>
>>>>>  		.op = REQ_OP_WRITE,
>>>>>  		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
>>>>>  		.old_blkaddr = page->index,
>>>>> @@ -2693,6 +2750,8 @@ int rewrite_data_page(struct f2fs_io_info *fio)
>>>>>  	int err;
>>>>>  
>>>>>  	fio->new_blkaddr = fio->old_blkaddr;
>>>>> +	/* i/o temperature is needed for passing down write hints */
>>>>> +	__get_segment_type(fio);
>>>>>  	stat_inc_inplace_blocks(fio->sbi);
>>>>>  
>>>>>  	err = f2fs_submit_page_bio(fio);
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index 8173ae6..9e22926 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -129,6 +129,7 @@ enum {
>>>>>  	Opt_jqfmt_vfsold,
>>>>>  	Opt_jqfmt_vfsv0,
>>>>>  	Opt_jqfmt_vfsv1,
>>>>> +	Opt_whint,
>>>>>  	Opt_err,
>>>>>  };
>>>>>  
>>>>> @@ -182,6 +183,7 @@ enum {
>>>>>  	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
>>>>>  	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
>>>>>  	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
>>>>> +	{Opt_whint, "whint_mode=%s"},
>>>>>  	{Opt_err, NULL},
>>>>>  };
>>>>>  
>>>>> @@ -679,6 +681,22 @@ static int parse_options(struct super_block *sb, char *options)
>>>>>  					"quota operations not supported");
>>>>>  			break;
>>>>>  #endif
>>>>> +		case Opt_whint:
>>>>> +			name = match_strdup(&args[0]);
>>>>> +			if (!name)
>>>>> +				return -ENOMEM;
>>>>> +			if (strlen(name) == 10 &&
>>>>> +					!strncmp(name, "user-based", 10)) {
>>>>> +				sbi->whint_mode = WHINT_MODE_USER;
>>>>> +			} else if (strlen(name) == 3 &&
>>>>> +					!strncmp(name, "off", 3)) {
>>>>> +				sbi->whint_mode = WHINT_MODE_OFF;
>>>>> +			} else {
>>>>> +				kfree(name);
>>>>> +				return -EINVAL;
>>>>> +			}
>>>>> +			kfree(name);
>>>>> +			break;
>>>>>  		default:
>>>>>  			f2fs_msg(sb, KERN_ERR,
>>>>>  				"Unrecognized mount option \"%s\" or missing value",
>>>>> @@ -1225,6 +1243,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>>>  		seq_puts(seq, ",prjquota");
>>>>>  #endif
>>>>>  	f2fs_show_quota_options(seq, sbi->sb);
>>>>> +	if (sbi->whint_mode == WHINT_MODE_USER)
>>>>> +		seq_printf(seq, ",whint_mode=%s", "user-based");
>>>>>  
>>>>>  	return 0;
>>>>>  }
>>>>> @@ -1234,6 +1254,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>>>>  	/* init some FS parameters */
>>>>>  	sbi->active_logs = NR_CURSEG_TYPE;
>>>>>  	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>>>>> +	sbi->whint_mode = WHINT_MODE_OFF;
>>>>>  
>>>>>  	set_opt(sbi, BG_GC);
>>>>>  	set_opt(sbi, INLINE_XATTR);
>>>>> @@ -1274,6 +1295,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>  	bool need_restart_gc = false;
>>>>>  	bool need_stop_gc = false;
>>>>>  	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
>>>>> +	int old_whint_mode = sbi->whint_mode;
>>>>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>>>>>  	struct f2fs_fault_info ffi = sbi->fault_info;
>>>>>  #endif
>>>>> @@ -1373,7 +1395,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>  		need_stop_gc = true;
>>>>>  	}
>>>>>  
>>>>> -	if (*flags & SB_RDONLY) {
>>>>> +	if (*flags & SB_RDONLY || sbi->whint_mode != old_whint_mode) {
>>>>>  		writeback_inodes_sb(sb, WB_REASON_SYNC);
>>>>>  		sync_inodes_sb(sb);
>>>>>  
>>>>>
>>>>
>>>
>>> .
>>>
>>
>>
> 
> .
> 
