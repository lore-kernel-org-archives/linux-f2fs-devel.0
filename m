From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: introduce cur_reserved_blocks in
 sysfs
Date: Wed, 25 Oct 2017 18:02:20 +0800
Message-ID: <617468f3-2723-d3d3-d23f-da8aa488862b@huawei.com>
References: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
 <1502451826-45453-1-git-send-email-yunlong.song@huawei.com>
 <2e1652f9-5e3a-4f38-5736-54b1a89ac02a@huawei.com>
 <3ef856f1-4155-4821-4cf8-25f5872257e5@huawei.com>
 <f09c40a0-1f64-cfa4-3258-9265c72e8e00@huawei.com>
 <d7eee439-d1d3-f1ee-ba63-6940f185b7f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1e7IaA-0004qt-GZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 10:06:42 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e7Ia8-0007r1-Lq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 10:06:42 +0000
In-Reply-To: <d7eee439-d1d3-f1ee-ba63-6940f185b7f6@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao,

ping...

Please see the review comment below. And the change is already in the v3 
patch.

On 2017/8/18 23:16, Yunlong Song wrote:
> I send a v3 patch, please review, and the main difference is shown below.
>
> On 2017/8/18 18:20, Chao Yu wrote:
>> Hi Yunlong,
>>
>> IMO, we don't need additional sysfs entry, how about changing a bit 
>> as below?
>>
>> >From 3fc8206871fe457859f1537c9dc8918b45f14601 Mon Sep 17 00:00:00 2001
>> From: Yunlong Song <yunlong.song@huawei.com>
>> Date: Wed, 16 Aug 2017 23:01:56 +0800
>> Subject: [PATCH] f2fs: support soft block reservation
>>
>> It supports to extend reserved_blocks sysfs interface to be soft
>> threshold, which allows user configure it exceeding current available
>> user space.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
>>   fs/f2fs/f2fs.h                          | 12 ++++++++++--
>>   fs/f2fs/super.c                         |  3 ++-
>>   fs/f2fs/sysfs.c                         | 16 ++++++++++++++--
>>   4 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs 
>> b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 11b7f4ebea7c..45c3d92f77c8 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -138,7 +138,8 @@ What: /sys/fs/f2fs/<disk>/reserved_blocks
>>   Date:        June 2017
>>   Contact:    "Chao Yu" <yuchao0@huawei.com>
>>   Description:
>> -         Controls current reserved blocks in system.
>> +         Controls current reserved blocks in system, the threshold
>> +         is soft, it could exceed current avaible user space.
>>
>>   What:        /sys/fs/f2fs/<disk>/gc_urgent
>>   Date:        August 2017
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 336021b9b93e..a7b2d257e8ee 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1046,6 +1046,7 @@ struct f2fs_sb_info {
>>       block_t discard_blks;            /* discard command candidats */
>>       block_t last_valid_block_count;        /* for recovery */
>>       block_t reserved_blocks;        /* configurable reserved blocks */
>> +    block_t current_reserved_blocks;    /* current reserved blocks */
>>
>>       u32 s_next_generation;            /* for NFS support */
>>
>> @@ -1520,7 +1521,8 @@ static inline int inc_valid_block_count(struct 
>> f2fs_sb_info *sbi,
>>
>>       spin_lock(&sbi->stat_lock);
>>       sbi->total_valid_block_count += (block_t)(*count);
>> -    avail_user_block_count = sbi->user_block_count - 
>> sbi->reserved_blocks;
>> +    avail_user_block_count = sbi->user_block_count -
>> +                    sbi->current_reserved_blocks;
>>       if (unlikely(sbi->total_valid_block_count > 
>> avail_user_block_count)) {
>>           diff = sbi->total_valid_block_count - avail_user_block_count;
>>           *count -= diff;
>> @@ -1554,6 +1556,9 @@ static inline void dec_valid_block_count(struct 
>> f2fs_sb_info *sbi,
>>       f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
>>       f2fs_bug_on(sbi, inode->i_blocks < sectors);
>>       sbi->total_valid_block_count -= (block_t)count;
>> +    if (sbi->reserved_blocks)
> Add sbi->reserved_blocks != sbi->cur_reserved_blocks check
>> +        sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> +                    sbi->current_reserved_blocks + count);
>>       spin_unlock(&sbi->stat_lock);
>>       f2fs_i_blocks_write(inode, count, false, true);
>>   }
>> @@ -1700,7 +1705,7 @@ static inline int inc_valid_node_count(struct 
>> f2fs_sb_info *sbi,
>>       spin_lock(&sbi->stat_lock);
>>
>>       valid_block_count = sbi->total_valid_block_count + 1;
>> -    if (unlikely(valid_block_count + sbi->reserved_blocks >
>> +    if (unlikely(valid_block_count + sbi->current_reserved_blocks >
>>                           sbi->user_block_count)) {
>>           spin_unlock(&sbi->stat_lock);
>>           goto enospc;
>> @@ -1743,6 +1748,9 @@ static inline void dec_valid_node_count(struct 
>> f2fs_sb_info *sbi,
>>
>>       sbi->total_valid_node_count--;
>>       sbi->total_valid_block_count--;
>> +    if (sbi->reserved_blocks)
>> +        sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> +                    sbi->current_reserved_blocks + 1);
> change to sbi->cur_reserved_blocks++;
>>
>>       spin_unlock(&sbi->stat_lock);
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 4c1bdcb94133..036f083bbf56 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, 
>> struct kstatfs *buf)
>>       buf->f_blocks = total_count - start_count;
>>       buf->f_bfree = user_block_count - valid_user_blocks(sbi) + 
>> ovp_count;
>>       buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>> -                        sbi->reserved_blocks;
>> +                        sbi->current_reserved_blocks;
>>
>>       avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>
>> @@ -2411,6 +2411,7 @@ static int f2fs_fill_super(struct super_block 
>> *sb, void *data, int silent)
>> le64_to_cpu(sbi->ckpt->valid_block_count);
>>       sbi->last_valid_block_count = sbi->total_valid_block_count;
>>       sbi->reserved_blocks = 0;
>> +    sbi->current_reserved_blocks = 0;
>>
>>       for (i = 0; i < NR_INODE_TYPE; i++) {
>>           INIT_LIST_HEAD(&sbi->inode_list[i]);
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 4bcaa9059026..3173a272fe7c 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -104,12 +104,23 @@ static ssize_t features_show(struct f2fs_attr *a,
>>       return len;
>>   }
>>
>> +static ssize_t f2fs_reserved_blocks_show(struct f2fs_attr *a,
>> +                    struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +    return snprintf(buf, PAGE_SIZE,
>> +            "expected:    %u\ncurrent:    %u\n",
>> +            sbi->reserved_blocks, sbi->current_reserved_blocks);
>> +}
>> +
>>   static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>               struct f2fs_sb_info *sbi, char *buf)
>>   {
>>       unsigned char *ptr = NULL;
>>       unsigned int *ui;
>>
>> +    if (a->struct_type == RESERVED_BLOCKS)
>> +        return f2fs_reserved_blocks_show(a, sbi, buf);
>> +
>>       ptr = __struct_ptr(sbi, a->struct_type);
>>       if (!ptr)
>>           return -EINVAL;
>> @@ -143,12 +154,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>   #endif
>>       if (a->struct_type == RESERVED_BLOCKS) {
>>           spin_lock(&sbi->stat_lock);
>> -        if ((unsigned long)sbi->total_valid_block_count + t >
>> -                (unsigned long)sbi->user_block_count) {
>> +        if (t > (unsigned long)sbi->user_block_count) {
>>               spin_unlock(&sbi->stat_lock);
>>               return -EINVAL;
>>           }
>>           *ui = t;
>> +        sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> +                sbi->user_block_count - valid_user_blocks(sbi));
> This is not safe for support system's activation, since the user 
> available space can be suddenly zero!
> So I change this to only admit t < sbi->cur_reserved_blocks then 
> change its value.
>> spin_unlock(&sbi->stat_lock);
>>           return count;
>>       }
>

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
