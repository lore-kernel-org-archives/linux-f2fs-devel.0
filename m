From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: speed up gc_urgent mode with SSR
Date: Sat,  9 Sep 2017 12:17:09 -0700
Message-ID: <20170909191710.81288-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dqlFm-0004gV-FY
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Sep 2017 19:17:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dqlFl-0006Kx-Mm
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Sep 2017 19:17:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Jaegeuk Kim <jaegeuk@google.com>

From: Jaegeuk Kim <jaegeuk@google.com>

This patch activates SSR in gc_urgent mode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 15 +++++++++++++++
 fs/f2fs/segment.h | 13 -------------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c0803b1873b3..9a7c90386947 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2511,6 +2511,7 @@ void destroy_node_manager_caches(void);
 /*
  * segment.c
  */
+bool need_SSR(struct f2fs_sb_info *sbi);
 void register_inmem_page(struct inode *inode, struct page *page);
 void drop_inmem_pages(struct inode *inode);
 void drop_inmem_page(struct inode *inode, struct page *page);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9e708e525ba8..f96e61e8ddf7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -168,6 +168,21 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
 	return result - size + __reverse_ffz(tmp);
 }
 
+bool need_SSR(struct f2fs_sb_info *sbi)
+{
+	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
+	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
+	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
+
+	if (test_opt(sbi, LFS))
+		return false;
+	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
+		return true;
+
+	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
+						2 * reserved_sections(sbi));
+}
+
 void register_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 613b2fa7b1c1..e0a6cc23ace3 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -497,19 +497,6 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
 }
 
-static inline bool need_SSR(struct f2fs_sb_info *sbi)
-{
-	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
-	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
-	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
-
-	if (test_opt(sbi, LFS))
-		return false;
-
-	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
-						2 * reserved_sections(sbi));
-}
-
 static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 					int freed, int needed)
 {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
