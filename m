From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: clean up acl flow for better
	readability
Date: Mon, 28 Oct 2013 14:07:25 +0900
Message-ID: <1382936846-4860-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vaf3o-0001bc-7G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 05:08:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vaf3m-00089D-LD for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 05:08:16 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVD0088W4XK46P0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 14:08:08 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch cleans up a couple of acl codes.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/acl.c | 25 +++++++++++++------------
 fs/f2fs/acl.h |  6 +++---
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index b7826ec..f1a6975 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -262,8 +262,8 @@ static int f2fs_set_acl(struct inode *inode, int type, struct posix_acl *acl)
 
 int f2fs_init_acl(struct inode *inode, struct inode *dir)
 {
-	struct posix_acl *acl = NULL;
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
+	struct posix_acl *acl = NULL;
 	int error = 0;
 
 	if (!S_ISLNK(inode->i_mode)) {
@@ -276,19 +276,19 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir)
 			inode->i_mode &= ~current_umask();
 	}
 
-	if (test_opt(sbi, POSIX_ACL) && acl) {
+	if (!test_opt(sbi, POSIX_ACL) || !acl)
+		goto cleanup;
 
-		if (S_ISDIR(inode->i_mode)) {
-			error = f2fs_set_acl(inode, ACL_TYPE_DEFAULT, acl);
-			if (error)
-				goto cleanup;
-		}
-		error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
-		if (error < 0)
-			return error;
-		if (error > 0)
-			error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl);
+	if (S_ISDIR(inode->i_mode)) {
+		error = f2fs_set_acl(inode, ACL_TYPE_DEFAULT, acl);
+		if (error)
+			goto cleanup;
 	}
+	error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
+	if (error < 0)
+		return error;
+	if (error > 0)
+		error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl);
 cleanup:
 	posix_acl_release(acl);
 	return error;
@@ -313,6 +313,7 @@ int f2fs_acl_chmod(struct inode *inode)
 	error = posix_acl_chmod(&acl, GFP_KERNEL, mode);
 	if (error)
 		return error;
+
 	error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl);
 	posix_acl_release(acl);
 	return error;
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 80f4306..3839048 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -36,9 +36,9 @@ struct f2fs_acl_header {
 
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
-extern struct posix_acl *f2fs_get_acl(struct inode *inode, int type);
-extern int f2fs_acl_chmod(struct inode *inode);
-extern int f2fs_init_acl(struct inode *inode, struct inode *dir);
+extern struct posix_acl *f2fs_get_acl(struct inode *, int);
+extern int f2fs_acl_chmod(struct inode *);
+extern int f2fs_init_acl(struct inode *, struct inode *);
 #else
 #define f2fs_check_acl	NULL
 #define f2fs_get_acl	NULL
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
