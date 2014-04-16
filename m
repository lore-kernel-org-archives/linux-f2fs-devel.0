From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix to unlock f2fs_lock at the omitted
	error case
Date: Thu, 17 Apr 2014 08:27:46 +0900
Message-ID: <1397690866-25379-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WaZHE-0007bn-3I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Apr 2014 23:30:00 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WaZHB-0003tD-S1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Apr 2014 23:30:00 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4500AAQD9PD580@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Apr 2014 08:29:49 +0900 (KST)
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

If it occurs an error, we should call f2fs_unlock_op.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/inline.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 383db1f..3258c7c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -81,8 +81,10 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 
 	f2fs_lock_op(sbi);
 	ipage = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage))
-		return PTR_ERR(ipage);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
+		goto out;
+	}
 
 	/*
 	 * i_addr[0] is not used for inline data,
@@ -90,10 +92,8 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 	 */
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
-	if (err) {
-		f2fs_unlock_op(sbi);
-		return err;
-	}
+	if (err)
+		goto out;
 
 	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
@@ -118,6 +118,7 @@ static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
 
 	sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
+out:
 	f2fs_unlock_op(sbi);
 	return err;
 }
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
