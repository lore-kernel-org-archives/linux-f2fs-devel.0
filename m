From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: kill __is_extent_same
Date: Sat, 25 Feb 2017 17:29:54 +0800
Message-ID: <20170225092954.98656-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chYgd-000836-9D
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 09:30:43 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chYgW-0002wz-Pu
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 09:30:43 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Since commit ee6d182f2a19 ("f2fs: remove syncing inode page in all the
cases") delayed inode element updating from inode cache to node page
cache, so once largest cached extent is updated, we can make inode dirty
immediately instead of checking and updating it in the end of extent
cache update.

The above commit didn't clean up unneeded codes in extent_cache.c, let's
finish the job in this patch.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 8 +++-----
 fs/f2fs/f2fs.h         | 7 -------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0ab5518e45c2..c6934f014e0f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -413,7 +413,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 	return en;
 }
 
-static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
+static void f2fs_update_extent_tree_range(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr, unsigned int len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -426,7 +426,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	unsigned int pos = (unsigned int)fofs;
 
 	if (!et)
-		return false;
+		return;
 
 	trace_f2fs_update_extent_tree_range(inode, fofs, blkaddr, len);
 
@@ -434,7 +434,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 
 	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
 		write_unlock(&et->lock);
-		return false;
+		return;
 	}
 
 	prev = et->largest;
@@ -531,8 +531,6 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
-
-	return !__is_extent_same(&prev, &et->largest);
 }
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6a31b36e59bc..c4ee149ad6df 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -496,13 +496,6 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
 	ei->len = len;
 }
 
-static inline bool __is_extent_same(struct extent_info *ei1,
-						struct extent_info *ei2)
-{
-	return (ei1->fofs == ei2->fofs && ei1->blk == ei2->blk &&
-						ei1->len == ei2->len);
-}
-
 static inline bool __is_extent_mergeable(struct extent_info *back,
 						struct extent_info *front)
 {
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
