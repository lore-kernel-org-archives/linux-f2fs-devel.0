From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/5] f2fs: support data flush in ioctl
Date: Thu, 24 Dec 2015 18:10:25 +0800
Message-ID: <016701d13e33$676f0bc0$364d2340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aC2rc-0005IT-Ny
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 10:11:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aC2rb-00020o-8v
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 10:11:16 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZU01066XMGKCC0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 19:11:07 +0900 (KST)
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

Sometimes user want to sync all data belong to superblock into storage
for persistence, 'syncfs' syscall is one option, still f2fs supports
similar one through ioctl, difference is that sb releted kworker is
online for writebacking concurrently.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a60d088..91997a5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1621,6 +1621,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct cp_control cpc;
 	int err;
+	int flush_data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1628,6 +1629,15 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (get_user(flush_data, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (flush_data) {
+		err = sync_dirty_inodes(sbi, FILE_INODE);
+		if (err)
+			return err;
+	}
+
 	cpc.reason = __get_cp_reason(sbi);
 
 	mutex_lock(&sbi->gc_mutex);
-- 
2.6.3



------------------------------------------------------------------------------
