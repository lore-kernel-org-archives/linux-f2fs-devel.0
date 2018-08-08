From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to return success when trimming meta area
Date: Wed, 8 Aug 2018 17:36:29 +0800
Message-ID: <20180808093629.84207-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

generic/251
    --- tests/generic/251.out	2016-05-03 20:20:11.381899000 +0800
     QA output created by 251
     Running the test: done.
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    ...
Ran: generic/251
Failures: generic/251

The reason is coverage of fstrim locates in meta area, previously we
just return -EINVAL for such case, making generic/251 failed, to fix
this problem, let's relieve restriction to return success with no
block discarded.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8826ea683804..ce55e93958c8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2637,8 +2637,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
 
-	if (end <= MAIN_BLKADDR(sbi))
-		return -EINVAL;
+	if (end < MAIN_BLKADDR(sbi))
+		goto out;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-- 
2.18.0.rc1
