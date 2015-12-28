From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: load largest extent all the time
Date: Mon, 28 Dec 2015 15:31:37 -0800
Message-ID: <1451345497-65784-3-git-send-email-jaegeuk@kernel.org>
References: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aDhGW-0000ko-BP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:31:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aDhGV-00043H-EB for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:31:48 +0000
In-Reply-To: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
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

Otherwise, we can get mismatched largest extent information.

One example is:
1. mount f2fs w/ extent_cache
2. make a small extent
3. umount
4. mount f2fs w/o extent_cache
5. update the largest extent
6. umount
7. mount f2fs w/ extent_cache
8. get the old extent made by #2

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 18 +++++++++++++-----
 fs/f2fs/f2fs.h         |  2 +-
 fs/f2fs/inode.c        |  3 ++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index e7b6548..23e7c82 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -166,20 +166,27 @@ static void __drop_largest_extent(struct inode *inode,
 		largest->len = 0;
 }
 
-void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+/* return true, if inode page is changed */
+bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei;
 
-	if (!f2fs_may_extent_tree(inode))
-		return;
+	if (!f2fs_may_extent_tree(inode)) {
+		/* drop largest extent */
+		if (i_ext && i_ext->len) {
+			i_ext->len = 0;
+			return true;
+		}
+		return false;
+	}
 
 	et = __grab_extent_tree(inode);
 
-	if (!i_ext || le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
-		return;
+	if (!i_ext || !i_ext->len)
+		return false;
 
 	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
 		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
@@ -196,6 +203,7 @@ void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	}
 out:
 	write_unlock(&et->lock);
+	return false;
 }
 
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e04b2be..a339508 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2083,7 +2083,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *);
  * extent_cache.c
  */
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
-void f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
+bool f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
 unsigned int f2fs_destroy_extent_node(struct inode *);
 void f2fs_destroy_extent_tree(struct inode *);
 bool f2fs_lookup_extent_cache(struct inode *, pgoff_t, struct extent_info *);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ec3fb32..e955008 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -138,7 +138,8 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	f2fs_init_extent_tree(inode, &ri->i_ext);
+	if (f2fs_init_extent_tree(inode, &ri->i_ext))
+		set_page_dirty(node_page);
 
 	get_inline_info(fi, ri);
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
