From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/3] f2fs: fix to decrease the number of dirty
	dentry page
Date: Tue, 15 Apr 2014 19:57:02 +0900
Message-ID: <1397559423-27411-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Wa15E-0006Cp-Al
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wa15D-0001mu-5o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 10:59:20 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N4200LAVJUJ55A0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Apr 2014 19:59:07 +0900 (KST)
In-reply-to: <1397559423-27411-1-git-send-email-jaegeuk.kim@samsung.com>
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

The f2fs_write_data_page should decrease the number of dirty dentry page
all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45abd60..9a3fa38 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -790,6 +790,8 @@ static int f2fs_write_data_page(struct page *page,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
 	};
 
+	inode_dec_dirty_dents(inode);
+
 	if (page->index < end_index)
 		goto write;
 
@@ -798,10 +800,8 @@ static int f2fs_write_data_page(struct page *page,
 	 * this page does not have to be written to disk.
 	 */
 	offset = i_size & (PAGE_CACHE_SIZE - 1);
-	if ((page->index >= end_index + 1) || !offset) {
-		inode_dec_dirty_dents(inode);
+	if ((page->index >= end_index + 1) || !offset)
 		goto out;
-	}
 
 	zero_user_segment(page, offset, PAGE_CACHE_SIZE);
 write:
@@ -810,7 +810,6 @@ write:
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
-		inode_dec_dirty_dents(inode);
 		err = do_write_data_page(page, &fio);
 		goto done;
 	}
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
