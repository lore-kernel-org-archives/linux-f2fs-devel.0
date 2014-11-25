From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix deadlock during inline_data
	conversion
Date: Tue, 25 Nov 2014 15:39:55 -0800
Message-ID: <1416958796-39186-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XtPiW-0005BN-GP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 23:40:20 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XtPiV-0005RK-AH for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Nov 2014 23:40:20 +0000
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

A deadlock can be occurred:
Thread 1]                             Thread 2]
 - f2fs_write_data_pages              - f2fs_write_begin
   - lock_page(page #0)
                                        - grab_cache_page(page #X)
                                        - get_node_page(inode_page)
                                        - grab_cache_page(page #0)
                                          : to convert inline_data
   - f2fs_write_data_page
     - f2fs_write_inline_data
       - get_node_page(inode_page)

In this case, trying to lock inode_page and page #0 causes deadlock.
In order to avoid this, this patch adds a rule for this locking policy,
which is that page #0 should be locked followed by inode_page lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 12dd58a..c7bc626 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -936,6 +936,17 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
 	f2fs_balance_fs(sbi);
+
+	/*
+	 * We should check this at this moment to avoid deadlock on inode page
+	 * and #0 page. The locking rule for inline_data conversion should be:
+	 * lock_page(page #0) -> lock_page(inode_page)
+	 */
+	if (index != 0) {
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			goto fail;
+	}
 repeat:
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page) {
@@ -960,21 +971,10 @@ repeat:
 			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
 			sync_inode_page(&dn);
 			goto put_next;
-		} else if (page->index == 0) {
-			err = f2fs_convert_inline_page(&dn, page);
-			if (err)
-				goto put_fail;
-		} else {
-			struct page *p = grab_cache_page(inode->i_mapping, 0);
-			if (!p) {
-				err = -ENOMEM;
-				goto put_fail;
-			}
-			err = f2fs_convert_inline_page(&dn, p);
-			f2fs_put_page(p, 1);
-			if (err)
-				goto put_fail;
 		}
+		err = f2fs_convert_inline_page(&dn, page);
+		if (err)
+			goto put_fail;
 	}
 	err = f2fs_reserve_block(&dn, index);
 	if (err)
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
