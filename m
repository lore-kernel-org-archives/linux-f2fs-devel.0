From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to drop all inmem pages correctly
Date: Mon, 15 Jan 2018 17:16:46 +0800
Message-ID: <20180115091646.46614-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In commit 57864ae5ce3a ("f2fs: limit # of inmemory pages"), we have
limited memory footprint of all inmem pages with 20% of total memory,
otherwise, if we exceed the threshold, we will try to drop all inmem
pages to avoid excessive memory pressure resulting in performance
regression.

But in some unrelated error paths, we will also drop all inmem pages,
which should be wrong, fix it in this patch.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 81fd4823a071..2db26388b6bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2078,7 +2078,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page = NULL;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
-	bool need_balance = false;
+	bool need_balance = false, drop_atomic = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
@@ -2087,6 +2087,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	if (f2fs_is_atomic_file(inode) &&
 			!available_free_memory(sbi, INMEM_PAGES)) {
 		err = -ENOMEM;
+		drop_atomic = true;
 		goto fail;
 	}
 
@@ -2167,7 +2168,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 fail:
 	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
-	if (f2fs_is_atomic_file(inode))
+	if (drop_atomic)
 		drop_inmem_pages_all(sbi);
 	return err;
 }
-- 
2.15.0.55.gc2ece9dc4de6
