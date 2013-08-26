From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 4/5] f2fs: add the truncate_xattr_node function
Date: Mon, 26 Aug 2013 20:16:40 +0900
Message-ID: <1377515801-15243-4-git-send-email-jaegeuk.kim@samsung.com>
References: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VDun7-0005PG-Jr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 11:17:01 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VDun6-0007gd-P8 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 11:17:01 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MS400EB5XZP79Z0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Aug 2013 20:16:48 +0900 (KST)
In-reply-to: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
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

The truncate_xattr_node function will be used by inline xattr.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0343759..0fe9302 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1016,6 +1016,7 @@ int is_checkpointed_node(struct f2fs_sb_info *, nid_t);
 void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
+int truncate_xattr_node(struct inode *, struct page *);
 int remove_inode_page(struct inode *);
 struct page *new_inode_page(struct inode *, const struct qstr *);
 struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f0e733b..2a464a7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -772,6 +772,29 @@ fail:
 	return err > 0 ? 0 : err;
 }
 
+int truncate_xattr_node(struct inode *inode, struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	nid_t nid = F2FS_I(inode)->i_xattr_nid;
+	struct dnode_of_data dn;
+	struct page *npage;
+
+	if (!nid)
+		return 0;
+
+	npage = get_node_page(sbi, nid);
+	if (IS_ERR(npage))
+		return PTR_ERR(npage);
+
+	F2FS_I(inode)->i_xattr_nid = 0;
+	set_new_dnode(&dn, inode, page, npage, nid);
+
+	if (page)
+		dn.inode_page_locked = 1;
+	truncate_node(&dn);
+	return 0;
+}
+
 /*
  * Caller should grab and release a mutex by calling mutex_lock_op() and
  * mutex_unlock_op().
@@ -782,22 +805,16 @@ int remove_inode_page(struct inode *inode)
 	struct page *page;
 	nid_t ino = inode->i_ino;
 	struct dnode_of_data dn;
+	int err;
 
 	page = get_node_page(sbi, ino);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	if (F2FS_I(inode)->i_xattr_nid) {
-		nid_t nid = F2FS_I(inode)->i_xattr_nid;
-		struct page *npage = get_node_page(sbi, nid);
-
-		if (IS_ERR(npage))
-			return PTR_ERR(npage);
-
-		F2FS_I(inode)->i_xattr_nid = 0;
-		set_new_dnode(&dn, inode, page, npage, nid);
-		dn.inode_page_locked = 1;
-		truncate_node(&dn);
+	err = truncate_xattr_node(inode, page);
+	if (err) {
+		f2fs_put_page(page, 1);
+		return err;
 	}
 
 	/* 0 is possible, after f2fs_new_inode() is failed */
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
