From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/7] f2fs: verify file type early in
	f2fs_fallocate
Date: Fri, 11 Sep 2015 14:39:02 +0800
Message-ID: <00f301d0ec5c$a3d92dd0$eb8b8970$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZaHzz-0002fH-Uu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:39:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZaHzy-0006pX-7m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:39:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUI01W8B2I6WSD0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 15:39:42 +0900 (KST)
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

This patch changes to verify file type early in f2fs_fallocate for
cleanup, meanwhile this also fixes to add missing verification for
expand_inode_data.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac97f78..9e03622 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -775,9 +775,6 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EOPNOTSUPP;
-
 	if (f2fs_has_inline_data(inode)) {
 		ret = f2fs_convert_inline_inode(inode);
 		if (ret)
@@ -918,9 +915,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	if (offset + len >= i_size_read(inode))
 		return -EINVAL;
 
@@ -969,9 +963,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	ret = inode_newsize_ok(inode, (len + offset));
 	if (ret)
 		return ret;
@@ -1078,9 +1069,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	loff_t new_size;
 	int ret;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	new_size = i_size_read(inode) + len;
 	if (new_size > inode->i_sb->s_maxbytes)
 		return -EFBIG;
@@ -1238,6 +1226,10 @@ static long f2fs_fallocate(struct file *file, int mode,
 	struct inode *inode = file_inode(file);
 	long ret = 0;
 
+	/* f2fs only support ->fallocate for regular file */
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	if (f2fs_encrypted_inode(inode) &&
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
-- 
2.4.2



------------------------------------------------------------------------------
