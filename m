From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: check the largest extent at look-up
	time
Date: Tue, 30 Jun 2015 18:25:45 -0700
Message-ID: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZA6mk-0002nW-9y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:25:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZA6mj-0003PG-Bi for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:25:58 +0000
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

Because of the extent shrinker or other -ENOMEM scenarios, it cannot guarantee
that the largest extent would be cached in the tree all the time.

Instead of relying on extent_tree, we can simply check the cached one in extent
tree accordingly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              | 16 ++++++++++++++--
 include/trace/events/f2fs.h | 12 ++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b6c28bb..8f059e0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -511,12 +511,22 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	struct extent_node *en;
+	bool ret = false;
 
 	f2fs_bug_on(sbi, !et);
 
 	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
 
 	read_lock(&et->lock);
+
+	if (et->largest.fofs <= pgofs &&
+			et->largest.fofs + et->largest.len > pgofs) {
+		*ei = et->largest;
+		ret = true;
+		stat_inc_read_hit(sbi->sb);
+		goto out;
+	}
+
 	en = __lookup_extent_tree(et, pgofs);
 	if (en) {
 		*ei = en->ei;
@@ -525,13 +535,15 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 			list_move_tail(&en->list, &sbi->extent_list);
 		et->cached_en = en;
 		spin_unlock(&sbi->extent_lock);
+		ret = true;
 		stat_inc_read_hit(sbi->sb);
 	}
+out:
 	stat_inc_total_hit(sbi->sb);
 	read_unlock(&et->lock);
 
-	trace_f2fs_lookup_extent_tree_end(inode, pgofs, en);
-	return en ? true : false;
+	trace_f2fs_lookup_extent_tree_end(inode, pgofs, ei);
+	return ret;
 }
 
 /* return true, if on-disk extent should be updated */
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 04856a2..a019465 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1099,11 +1099,11 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 
 	TP_PROTO(struct inode *inode, unsigned int pgofs,
-						struct extent_node *en),
+						struct extent_info *ei),
 
-	TP_ARGS(inode, pgofs, en),
+	TP_ARGS(inode, pgofs, ei),
 
-	TP_CONDITION(en),
+	TP_CONDITION(ei),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -1118,9 +1118,9 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
-		__entry->fofs = en->ei.fofs;
-		__entry->blk = en->ei.blk;
-		__entry->len = en->ei.len;
+		__entry->fofs = ei->fofs;
+		__entry->blk = ei->blk;
+		__entry->len = ei->len;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, pgofs = %u, "
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
