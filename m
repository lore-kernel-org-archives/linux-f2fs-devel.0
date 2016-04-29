From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: fix to clear private data in page
Date: Fri, 29 Apr 2016 20:09:15 +0800
Message-ID: <1461931755-3120-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Private data in page should be removed during ->releasepage or
->invalidatepage, otherwise garbage data would be remained in that page.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 38ce5d6..888f178 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1723,6 +1723,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return;
 
+	set_page_private(page, 0);
 	ClearPagePrivate(page);
 }
 
@@ -1736,6 +1737,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return 0;
 
+	set_page_private(page, 0);
 	ClearPagePrivate(page);
 	return 1;
 }
-- 
2.7.2
