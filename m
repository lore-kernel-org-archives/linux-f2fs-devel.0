From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: rearrange options to remove redundant check
Date: Wed,  3 Sep 2014 23:12:56 -0700
Message-ID: <1409811176-82299-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XPQI6-0007DZ-Vw
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 06:13:07 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XPQI5-0000KR-KJ for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 06:13:06 +0000
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

This patch summarizes the usage of options.

-a : auto_fix, fix corruption, only if f2fs reported some potential errors
-f : force,    fix corruption entire partition
None : prompt, if fsck.f2fs detets any corruption

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 18 +++++++++---------
 fsck/main.c       | 17 +++++++++--------
 fsck/mount.c      |  2 +-
 include/f2fs_fs.h |  1 -
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3fd9784..d0819c4 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -367,7 +367,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			if (find_and_dec_hard_link_list(sbi, nid)) {
 				ASSERT_MSG("[0x%x] needs more i_links=0x%x",
 						nid, i_links);
-				if (config.fix_cnt) {
+				if (config.fix_on) {
 					node_blk->i.i_links =
 						cpu_to_le32(i_links + 1);
 					need_fix = 1;
@@ -383,7 +383,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	if (fsck_chk_xattr_blk(sbi, nid,
 			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt) &&
-			config.fix_cnt) {
+			config.fix_on) {
 		node_blk->i.i_xattr_nid = 0;
 		need_fix = 1;
 		FIX_MSG("Remove xattr block: 0x%x, x_nid = 0x%x",
@@ -408,7 +408,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					ftype, nid, idx, ni->version);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
-			} else if (config.fix_cnt) {
+			} else if (config.fix_on) {
 				node_blk->i.i_addr[idx] = 0;
 				need_fix = 1;
 				FIX_MSG("[0x%x] i_addr[%d] = 0", nid, idx);
@@ -433,7 +433,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					ftype, ntype, blk_cnt);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
-			} else if (config.fix_cnt) {
+			} else if (config.fix_on) {
 				node_blk->i.i_nid[idx] = 0;
 				need_fix = 1;
 				FIX_MSG("[0x%x] i_nid[%d] = 0", nid, idx);
@@ -457,7 +457,7 @@ check:
 		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
 				"but has %u blocks",
 				nid, i_blocks, *blk_cnt);
-		if (config.fix_cnt) {
+		if (config.fix_on) {
 			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
 			need_fix = 1;
 			FIX_MSG("[0x%x] i_blocks=0x%08"PRIx64" -> 0x%x",
@@ -467,7 +467,7 @@ check:
 	if (ftype == F2FS_FT_DIR && i_links != child_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
 				nid, i_links, child_cnt);
-		if (config.fix_cnt) {
+		if (config.fix_on) {
 			node_blk->i.i_links = cpu_to_le32(child_cnt);
 			need_fix = 1;
 			FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
@@ -651,7 +651,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 				TYPE_INODE,
 				&blk_cnt);
 
-		if (ret && config.fix_cnt) {
+		if (ret && config.fix_on) {
 			int j;
 			int slots = (name_len + F2FS_SLOT_LEN - 1) /
 				F2FS_SLOT_LEN;
@@ -734,7 +734,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
 		return;
 
-	if (config.fix_cnt)
+	if (config.fix_on)
 		return;
 
 	start_blk = __start_cp_addr(sbi) + 1 +
@@ -983,7 +983,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	/* fix global metadata */
-	if (config.bug_on && config.fix_cnt) {
+	if (config.bug_on && config.fix_on) {
 		fix_nat_entries(sbi);
 		rewrite_sit_area_bitmap(sbi);
 		fix_checkpoint(sbi);
diff --git a/fsck/main.c b/fsck/main.c
index e20eac2..2af3daf 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -17,7 +17,10 @@ void fsck_usage()
 {
 	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
+	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
 	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -f check/fix entire partition\n");
+	MSG(0, "  -t show directory tree [-d -1]\n");
 	exit(1);
 }
 
@@ -214,24 +217,22 @@ fsck_again:
 	f2fs_do_umount(sbi);
 out:
 	if (config.func == FSCK && config.bug_on) {
-		if (config.fix_on == 0 && !config.auto_fix) {
+		if (config.fix_on == 0 && config.auto_fix == 0) {
 			char ans[255] = {0};
 retry:
 			printf("Do you want to fix this partition? [Y/N] ");
 			ret = scanf("%s", ans);
 			ASSERT(ret >= 0);
 			if (!strcasecmp(ans, "y"))
-				config.fix_cnt++;
+				config.fix_on = 1;
 			else if (!strcasecmp(ans, "n"))
-				config.fix_cnt = 0;
+				config.fix_on = 0;
 			else
 				goto retry;
-		} else {
-			config.fix_cnt++;
+
+			if (config.fix_on)
+				goto fsck_again;
 		}
-		/* avoid infinite trials */
-		if (config.fix_cnt > 0 && config.fix_cnt < 4)
-			goto fsck_again;
 	}
 	f2fs_finalize_device(&config);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 5a12bb1..415f977 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1213,7 +1213,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		u32 flag = le32_to_cpu(sbi->ckpt->ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG)
-			config.fix_cnt = 1;
+			config.fix_on = 1;
 		else
 			return 1;
 	}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6467791..6367e05 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -183,7 +183,6 @@ struct f2fs_configuration {
 	int func;
 	void *private;
 	int fix_on;
-	int fix_cnt;
 	int bug_on;
 	int auto_fix;
 } __attribute__((packed));
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
