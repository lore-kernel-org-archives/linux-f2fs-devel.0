From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/17] fsck.f2fs: remove return value of
	get_node_info
Date: Fri, 29 Aug 2014 17:28:52 -0700
Message-ID: <1409358544-54740-5-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWXz-00055z-Do
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:39 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWXy-0004e3-Fl for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:39 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

We don't need to get the return value.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c  | 23 +++++++++--------------
 fsck/fsck.c  |  5 ++---
 fsck/fsck.h  |  4 ++--
 fsck/mount.c | 23 +++++++----------------
 4 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index e14a190..54f9a52 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -140,8 +140,8 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk;
-	int i, ret;
 	u32 idx, skip = 0;
+	int i;
 
 	switch (ntype) {
 	case TYPE_DIRECT_NODE:
@@ -162,8 +162,7 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 		return;
 	}
 
-	ret = get_node_info(sbi, nid, &ni);
-	ASSERT(ret >= 0);
+	get_node_info(sbi, nid, &ni);
 
 	node_blk = calloc(BLOCK_SZ, 1);
 	dev_read_block(node_blk, ni.blk_addr);
@@ -267,14 +266,12 @@ void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 	}
 }
 
-int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
+void dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk;
-	int ret;
 
-	ret = get_node_info(sbi, nid, &ni);
-	ASSERT(ret >= 0);
+	get_node_info(sbi, nid, &ni);
 
 	node_blk = calloc(BLOCK_SZ, 1);
 	dev_read_block(node_blk, ni.blk_addr);
@@ -284,9 +281,8 @@ int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	DBG(1, "nat_entry.version     [0x%x]\n", ni.version);
 	DBG(1, "nat_entry.ino         [0x%x]\n", ni.ino);
 
-	if (ni.blk_addr == 0x0) {
+	if (ni.blk_addr == 0x0)
 		MSG(0, "Invalid nat entry\n\n");
-	}
 
 	DBG(1, "node_blk.footer.ino [0x%x]\n", le32_to_cpu(node_blk->footer.ino));
 	DBG(1, "node_blk.footer.nid [0x%x]\n", le32_to_cpu(node_blk->footer.nid));
@@ -300,7 +296,6 @@ int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	}
 
 	free(node_blk);
-	return 0;
 }
 
 int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
@@ -314,8 +309,7 @@ int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	type = get_sum_entry(sbi, blk_addr, &sum_entry);
 	nid = le32_to_cpu(sum_entry.nid);
 
-	ret = get_node_info(sbi, nid, &ni);
-	ASSERT(ret >= 0);
+	get_node_info(sbi, nid, &ni);
 
 	DBG(1, "Note: blkaddr = main_blkaddr + segno * 512 + offset\n");
 	DBG(1, "Block_addr            [0x%x]\n", blk_addr);
@@ -331,7 +325,8 @@ int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	node_blk = calloc(BLOCK_SZ, 1);
 
 read_node_blk:
-	dev_read_block(node_blk, blk_addr);
+	ret = dev_read_block(node_blk, blk_addr);
+	ASSERT(ret >= 0);
 
 	ino = le32_to_cpu(node_blk->footer.ino);
 	nid = le32_to_cpu(node_blk->footer.nid);
@@ -339,7 +334,7 @@ read_node_blk:
 	if (ino == nid) {
 		print_node_info(node_blk);
 	} else {
-		ret = get_node_info(sbi, ino, &ni);
+		get_node_info(sbi, ino, &ni);
 		goto read_node_blk;
 	}
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 5eab522..d2781d9 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -200,8 +200,7 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 	else
 		ASSERT_MSG("nid duplicated [0x%x]\n", nid);
 
-	ret = get_node_info(sbi, nid, &ni);
-	ASSERT(ret >= 0);
+	get_node_info(sbi, nid, &ni);
 
 	/* Is it reserved block?
 	 * if block addresss was 0xffff,ffff,ffff,ffff
@@ -682,7 +681,7 @@ int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 	fsck->chk.valid_blk_cnt++;
 	fsck->chk.valid_node_cnt++;
 
-	ASSERT(get_node_info(sbi, x_nid, &ni) >= 0);
+	get_node_info(sbi, x_nid, &ni);
 
 	if (f2fs_test_main_bitmap(sbi, ni.blk_addr) != 0) {
 		ASSERT_MSG("Duplicated node block for x_attr. "
diff --git a/fsck/fsck.h b/fsck/fsck.h
index dcb6656..b673646 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -99,7 +99,7 @@ extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
 extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
 				struct f2fs_summary_block *);
 extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
-extern int get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
+extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 extern void build_nat_area_bitmap(struct f2fs_sb_info *);
 extern int build_sit_area_bitmap(struct f2fs_sb_info *);
 extern int fsck_init(struct f2fs_sb_info *);
@@ -120,7 +120,7 @@ struct dump_option {
 
 extern void sit_dump(struct f2fs_sb_info *, int, int);
 extern void ssa_dump(struct f2fs_sb_info *, int, int);
-extern int dump_node(struct f2fs_sb_info *, nid_t);
+extern void dump_node(struct f2fs_sb_info *, nid_t);
 extern int dump_inode_from_blkaddr(struct f2fs_sb_info *, u32);
 
 #endif /* _FSCK_H_ */
diff --git a/fsck/mount.c b/fsck/mount.c
index 7ea3296..ab5f7f3 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -801,9 +801,9 @@ int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *s
 	return ret;
 }
 
-int get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid, struct f2fs_nat_entry *raw_nat)
+static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
+				struct f2fs_nat_entry *raw_nat)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	pgoff_t block_off;
@@ -811,13 +811,8 @@ int get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid, struct f2fs_nat_entry *ra
 	int seg_off, entry_off;
 	int ret;
 
-	if ((nid / NAT_ENTRY_PER_BLOCK) > fsck->nr_nat_entries) {
-		DBG(0, "nid is over max nid\n");
-		return -EINVAL;
-	}
-
 	if (lookup_nat_in_journal(sbi, nid, raw_nat) >= 0)
-		return 0;
+		return;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
@@ -835,21 +830,17 @@ int get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid, struct f2fs_nat_entry *ra
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
 
-	memcpy(raw_nat, &nat_block->entries[entry_off], sizeof(struct f2fs_nat_entry));
+	memcpy(raw_nat, &nat_block->entries[entry_off],
+					sizeof(struct f2fs_nat_entry));
 	free(nat_block);
-
-	return 0;
 }
 
-int get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
+void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 {
 	struct f2fs_nat_entry raw_nat;
-	int ret;
-
-	ret = get_nat_entry(sbi, nid, &raw_nat);
+	get_nat_entry(sbi, nid, &raw_nat);
 	ni->nid = nid;
 	node_info_from_raw_nat(ni, &raw_nat);
-	return ret;
 }
 
 void build_sit_entries(struct f2fs_sb_info *sbi)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
