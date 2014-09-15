From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/5] f2fs: fix to truncate blocks past EOF in
 ->setattr
Date: Mon, 15 Sep 2014 18:02:09 +0800
Message-ID: <002e01cfd0cc$3a47bf00$aed73d00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XTT7l-0008Ek-PI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:03:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XTT7i-0005qJ-QX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:03:09 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NBX005VZT8Z5F10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 19:02:59 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

By using FALLOC_FL_KEEP_SIZE in ->fallocate of f2fs, we can fallocate block past
EOF without changing i_size of inode. These blocks past EOF will not be
truncated in ->setattr as we truncate them only when change the file size.

We should give a chance to truncate blocks out of filesize in setattr().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c9a1295..7b34101 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -547,15 +547,22 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err)
 		return err;
 
-	if ((attr->ia_valid & ATTR_SIZE) &&
-			attr->ia_size != i_size_read(inode)) {
+	if (attr->ia_valid & ATTR_SIZE) {
 		err = f2fs_convert_inline_data(inode, attr->ia_size, NULL);
 		if (err)
 			return err;
 
-		truncate_setsize(inode, attr->ia_size);
-		f2fs_truncate(inode);
-		f2fs_balance_fs(F2FS_I_SB(inode));
+		if (attr->ia_size != i_size_read(inode)) {
+			truncate_setsize(inode, attr->ia_size);
+			f2fs_truncate(inode);
+			f2fs_balance_fs(F2FS_I_SB(inode));
+		} else {
+			/*
+			 * giving a chance to truncate blocks past EOF which
+			 * are fallocated with FALLOC_FL_KEEP_SIZE.
+			 */
+			f2fs_truncate(inode);
+		}
 	}
 
 	__setattr_copy(inode, attr);
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
