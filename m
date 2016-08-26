From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: do in batch synchronously readahead
	during GC
Date: Sat, 27 Aug 2016 00:14:31 +0800
Message-ID: <1472228072-4555-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bdJoH-0008RC-Je
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 16:16:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdJoF-0001sE-B0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 16:16:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In order to enhance performance, we try to readahead node page during
GC, but before loading node page we should get block address of node page
which is stored in NAT table, so synchronously read of single NAT page
block our readahead flow.

f2fs_submit_page_bio: dev = (251,0), ino = 2, page_index = 0xa1e, oldaddr = 0xa1e, newaddr = 0xa1e, rw = READ_SYNC(MP), type = META
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x35e9, oldaddr = 0x72d7a, newaddr = 0x72d7a, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 2, page_index = 0xc1f, oldaddr = 0xc1f, newaddr = 0xc1f, rw = READ_SYNC(MP), type = META
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x389d, oldaddr = 0x72d7d, newaddr = 0x72d7d, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x3a82, oldaddr = 0x72d7f, newaddr = 0x72d7f, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x3bfa, oldaddr = 0x72d86, newaddr = 0x72d86, rw = READAHEAD ^H, type = NODE

This patch adds one phase that do readahead NAT pages in batch before
readahead node page for more effeciently.

f2fs_submit_page_bio: dev = (251,0), ino = 2, page_index = 0x1952, oldaddr = 0x1952, newaddr = 0x1952, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc34, oldaddr = 0xc34, newaddr = 0xc34, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xa33, oldaddr = 0xa33, newaddr = 0xa33, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc30, oldaddr = 0xc30, newaddr = 0xc30, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc32, oldaddr = 0xc32, newaddr = 0xc32, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc26, oldaddr = 0xc26, newaddr = 0xc26, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xa2b, oldaddr = 0xa2b, newaddr = 0xa2b, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc23, oldaddr = 0xc23, newaddr = 0xc23, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc24, oldaddr = 0xc24, newaddr = 0xc24, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xa10, oldaddr = 0xa10, newaddr = 0xa10, rw = READ_SYNC(MP), type = META
f2fs_submit_page_mbio: dev = (251,0), ino = 2, page_index = 0xc2c, oldaddr = 0xc2c, newaddr = 0xc2c, rw = READ_SYNC(MP), type = META
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5db7, oldaddr = 0x6be00, newaddr = 0x6be00, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5db9, oldaddr = 0x6be17, newaddr = 0x6be17, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5dbc, oldaddr = 0x6be1a, newaddr = 0x6be1a, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5dc3, oldaddr = 0x6be20, newaddr = 0x6be20, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5dc7, oldaddr = 0x6be24, newaddr = 0x6be24, rw = READAHEAD ^H, type = NODE
f2fs_submit_page_bio: dev = (251,0), ino = 1, page_index = 0x5dc9, oldaddr = 0x6be25, newaddr = 0x6be25, rw = READAHEAD ^H, type = NODE

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c1599b4..cdc44a6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -423,10 +423,10 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
 static void gc_node_segment(struct f2fs_sb_info *sbi,
 		struct f2fs_summary *sum, unsigned int segno, int gc_type)
 {
-	bool initial = true;
 	struct f2fs_summary *entry;
 	block_t start_addr;
 	int off;
+	int phase = 0;
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -445,10 +445,18 @@ next_step:
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
 
-		if (initial) {
+		if (phase == 0) {
+			ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+							META_NAT, true);
+			continue;
+		}
+
+		if (phase == 1) {
 			ra_node_page(sbi, nid);
 			continue;
 		}
+
+		/* phase == 2 */
 		node_page = get_node_page(sbi, nid);
 		if (IS_ERR(node_page))
 			continue;
@@ -469,10 +477,8 @@ next_step:
 		stat_inc_node_blk_count(sbi, 1, gc_type);
 	}
 
-	if (initial) {
-		initial = false;
+	if (++phase < 3)
 		goto next_step;
-	}
 }
 
 /*
@@ -706,6 +712,7 @@ next_step:
 		struct node_info dni; /* dnode info for the data */
 		unsigned int ofs_in_node, nofs;
 		block_t start_bidx;
+		nid_t nid = le32_to_cpu(entry->nid);
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
@@ -715,7 +722,13 @@ next_step:
 			continue;
 
 		if (phase == 0) {
-			ra_node_page(sbi, le32_to_cpu(entry->nid));
+			ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+							META_NAT, true);
+			continue;
+		}
+
+		if (phase == 1) {
+			ra_node_page(sbi, nid);
 			continue;
 		}
 
@@ -723,14 +736,14 @@ next_step:
 		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
 			continue;
 
-		if (phase == 1) {
+		if (phase == 2) {
 			ra_node_page(sbi, dni.ino);
 			continue;
 		}
 
 		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
 
-		if (phase == 2) {
+		if (phase == 3) {
 			inode = f2fs_iget(sb, dni.ino);
 			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
@@ -756,7 +769,7 @@ next_step:
 			continue;
 		}
 
-		/* phase 3 */
+		/* phase 4 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
 			struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -789,7 +802,7 @@ next_step:
 		}
 	}
 
-	if (++phase < 4)
+	if (++phase < 5)
 		goto next_step;
 }
 
-- 
2.7.2


------------------------------------------------------------------------------
