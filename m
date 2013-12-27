From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: handle errors correctly during
	f2fs_reserve_block
Date: Fri, 27 Dec 2013 18:17:09 +0900
Message-ID: <1388135829-21292-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwTZ1-0002Rf-FK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 09:18:39 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwTYz-0004Nz-8d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 09:18:39 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG0090IKINBIC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 18:18:23 +0900 (KST)
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

The get_dnode_of_data nullifies inode and node page when error is occurred.

There are two cases that passes inode page into get_dnode_of_data().

1. make_empty_dir()
    -> get_new_data_page()
      -> f2fs_reserve_block(ipage)
	-> get_dnode_of_data()

2. f2fs_convert_inline_data()
    -> __f2fs_convert_inline_data()
      -> f2fs_reserve_block(ipage)
	-> get_dnode_of_data()

This patch adds correct error handling codes when get_dnode_of_data() returns
an error.

At first, f2fs_reserve_block() calls f2fs_put_dnode() whenever reserve_new_block
returns an error.
So, the rule of f2fs_reserve_block() is to nullify inode page when there is any
error internally.

Finally, two callers of f2fs_reserve_block() should call f2fs_put_dnode()
appropriately if they got an error since successful f2fs_reserve_block().

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c   | 29 ++++++++++++++++++++---------
 fs/f2fs/dir.c    |  7 ++++---
 fs/f2fs/inline.c |  6 ++----
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fc7a28c..63d1902 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -258,13 +258,16 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	bool need_put = dn->inode_page ? false : true;
 	int err;
 
+	/* if inode_page exists, index should be zero */
+	f2fs_bug_on(!need_put && index);
+
 	err = get_dnode_of_data(dn, index, ALLOC_NODE);
 	if (err)
 		return err;
+
 	if (dn->data_blkaddr == NULL_ADDR)
 		err = reserve_new_block(dn);
-
-	if (need_put)
+	if (err || need_put)
 		f2fs_put_dnode(dn);
 	return err;
 }
@@ -510,10 +513,10 @@ repeat:
  *
  * Also, caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
- * Note that, npage is set only by make_empty_dir.
+ * Note that, ipage is set only by make_empty_dir.
  */
 struct page *get_new_data_page(struct inode *inode,
-		struct page *npage, pgoff_t index, bool new_i_size)
+		struct page *ipage, pgoff_t index, bool new_i_size)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct address_space *mapping = inode->i_mapping;
@@ -521,14 +524,16 @@ struct page *get_new_data_page(struct inode *inode,
 	struct dnode_of_data dn;
 	int err;
 
-	set_new_dnode(&dn, inode, npage, npage, 0);
+	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	if (err)
 		return ERR_PTR(err);
 repeat:
 	page = grab_cache_page(mapping, index);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	if (!page) {
+		err = -ENOMEM;
+		goto put_err;
+	}
 
 	if (PageUptodate(page))
 		return page;
@@ -540,11 +545,13 @@ repeat:
 		err = f2fs_submit_page_bio(sbi, page, dn.data_blkaddr,
 								READ_SYNC);
 		if (err)
-			return ERR_PTR(err);
+			goto put_err;
+
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
-			return ERR_PTR(-EIO);
+			err = -EIO;
+			goto put_err;
 		}
 		if (unlikely(page->mapping != mapping)) {
 			f2fs_put_page(page, 1);
@@ -560,6 +567,10 @@ repeat:
 		mark_inode_dirty_sync(inode);
 	}
 	return page;
+
+put_err:
+	f2fs_put_dnode(&dn);
+	return ERR_PTR(err);
 }
 
 static int __allocate_data_block(struct dnode_of_data *dn)
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 6da77e5..f815ca0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -342,11 +342,11 @@ static struct page *init_inode_metadata(struct inode *inode,
 
 		err = f2fs_init_acl(inode, dir, page);
 		if (err)
-			goto error;
+			goto put_error;
 
 		err = f2fs_init_security(inode, dir, name, page);
 		if (err)
-			goto error;
+			goto put_error;
 
 		wait_on_page_writeback(page);
 	} else {
@@ -370,8 +370,9 @@ static struct page *init_inode_metadata(struct inode *inode,
 	}
 	return page;
 
-error:
+put_error:
 	f2fs_put_page(page, 1);
+error:
 	remove_inode_page(inode);
 	return ERR_PTR(err);
 }
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index bcc6f65..afbdf87 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -81,10 +81,9 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	 * i_addr[0] is not used for inline data,
 	 * so reserving new block will not destroy inline data
 	 */
-	set_new_dnode(&dn, inode, ipage, ipage, 0);
+	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
 	if (err) {
-		f2fs_put_page(ipage, 1);
 		f2fs_unlock_op(sbi);
 		return err;
 	}
@@ -111,9 +110,8 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	stat_dec_inline_inode(inode);
 
 	sync_inode_page(&dn);
-	f2fs_put_page(ipage, 1);
+	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
-
 	return err;
 }
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
