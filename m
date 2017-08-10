From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: introduce cur_reserved_blocks in sysfs
Date: Thu, 10 Aug 2017 11:58:13 +0800
Message-ID: <5952a72c-9b42-6f5a-ce03-410b42ada799@huawei.com>
References: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
 <b1976eed-d55c-b98b-122f-554bd901f504@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b1976eed-d55c-b98b-122f-554bd901f504@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

I think the aim of reserved_blocks function is to leave space for f2fs 
and FTL, so I change it to a
soft version so that it can be used to fit to the data image which does 
not satisfy the hard version,
especially for backward compatibility when updated kernel with new 
default reserved_blocks set
(currently it is initially set 0 as default, but can be set any value 
with my new patch).

As for the uid/gid, does current f2fs space management design consider 
this issue? IMO, I think we
can just ensure the reserved space for file system no matter user/system 
type. Whether the value of
reserved_blocks is OK or not, should not be filesystem's issue. 
Filesystem just provide this interface,
and the upper layer, such as android vold should take care of the value 
of reserved_blocks and make
sure its value is appropriate and will not block any activation of 
system user, if it really happens, android
should change the value dynamically, it is fine, since we make 
reserved_blocks to a soft version.

On 2017/8/10 11:15, Chao Yu wrote:
> On 2017/8/8 21:43, Yunlong Song wrote:
>> In this patch, we add a new sysfs interface, we can use it to gradually achieve
>> the reserved_blocks finally, even when reserved_blocks is initially set over
>> user_block_count - total_valid_block_count. This is very useful, especially when
>> we upgrade kernel with new reserved_blocks value, but old disk image unluckily has
>> user_block_count - total_valid_block_count smaller than the desired reserved_blocks.
>> With this patch, f2fs can try its best to reserve space and get close to the
>> reserved_blocks, and the current value of achieved reserved_blocks can be shown
>> in real time.
> Oh, this looks like a soft limitation in quota system, but original
> reserved_blocks implementation likes a hard one, so this patch changes the
> semantics of reserved_blocks.
>
> Actually, I doubt that it would be hard to reserve all left free space in real
> user scenario now, since system user's activation may depend on free space of
> data partition due to file creation requirement, so w/o supporting feature of
> uid/gid reserved block, soft reservation will block any activation of system
> user, such as android.
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>>   fs/f2fs/f2fs.h                          |  9 +++++++--
>>   fs/f2fs/super.c                         |  4 +++-
>>   fs/f2fs/sysfs.c                         | 15 ++++++++++-----
>>   4 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 11b7f4e..bdbb9f3 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -151,3 +151,9 @@ Date:		August 2017
>>   Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>>   Description:
>>   		 Controls sleep time of GC urgent mode
>> +
>> +What:		/sys/fs/f2fs/<disk>/cur_reserved_blocks
>> +Date:		August 2017
>> +Contact:	"Yunlong Song" <yunlong.song@huawei.com>
>> +Description:
>> +		 Shows current reserved blocks in system.
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index cea329f..3b7056f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1040,6 +1040,7 @@ struct f2fs_sb_info {
>>   	block_t discard_blks;			/* discard command candidats */
>>   	block_t last_valid_block_count;		/* for recovery */
>>   	block_t reserved_blocks;		/* configurable reserved blocks */
>> +	block_t cur_reserved_blocks;		/* current reserved blocks */
>>   
>>   	u32 s_next_generation;			/* for NFS support */
>>   
>> @@ -1514,7 +1515,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>   
>>   	spin_lock(&sbi->stat_lock);
>>   	sbi->total_valid_block_count += (block_t)(*count);
>> -	avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
>> +	avail_user_block_count = sbi->user_block_count - sbi->cur_reserved_blocks;
>>   	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>>   		diff = sbi->total_valid_block_count - avail_user_block_count;
>>   		*count -= diff;
>> @@ -1548,6 +1549,8 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>>   	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
>>   	f2fs_bug_on(sbi, inode->i_blocks < sectors);
>>   	sbi->total_valid_block_count -= (block_t)count;
>> +	sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>> +									sbi->cur_reserved_blocks + count);
>>   	spin_unlock(&sbi->stat_lock);
>>   	f2fs_i_blocks_write(inode, count, false, true);
>>   }
>> @@ -1694,7 +1697,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>   	spin_lock(&sbi->stat_lock);
>>   
>>   	valid_block_count = sbi->total_valid_block_count + 1;
>> -	if (unlikely(valid_block_count + sbi->reserved_blocks >
>> +	if (unlikely(valid_block_count + sbi->cur_reserved_blocks >
>>   						sbi->user_block_count)) {
>>   		spin_unlock(&sbi->stat_lock);
>>   		goto enospc;
>> @@ -1737,6 +1740,8 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>>   
>>   	sbi->total_valid_node_count--;
>>   	sbi->total_valid_block_count--;
>> +	sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>> +									sbi->cur_reserved_blocks + 1);
>>   
>>   	spin_unlock(&sbi->stat_lock);
>>   
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 4c1bdcb..2934aa2 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>   	buf->f_blocks = total_count - start_count;
>>   	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>>   	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>> -						sbi->reserved_blocks;
>> +						sbi->cur_reserved_blocks;
>>   
>>   	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>   
>> @@ -2411,6 +2411,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   				le64_to_cpu(sbi->ckpt->valid_block_count);
>>   	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>   	sbi->reserved_blocks = 0;
>> +	sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>> +						sbi->user_block_count - sbi->total_valid_block_count);
>>   
>>   	for (i = 0; i < NR_INODE_TYPE; i++) {
>>   		INIT_LIST_HEAD(&sbi->inode_list[i]);
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index b769a3d..405c13f 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -76,6 +76,12 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>>   			BD_PART_WRITTEN(sbi)));
>>   }
>>   
>> +static ssize_t cur_reserved_blocks_show(struct f2fs_attr *a,
>> +		struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return snprintf(buf, PAGE_SIZE, "%u\n", sbi->cur_reserved_blocks);
>> +}
>> +
>>   static ssize_t features_show(struct f2fs_attr *a,
>>   		struct f2fs_sb_info *sbi, char *buf)
>>   {
>> @@ -143,12 +149,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>   #endif
>>   	if (a->struct_type == RESERVED_BLOCKS) {
>>   		spin_lock(&sbi->stat_lock);
>> -		if ((unsigned long)sbi->total_valid_block_count + t >
>> -				(unsigned long)sbi->user_block_count) {
>> -			spin_unlock(&sbi->stat_lock);
>> -			return -EINVAL;
>> -		}
>>   		*ui = t;
>> +		sbi->cur_reserved_blocks = min(t, sbi->user_block_count -
>> +										sbi->total_valid_block_count);
>>   		spin_unlock(&sbi->stat_lock);
>>   		return count;
>>   	}
>> @@ -274,6 +277,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>>   #endif
>>   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>>   F2FS_GENERAL_RO_ATTR(features);
>> +F2FS_GENERAL_RO_ATTR(cur_reserved_blocks);
>>   
>>   #ifdef CONFIG_F2FS_FS_ENCRYPTION
>>   F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
>> @@ -317,6 +321,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>>   	ATTR_LIST(lifetime_write_kbytes),
>>   	ATTR_LIST(features),
>>   	ATTR_LIST(reserved_blocks),
>> +	ATTR_LIST(cur_reserved_blocks),
>>   	NULL,
>>   };
>>   
>>
>
> .
>

-- 
Thanks,
Yunlong Song
