From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to redirty page if fail to gc data page
Date: Sat, 21 May 2016 13:19:11 +0800
Message-ID: <1463807951-10472-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

If we fail to move data page during foreground GC, we should give another
chance to writeback that page which was set dirty previously by writer.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 38d56f6..ee213a8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -653,12 +653,15 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.page = page,
 			.encrypted_page = NULL,
 		};
+		bool is_dirty = PageDirty(page);
+
 		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_pages(inode);
 		set_cold_data(page);
-		do_write_data_page(&fio);
+		if (do_write_data_page(&fio) && is_dirty)
+			set_page_dirty(page);
 		clear_cold_data(page);
 	}
 out:
-- 
2.7.2
