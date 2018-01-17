From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: hanlde error case in f2fs_ioc_shutdown
Date: Wed, 17 Jan 2018 22:28:52 +0800
Message-ID: <20180117142853.26584-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch makes f2fs_ioc_shutdown handling error case correctly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 94be67591d1f..593a79447907 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1839,14 +1839,20 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		sb = freeze_bdev(sb->s_bdev);
-		if (sb && !IS_ERR(sb)) {
+		if (IS_ERR(sb)) {
+			ret = PTR_ERR(sb);
+			goto out;
+		}
+		if (sb) {
 			f2fs_stop_checkpoint(sbi, false);
 			thaw_bdev(sb->s_bdev, sb);
 		}
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
-		f2fs_sync_fs(sb, 1);
+		ret = f2fs_sync_fs(sb, 1);
+		if (ret)
+			goto out;
 		f2fs_stop_checkpoint(sbi, false);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
-- 
2.14.1.145.gb3622a4ee
