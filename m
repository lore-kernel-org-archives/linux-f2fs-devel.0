From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: fix to cover lock_op for
	update_inode_page
Date: Tue, 18 Aug 2015 01:46:26 -0700
Message-ID: <1439887589-35190-2-git-send-email-jaegeuk@kernel.org>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZRcXX-0002mZ-NC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZRcXV-0001r1-Ul for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:39 +0000
In-Reply-To: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
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

Previously, update_inode_page is not called under f2fs_lock_op.
Instead we should call with f2fs_write_inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 016ed3b..7faafb5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -206,8 +206,8 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	}
 
 	/* if the inode is dirty, let's recover all the time */
-	if (!datasync && is_inode_flag_set(fi, FI_DIRTY_INODE)) {
-		update_inode_page(inode);
+	if (!datasync) {
+		f2fs_write_inode(inode, NULL);
 		goto go_write;
 	}
 
-- 
2.1.1


------------------------------------------------------------------------------
