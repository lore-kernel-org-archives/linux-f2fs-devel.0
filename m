From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: introduce need_do_checkpoint for
 readability
Date: Wed, 20 Aug 2014 18:37:35 +0800
Message-ID: <008101cfbc62$d9d92fa0$8d8b8ee0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XK3He-0008QT-7M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 10:38:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XK3Hd-000683-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 10:38:26 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NAL008HXPJUR7B0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 19:38:18 +0900 (KST)
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

This patch introduce need_do_checkpoint() to include numerous judgment condition
for readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 208f1a9..9c09a0f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -110,6 +110,25 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	return 1;
 }
 
+static inline bool need_do_checkpoint(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	bool need_cp = false;
+
+	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
+		need_cp = true;
+	else if (file_wrong_pino(inode))
+		need_cp = true;
+	else if (!space_for_roll_forward(sbi))
+		need_cp = true;
+	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
+		need_cp = true;
+	else if (F2FS_I(inode)->xattr_ver == cur_cp_version(F2FS_CKPT(sbi)))
+		need_cp = true;
+
+	return need_cp;
+}
+
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -154,23 +173,12 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	/* guarantee free sections for fsync */
 	f2fs_balance_fs(sbi);
 
-	down_read(&fi->i_sem);
-
 	/*
 	 * Both of fdatasync() and fsync() are able to be recovered from
 	 * sudden-power-off.
 	 */
-	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
-		need_cp = true;
-	else if (file_wrong_pino(inode))
-		need_cp = true;
-	else if (!space_for_roll_forward(sbi))
-		need_cp = true;
-	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
-		need_cp = true;
-	else if (F2FS_I(inode)->xattr_ver == cur_cp_version(F2FS_CKPT(sbi)))
-		need_cp = true;
-
+	down_read(&fi->i_sem);
+	need_cp = need_do_checkpoint(inode);
 	up_read(&fi->i_sem);
 
 	if (need_cp) {
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
