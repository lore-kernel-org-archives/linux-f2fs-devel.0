From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to handle do_recover_data errors
Date: Wed, 22 May 2013 09:13:32 +0900
Message-ID: <1369181612-15777-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1369181612-15777-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uewhh-0003sp-SD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 00:14:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uewhh-00080p-06 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 00:14:53 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN6008EFBC206J0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 09:14:44 +0900 (KST)
In-reply-to: <1369181612-15777-1-git-send-email-jaegeuk.kim@samsung.com>
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

This patch adds error handling codes of check_index_in_prev_nodes and its
caller, do_recover_data.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index eceb665..dcd8e86 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -188,7 +188,7 @@ static void destroy_fsync_dnodes(struct f2fs_sb_info *sbi,
 	}
 }
 
-static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
+static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 			block_t blkaddr, struct dnode_of_data *dn)
 {
 	struct seg_entry *sentry;
@@ -205,7 +205,7 @@ static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 
 	sentry = get_seg_entry(sbi, segno);
 	if (!f2fs_test_bit(blkoff, sentry->cur_valid_map))
-		return;
+		return 0;
 
 	/* Get the previous summary */
 	for (i = CURSEG_WARM_DATA; i <= CURSEG_COLD_DATA; i++) {
@@ -232,16 +232,18 @@ static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		tdn.node_page = dn->inode_page;
 		tdn.ofs_in_node = sum.ofs_in_node;
 		truncate_data_blocks_range(&tdn, 1);
-		return;
+		return 0;
 	} else if (dn->nid == nid) {
 		struct dnode_of_data tdn = *dn;
 		tdn.ofs_in_node = sum.ofs_in_node;
 		truncate_data_blocks_range(&tdn, 1);
-		return;
+		return 0;
 	}
 
 	/* Get the node page */
 	node_page = get_node_page(sbi, nid);
+	if (IS_ERR(node_page))
+		return PTR_ERR(node_page);
 	bidx = start_bidx_of_node(ofs_of_node(node_page)) +
 					le16_to_cpu(sum.ofs_in_node);
 	ino = ino_of_node(node_page);
@@ -250,10 +252,11 @@ static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	/* Deallocate previous index in the node page */
 	inode = f2fs_iget(sbi->sb, ino);
 	if (IS_ERR(inode))
-		return;
+		return PTR_ERR(inode);
 
 	truncate_hole(inode, bidx, bidx + 1);
 	iput(inode);
+	return 0;
 }
 
 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
@@ -301,7 +304,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			}
 
 			/* Check the previous node page having this index */
-			check_index_in_prev_nodes(sbi, dest, &dn);
+			err = check_index_in_prev_nodes(sbi, dest, &dn);
+			if (err)
+				goto err;
 
 			set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
@@ -324,13 +329,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	set_page_dirty(dn.node_page);
 
 	recover_node_page(sbi, dn.node_page, &sum, &ni, blkaddr);
+err:
 	f2fs_put_dnode(&dn);
 	mutex_unlock_op(sbi, ilock);
 
 	f2fs_msg(sbi->sb, KERN_NOTICE, "recover_data: ino = %lx, "
-			"recovered_data = %d blocks",
-			inode->i_ino, recovered);
-	return 0;
+			"recovered_data = %d blocks, err = %d",
+			inode->i_ino, recovered, err);
+	return err;
 }
 
 static int recover_data(struct f2fs_sb_info *sbi,
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
