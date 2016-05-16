From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: manipulate dirty file inodes when
	DATA_FLUSH is set
Date: Mon, 16 May 2016 15:30:43 -0700
Message-ID: <1463437847-40412-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b2R2R-0002kG-Ub
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:30:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b2R2O-00060k-5W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 22:30:59 +0000
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

It needs to maintain dirty file inodes only if DATA_FLUSH is set.
Otherwise, let's avoid its overhead.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3da6499..d04113b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -785,9 +785,11 @@ void update_dirty_page(struct inode *inode, struct page *page)
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	spin_lock(&sbi->inode_lock[type]);
-	__add_dirty_inode(inode, type);
-	spin_unlock(&sbi->inode_lock[type]);
+	if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH)) {
+		spin_lock(&sbi->inode_lock[type]);
+		__add_dirty_inode(inode, type);
+		spin_unlock(&sbi->inode_lock[type]);
+	}
 
 	inode_inc_dirty_pages(inode);
 	SetPagePrivate(page);
@@ -803,6 +805,9 @@ void remove_dirty_inode(struct inode *inode)
 			!S_ISLNK(inode->i_mode))
 		return;
 
+	if (type == FILE_INODE && !test_opt(sbi, DATA_FLUSH))
+		return;
+
 	spin_lock(&sbi->inode_lock[type]);
 	__remove_dirty_inode(inode, type);
 	spin_unlock(&sbi->inode_lock[type]);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
