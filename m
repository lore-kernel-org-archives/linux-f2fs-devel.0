From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] f2fs: remove redundant checking of inline data flag
Date: Fri, 11 Mar 2016 10:29:44 +0800
Message-ID: <1457663384-19856-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Remove the f2fs_has_inline_data for f2fs_read_data_page,
and let f2fs_read_inline_data take over gatekeeper of
checking inline data flag.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5c762b..e4aa8af 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1047,9 +1047,9 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 
 	trace_f2fs_readpage(page, DATA);
 
-	/* If the file has inline data, try to read it directly */
-	if (f2fs_has_inline_data(inode))
-		ret = f2fs_read_inline_data(inode, page);
+	/* Firstly, let's try to read inline data directly */
+	ret = f2fs_read_inline_data(inode, page);
+
 	if (ret == -EAGAIN)
 		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1);
 	return ret;
-- 
2.3.7
