From: Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: silence VM_WARN_ON_ONCE in mempool_alloc
Date: Tue, 19 Feb 2019 10:31:52 +0800
Message-ID: <20190219023152.37863-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, miaoxie@huawei.com, Gao Xiang <gaoxiang25@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Note that __GFP_ZERO is not supported for mempool_alloc,
which also documented in the mempool_alloc comments.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f91d8630c9a2..83c14b31aaba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -299,9 +299,10 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		for (; start < F2FS_IO_SIZE(sbi); start++) {
 			struct page *page =
 				mempool_alloc(sbi->write_io_dummy,
-					GFP_NOIO | __GFP_ZERO | __GFP_NOFAIL);
+					      GFP_NOIO | __GFP_NOFAIL);
 			f2fs_bug_on(sbi, !page);
 
+			zero_user_segment(page, 0, PAGE_SIZE);
 			SetPagePrivate(page);
 			set_page_private(page, (unsigned long)DUMMY_WRITTEN_PAGE);
 			lock_page(page);
-- 
2.14.4
