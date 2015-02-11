From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix accessing wrong indexed data blocks
Date: Wed, 11 Feb 2015 12:05:56 -0800
Message-ID: <1423685156-90598-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes the following test.

This causes:
 attempt to access beyond end of device
 sdb2: rw=16384, want=14413962000, limit=16777216

The reason is:
 - f2fs_write_begin
  - f2fs_convert_inline_inode returns -ENOSPC
  - f2fs_write_failed
   - truncate_blocks
    - truncate_partial_data_page
     - find_data_page
      - get_dnode_of_data returns wrong data index retrieved from inline_data
      - f2fs_submit_page_bio(wrong data index)
       - submit_bio(wrong data index)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1e354ff..97bd9d3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -474,7 +474,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct page *npage[4];
-	struct page *parent;
+	struct page *parent = NULL;
 	int offset[4];
 	unsigned int noffset[4];
 	nid_t nids[4];
@@ -491,6 +491,14 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		if (IS_ERR(npage[0]))
 			return PTR_ERR(npage[0]);
 	}
+
+	/* if inline_data is set, should not report any block indices */
+	if (f2fs_has_inline_data(dn->inode) && index) {
+		err = -EINVAL;
+		f2fs_put_page(npage[0], 1);
+		goto release_out;
+	}
+
 	parent = npage[0];
 	if (level != 0)
 		nids[1] = get_nid(parent, offset[0], true);
-- 
2.1.1
