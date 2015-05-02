From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 14/19] f2fs: add need_dentry_mark
Date: Fri,  1 May 2015 17:48:41 -0700
Message-ID: <1430527726-68547-14-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLck-0003sE-QS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcj-0000pc-PP for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:42 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces need_dentry_mark() to clean up and avoid redundant
node locks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 35 +++++++++++++++++------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b8f99fd..9e43ddc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1565,6 +1565,7 @@ struct dnode_of_data;
 struct node_info;
 
 bool available_free_memory(struct f2fs_sb_info *, int);
+int need_dentry_mark(struct f2fs_sb_info *, nid_t);
 bool is_checkpointed_node(struct f2fs_sb_info *, nid_t);
 bool need_inode_block_update(struct f2fs_sb_info *, nid_t);
 void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 880d578..62982e6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -195,32 +195,35 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
+int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
-	bool is_cp = true;
+	bool need = false;
 
 	down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
-	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
-		is_cp = false;
+	if (e) {
+		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
+				!get_nat_flag(e, HAS_FSYNCED_INODE))
+			need = true;
+	}
 	up_read(&nm_i->nat_tree_lock);
-	return is_cp;
+	return need;
 }
 
-static bool has_fsynced_inode(struct f2fs_sb_info *sbi, nid_t ino)
+bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
-	bool fsynced = false;
+	bool is_cp = true;
 
 	down_read(&nm_i->nat_tree_lock);
-	e = __lookup_nat_cache(nm_i, ino);
-	if (e && get_nat_flag(e, HAS_FSYNCED_INODE))
-		fsynced = true;
+	e = __lookup_nat_cache(nm_i, nid);
+	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
+		is_cp = false;
 	up_read(&nm_i->nat_tree_lock);
-	return fsynced;
+	return is_cp;
 }
 
 bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
@@ -1206,13 +1209,9 @@ continue_unlock:
 			/* called by fsync() */
 			if (ino && IS_DNODE(page)) {
 				set_fsync_mark(page, 1);
-				if (IS_INODE(page)) {
-					if (!is_checkpointed_node(sbi, ino) &&
-						!has_fsynced_inode(sbi, ino))
-						set_dentry_mark(page, 1);
-					else
-						set_dentry_mark(page, 0);
-				}
+				if (IS_INODE(page))
+					set_dentry_mark(page,
+						need_dentry_mark(sbi, ino));
 				nwritten++;
 			} else {
 				set_fsync_mark(page, 0);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
