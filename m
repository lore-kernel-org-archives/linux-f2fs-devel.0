From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/11] f2fs: use f2fs_grab_cache_page instead of
	grab_cache_page
Date: Tue,  3 May 2016 11:21:41 -0700
Message-ID: <1462299708-67906-4-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexQ-0008Ta-3D
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexP-0002m5-7H
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:04 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
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

This patch converts grab_cache_page to f2fs_grab_cache_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 ++++---
 fs/f2fs/inline.c     | 4 ++--
 fs/f2fs/node.c       | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index dc7bc72..ac87cd9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -34,7 +34,7 @@ struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page = NULL;
 repeat:
-	page = grab_cache_page(mapping, index);
+	page = f2fs_grab_cache_page(mapping, index, false);
 	if (!page) {
 		cond_resched();
 		goto repeat;
@@ -64,7 +64,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	if (unlikely(!is_meta))
 		fio.rw &= ~REQ_META;
 repeat:
-	page = grab_cache_page(mapping, index);
+	page = f2fs_grab_cache_page(mapping, index, false);
 	if (!page) {
 		cond_resched();
 		goto repeat;
@@ -186,7 +186,8 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			BUG();
 		}
 
-		page = grab_cache_page(META_MAPPING(sbi), fio.new_blkaddr);
+		page = f2fs_grab_cache_page(META_MAPPING(sbi),
+						fio.new_blkaddr, false);
 		if (!page)
 			continue;
 		if (PageUptodate(page)) {
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 33830b2..8a51955 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -161,7 +161,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	if (!f2fs_has_inline_data(inode))
 		return 0;
 
-	page = grab_cache_page(inode->i_mapping, 0);
+	page = f2fs_grab_cache_page(inode->i_mapping, 0, false);
 	if (!page)
 		return -ENOMEM;
 
@@ -358,7 +358,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	struct f2fs_dentry_block *dentry_blk;
 	int err;
 
-	page = grab_cache_page(dir->i_mapping, 0);
+	page = f2fs_grab_cache_page(dir->i_mapping, 0, false);
 	if (!page) {
 		f2fs_put_page(ipage, 1);
 		return -ENOMEM;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f80cfb6..af010f5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -995,7 +995,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	page = grab_cache_page(NODE_MAPPING(sbi), dn->nid);
+	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), dn->nid, false);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -1087,7 +1087,7 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	if (apage)
 		return;
 
-	apage = grab_cache_page(NODE_MAPPING(sbi), nid);
+	apage = f2fs_grab_cache_page(NODE_MAPPING(sbi), nid, false);
 	if (!apage)
 		return;
 
@@ -1128,7 +1128,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		return ERR_PTR(-ENOENT);
 	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
 repeat:
-	page = grab_cache_page(NODE_MAPPING(sbi), nid);
+	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), nid, false);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -2012,7 +2012,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (unlikely(old_ni.blk_addr != NULL_ADDR))
 		return -EINVAL;
 
-	ipage = grab_cache_page(NODE_MAPPING(sbi), ino);
+	ipage = f2fs_grab_cache_page(NODE_MAPPING(sbi), ino, false);
 	if (!ipage)
 		return -ENOMEM;
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
