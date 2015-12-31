From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: use IPU for fdatasync
Date: Thu, 31 Dec 2015 15:49:52 -0800
Message-ID: <1451605794-5636-3-git-send-email-jaegeuk@kernel.org>
References: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aEmyv-0008IY-QM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEmyv-00073m-5n for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:09 +0000
In-Reply-To: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes missing IPU condition when fdatasync is called.
With this patch, fdatasync is able to avoid additional node writes for recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b04ab40..e3d32f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -202,7 +202,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	trace_f2fs_sync_file_enter(inode);
 
 	/* if fdatasync is triggered, let's do in-place-update */
-	if (get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
+	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(fi, FI_NEED_IPU);
 	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	clear_inode_flag(fi, FI_NEED_IPU);
-- 
2.6.3


------------------------------------------------------------------------------
