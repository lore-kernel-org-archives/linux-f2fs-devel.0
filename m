From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/4] f2fs: use ->writepage in sync_meta_pages
Date: Mon, 16 Feb 2015 16:19:22 +0800
Message-ID: <006601d049c1$68710ee0$39532ca0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch uses ->writepage of meta mapping in sync_meta_pages instead of
f2fs_write_meta_page, by this way, in its caller we can ignore any changes
(e.g. changing name) of this registered function.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7f794b7..6faffce 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -276,7 +276,7 @@ continue_unlock:
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			if (f2fs_write_meta_page(page, &wbc)) {
+			if (mapping->a_ops->writepage(page, &wbc)) {
 				unlock_page(page);
 				break;
 			}
-- 
2.2.1
