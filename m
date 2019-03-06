From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove wrong comment in f2fs_invalidate_page()
Date: Wed, 6 Mar 2019 16:18:33 +0800
Message-ID: <20190306081833.74065-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Since 8c242db9b8c0 ("f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer"),
we've started to not skip clear private flag for atomic_write page
truncation, so removing old wrong comment in f2fs_invalidate_page().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 14ee7dd0c6bc..c36d7aa682d1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2711,7 +2711,6 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 
 	clear_cold_data(page);
 
-	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return f2fs_drop_inmem_page(inode, page);
 
-- 
2.18.0.rc1
