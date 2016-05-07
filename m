From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: read node blocks ahead when truncating
	blocks
Date: Sat,  7 May 2016 10:45:18 -0700
Message-ID: <1462643119-96530-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1az6IC-0002RH-W9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:45:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1az6IB-0005oQ-VF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:45:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch enables reading node blocks in advance when truncating large
data blocks.

 > time rm $MNT/testfile (500GB) after drop_cachees
Before : 9.422 s
After  : 4.821 s

Reported-by: Stephen Bates <stephen.bates@microsemi.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c |  2 +-
 fs/f2fs/node.c | 52 ++++++++++++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fb8cc27..3146129 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -584,7 +584,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
-	err = get_dnode_of_data(&dn, free_from, LOOKUP_NODE);
+	err = get_dnode_of_data(&dn, free_from, LOOKUP_NODE_RA);
 	if (err) {
 		if (err == -ENOENT)
 			goto free_next;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 264abe0..cda7c7c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -407,6 +407,29 @@ cache:
 	up_write(&nm_i->nat_tree_lock);
 }
 
+/*
+ * readahead MAX_RA_NODE number of node pages.
+ */
+static void ra_node_pages(struct page *parent, int start, int n)
+{
+	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
+	struct blk_plug plug;
+	int i, end;
+	nid_t nid;
+
+	blk_start_plug(&plug);
+
+	/* Then, try readahead for siblings of the desired node */
+	end = start + n;
+	end = min(end, NIDS_PER_BLOCK);
+	for (i = start; i < end; i++) {
+		nid = get_nid(parent, i, false);
+		ra_node_page(sbi, nid);
+	}
+
+	blk_finish_plug(&plug);
+}
+
 pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
 {
 	const long direct_index = ADDRS_PER_INODE(dn->inode);
@@ -707,6 +730,8 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 		return PTR_ERR(page);
 	}
 
+	ra_node_pages(page, ofs, NIDS_PER_BLOCK);
+
 	rn = F2FS_NODE(page);
 	if (depth < 3) {
 		for (i = ofs; i < NIDS_PER_BLOCK; i++, freed++) {
@@ -784,6 +809,8 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		nid[i + 1] = get_nid(pages[i], offset[i + 1], false);
 	}
 
+	ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK);
+
 	/* free direct nodes linked to a partial indirect node */
 	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
 		child_nid = get_nid(pages[idx], i, false);
@@ -1095,29 +1122,6 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_put_page(apage, err ? 1 : 0);
 }
 
-/*
- * readahead MAX_RA_NODE number of node pages.
- */
-static void ra_node_pages(struct page *parent, int start)
-{
-	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
-	struct blk_plug plug;
-	int i, end;
-	nid_t nid;
-
-	blk_start_plug(&plug);
-
-	/* Then, try readahead for siblings of the desired node */
-	end = start + MAX_RA_NODE;
-	end = min(end, NIDS_PER_BLOCK);
-	for (i = start; i < end; i++) {
-		nid = get_nid(parent, i, false);
-		ra_node_page(sbi, nid);
-	}
-
-	blk_finish_plug(&plug);
-}
-
 static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
@@ -1141,7 +1145,7 @@ repeat:
 	}
 
 	if (parent)
-		ra_node_pages(parent, start + 1);
+		ra_node_pages(parent, start + 1, MAX_RA_NODE);
 
 	lock_page(page);
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
