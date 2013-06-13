From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH 3/3] f2fs: optimize do_write_data_page()
Date: Thu, 13 Jun 2013 16:59:29 +0800
Message-ID: <1371113969-946-4-git-send-email-haicheng.li@linux.intel.com>
References: <1371113969-946-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371113969-946-1-git-send-email-haicheng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since "need_inplace_update() == true" is a very rare case, using unlikely()
to give compiler a chance to optimize the code.

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fs/f2fs/data.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5b145fc..6d4a743 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -497,8 +497,9 @@ int do_write_data_page(struct page *page)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (old_blk_addr != NEW_ADDR && !is_cold_data(page) &&
-				need_inplace_update(inode)) {
+	if (unlikely(old_blk_addr != NEW_ADDR &&
+			!is_cold_data(page) &&
+			need_inplace_update(inode))) {
 		rewrite_data_page(F2FS_SB(inode->i_sb), page,
 						old_blk_addr);
 	} else {
-- 
1.7.9.5
