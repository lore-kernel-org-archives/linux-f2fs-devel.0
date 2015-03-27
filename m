From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] fsck.f2fs: fix inodes having wrong i_links
Date: Thu, 26 Mar 2015 17:03:07 -0700
Message-ID: <1427414589-66956-4-git-send-email-jaegeuk@kernel.org>
References: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkG-00067g-5q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHkF-0007cU-8W for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:28 +0000
In-Reply-To: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes inodes which have wrong i_links.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fsck/fsck.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8db8f27..8cfea56 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -63,6 +63,7 @@ static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
 
 	node->nid = nid;
 	node->links = link_cnt;
+	node->actual_links = 1;
 	node->next = NULL;
 
 	if (fsck->hard_link_list_head == NULL) {
@@ -112,6 +113,7 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 
 	/* Decrease link count */
 	node->links = node->links - 1;
+	node->actual_links++;
 
 	/* if link count becomes one, remove the node */
 	if (node->links == 1) {
@@ -296,6 +298,10 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
+	/* this if only from fix_hard_links */
+	if (ftype == F2FS_FT_MAX)
+		return 0;
+
 	if (ntype == TYPE_INODE &&
 		__check_inode_mode(nid, ftype, le32_to_cpu(node_blk->i.i_mode)))
 		return -EINVAL;
@@ -999,6 +1005,40 @@ void fsck_init(struct f2fs_sb_info *sbi)
 	ASSERT(tree_mark != NULL);
 }
 
+static void fix_hard_links(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct hard_link_node *tmp, *node;
+	struct f2fs_node *node_blk = NULL;
+	struct node_info ni;
+	int ret;
+
+	if (fsck->hard_link_list_head == NULL)
+		return;
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	node = fsck->hard_link_list_head;
+	while (node) {
+		/* Sanity check */
+		if (sanity_check_nid(sbi, node->nid, node_blk,
+					F2FS_FT_MAX, TYPE_INODE, &ni, NULL))
+			FIX_MSG("Failed to fix, rerun fsck.f2fs");
+
+		node_blk->i.i_links = cpu_to_le32(node->actual_links);
+
+		FIX_MSG("File: 0x%x i_links= 0x%x -> 0x%x",
+				node->nid, node->links, node->actual_links);
+
+		ret = dev_write_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+		tmp = node;
+		node = node->next;
+		free(tmp);
+	}
+}
+
 static void fix_nat_entries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -1223,6 +1263,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 
 	/* fix global metadata */
 	if (force || (config.bug_on && config.fix_on)) {
+		fix_hard_links(sbi);
 		fix_nat_entries(sbi);
 		rewrite_sit_area_bitmap(sbi);
 		fix_checkpoint(sbi);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index ff2b25d..1c2ef94 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -67,6 +67,7 @@ enum NODE_TYPE {
 struct hard_link_node {
 	u32 nid;
 	u32 links;
+	u32 actual_links;
 	struct hard_link_node *next;
 };
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
