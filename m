From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to wait on page writeback before updating page
Date: Thu, 21 Jun 2018 22:38:28 +0800
Message-ID: <20180621143828.3844-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In error path of f2fs_move_rehashed_dirents, inode page could be writeback
state, so we should wait on inode page writeback before updating it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a6d6d340211a..d0d430ad79ff 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -477,6 +477,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	return 0;
 recover:
 	lock_page(ipage);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
-- 
2.16.2.17.g38e79b1fd
