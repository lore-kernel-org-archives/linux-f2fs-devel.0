From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: introduce discard_granularity sysfs entry
Date: Tue, 15 Aug 2017 20:04:59 +0800
Message-ID: <085f08d4-1f46-6bd5-b81e-a09b51499267@huawei.com>
References: <20170807150956.9433-1-chao@kernel.org>
 <20170815034518.GA94478@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815034518.GA94478@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/15 11:45, Jaegeuk Kim wrote:
> On 08/07, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Commit d618ebaf0aa8 ("f2fs: enable small discard by default") enables
>> f2fs to issue 4K size discard in real-time discard mode. However, issuing
>> smaller discard may cost more lifetime but releasing less free space in
>> flash device. Since f2fs has ability of separating hot/cold data and
>> garbage collection, we can expect that small-sized invalid region would
>> expand soon with OPU, deletion or garbage collection on valid datas, so
>> it's better to delay or skip issuing smaller size discards, it could help
>> to reduce overmuch consumption of IO bandwidth and lifetime of flash
>> storage.
>>
>> This patch makes f2fs selectng 64K size as its default minimal
>> granularity, and issue discard with the size which is not smaller than
>> minimal granularity. Also it exposes discard granularity as sysfs entry
>> for configuration in different scenario.
> 
> Hi Chao,
> 
> I'd like to change the default value to 1 in order to keep the original
> behavior, since we must avoid performance fluctuation after this single
> patch. Instead, you probably can change the value through sysfs.

As I know, in fragmented filesystem space, there are may dozens of thousand
discard, in scenario of cellphone user are using, 30% is above 64K size, but
occupy 75% space of all undiscard space, so I changed discard_granularity to 64K
just to release bulk space in device. For other small-sized discards, I expect
that they may extend and cross the granularity threshold soon, and fstrim of
android could cover them in the night.

Do you encounter performance degression due to holding 64k-below size discard?

thank,

> 
> Thanks,
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v4: minor change in commit log.
>>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>>  fs/f2fs/f2fs.h                          |  4 ++++
>>  fs/f2fs/segment.c                       | 23 ++++++++++++++++++++++-
>>  fs/f2fs/sysfs.c                         |  7 +++++++
>>  4 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 84c606fb3ca4..c579ce5e0ef5 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -57,6 +57,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>  Description:
>>  		 Controls the issue rate of small discard commands.
>>  
>> +What:          /sys/fs/f2fs/<disk>/discard_granularity
>> +Date:          July 2017
>> +Contact:       "Chao Yu" <yuchao0@huawei.com>
>> +Description:
>> +		Controls discard granularity of inner discard thread, inner thread
>> +		will not issue discards with size that is smaller than granularity.
>> +		The unit size is one block, now only support configuring in range
>> +		of [1, 512].
>> +
>>  What:		/sys/fs/f2fs/<disk>/max_victim_search
>>  Date:		January 2014
>>  Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 0ccccbfdeeab..1bcaa93bfed7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -195,6 +195,9 @@ struct discard_entry {
>>  	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
>>  };
>>  
>> +/* default discard granularity of inner discard thread, unit: block count */
>> +#define DEFAULT_DISCARD_GRANULARITY		16
>> +
>>  /* max discard pend list number */
>>  #define MAX_PLIST_NUM		512
>>  #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
>> @@ -240,6 +243,7 @@ struct discard_cmd_control {
>>  	struct mutex cmd_lock;
>>  	unsigned int nr_discards;		/* # of discards in the list */
>>  	unsigned int max_discards;		/* max. discards to be issued */
>> +	unsigned int discard_granularity;	/* discard granularity */
>>  	unsigned int undiscard_blks;		/* # of undiscard blocks */
>>  	atomic_t issued_discard;		/* # of issued discard */
>>  	atomic_t issing_discard;		/* # of issing discard */
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 71c2e0ac13d7..f336f8c541f0 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1019,7 +1019,8 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>>  	f2fs_bug_on(sbi,
>>  		!__check_rb_tree_consistence(sbi, &dcc->root));
>>  	blk_start_plug(&plug);
>> -	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>> +	for (i = MAX_PLIST_NUM - 1; i >= 0 &&
>> +			i >= dcc->discard_granularity - 1; i--) {
>>  		pend_list = &dcc->pend_list[i];
>>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>> @@ -1035,6 +1036,24 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>>  	mutex_unlock(&dcc->cmd_lock);
>>  }
>>  
>> +static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
>> +{
>> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>> +	struct list_head *pend_list;
>> +	struct discard_cmd *dc, *tmp;
>> +	int i;
>> +
>> +	mutex_lock(&dcc->cmd_lock);
>> +	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>> +		pend_list = &dcc->pend_list[i];
>> +		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>> +			f2fs_bug_on(sbi, dc->state != D_PREP);
>> +			__remove_discard_cmd(sbi, dc);
>> +		}
>> +	}
>> +	mutex_unlock(&dcc->cmd_lock);
>> +}
>> +
>>  static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
>>  							struct discard_cmd *dc)
>>  {
>> @@ -1117,6 +1136,7 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
>>  void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>>  {
>>  	__issue_discard_cmd(sbi, false);
>> +	__drop_discard_cmd(sbi);
>>  	__wait_discard_cmd(sbi, false);
>>  }
>>  
>> @@ -1449,6 +1469,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>  	atomic_set(&dcc->discard_cmd_cnt, 0);
>>  	dcc->nr_discards = 0;
>>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>> +	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
>>  	dcc->undiscard_blks = 0;
>>  	dcc->root = RB_ROOT;
>>  
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 045b948c7466..4e5a95e9e666 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -152,6 +152,11 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>  		spin_unlock(&sbi->stat_lock);
>>  		return count;
>>  	}
>> +
>> +	if (!strcmp(a->attr.name, "discard_granularity") &&
>> +					(t == 0 || t > MAX_PLIST_NUM))
>> +		return -EINVAL;
>> +
>>  	*ui = t;
>>  
>>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>> @@ -241,6 +246,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
>>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
>>  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
>> +F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>>  F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>> @@ -281,6 +287,7 @@ static struct attribute *f2fs_attrs[] = {
>>  	ATTR_LIST(gc_idle),
>>  	ATTR_LIST(reclaim_segments),
>>  	ATTR_LIST(max_small_discards),
>> +	ATTR_LIST(discard_granularity),
>>  	ATTR_LIST(batched_trim_sections),
>>  	ATTR_LIST(ipu_policy),
>>  	ATTR_LIST(min_ipu_util),
>> -- 
>> 2.14.0
> 
> .
> 
