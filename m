From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: remove redundant calls
Date: Thu,  7 Jan 2016 17:36:35 -0800
Message-ID: <1452216996-9689-2-git-send-email-jaegeuk@kernel.org>
References: <1452216996-9689-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aHLyx-0004ok-OV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jan 2016 01:36:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aHLyx-0003PF-0n for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jan 2016 01:36:47 +0000
In-Reply-To: <1452216996-9689-1-git-send-email-jaegeuk@kernel.org>
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

This patch removes redundant calls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e3d32f6..69bc65f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -267,8 +267,6 @@ sync_nodes:
 	if (need_inode_block_update(sbi, ino)) {
 		mark_inode_dirty_sync(inode);
 		f2fs_write_inode(inode, NULL);
-
-		f2fs_balance_fs(sbi);
 		goto sync_nodes;
 	}
 
@@ -484,7 +482,6 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 						F2FS_I(dn->inode)) + ofs;
 		f2fs_update_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
-		set_page_dirty(dn->node_page);
 		sync_inode_page(dn);
 	}
 	dn->ofs_in_node = ofs;
-- 
2.6.3


------------------------------------------------------------------------------
