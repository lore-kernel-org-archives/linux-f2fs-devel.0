From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH] f2fs: find parent dentry correctly
Date: Sat, 4 Jun 2016 22:01:28 +0800
Message-ID: <1465048888-11964-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1b9CCa-0008CO-9g
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jun 2016 14:05:24 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b9CCW-0005ac-9D
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jun 2016 14:05:24 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

If dotdot directory is corrupted, its slot may be ocupied by another
file. In this case, dentry[1] is not the parent directory. Rename and
cross-rename will update the inode in dentry[1] incorrectly.   This
patch finds dotdot dentry by name.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/dir.c    | 14 +++++---------
 fs/f2fs/f2fs.h   |  1 -
 fs/f2fs/inline.c | 19 -------------------
 3 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5373f33..253da0e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -261,19 +261,15 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 {
 	struct page *page;
 	struct f2fs_dir_entry *de;
-	struct f2fs_dentry_block *dentry_blk;
-
-	if (f2fs_has_inline_dentry(dir))
-		return f2fs_parent_inline_dir(dir, p);
+	struct qstr dotdot = QSTR_INIT("..", 2);
 
-	page = get_lock_data_page(dir, 0, false);
-	if (IS_ERR(page))
+	de = f2fs_find_entry(dir, &dotdot, &page);
+	if (!de) {
+		f2fs_bug_on(F2FS_I_SB(dir), de == NULL);
 		return NULL;
+	}
 
-	dentry_blk = kmap(page);
-	de = &dentry_blk->dentry[1];
 	*p = page;
-	unlock_page(page);
 	return de;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6e6fd0b..bee0470 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2148,7 +2148,6 @@ int f2fs_write_inline_data(struct inode *, struct page *);
 bool recover_inline_data(struct inode *, struct page *);
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
 				struct fscrypt_name *, struct page **);
-struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, struct page **);
 int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
 int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
 						nid_t, umode_t);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8a51955..57864eb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -306,25 +306,6 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 	return de;
 }
 
-struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *dir,
-							struct page **p)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct page *ipage;
-	struct f2fs_dir_entry *de;
-	struct f2fs_inline_dentry *dentry_blk;
-
-	ipage = get_node_page(sbi, dir->i_ino);
-	if (IS_ERR(ipage))
-		return NULL;
-
-	dentry_blk = inline_data_addr(ipage);
-	de = &dentry_blk->dentry[1];
-	*p = ipage;
-	unlock_page(ipage);
-	return de;
-}
-
 int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 							struct page *ipage)
 {
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
