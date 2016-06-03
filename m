From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/8] f2fs: remove deprecated parameter
Date: Thu,  2 Jun 2016 20:55:33 -0700
Message-ID: <1464926139-58252-2-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gD8-0006pI-61
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gD7-00030W-Eu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:50 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
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

Remove deprecated paramter.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 4 ++--
 fs/f2fs/f2fs.h   | 2 +-
 fs/f2fs/inline.c | 5 ++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 6fbb1ed..f6ab3c2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -664,7 +664,7 @@ fail:
 	return err;
 }
 
-void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
+void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 
@@ -723,7 +723,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	mark_inode_dirty_sync(dir);
 
 	if (inode)
-		f2fs_drop_nlink(dir, inode, NULL);
+		f2fs_drop_nlink(dir, inode);
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 			!truncate_hole(dir, page->index, page->index + 1)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4697b7..498c736 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1915,7 +1915,7 @@ struct page *init_inode_metadata(struct inode *, struct inode *,
 			const struct qstr *, struct page *);
 void update_parent_metadata(struct inode *, struct inode *, unsigned int);
 int room_for_filename(const void *, int, int);
-void f2fs_drop_nlink(struct inode *, struct inode *, struct page *);
+void f2fs_drop_nlink(struct inode *, struct inode *);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *, struct qstr *,
 							struct page **);
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *, struct page **);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1eb3043..669f92f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -582,14 +582,13 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 				&inline_dentry->dentry_bitmap);
 
 	set_page_dirty(page);
+	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty_sync(dir);
 
 	if (inode)
-		f2fs_drop_nlink(dir, inode, page);
-
-	f2fs_put_page(page, 1);
+		f2fs_drop_nlink(dir, inode);
 }
 
 bool f2fs_empty_inline_dir(struct inode *dir)
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
