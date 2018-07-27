From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: fix to active page in lru list for read path
Date: Fri, 27 Jul 2018 18:15:14 +0800
Message-ID: <20180727101516.41403-2-yuchao0@huawei.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727101516.41403-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If config CONFIG_F2FS_FAULT_INJECTION is on, for both read or write path
we will call find_lock_page() to get the page, but for read path, it
missed to passing FGP_ACCESSED to allocator to active the page in LRU
list, result in being reclaimed in advance incorrectly, fix it.

Reported-by: Xianrong Zhou <zhouxianrong@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fa5d0ebf8998..5f9e6a406284 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1974,8 +1974,13 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	struct page *page = find_lock_page(mapping, index);
+	struct page *page;
 
+	if (!for_write)
+		page = find_get_page_flags(mapping, index,
+						FGP_LOCK | FGP_ACCESSED);
+	else
+		page = find_lock_page(mapping, index);
 	if (page)
 		return page;
 
-- 
2.18.0.rc1
