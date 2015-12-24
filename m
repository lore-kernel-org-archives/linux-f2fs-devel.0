From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs: clean up f2fs_ioc_write_checkpoint
Date: Thu, 24 Dec 2015 18:11:32 +0800
Message-ID: <016801d13e33$8f150a30$ad3f1e90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Use f2fs_sync_fs to clean up codes in f2fs_ioc_write_checkpoint.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 91997a5..b75037b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1619,7 +1619,6 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct cp_control cpc;
 	int err;
 	int flush_data;
 
@@ -1638,13 +1637,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 			return err;
 	}
 
-	cpc.reason = __get_cp_reason(sbi);
-
-	mutex_lock(&sbi->gc_mutex);
-	err = write_checkpoint(sbi, &cpc);
-	mutex_unlock(&sbi->gc_mutex);
-
-	return err;
+	return f2fs_sync_fs(sbi->sb, 1);
 }
 
 static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
-- 
2.6.3
