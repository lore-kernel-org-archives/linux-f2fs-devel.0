From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: make __f2fs_write_data_pages() static
Date: Wed, 30 May 2018 00:20:39 +0800
Message-ID: <20180529162041.16005-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 fs/f2fs/f2fs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97e6df852f37..10aa4d9a4b7c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2072,7 +2072,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-int __f2fs_write_data_pages(struct address_space *mapping,
+static int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
 						enum iostat_type io_type)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c8e7f34ca290..18de7556dee8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2956,9 +2956,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
 bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
-int __f2fs_write_data_pages(struct address_space *mapping,
-						struct writeback_control *wbc,
-						enum iostat_type io_type);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
-- 
2.16.2.17.g38e79b1fd
