From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] f2fs: check inline flag ahead for f2fs_read_inline_data
Date: Fri, 11 Mar 2016 10:29:02 +0800
Message-ID: <1457663342-19200-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

No matter inline data flag is set or not, get_node_page is
going work now. But actually we can avoid it by puting the
check of inline data flag in advance to save this cpu cycle.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/inline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 358214e..0182106 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -81,17 +81,15 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 {
 	struct page *ipage;
 
+	if (!f2fs_has_inline_data(inode))
+		return -EAGAIN;
+
 	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage)) {
 		unlock_page(page);
 		return PTR_ERR(ipage);
 	}
 
-	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_page(ipage, 1);
-		return -EAGAIN;
-	}
-
 	if (page->index)
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	else
-- 
2.3.7
