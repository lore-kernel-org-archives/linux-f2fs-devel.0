From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] fsck.f2fs: support restore lost files into
	./lost_found/
Date: Thu, 13 Oct 2016 17:02:30 -0700
Message-ID: <20161014000230.59232-5-jaegeuk@kernel.org>
References: <20161014000230.59232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bupxl-0005el-Rv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:03:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bupxk-0001fb-QO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:03:01 +0000
In-Reply-To: <20161014000230.59232-1-jaegeuk@kernel.org>
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

This patch adds to support restoring lost files into ./lost_found/.

For example,

 # fsck.f2fs /dev/sdXX

...
NID[0x87d7] is unreachable
NID[0x87d8] is unreachable
NID[0x87d9] is unreachable
[FSCK] Unreachable nat entries                        [Fail] [0x4988]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Fail] [0x2]
[FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x1]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x4989]
[FSCK] valid_inode_count matched with CP              [Fail] [0x1]
[FSCK] free segment_count matched with CP             [Ok..] [0x1f7]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

Do you want to restore lost files into ./lost_found/? [Y/N] y

Then, you can restore unreachable files from ./lost_found/ in its best effort.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c  | 41 +++++++++++++++++++++++------------------
 fsck/fsck.c  | 15 +++++++++++++++
 fsck/fsck.h  |  4 ++--
 fsck/main.c  |  2 +-
 fsck/mount.c | 11 ++++++-----
 5 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index c048429..befffd7 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -239,7 +239,7 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 	close(fd);
 }
 
-static void dump_data_blk(__u64 offset, u32 blkaddr)
+static void dump_data_blk(struct f2fs_sb_info *sbi, __u64 offset, u32 blkaddr)
 {
 	char buf[F2FS_BLKSIZE];
 
@@ -247,7 +247,7 @@ static void dump_data_blk(__u64 offset, u32 blkaddr)
 		return;
 
 	/* get data */
-	if (blkaddr == NEW_ADDR) {
+	if (blkaddr == NEW_ADDR || !IS_VALID_BLK_ADDR(sbi, blkaddr)) {
 		memset(buf, 0, F2FS_BLKSIZE);
 	} else {
 		int ret;
@@ -294,7 +294,7 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 	for (i = 0; i < idx; i++, (*ofs)++) {
 		switch (ntype) {
 		case TYPE_DIRECT_NODE:
-			dump_data_blk(*ofs * F2FS_BLKSIZE,
+			dump_data_blk(sbi, *ofs * F2FS_BLKSIZE,
 					le32_to_cpu(node_blk->dn.addr[i]));
 			break;
 		case TYPE_INDIRECT_NODE:
@@ -328,7 +328,7 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	/* check data blocks in inode */
 	for (i = 0; i < ADDRS_PER_INODE(&node_blk->i); i++, ofs++)
-		dump_data_blk(ofs * F2FS_BLKSIZE,
+		dump_data_blk(sbi, ofs * F2FS_BLKSIZE,
 				le32_to_cpu(node_blk->i.i_addr[i]));
 
 	/* check node blocks in inode */
@@ -347,33 +347,36 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	}
 }
 
-void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
-					struct f2fs_node *node_blk)
+static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
+				struct f2fs_node *node_blk, int force)
 {
 	struct f2fs_inode *inode = &node_blk->i;
 	u32 imode = le32_to_cpu(inode->i_mode);
+	u32 namelen = le32_to_cpu(inode->i_namelen);
 	char name[255] = {0};
 	char path[1024] = {0};
 	char ans[255] = {0};
 	int ret;
 
-	if (!S_ISREG(imode)) {
-		MSG(0, "Not a regular file\n\n");
+	if (!S_ISREG(imode) || namelen == 0 || namelen > F2FS_NAME_LEN) {
+		MSG(force, "Not a regular file or wrong name info\n\n");
 		return;
 	}
+	if (force)
+		goto dump;
 
 	printf("Do you want to dump this file into ./lost_found/? [Y/N] ");
 	ret = scanf("%s", ans);
 	ASSERT(ret >= 0);
 
 	if (!strcasecmp(ans, "y")) {
+dump:
 		ret = system("mkdir -p ./lost_found");
 		ASSERT(ret >= 0);
 
 		/* make a file */
-		strncpy(name, (const char *)inode->i_name,
-					le32_to_cpu(inode->i_namelen));
-		name[le32_to_cpu(inode->i_namelen)] = 0;
+		strncpy(name, (const char *)inode->i_name, namelen);
+		name[namelen] = 0;
 		sprintf(path, "./lost_found/%s", name);
 
 		c.dump_fd = open(path, O_TRUNC|O_CREAT|O_RDWR, 0666);
@@ -390,7 +393,7 @@ void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 	}
 }
 
-void dump_node(struct f2fs_sb_info *sbi, nid_t nid)
+void dump_node(struct f2fs_sb_info *sbi, nid_t nid, int force)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk;
@@ -406,17 +409,19 @@ void dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	DBG(1, "nat_entry.ino         [0x%x]\n", ni.ino);
 
 	if (ni.blk_addr == 0x0)
-		MSG(0, "Invalid nat entry\n\n");
+		MSG(force, "Invalid nat entry\n\n");
 
 	DBG(1, "node_blk.footer.ino [0x%x]\n", le32_to_cpu(node_blk->footer.ino));
 	DBG(1, "node_blk.footer.nid [0x%x]\n", le32_to_cpu(node_blk->footer.nid));
 
 	if (le32_to_cpu(node_blk->footer.ino) == ni.ino &&
-			le32_to_cpu(node_blk->footer.nid) == ni.nid) {
-		print_node_info(node_blk);
-		dump_file(sbi, &ni, node_blk);
+			le32_to_cpu(node_blk->footer.nid) == ni.nid &&
+			ni.ino == ni.nid) {
+		print_node_info(node_blk, force);
+		dump_file(sbi, &ni, node_blk, force);
 	} else {
-		MSG(0, "Invalid node block\n\n");
+		print_node_info(node_blk, force);
+		MSG(force, "Invalid (i)node block\n\n");
 	}
 
 	free(node_blk);
@@ -434,7 +439,7 @@ static void dump_node_from_blkaddr(u32 blk_addr)
 	ASSERT(ret >= 0);
 
 	if (c.dbg_lv > 0)
-		print_node_info(node_blk);
+		print_node_info(node_blk, 0);
 	else
 		print_inode_info(&node_blk->i, 1);
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 636477d..7dd311f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1939,6 +1939,21 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		ret = EXIT_ERR_CODE;
 	}
 
+#ifndef WITH_ANDROID
+	if (nr_unref_nid && !c.ro) {
+		char ans[255] = {0};
+
+		printf("\nDo you want to restore lost files into ./lost_found/? [Y/N] ");
+		ret = scanf("%s", ans);
+		ASSERT(ret >= 0);
+		if (!strcasecmp(ans, "y")) {
+			for (i = 0; i < fsck->nr_nat_entries; i++) {
+				if (f2fs_test_bit(i, fsck->nat_area_bitmap))
+					dump_node(sbi, i, 1);
+			}
+		}
+	}
+#endif
 	/* fix global metadata */
 	if (force || (c.fix_on && !c.ro)) {
 		struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index a86a30f..438d29b 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -133,7 +133,7 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi);
 
 extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
-extern void print_node_info(struct f2fs_node *);
+extern void print_node_info(struct f2fs_node *, int);
 extern void print_inode_info(struct f2fs_inode *, int);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
 extern struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *,
@@ -179,7 +179,7 @@ struct dump_option {
 extern void nat_dump(struct f2fs_sb_info *);
 extern void sit_dump(struct f2fs_sb_info *, unsigned int, unsigned int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
-extern void dump_node(struct f2fs_sb_info *, nid_t);
+extern void dump_node(struct f2fs_sb_info *, nid_t, int);
 extern int dump_info_from_blkaddr(struct f2fs_sb_info *, u32);
 
 /* defrag.c */
diff --git a/fsck/main.c b/fsck/main.c
index 8acc970..7e8fdf3 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -376,7 +376,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
 	if (opt->blk_addr != -1)
 		dump_info_from_blkaddr(sbi, opt->blk_addr);
 	if (opt->nid)
-		dump_node(sbi, opt->nid);
+		dump_node(sbi, opt->nid, 0);
 
 	print_cp_state(flag);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 1550f45..f343718 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -105,21 +105,22 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	printf("\n");
 }
 
-void print_node_info(struct f2fs_node *node_block)
+void print_node_info(struct f2fs_node *node_block, int verbose)
 {
 	nid_t ino = le32_to_cpu(node_block->footer.ino);
 	nid_t nid = le32_to_cpu(node_block->footer.nid);
 	/* Is this inode? */
 	if (ino == nid) {
-		DBG(0, "Node ID [0x%x:%u] is inode\n", nid, nid);
-		print_inode_info(&node_block->i, 0);
+		DBG(verbose, "Node ID [0x%x:%u] is inode\n", nid, nid);
+		print_inode_info(&node_block->i, verbose);
 	} else {
 		int i;
 		u32 *dump_blk = (u32 *)node_block;
-		DBG(0, "Node ID [0x%x:%u] is direct node or indirect node.\n",
+		DBG(verbose,
+			"Node ID [0x%x:%u] is direct node or indirect node.\n",
 								nid, nid);
 		for (i = 0; i <= 10; i++)
-			MSG(0, "[%d]\t\t\t[0x%8x : %d]\n",
+			MSG(verbose, "[%d]\t\t\t[0x%8x : %d]\n",
 						i, dump_blk[i], dump_blk[i]);
 	}
 }
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
