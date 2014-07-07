From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: use inner macro and function to clean up
	codes
Date: Mon, 07 Jul 2014 11:21:59 +0800
Message-ID: <006201cf9992$b98c7a60$2ca56f20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X3zW6-0006qF-6u
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 03:22:58 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X3zW2-00054z-Qc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 03:22:58 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8B00F92O1ZHU10@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Jul 2014 12:22:47 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In this patch we use below inner macro and function to clean up codes.
1. ADDRS_PER_PAGE
2. SM_I
3. f2fs_readonly

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c    | 3 +--
 fs/f2fs/segment.c | 9 ++++-----
 fs/f2fs/super.c   | 7 +++----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 36fa505..7c652b3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -272,8 +272,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 			}
 		}
 
-		end_offset = IS_INODE(dn.node_page) ?
-			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
+		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 
 		/* find data/hole in dnode block */
 		for (; dn.ofs_in_node < end_offset;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a4f8375..8a6e57d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -272,13 +272,13 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 	spin_lock_init(&fcc->issue_lock);
 	init_waitqueue_head(&fcc->flush_wait_queue);
-	sbi->sm_info->cmd_control_info = fcc;
+	SM_I(sbi)->cmd_control_info = fcc;
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		err = PTR_ERR(fcc->f2fs_issue_flush);
 		kfree(fcc);
-		sbi->sm_info->cmd_control_info = NULL;
+		SM_I(sbi)->cmd_control_info = NULL;
 		return err;
 	}
 
@@ -287,13 +287,12 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi)
 {
-	struct flush_cmd_control *fcc =
-				sbi->sm_info->cmd_control_info;
+	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
 
 	if (fcc && fcc->f2fs_issue_flush)
 		kthread_stop(fcc->f2fs_issue_flush);
 	kfree(fcc);
-	sbi->sm_info->cmd_control_info = NULL;
+	SM_I(sbi)->cmd_control_info = NULL;
 }
 
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bed9413..5800e5c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -615,7 +615,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * Previous and new state of filesystem is RO,
 	 * so skip checking GC and FLUSH_MERGE conditions.
 	 */
-	if ((sb->s_flags & MS_RDONLY) && (*flags & MS_RDONLY))
+	if (f2fs_readonly(sb) && (*flags & MS_RDONLY))
 		goto skip;
 
 	/*
@@ -642,8 +642,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		destroy_flush_cmd_control(sbi);
-	} else if (test_opt(sbi, FLUSH_MERGE) &&
-					!sbi->sm_info->cmd_control_info) {
+	} else if (test_opt(sbi, FLUSH_MERGE) && !SM_I(sbi)->cmd_control_info) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			goto restore_gc;
@@ -1082,7 +1081,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If filesystem is not mounted as read-only then
 	 * do start the gc_thread.
 	 */
-	if (!(sb->s_flags & MS_RDONLY)) {
+	if (!f2fs_readonly(sb)) {
 		/* After POR, we can run background GC thread.*/
 		err = start_gc_thread(sbi);
 		if (err)
-- 
2.0.0.257.g75cc6c6



------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
