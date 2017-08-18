From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: introduce cur_reserved_blocks in sysfs
Date: Fri, 18 Aug 2017 18:20:23 +0800
Message-ID: <f09c40a0-1f64-cfa4-3258-9265c72e8e00@huawei.com>
References: <1502199825-15218-1-git-send-email-yunlong.song@huawei.com>
 <1502451826-45453-1-git-send-email-yunlong.song@huawei.com>
 <2e1652f9-5e3a-4f38-5736-54b1a89ac02a@huawei.com>
 <3ef856f1-4155-4821-4cf8-25f5872257e5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ef856f1-4155-4821-4cf8-25f5872257e5@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

IMO, we don't need additional sysfs entry, how about changing a bit as below?

>From 3fc8206871fe457859f1537c9dc8918b45f14601 Mon Sep 17 00:00:00 2001
From: Yunlong Song <yunlong.song@huawei.com>
Date: Wed, 16 Aug 2017 23:01:56 +0800
Subject: [PATCH] f2fs: support soft block reservation

It supports to extend reserved_blocks sysfs interface to be soft
threshold, which allows user configure it exceeding current available
user space.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
 fs/f2fs/f2fs.h                          | 12 ++++++++++--
 fs/f2fs/super.c                         |  3 ++-
 fs/f2fs/sysfs.c                         | 16 ++++++++++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 11b7f4ebea7c..45c3d92f77c8 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -138,7 +138,8 @@ What:		/sys/fs/f2fs/<disk>/reserved_blocks
 Date:		June 2017
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:
-		 Controls current reserved blocks in system.
+		 Controls current reserved blocks in system, the threshold
+		 is soft, it could exceed current avaible user space.

 What:		/sys/fs/f2fs/<disk>/gc_urgent
 Date:		August 2017
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 336021b9b93e..a7b2d257e8ee 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1046,6 +1046,7 @@ struct f2fs_sb_info {
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
+	block_t current_reserved_blocks;	/* current reserved blocks */

 	u32 s_next_generation;			/* for NFS support */

@@ -1520,7 +1521,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,

 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
+	avail_user_block_count = sbi->user_block_count -
+					sbi->current_reserved_blocks;
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		*count -= diff;
@@ -1554,6 +1556,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
 	f2fs_bug_on(sbi, inode->i_blocks < sectors);
 	sbi->total_valid_block_count -= (block_t)count;
+	if (sbi->reserved_blocks)
+		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
+					sbi->current_reserved_blocks + count);
 	spin_unlock(&sbi->stat_lock);
 	f2fs_i_blocks_write(inode, count, false, true);
 }
@@ -1700,7 +1705,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	spin_lock(&sbi->stat_lock);

 	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->reserved_blocks >
+	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
 						sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
@@ -1743,6 +1748,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,

 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
+	if (sbi->reserved_blocks)
+		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
+					sbi->current_reserved_blocks + 1);

 	spin_unlock(&sbi->stat_lock);

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c1bdcb94133..036f083bbf56 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
-						sbi->reserved_blocks;
+						sbi->current_reserved_blocks;

 	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;

@@ -2411,6 +2411,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
+	sbi->current_reserved_blocks = 0;

 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 4bcaa9059026..3173a272fe7c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -104,12 +104,23 @@ static ssize_t features_show(struct f2fs_attr *a,
 	return len;
 }

+static ssize_t f2fs_reserved_blocks_show(struct f2fs_attr *a,
+					struct f2fs_sb_info *sbi, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE,
+			"expected:	%u\ncurrent:	%u\n",
+			sbi->reserved_blocks, sbi->current_reserved_blocks);
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
 	unsigned char *ptr = NULL;
 	unsigned int *ui;

+	if (a->struct_type == RESERVED_BLOCKS)
+		return f2fs_reserved_blocks_show(a, sbi, buf);
+
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
 		return -EINVAL;
@@ -143,12 +154,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-		if ((unsigned long)sbi->total_valid_block_count + t >
-				(unsigned long)sbi->user_block_count) {
+		if (t > (unsigned long)sbi->user_block_count) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
 		*ui = t;
+		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
+				sbi->user_block_count - valid_user_blocks(sbi));
 		spin_unlock(&sbi->stat_lock);
 		return count;
 	}
-- 
2.13.1.388.g69e6b9b4f4a9



On 2017/8/18 18:05, Yunlong Song wrote:
> ping...
> 
> On 2017/8/15 12:08, Yunlong Song wrote:
>> ping...
>>
>> On 2017/8/11 19:43, Yunlong Song wrote:
>>> In this patch, we add a new sysfs interface, we can use it to 
>>> gradually achieve
>>> the reserved_blocks finally, even when reserved_blocks is initially 
>>> set over
>>> user_block_count - total_valid_block_count. This is very useful, 
>>> especially when
>>> we upgrade kernel with new reserved_blocks value, but old disk image 
>>> unluckily has
>>> user_block_count - total_valid_block_count smaller than the desired 
>>> reserved_blocks.
>>> With this patch, f2fs can try its best to reserve space and get close 
>>> to the
>>> reserved_blocks, and the current value of achieved reserved_blocks 
>>> can be shown
>>> in real time.
>>>
>>> To ensure there is enough space for supporting system's activation, 
>>> we safely
>>> increase cur_reserved_blocks in dev_valid_block(,node)_count to only 
>>> take up the
>>> blocks which are just obsoleted.
>>>
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>>>   fs/f2fs/f2fs.h                          |  9 +++++++--
>>>   fs/f2fs/super.c                         |  3 ++-
>>>   fs/f2fs/sysfs.c                         | 15 ++++++++++-----
>>>   4 files changed, 25 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs 
>>> b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> index 11b7f4e..bdbb9f3 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> @@ -151,3 +151,9 @@ Date:        August 2017
>>>   Contact:    "Jaegeuk Kim" <jaegeuk@kernel.org>
>>>   Description:
>>>            Controls sleep time of GC urgent mode
>>> +
>>> +What:        /sys/fs/f2fs/<disk>/cur_reserved_blocks
>>> +Date:        August 2017
>>> +Contact:    "Yunlong Song" <yunlong.song@huawei.com>
>>> +Description:
>>> +         Shows current reserved blocks in system.
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 2f20b6b..62d7343 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1041,6 +1041,7 @@ struct f2fs_sb_info {
>>>       block_t discard_blks;            /* discard command candidats */
>>>       block_t last_valid_block_count;        /* for recovery */
>>>       block_t reserved_blocks;        /* configurable reserved blocks */
>>> +    block_t cur_reserved_blocks;        /* current reserved blocks */
>>>         u32 s_next_generation;            /* for NFS support */
>>>   @@ -1515,7 +1516,7 @@ static inline int 
>>> inc_valid_block_count(struct f2fs_sb_info *sbi,
>>>         spin_lock(&sbi->stat_lock);
>>>       sbi->total_valid_block_count += (block_t)(*count);
>>> -    avail_user_block_count = sbi->user_block_count - 
>>> sbi->reserved_blocks;
>>> +    avail_user_block_count = sbi->user_block_count - 
>>> sbi->cur_reserved_blocks;
>>>       if (unlikely(sbi->total_valid_block_count > 
>>> avail_user_block_count)) {
>>>           diff = sbi->total_valid_block_count - avail_user_block_count;
>>>           *count -= diff;
>>> @@ -1549,6 +1550,8 @@ static inline void dec_valid_block_count(struct 
>>> f2fs_sb_info *sbi,
>>>       f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
>>>       f2fs_bug_on(sbi, inode->i_blocks < sectors);
>>>       sbi->total_valid_block_count -= (block_t)count;
>>> +    sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>>> +                                    sbi->cur_reserved_blocks + count);
>>>       spin_unlock(&sbi->stat_lock);
>>>       f2fs_i_blocks_write(inode, count, false, true);
>>>   }
>>> @@ -1695,7 +1698,7 @@ static inline int inc_valid_node_count(struct 
>>> f2fs_sb_info *sbi,
>>>       spin_lock(&sbi->stat_lock);
>>>         valid_block_count = sbi->total_valid_block_count + 1;
>>> -    if (unlikely(valid_block_count + sbi->reserved_blocks >
>>> +    if (unlikely(valid_block_count + sbi->cur_reserved_blocks >
>>>                           sbi->user_block_count)) {
>>>           spin_unlock(&sbi->stat_lock);
>>>           goto enospc;
>>> @@ -1738,6 +1741,8 @@ static inline void dec_valid_node_count(struct 
>>> f2fs_sb_info *sbi,
>>>         sbi->total_valid_node_count--;
>>>       sbi->total_valid_block_count--;
>>> +    sbi->cur_reserved_blocks = min(sbi->reserved_blocks,
>>> +                                    sbi->cur_reserved_blocks + 1);
>>>         spin_unlock(&sbi->stat_lock);
>>>   diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 4c1bdcb..16a805f 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -957,7 +957,7 @@ static int f2fs_statfs(struct dentry *dentry, 
>>> struct kstatfs *buf)
>>>       buf->f_blocks = total_count - start_count;
>>>       buf->f_bfree = user_block_count - valid_user_blocks(sbi) + 
>>> ovp_count;
>>>       buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>>> -                        sbi->reserved_blocks;
>>> +                        sbi->cur_reserved_blocks;
>>>         avail_node_count = sbi->total_node_count - 
>>> F2FS_RESERVED_NODE_NUM;
>>>   @@ -2411,6 +2411,7 @@ static int f2fs_fill_super(struct super_block 
>>> *sb, void *data, int silent)
>>> le64_to_cpu(sbi->ckpt->valid_block_count);
>>>       sbi->last_valid_block_count = sbi->total_valid_block_count;
>>>       sbi->reserved_blocks = 0;
>>> +    sbi->cur_reserved_blocks = 0;
>>>         for (i = 0; i < NR_INODE_TYPE; i++) {
>>>           INIT_LIST_HEAD(&sbi->inode_list[i]);
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index a1be5ac..03f9d3d 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -76,6 +76,12 @@ static ssize_t lifetime_write_kbytes_show(struct 
>>> f2fs_attr *a,
>>>               BD_PART_WRITTEN(sbi)));
>>>   }
>>>   +static ssize_t cur_reserved_blocks_show(struct f2fs_attr *a,
>>> +        struct f2fs_sb_info *sbi, char *buf)
>>> +{
>>> +    return snprintf(buf, PAGE_SIZE, "%u\n", sbi->cur_reserved_blocks);
>>> +}
>>> +
>>>   static ssize_t features_show(struct f2fs_attr *a,
>>>           struct f2fs_sb_info *sbi, char *buf)
>>>   {
>>> @@ -143,12 +149,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>>   #endif
>>>       if (a->struct_type == RESERVED_BLOCKS) {
>>>           spin_lock(&sbi->stat_lock);
>>> -        if ((unsigned long)sbi->total_valid_block_count + t >
>>> -                (unsigned long)sbi->user_block_count) {
>>> -            spin_unlock(&sbi->stat_lock);
>>> -            return -EINVAL;
>>> -        }
>>>           *ui = t;
>>> +        if (t < sbi->cur_reserved_blocks)
>>> +            sbi->cur_reserved_blocks = t;
>>>           spin_unlock(&sbi->stat_lock);
>>>           return count;
>>>       }
>>> @@ -274,6 +277,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr 
>>> *a,
>>>   #endif
>>>   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>>>   F2FS_GENERAL_RO_ATTR(features);
>>> +F2FS_GENERAL_RO_ATTR(cur_reserved_blocks);
>>>     #ifdef CONFIG_F2FS_FS_ENCRYPTION
>>>   F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
>>> @@ -317,6 +321,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr 
>>> *a,
>>>       ATTR_LIST(lifetime_write_kbytes),
>>>       ATTR_LIST(features),
>>>       ATTR_LIST(reserved_blocks),
>>> +    ATTR_LIST(cur_reserved_blocks),
>>>       NULL,
>>>   };
>>
> 
