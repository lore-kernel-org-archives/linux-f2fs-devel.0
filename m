From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: fix the potential mismatch between
 dir's i_size and i_blocks
Date: Tue, 04 Feb 2014 13:46:43 +0900
Message-ID: <1391489204-19695-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WAXvs-0005Io-9i
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 04:48:24 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WAXvq-0006F8-Aa
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 04:48:24 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0G00E5PG0EZ800@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 13:48:14 +0900 (KST)
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

This is the erroneous scenario.

                             i_size    on-disk i_size    i_blocks
__f2fs_add_link()             4096           4096           2
 get_new_data_page            8192           4096           3
 -ENOSPC = init_inode_metadata
 checkpoint                     -            4096           3
 POR and reboot

__f2fs_add_link()             4096           4096           3
 page = get_new_data_page (page->index = 1 by NEW_ADDR)
 add a dentry to the page successfully

f2fs_rmdir()
 f2fs_empty_dir()             4096           4096           3
 f2fs_unlink() goes, since there is no valid dentry due to i_size = 4096.
 But, still there is one dentry in page->index = 1.

So this patch moves the code to write dir->i_size into on-disk i_size in order
to sync dir's i_size, on-disk i_size, and its i_blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 2b7c255..bfcb4ae 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -395,9 +395,6 @@ static void update_parent_metadata(struct inode *dir, struct inode *inode,
 		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
 	}
 
-	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR))
-		update_inode_page(dir);
-
 	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
 		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 }
@@ -511,7 +508,10 @@ add_dentry:
 
 	update_parent_metadata(dir, inode, current_depth);
 fail:
-	clear_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR)) {
+		update_inode_page(dir);
+		clear_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+	}
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
 	return err;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
