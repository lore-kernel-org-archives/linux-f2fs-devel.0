From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 03/13] f2fs: remove new blank line of f2fs kernel
 message
Date: Mon, 15 Apr 2019 15:28:32 +0800
Message-ID: <20190415072842.2438-3-yuchao0@huawei.com>
References: <20190415072842.2438-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hFw30-0004xP-3B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:28:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hFw2y-005rWu-SK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 07:28:58 +0000
In-Reply-To: <20190415072842.2438-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Just removing '\n' in f2fs_msg(, "\n") to avoid redundant new blank line.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c  | 4 ++--
 fs/f2fs/super.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f19a2ec9f0ef..333d1fed956e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2587,7 +2587,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 	if (!f2fs_is_multi_device(sbi) || sbi->s_ndevs - 1 <= range.dev_num ||
 			__is_large_section(sbi)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"Can't flush %u in %d for segs_per_sec %u != 1\n",
+			"Can't flush %u in %d for segs_per_sec %u != 1",
 				range.dev_num, sbi->s_ndevs,
 				sbi->segs_per_sec);
 		return -EINVAL;
@@ -2869,7 +2869,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 
 	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"%s: Enable GC = ino %lx after %x GC trials\n",
+			"%s: Enable GC = ino %lx after %x GC trials",
 			__func__, inode->i_ino,
 			fi->i_gc_failures[GC_FAILURE_PIN]);
 		clear_inode_flag(inode, FI_PIN_FILE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0b6fa77c35f3..2cd78583218a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2454,7 +2454,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	/* Currently, support only 4KB page cache size */
 	if (F2FS_BLKSIZE != PAGE_SIZE) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid page_cache_size (%lu), supports only 4KB\n",
+			"Invalid page_cache_size (%lu), supports only 4KB",
 			PAGE_SIZE);
 		return 1;
 	}
@@ -2463,7 +2463,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
 	if (blocksize != F2FS_BLKSIZE) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid blocksize (%u), supports only 4KB\n",
+			"Invalid blocksize (%u), supports only 4KB",
 			blocksize);
 		return 1;
 	}
@@ -2471,7 +2471,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	/* check log blocks per segment */
 	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
 		f2fs_msg(sb, KERN_INFO,
-			"Invalid log blocks per segment (%u)\n",
+			"Invalid log blocks per segment (%u)",
 			le32_to_cpu(raw_super->log_blocks_per_seg));
 		return 1;
 	}
@@ -3113,7 +3113,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #ifndef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		f2fs_msg(sb, KERN_ERR,
-			 "Zoned block device support is not enabled\n");
+			 "Zoned block device support is not enabled");
 		err = -EOPNOTSUPP;
 		goto free_sb_buf;
 	}
-- 
2.18.0.rc1
