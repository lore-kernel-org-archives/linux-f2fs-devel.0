From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: fix wrong error injection for
	evict_inode
Date: Tue,  7 Mar 2017 14:13:00 -0800
Message-ID: <20170307221303.6757-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clNM2-0007pS-FD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clNM1-0007G7-FM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:14 +0000
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

The previous one was not a proper location to inject an error, since there
is no point to get errors. Instead, we can emulate EIO during truncation,
and the below logic should handle it correctly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ef8610bf950f..2520fa72b23f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,13 +372,6 @@ void f2fs_evict_inode(struct inode *inode)
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
 
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
-		f2fs_show_injection_info(FAULT_EVICT_INODE);
-		goto no_delete;
-	}
-#endif
-
 	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 
@@ -389,6 +382,12 @@ void f2fs_evict_inode(struct inode *inode)
 	if (F2FS_HAS_BLOCKS(inode))
 		err = f2fs_truncate(inode);
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
+		f2fs_show_injection_info(FAULT_EVICT_INODE);
+		err = -EIO;
+	}
+#endif
 	if (!err) {
 		f2fs_lock_op(sbi);
 		err = remove_inode_page(inode);
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
