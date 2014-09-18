From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: introduce a flag to represent each nat
	entry information
Date: Wed, 17 Sep 2014 22:51:06 -0700
Message-ID: <1411019468-2201-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XUUcj-0004d0-ST
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:51:21 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUUcg-0003IW-Vg for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:51:21 +0000
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

This patch introduces a flag in the nat entry structure to merge various
information such as checkpointed and fsync_done marks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 13 +++++++------
 fs/f2fs/node.h | 28 ++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b32eb56..d19d6b1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -131,7 +131,7 @@ int is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 
 	read_lock(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
-	if (e && !e->checkpointed)
+	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
 		is_cp = 0;
 	read_unlock(&nm_i->nat_tree_lock);
 	return is_cp;
@@ -146,7 +146,7 @@ bool fsync_mark_done(struct f2fs_sb_info *sbi, nid_t nid)
 	read_lock(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
 	if (e)
-		fsync_done = e->fsync_done;
+		fsync_done = get_nat_flag(e, HAS_FSYNC_MARK);
 	read_unlock(&nm_i->nat_tree_lock);
 	return fsync_done;
 }
@@ -159,7 +159,7 @@ void fsync_mark_clear(struct f2fs_sb_info *sbi, nid_t nid)
 	write_lock(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
 	if (e)
-		e->fsync_done = false;
+		set_nat_flag(e, HAS_FSYNC_MARK, false);
 	write_unlock(&nm_i->nat_tree_lock);
 }
 
@@ -176,7 +176,7 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
 	}
 	memset(new, 0, sizeof(struct nat_entry));
 	nat_set_nid(new, nid);
-	new->checkpointed = true;
+	set_nat_flag(new, IS_CHECKPOINTED, true);
 	list_add_tail(&new->list, &nm_i->nat_entries);
 	nm_i->nat_cnt++;
 	return new;
@@ -249,7 +249,7 @@ retry:
 	/* update fsync_mark if its inode nat entry is still alive */
 	e = __lookup_nat_cache(nm_i, ni->ino);
 	if (e)
-		e->fsync_done = fsync_done;
+		set_nat_flag(e, HAS_FSYNC_MARK, fsync_done);
 	write_unlock(&nm_i->nat_tree_lock);
 }
 
@@ -1349,7 +1349,8 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		read_lock(&nm_i->nat_tree_lock);
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (ne &&
-			(!ne->checkpointed || nat_get_blkaddr(ne) != NULL_ADDR))
+			(!get_nat_flag(ne, IS_CHECKPOINTED) ||
+				nat_get_blkaddr(ne) != NULL_ADDR))
 			allocated = true;
 		read_unlock(&nm_i->nat_tree_lock);
 		if (allocated)
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 324917d..3043778 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -39,10 +39,14 @@ struct node_info {
 	unsigned char version;	/* version of the node */
 };
 
+enum {
+	IS_CHECKPOINTED,	/* is it checkpointed before? */
+	HAS_FSYNC_MARK,		/* has the latest node fsync mark? */
+};
+
 struct nat_entry {
 	struct list_head list;	/* for clean or dirty nat list */
-	bool checkpointed;	/* whether it is checkpointed or not */
-	bool fsync_done;	/* whether the latest node has fsync mark */
+	unsigned char flag;	/* for node information bits */
 	struct node_info ni;	/* in-memory node information */
 };
 
@@ -57,16 +61,32 @@ struct nat_entry {
 
 #define __set_nat_cache_dirty(nm_i, ne)					\
 	do {								\
-		ne->checkpointed = false;				\
+		set_nat_flag(ne, IS_CHECKPOINTED, false);		\
 		list_move_tail(&ne->list, &nm_i->dirty_nat_entries);	\
 	} while (0)
 #define __clear_nat_cache_dirty(nm_i, ne)				\
 	do {								\
-		ne->checkpointed = true;				\
+		set_nat_flag(ne, IS_CHECKPOINTED, true);		\
 		list_move_tail(&ne->list, &nm_i->nat_entries);		\
 	} while (0)
 #define inc_node_version(version)	(++version)
 
+static inline void set_nat_flag(struct nat_entry *ne,
+				unsigned int type, bool set)
+{
+	unsigned char mask = 0x01 << type;
+	if (set)
+		ne->flag |= mask;
+	else
+		ne->flag &= ~mask;
+}
+
+static inline bool get_nat_flag(struct nat_entry *ne, unsigned int type)
+{
+	unsigned char mask = 0x01 << type;
+	return ne->flag & mask;
+}
+
 static inline void node_info_from_raw_nat(struct node_info *ni,
 						struct f2fs_nat_entry *raw_ne)
 {
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
