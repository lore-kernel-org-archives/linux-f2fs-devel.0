From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 7/7] f2fs: support data flush in background
Date: Thu, 17 Dec 2015 17:13:28 +0800
Message-ID: <006c01d138ab$4938d740$dbaa85c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a9Udd-0004fx-4Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 09:14:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a9Uda-0007um-TN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 09:14:17 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZH001SYWBEFUB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 18:14:07 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, when finishing a checkpoint, we have persisted all fs meta
info including meta inode, node inode, dentry page of directory inode, so,
after a sudden power cut, f2fs can recover from last checkpoint with full
directory structure.

But during checkpoint, we didn't flush dirty pages of regular and symlink
inode, so such dirty datas still in memory will be lost in that moment of
power off.

In order to reduce the chance of lost data, this patch enables
f2fs_balance_fs_bg with the ability of data flushing. It will try to flush
user data before starting a checkpoint. So user's data written after last
checkpoint which may not be fsynced could be saved.

When we mount with data_flush option, after every period of cp_interval
(could be configured in sysfs: /sys/fs/f2fs/device/cp_interval) seconds
user data could be flushed into device once f2fs_balance_fs_bg was called
in kworker thread or gc thread.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - trigger data flush in f2fs_balance_fs_bg.
v3:
 - adjust to modify commit message.
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5fa519f..c247450 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -291,8 +291,11 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
-			jiffies > sbi->cp_expires)
+			jiffies > sbi->cp_expires) {
+		if (test_opt(sbi, DATA_FLUSH))
+			sync_dirty_inodes(sbi, FILE_INODE);
 		f2fs_sync_fs(sbi->sb, true);
+	}
 }
 
 static int issue_flush_thread(void *data)
-- 
2.6.3



------------------------------------------------------------------------------
