From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] fsck.f2fs: show cp_state for fsck.f2fs
Date: Fri, 20 Mar 2015 23:06:30 -0700
Message-ID: <1426917991-25128-2-git-send-email-jaegeuk@kernel.org>
References: <1426917991-25128-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YZCYa-0006ii-01
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YZCYY-00042C-T1 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:47 +0000
In-Reply-To: <1426917991-25128-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds to show cp_state during fsck.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  |  1 -
 fsck/fsck.h  |  1 +
 fsck/main.c  | 21 +++++----------------
 fsck/mount.c | 20 ++++++++++++++++++++
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index c268f15..709fbf3 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -159,7 +159,6 @@ struct f2fs_sb_info {
 	u32 s_next_generation;                  /* for NFS support */
 
 	unsigned int cur_victim_sec;            /* current victim section num */
-
 };
 
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 9cad013..98425c6 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -96,6 +96,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, u32 *, u32 *, int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		u32 *, u32 *);
 
+void print_cp_state(u32);
 extern void print_node_info(struct f2fs_node *);
 extern void print_inode_info(struct f2fs_inode *, int);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
diff --git a/fsck/main.c b/fsck/main.c
index 3606f62..16fab9c 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -140,10 +140,14 @@ void f2fs_parse_options(int argc, char *argv[])
 
 static void do_fsck(struct f2fs_sb_info *sbi)
 {
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 	u32 blk_cnt;
 
 	fsck_init(sbi);
 
+	print_cp_state(flag);
+
 	fsck_chk_orphan_node(sbi);
 
 	/* Traverse all block recursively from root inode */
@@ -175,22 +179,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
 		goto cleanup;
 	}
 
-	MSG(0, "Info: checkpoint state = %x : ", flag);
-	if (flag & CP_FSCK_FLAG)
-		MSG(0, "%s", " fsck");
-	if (flag & CP_ERROR_FLAG)
-		MSG(0, "%s", " error");
-	if (flag & CP_COMPACT_SUM_FLAG)
-		MSG(0, "%s", " compacted_summary");
-	if (flag & CP_ORPHAN_PRESENT_FLAG)
-		MSG(0, "%s", " orphan_inodes");
-	if (flag & CP_FASTBOOT_FLAG)
-		MSG(0, "%s", " fastboot");
-	if (flag & CP_UMOUNT_FLAG)
-		MSG(0, "%s", " unmount");
-	else
-		MSG(0, "%s", " sudden-power-off");
-	MSG(0, "\n");
+	print_cp_state(flag);
 
 	dump_node(sbi, opt->nid);
 cleanup:
diff --git a/fsck/mount.c b/fsck/mount.c
index 6d96db8..879cadb 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -204,6 +204,26 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 	printf("\n\n");
 }
 
+void print_cp_state(u32 flag)
+{
+	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_FSCK_FLAG)
+		MSG(0, "%s", " fsck");
+	if (flag & CP_ERROR_FLAG)
+		MSG(0, "%s", " error");
+	if (flag & CP_COMPACT_SUM_FLAG)
+		MSG(0, "%s", " compacted_summary");
+	if (flag & CP_ORPHAN_PRESENT_FLAG)
+		MSG(0, "%s", " orphan_inodes");
+	if (flag & CP_FASTBOOT_FLAG)
+		MSG(0, "%s", " fastboot");
+	if (flag & CP_UMOUNT_FLAG)
+		MSG(0, "%s", " unmount");
+	else
+		MSG(0, "%s", " sudden-power-off");
+	MSG(0, "\n");
+}
+
 int sanity_check_raw_super(struct f2fs_super_block *raw_super)
 {
 	unsigned int blocksize;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
