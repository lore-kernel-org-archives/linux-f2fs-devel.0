From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: introduce get_next_page_offset to
	speed up SEEK_DATA
Date: Tue, 26 Jan 2016 15:40:44 +0800
Message-ID: <009501d1580d$050f8f60$0f2eae20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aNyGH-00031G-JT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:42:01 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aNyGF-000888-Ub
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:42:01 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1J02Z5WUPSNC50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 16:41:52 +0900 (KST)
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

When seeking data in ->llseek, if we encounter a big hole which covers
several dnode pages, we will try to seek data from index of page which
is the first page of next dnode page, at most we could skip searching
(ADDRS_PER_BLOCK - 1) pages.

However it's still not efficient, because if our indirect/double-indirect
pointer are NULL, there are no dnode page locate in the tree indirect/
double-indirect pointer point to, it's not necessary to search the whole
region.

This patch introduces get_next_page_offset to calculate next page offset
based on current searching level and max searching level returned from
get_dnode_of_data, with this, we could skip searching the entire area
indirect or double-indirect node block is not exist.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |  3 +++
 fs/f2fs/file.c |  2 +-
 fs/f2fs/node.c | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4bcc512..3e1ba0a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -552,6 +552,8 @@ struct dnode_of_data {
 	unsigned int ofs_in_node;	/* data offset in the node page */
 	bool inode_page_locked;		/* inode page is locked or not */
 	bool node_changed;		/* is node block changed */
+	char cur_level;			/* level of hole node page */
+	char max_level;			/* level of current page located */
 	block_t	data_blkaddr;		/* block address of the node block */
 };
 
@@ -1783,6 +1785,7 @@ int need_dentry_mark(struct f2fs_sb_info *, nid_t);
 bool is_checkpointed_node(struct f2fs_sb_info *, nid_t);
 bool need_inode_block_update(struct f2fs_sb_info *, nid_t);
 void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
+pgoff_t get_next_page_offset(struct dnode_of_data *, pgoff_t);
 int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
 int truncate_xattr_node(struct inode *, struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2b14e3..2d73f14 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -358,7 +358,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 		} else if (err == -ENOENT) {
 			/* direct node does not exists */
 			if (whence == SEEK_DATA) {
-				pgofs = PGOFS_OF_NEXT_DNODE(pgofs, inode);
+				pgofs = get_next_page_offset(&dn, pgofs);
 				continue;
 			} else {
 				goto found;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 97a4695..77a35f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -403,6 +403,37 @@ cache:
 	up_write(&nm_i->nat_tree_lock);
 }
 
+pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
+{
+	const long direct_index = ADDRS_PER_INODE(dn->inode);
+	const long direct_blks = ADDRS_PER_BLOCK;
+	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
+	unsigned int skipped_unit = ADDRS_PER_BLOCK;
+	int cur_level = dn->cur_level;
+	int max_level = dn->max_level;
+	pgoff_t base = 0;
+
+	if (!dn->max_level)
+		return pgofs + 1;
+
+	while (max_level-- > cur_level)
+		skipped_unit *= NIDS_PER_BLOCK;
+
+	switch (dn->max_level) {
+	case 3:
+		base += 2 * indirect_blks;
+	case 2:
+		base += 2 * direct_blks;
+	case 1:
+		base += direct_index;
+		break;
+	default:
+		f2fs_bug_on(F2FS_I_SB(dn->inode), 1);
+	}
+
+	return ((pgofs - base) / skipped_unit + 1) * skipped_unit + base;
+}
+
 /*
  * The maximum depth is four.
  * Offset[0] will have raw inode offset.
@@ -495,7 +526,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	int offset[4];
 	unsigned int noffset[4];
 	nid_t nids[4];
-	int level, i;
+	int level, i = 0;
 	int err = 0;
 
 	level = get_node_path(dn->inode, index, offset, noffset);
@@ -585,6 +616,10 @@ release_pages:
 release_out:
 	dn->inode_page = NULL;
 	dn->node_page = NULL;
+	if (err == -ENOENT) {
+		dn->cur_level = i;
+		dn->max_level = level;
+	}
 	return err;
 }
 
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
