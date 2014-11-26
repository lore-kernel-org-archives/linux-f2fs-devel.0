From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix to recover converted inline_data
Date: Tue, 25 Nov 2014 18:08:11 -0800
Message-ID: <1416967691-47240-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If an inode has converted inline_data which was written to the disk, we should
set its inode flag for further fsync so that this inline_data can be recovered
from sudden power off.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e27f290..f2d3c58 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -122,6 +122,9 @@ no_update:
 	if (dirty)
 		inode_dec_dirty_pages(dn->inode);
 
+	/* this converted inline_data should be recovered. */
+	set_inode_flag(F2FS_I(dn->inode), FI_APPEND_WRITE);
+
 	/* clear inline data and flag after data writeback */
 	truncate_inline_data(dn->inode_page, 0);
 clear_out:
-- 
2.1.1

