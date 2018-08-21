From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: fix performance issue observed with
 multi-thread sequential read
Date: Tue, 21 Aug 2018 11:26:18 +0800
Message-ID: <685bee8d-2909-a332-8362-2e0e073fb8e3@huawei.com>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
 <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
 <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
 <20180817182944.GA58612@jaegeuk-macbookpro.roam.corp.google.com>
 <4899ff2c-5961-10e7-e074-af7442ceee15@huawei.com>
 <20180821022812.GA20263@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1frxJS-0000oT-HV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Aug 2018 03:26:34 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1frxJP-00AGvS-Ud
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Aug 2018 03:26:34 +0000
In-Reply-To: <20180821022812.GA20263@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/21 10:28, Jaegeuk Kim wrote:
> On 08/20, Chao Yu wrote:
>> On 2018/8/18 2:29, Jaegeuk Kim wrote:
>>> This reverts the commit - "b93f771 - f2fs: remove writepages lock"
>>> to fix the drop in sequential read throughput.
>>>
>>> Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
>>> device: UFS
>>>
>>> Before -
>>> read throughput: 185 MB/s
>>> total read requests: 85177 (of these ~80000 are 4KB size requests).
>>> total write requests: 2546 (of these ~2208 requests are written in 512KB).
>>>
>>> After -
>>> read throughput: 758 MB/s
>>> total read requests: 2417 (of these ~2042 are 512KB reads).
>>> total write requests: 2701 (of these ~2034 requests are written in 512KB).
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>
>>> Change log from v3:
>>>  - add more conditions to serialize the allocation
>>>
>>>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
>>>  fs/f2fs/data.c                          | 10 ++++++++++
>>>  fs/f2fs/f2fs.h                          |  2 ++
>>>  fs/f2fs/segment.c                       |  1 +
>>>  fs/f2fs/super.c                         |  1 +
>>>  fs/f2fs/sysfs.c                         |  2 ++
>>>  6 files changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> index 9b0123388f18..94a24aedcdb2 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> @@ -51,6 +51,14 @@ Description:
>>>  		 Controls the dirty page count condition for the in-place-update
>>>  		 policies.
>>>  
>>> +What:		/sys/fs/f2fs/<disk>/min_seq_blocks
>>> +Date:		August 2018
>>> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>>> +Description:
>>> +		 Controls the dirty page count condition for batched sequential
>>> +		 writes in ->writepages.
>>> +
>>> +
>>>  What:		/sys/fs/f2fs/<disk>/min_hot_blocks
>>>  Date:		March 2017
>>>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 43d3723dc886..fb63425ea242 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2130,6 +2130,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>  	struct blk_plug plug;
>>>  	int ret;
>>> +	bool locked = false;
>>>  
>>>  	/* deal with chardevs and other special file */
>>>  	if (!mapping->a_ops->writepage)
>>> @@ -2160,10 +2161,19 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>  	else if (atomic_read(&sbi->wb_sync_req[DATA]))
>>>  		goto skip_write;
>>>  
>>> +	if (!S_ISDIR(inode->i_mode) && (wbc->sync_mode != WB_SYNC_ALL ||
>>> +			get_dirty_pages(inode) <= SM_I(sbi)->min_seq_blocks)) {
>>
>> get_dirty_pages(inode) >= SM_I(sbi)->min_seq_blocks
> 
> Oops. :P
> 
>>
>>> +		mutex_lock(&sbi->writepages);
>>
>> Still didn't see atomic write being covered by this lock.
> 
> Taking a look at this again, I'm in doubt to cover this, since 1) normal usecase
> of atomic writes is to set page dirty and write it right away during commit, 2)
> there'd be no large number of dirty pages even when we consider race condition
> between writepages and atomic_commit. Am I missing another case?

Yup, reasonable, hot type data is not fit for this optimization, due to easily
defragmenting, and small size. :)

Thanks,

> 
>>
>> How about introducing a macro like __should_serialize_io() for indicating the
>> condition in where we should serialize IOs.
> 
> Done.
> 
> Thank you for ths suggestion.
> 
>>
>> Thanks,
>>
>>> +		locked = true;
>>> +	}
>>> +
>>>  	blk_start_plug(&plug);
>>>  	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
>>>  	blk_finish_plug(&plug);
>>>  
>>> +	if (locked)
>>> +		mutex_unlock(&sbi->writepages);
>>> +
>>>  	if (wbc->sync_mode == WB_SYNC_ALL)
>>>  		atomic_dec(&sbi->wb_sync_req[DATA]);
>>>  	/*
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 9a6ba4a8d338..170573f8a04a 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -913,6 +913,7 @@ struct f2fs_sm_info {
>>>  	unsigned int ipu_policy;	/* in-place-update policy */
>>>  	unsigned int min_ipu_util;	/* in-place-update threshold */
>>>  	unsigned int min_fsync_blocks;	/* threshold for fsync */
>>> +	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
>>>  	unsigned int min_hot_blocks;	/* threshold for hot block allocation */
>>>  	unsigned int min_ssr_sections;	/* threshold to trigger SSR allocation */
>>>  
>>> @@ -1133,6 +1134,7 @@ struct f2fs_sb_info {
>>>  	struct rw_semaphore sb_lock;		/* lock for raw super block */
>>>  	int valid_super_block;			/* valid super block no */
>>>  	unsigned long s_flag;				/* flags for sbi */
>>> +	struct mutex writepages;		/* mutex for writepages() */
>>>  
>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>  	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index b136e39e1e9e..20650e25117b 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -4127,6 +4127,7 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
>>>  		sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
>>>  	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
>>>  	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
>>> +	sm_info->min_seq_blocks = sbi->blocks_per_seg * sbi->segs_per_sec;
>>>  	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
>>>  	sm_info->min_ssr_sections = reserved_sections(sbi);
>>>  
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index c6e4750a9187..6b6cb4eb8439 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -2864,6 +2864,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>  	/* init f2fs-specific super block info */
>>>  	sbi->valid_super_block = valid_super_block;
>>>  	mutex_init(&sbi->gc_mutex);
>>> +	mutex_init(&sbi->writepages);
>>>  	mutex_init(&sbi->cp_mutex);
>>>  	init_rwsem(&sbi->node_write);
>>>  	init_rwsem(&sbi->node_change);
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index cd2e030e47b8..81c0e5337443 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -397,6 +397,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
>>> +F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_seq_blocks, min_seq_blocks);
>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
>>>  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ssr_sections, min_ssr_sections);
>>>  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
>>> @@ -449,6 +450,7 @@ static struct attribute *f2fs_attrs[] = {
>>>  	ATTR_LIST(ipu_policy),
>>>  	ATTR_LIST(min_ipu_util),
>>>  	ATTR_LIST(min_fsync_blocks),
>>> +	ATTR_LIST(min_seq_blocks),
>>>  	ATTR_LIST(min_hot_blocks),
>>>  	ATTR_LIST(min_ssr_sections),
>>>  	ATTR_LIST(max_victim_search),
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
