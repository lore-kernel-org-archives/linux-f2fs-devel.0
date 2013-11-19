From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/5] f2fs: convert remove_inode_page to void
Date: Tue, 19 Nov 2013 18:03:18 +0800
Message-ID: <528B3766.4070202@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1ViiFY-0001Je-Vt
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:09:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViiFW-0006DF-Sn for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:09:40 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |    2 +-
 fs/f2fs/node.c |   12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 89dc750..94fbec3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1027,7 +1027,7 @@ int get_dnode_of_data(struct dnode_of_data *, pgoff_t, int);
 int truncate_inode_blocks(struct inode *, pgoff_t);
 int truncate_xattr_node(struct inode *, struct page *);
 int wait_on_node_pages_writeback(struct f2fs_sb_info *, nid_t);
-int remove_inode_page(struct inode *);
+void remove_inode_page(struct inode *);
 struct page *new_inode_page(struct inode *, const struct qstr *);
 struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
 void ra_node_page(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4ac4150..e7b6826 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -803,29 +803,25 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
  * Caller should grab and release a mutex by calling mutex_lock_op() and
  * mutex_unlock_op().
  */
-int remove_inode_page(struct inode *inode)
+void remove_inode_page(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct page *page;
 	nid_t ino = inode->i_ino;
 	struct dnode_of_data dn;
-	int err;
 
 	page = get_node_page(sbi, ino);
 	if (IS_ERR(page))
-		return PTR_ERR(page);
+		return;
 
-	err = truncate_xattr_node(inode, page);
-	if (err) {
+	if (truncate_xattr_node(inode, page)) {
 		f2fs_put_page(page, 1);
-		return err;
+		return;
 	}
-
 	/* 0 is possible, after f2fs_new_inode() is failed */
 	f2fs_bug_on(inode->i_blocks != 0 && inode->i_blocks != 1);
 	set_new_dnode(&dn, inode, page, page, ino);
 	truncate_node(&dn);
-	return 0;
 }
 
 struct page *new_inode_page(struct inode *inode, const struct qstr *name)
-- 
1.7.7


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
