From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
Date: Tue, 30 Apr 2019 11:14:59 +0800
Message-ID: <5d421615-19a1-4609-4e51-3b0c397bafb3@huawei.com>
References: <20190426095754.85784-1-yuchao0@huawei.com>
 <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
 <f8b890b8-22a3-bead-7df5-6ab87deb56e9@kernel.org>
 <20190430025406.GA17299@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430025406.GA17299@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, drosen@google.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/4/30 10:54, Jaegeuk Kim wrote:
> On 04/29, Chao Yu wrote:
>> On 2019-4-28 21:47, Jaegeuk Kim wrote:
>>> On 04/26, Chao Yu wrote:
>>>> When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
>>>> can be increased after the judgment condition, result in overflow of
>>>> .f_bfree in later calculation. This patch fixes to use a temporary signed
>>>> variable to save the calculation result of .f_bfree.
>>>>
>>>> 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>>>>  		buf->f_bfree = 0;
>>>>  	else
>>>> 		buf->f_bfree -= sbi->unusable_block_count;
>>>
>>> Do we just need stat_lock for this?
>>
>> Like we access other stat value in statfs(), we just need the instantaneous
>> value of .unusable_block_count, so we don't need additional stat_lock, right?
> 
> What I've concerend is whether or not this fixes all the inconsistent values.
> The original intention was providing stats in best effort, so we wouldn't use
> any lock.

Hmm.. I've made a patch to protect .unusable_block_count update/access as below,
how about merging this two patch, in addition, in this patch, let's add
stat_lock around accessing .f_bfree/.unusable_block_count.

>From b927209d10fc222243037d05ccc899f48569e773 Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Fri, 26 Apr 2019 15:51:22 +0800
Subject: [PATCH] f2fs: fix to cover sbi->unusable_block_count with stat_lock

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/segment.c    | 5 ++++-
 fs/f2fs/super.c      | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f6ba9a743a2d..526a70ea7433 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1536,7 +1536,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct
cp_control *cpc)
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 	clear_sbi_flag(sbi, SBI_NEED_CP);
 	clear_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
+
+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
+
 	__set_cp_next_pack(sbi);

 	/*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5c3f07540db1..f10c394cf467 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2203,8 +2203,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi,
block_t blkaddr, int del)
 			 * before, we must track that to know how much space we
 			 * really have.
 			 */
-			if (f2fs_test_bit(offset, se->ckpt_valid_map))
+			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
 				sbi->unusable_block_count++;
+				spin_unlock(&sbi->stat_lock);
+			}
 		}

 		if (f2fs_test_and_clear_bit(offset, se->discard_map))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a05a636bd2a..dd6e7b351b58 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1546,7 +1546,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
 	f2fs_write_checkpoint(sbi, &cpc);

+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
 	mutex_unlock(&sbi->gc_mutex);
 restore_flag:
 	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
-- 
2.18.0.rc1



> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/super.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 2376bb01b5c4..fcc9793dbc2c 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>>>>  	block_t total_count, user_block_count, start_count;
>>>>  	u64 avail_node_count;
>>>> +	long long bfree;
>>>>  
>>>>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
>>>>  	user_block_count = sbi->user_block_count;
>>>> @@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>>  	buf->f_blocks = total_count - start_count;
>>>>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>>>>  						sbi->current_reserved_blocks;
>>>> -	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>>>> +
>>>> +	bfree = buf->f_bfree - sbi->unusable_block_count;
>>>> +	if (unlikely(bfree < 0))
>>>>  		buf->f_bfree = 0;
>>>>  	else
>>>> -		buf->f_bfree -= sbi->unusable_block_count;
>>>> +		buf->f_bfree = bfree;
>>>>  
>>>>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
>>>>  		buf->f_bavail = buf->f_bfree -
>>>> -- 
>>>> 2.18.0.rc1
> .
> 
