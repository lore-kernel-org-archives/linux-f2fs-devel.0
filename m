From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid f2fs_bug_on() in cp_error case
Date: Wed,  1 Aug 2018 10:22:49 -0700
Message-ID: <20180801172249.57306-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

There is a subtle race condition to invoke f2fs_bug_on() in shutdown tests. I've
confirmed that the last checkpoint is preserved in consistent state, so it'd be
fine to just return error at this moment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6055d2d12640..21ffb784764c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1075,6 +1075,10 @@ int f2fs_remove_inode_page(struct inode *inode)
 		f2fs_truncate_data_blocks_range(&dn, 1);
 
 	/* 0 is possible, after f2fs_new_inode() has failed */
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
+		f2fs_put_dnode(&dn);
+		return -EIO;
+	}
 	f2fs_bug_on(F2FS_I_SB(inode),
 			inode->i_blocks != 0 && inode->i_blocks != 8);
 
-- 
2.17.0.441.gb46fe60e1d-goog
