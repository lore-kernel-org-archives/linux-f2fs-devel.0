From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 13/19] f2fs: fix race on allocating and
	deallocating a dentry block
Date: Fri,  1 May 2015 17:48:40 -0700
Message-ID: <1430527726-68547-13-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcc-0001eo-Kb
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcb-0004Sy-Tj for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:34 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

There are two threads:
 f2fs_delete_entry()              get_new_data_page()
                                  f2fs_reserve_block()
				  dn.blkaddr = XXX
 lock_page(dentry_block)
 truncate_hole()
 dn.blkaddr = NULL
 unlock_page(dentry_block)
                                  lock_page(dentry_block)
                                  fill the block from XXX address
                                  add new dentries
                                  unlock_page(dentry_block)

Later, f2fs_write_data_page() will truncate the dentry_block, since
its block address is NULL.

The reason for this was due to the wrong lock order.
In this case, we should do f2fs_reserve_block() after locking its dentry block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 81d1fd5..9ba30b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1076,20 +1076,22 @@ struct page *get_new_data_page(struct inode *inode,
 	struct page *page;
 	struct dnode_of_data dn;
 	int err;
+repeat:
+	page = grab_cache_page(mapping, index);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
 
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
-	if (err)
+	if (err) {
+		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
-repeat:
-	page = grab_cache_page(mapping, index);
-	if (!page) {
-		err = -ENOMEM;
-		goto put_err;
 	}
+	if (!ipage)
+		f2fs_put_dnode(&dn);
 
 	if (PageUptodate(page))
-		return page;
+		goto got_it;
 
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
@@ -1104,20 +1106,19 @@ repeat:
 		};
 		err = f2fs_submit_page_bio(&fio);
 		if (err)
-			goto put_err;
+			return ERR_PTR(err);
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
-			err = -EIO;
-			goto put_err;
+			return ERR_PTR(-EIO);
 		}
 		if (unlikely(page->mapping != mapping)) {
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
 	}
-
+got_it:
 	if (new_i_size &&
 		i_size_read(inode) < ((index + 1) << PAGE_CACHE_SHIFT)) {
 		i_size_write(inode, ((index + 1) << PAGE_CACHE_SHIFT));
@@ -1125,10 +1126,6 @@ repeat:
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_DIR);
 	}
 	return page;
-
-put_err:
-	f2fs_put_dnode(&dn);
-	return ERR_PTR(err);
 }
 
 static int __allocate_data_block(struct dnode_of_data *dn)
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
