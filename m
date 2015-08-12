From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid clear valid page
Date: Wed, 12 Aug 2015 17:48:21 +0800
Message-ID: <00bc01d0d4e4$1dec93e0$59c5bba0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZPSej-0000V7-WA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 09:49:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZPSeh-00063s-Tm
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 09:49:09 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSY02L9IR9E6M60@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 18:49:01 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In f2fs_delete_entry, if last dirent is remove from the dentry page,
we will try to punch that page since it has no valid date in it.

But truncate_hole which is used for punching could fail because of
no memory or IO error, if that happened, we'd better skip clearing
this valid dentry page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a34ebd8..8f15fc1 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -718,8 +718,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	if (inode)
 		f2fs_drop_nlink(dir, inode, NULL);
 
-	if (bit_pos == NR_DENTRY_IN_BLOCK) {
-		truncate_hole(dir, page->index, page->index + 1);
+	if (bit_pos == NR_DENTRY_IN_BLOCK &&
+			!truncate_hole(dir, page->index, page->index + 1)) {
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
-- 
2.4.2



------------------------------------------------------------------------------
