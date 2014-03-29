From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix error path when fail to read inline
	data
Date: Sat, 29 Mar 2014 15:30:40 +0800
Message-ID: <000101cf4b20$e4765270$ad62f750$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WTnjv-00027F-KE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 29 Mar 2014 07:31:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WTnjt-0004au-PP
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 29 Mar 2014 07:31:39 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N3600N8GSWI1U20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 29 Mar 2014 16:31:30 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should unlock page in ->readpage() path and also should unlock & release page
in error path of ->write_begin() to avoid deadlock or memory leak.
So let's add release code to fix the problem when we fail to read inline data.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c   |   14 ++++++++++----
 fs/f2fs/inline.c |    4 +++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 598bfa6..45abd60 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -942,13 +942,19 @@ inline_data:
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	} else {
-		if (f2fs_has_inline_data(inode))
+		if (f2fs_has_inline_data(inode)) {
 			err = f2fs_read_inline_data(inode, page);
-		else
+			if (err) {
+				page_cache_release(page);
+				return err;
+			}
+		} else {
 			err = f2fs_submit_page_bio(sbi, page, dn.data_blkaddr,
 							READ_SYNC);
-		if (err)
-			return err;
+			if (err)
+				return err;
+		}
+
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 31ee5b1..383db1f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -45,8 +45,10 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	}
 
 	ipage = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage))
+	if (IS_ERR(ipage)) {
+		unlock_page(page);
 		return PTR_ERR(ipage);
+	}
 
 	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
-- 
1.7.9.5



------------------------------------------------------------------------------
