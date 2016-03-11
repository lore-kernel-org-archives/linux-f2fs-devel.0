From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] f2fs: check inline flag ahead for f2fs_write_inline_data
Date: Fri, 11 Mar 2016 10:48:29 +0800
Message-ID: <1457664509-2846-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

No matter inline data flag is set or not, current code is
going to new a dnode. But actually we can avoid it by puting
the check of inline data flag in advance to save this cpu cycle.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/inline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 358214e..0926eab 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -195,16 +195,14 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	struct dnode_of_data dn;
 	int err;
 
+	if (!f2fs_has_inline_data(inode))
+		return -EAGAIN;
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
 	if (err)
 		return err;
 
-	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_dnode(&dn);
-		return -EAGAIN;
-	}
-
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
 
 	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true);
-- 
2.3.7
