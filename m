From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [PATCH 1/1] No need to do recovery if there is no available CP
Date: Sun,  3 Nov 2013 23:08:21 +0800
Message-ID: <1383491301-11460-1-git-send-email-huajun.li.lee@gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Huajun Li <huajun.li@intel.com>

Normally we expect an empty partition after formatting by
mkfs.f2fs. But in this case, when we format a dirty partition and mount
it again. The former file will be recovered and available again! and
kernel log shows a recovery procedure is evoked.
This patch adds a new flag CP_EXIST_FLAG to indicate whether is a
available CP, and do recovery only when this flag is set.

You can reproduce the bug by following script:
===================================
	TEST_DEV=/dev/sdb1
	umount $TEST_DEV
	mkfs.f2fs $TEST_DEV > /dev/null
	mount -t f2fs $TEST_DEV /mnt
	dmesg -c > /dev/null

	echo
	echo "Small Vector Sync"
	echo "abcdefghijklmnopqrstuvwxyz" > /mnt/small_vector_async

	xfs_io -F -f -s -c "pread -v 0 1"\
	    -c "pwrite -S 0x61 4090 1"\
	    /mnt/small_vector_async

	umount $TEST_DEV

	mkfs.f2fs $TEST_DEV
	#After we format a partition, there should be nothing but root in it.
	#But in this case, when we format a used partition and mount it again,
	#the former created file small_vector_async will be recover!

	mount -t f2fs $TEST_DEV /mnt
	#We expect nothing after mkfs, but in this case small_vector_async will
	#be recovered when we mount the partition.

	ls /mnt
	dmesg


Signed-off-by: Huajun Li <huajun.li@intel.com>
Reported-and-tested-by: Weihong Xu <weihong.xu@intel.com>
---
 fs/f2fs/checkpoint.c    |    2 ++
 fs/f2fs/super.c         |    3 ++-
 include/linux/f2fs_fs.h |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d430157..22b3972 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -767,6 +767,8 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 		clear_prefree_segments(sbi);
 		F2FS_RESET_SB_DIRT(sbi);
 	}
+	if (!is_set_ckpt_flags(ckpt, CP_EXIST_FLAG))
+		set_ckpt_flags(ckpt, CP_EXIST_FLAG);
 }
 
 /*
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e42351c..963da7d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -959,7 +959,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	/* recover fsynced data */
-	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
+	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
+	    is_set_ckpt_flags(F2FS_CKPT(sbi), CP_EXIST_FLAG)) {
 		err = recover_fsync_data(sbi);
 		if (err)
 			f2fs_msg(sb, KERN_ERR,
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb942f6..6e48f22 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -80,6 +80,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_EXIST_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
-- 
1.7.9.5

