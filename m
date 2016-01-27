From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] Introduce lifetime write IO statistics
Date: Wed, 27 Jan 2016 15:20:03 +0800
Message-ID: <00c801d158d3$4507ae10$cf170a30$@samsung.com>
References: <1453794038-189520-1-git-send-email-liushuoran@huawei.com>
	<00a101d1581b$6a7ad090$3f7071b0$@samsung.com>
	<56A7468A.5050600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aOKPh-00036D-12
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 07:21:13 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aOKPd-0006n0-4S
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 07:21:13 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1L01YKEOEHMME0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 16:21:01 +0900 (KST)
In-reply-to: <56A7468A.5050600@huawei.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Shuoran' <liushuoran@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Shuoran [mailto:liushuoran@huawei.com]
> Sent: Tuesday, January 26, 2016 6:12 PM
> To: Chao Yu
> Cc: jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] Introduce lifetime write IO statistics
> 
> On 2016/1/26 17:24, Chao Yu wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Liu Shuoran [mailto:liushuoran@huawei.com]
> >> Sent: Tuesday, January 26, 2016 3:41 PM
> >> To: jaegeuk@kernel.org
> >> Cc: linux-f2fs-devel@lists.sourceforge.net
> >> Subject: [f2fs-dev] [PATCH] Introduce lifetime write IO statistics
> >>
> >> This patch introduces lifetime IO write statistics exposed to the sysfs interface.
> >> The write IO amount is obtained from block layer, accumulated in the file system and
> >> stored in the hot node summary of checkpoint.
> >>
> >> Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
> >> Signed-off-by: Pengyang Hou <houpengyang@huawei.com>
> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >> ---
> >>   fs/f2fs/checkpoint.c    | 12 ++++++++++++
> >>   fs/f2fs/f2fs.h          | 11 +++++++++++
> >>   fs/f2fs/super.c         | 35 +++++++++++++++++++++++++++++++++++
> >>   include/linux/f2fs_fs.h | 14 +++++++++++++-
> >>   4 files changed, 71 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 3842af9..998de47 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -921,6 +921,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> *cpc)
> >>   	int cp_payload_blks = __cp_payload(sbi);
> >>   	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
> >>   	bool invalidate = false;
> >> +	struct super_block *sb = sbi->sb;
> >> +	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
> >> +	u64 kbytes_written;
> >> +
> >>
> >>   	/*
> >>   	 * This avoids to conduct wrong roll-forward operations and uses
> >> @@ -1034,6 +1038,14 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control
> >> *cpc)
> >>
> >>   	write_data_summaries(sbi, start_blk);
> >>   	start_blk += data_sum_blocks;
> >> +
> >> +	/* Record write statistics in the hot node summary */
> >> +	kbytes_written = sbi->kbytes_written;
> >> +	if (sb->s_bdev->bd_part)
> >> +		kbytes_written += BD_PART_WRITTEN(sbi);
> >> +
> >> +	seg_i->sum_blk->info.kbytes_written = cpu_to_le64(kbytes_written);
> >> +
> >>   	if (__remain_node_summaries(cpc->reason)) {
> >>   		write_node_summaries(sbi, start_blk);
> >>   		start_blk += NR_CURSEG_NODE_TYPE;
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index ff79054..cee5fab0 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -844,8 +844,19 @@ struct f2fs_sb_info {
> >>   	struct list_head s_list;
> >>   	struct mutex umount_mutex;
> >>   	unsigned int shrinker_run_no;
> >> +
> >> +	/* For write statistics */
> >> +	u64 sectors_written_start;
> >> +	u64 kbytes_written;
> >>   };
> >>
> >> +/* For write statistics. Suppose sector size is 512 bytes,
> >> + * and the return value is in kbytes. s is of struct f2fs_sb_info.
> >> + */
> >> +#define BD_PART_WRITTEN(s)						 \
> >> +(((u64)part_stat_read(s->sb->s_bdev->bd_part, sectors[1]) -		 \
> >> +		s->sectors_written_start) >> 1)
> >> +
> >>   static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
> >>   {
> >>   	sbi->last_time[type] = jiffies;
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 3bf990b..7ed10f1 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -126,6 +126,19 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int
> >> struct_type)
> >>   	return NULL;
> >>   }
> >>
> >> +static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> >> +		struct f2fs_sb_info *sbi, char *buf)
> >> +{
> >> +	struct super_block *sb = sbi->sb;
> >> +
> >> +	if (!sb->s_bdev->bd_part)
> >> +		return snprintf(buf, PAGE_SIZE, "0\n");
> >> +
> >> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> >> +		(unsigned long long)(sbi->kbytes_written +
> >> +			BD_PART_WRITTEN(sbi)));
> >> +}
> >> +
> >>   static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >>   			struct f2fs_sb_info *sbi, char *buf)
> >>   {
> >> @@ -204,6 +217,9 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
> >>   		f2fs_sbi_show, f2fs_sbi_store,			\
> >>   		offsetof(struct struct_name, elname))
> >>
> >> +#define F2FS_GENERAL_RO_ATTR(name) \
> >> +static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
> >> +
> >>   F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
> >>   F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
> >>   F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
> >> @@ -220,6 +236,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search,
> >> max_victim_search);
> >>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> >>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
> >>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> >> +F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> >>
> >>   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> >>   static struct attribute *f2fs_attrs[] = {
> >> @@ -239,6 +256,7 @@ static struct attribute *f2fs_attrs[] = {
> >>   	ATTR_LIST(ra_nid_pages),
> >>   	ATTR_LIST(cp_interval),
> >>   	ATTR_LIST(idle_interval),
> >> +	ATTR_LIST(lifetime_write_kbytes),
> >>   	NULL,
> >>   };
> >>
> >> @@ -766,6 +784,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >>   	bool need_stop_gc = false;
> >>   	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
> >>
> >> +	if (*flags & MS_RDONLY) {
> >> +		set_opt(sbi, FASTBOOT);
> > Need to recover to original mode, otherwise it may change option user
> > set.
> Yes, maybe I can bring forward the action of saving old mount options.
> >> +		set_sbi_flag(sbi, SBI_IS_DIRTY);
> >> +	}
> >> +
> >>   	sync_filesystem(sb);
> >>
> >>   	/*
> >> @@ -1242,6 +1265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int
> silent)
> >>   	bool retry = true, need_fsck = false;
> >>   	char *options = NULL;
> >>   	int recovery, i, valid_super_block;
> >> +	struct curseg_info *seg_i;
> >>
> >>   try_onemore:
> >>   	err = -EINVAL;
> >> @@ -1372,6 +1396,17 @@ try_onemore:
> >>   		goto free_nm;
> >>   	}
> >>
> >> +	/* For write statistics */
> >> +	if (sb->s_bdev->bd_part)
> >> +		sbi->sectors_written_start =
> >> +			(u64)part_stat_read(sb->s_bdev->bd_part, sectors[1]);
> >> +
> >> +	/* Read accumulated write IO statistics if exists */
> >> +	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
> > Why not CURSEG_WARM_DATA?
> Data summary might be compacted. So only hot/warm/cold node summary is
> available, and we just picked hot node summary.

Oh, you're right, warm data journal would not be persisted if data
summaries are compacted, my mistake.

Wouldn't be better to persist this stat number into super block like
ext4?

Thanks,

> > Thanks,
> >
> >> +	if(__exist_node_summaries(sbi))
> >> +		sbi->kbytes_written =
> >> +			le64_to_cpu(seg_i->sum_blk->info.kbytes_written);
> >> +
> >>   	build_gc_manager(sbi);
> >>
> >>   	/* get an inode for node space */
> >> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >> index e59c3be..67aa01d 100644
> >> --- a/include/linux/f2fs_fs.h
> >> +++ b/include/linux/f2fs_fs.h
> >> @@ -358,6 +358,12 @@ struct summary_footer {
> >>   				sizeof(struct sit_journal_entry))
> >>   #define SIT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
> >>   				sizeof(struct sit_journal_entry))
> >> +
> >> +/* Reserved area should make size of f2fs_extra_info equals to
> >> + * that of nat_journal and sit_journal.
> >> + */
> >> +#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 8)
> >> +
> >>   /*
> >>    * frequently updated NAT/SIT entries can be stored in the spare area in
> >>    * summary blocks
> >> @@ -387,6 +393,11 @@ struct sit_journal {
> >>   	__u8 reserved[SIT_JOURNAL_RESERVED];
> >>   } __packed;
> >>
> >> +struct f2fs_extra_info {
> >> +	__le64 kbytes_written;
> >> +	__u8 reserved[EXTRA_INFO_RESERVED];
> >> +} __packed;
> >> +
> >>   /* 4KB-sized summary block structure */
> >>   struct f2fs_summary_block {
> >>   	struct f2fs_summary entries[ENTRIES_IN_SUM];
> >> @@ -394,10 +405,11 @@ struct f2fs_summary_block {
> >>   		__le16 n_nats;
> >>   		__le16 n_sits;
> >>   	};
> >> -	/* spare area is used by NAT or SIT journals */
> >> +	/* spare area is used by NAT or SIT journals or extra info */
> >>   	union {
> >>   		struct nat_journal nat_j;
> >>   		struct sit_journal sit_j;
> >> +		struct f2fs_extra_info info;
> >>   	};
> >>   	struct summary_footer footer;
> >>   } __packed;
> >> --
> >> 1.9.1
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> >> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> >> Monitor end-to-end web transactions and take corrective actions now
> >> Troubleshoot faster and improve end-user experience. Signup Now!
> >> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> > .
> >
> 



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
