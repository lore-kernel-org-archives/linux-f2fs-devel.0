From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clear PageError on writepage
Date: Thu, 12 Apr 2018 18:07:16 -0700
Message-ID: <20180413010716.53610-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch clears PageError in some pages tagged by read path, but when we
write the pages with valid contents, writepage should clear the bit likewise
ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index db50686f5096..6d39a6e12f78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1675,6 +1675,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			goto out_writepage;
 
 		set_page_writeback(page);
+		ClearPageError(page);
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
@@ -1697,6 +1698,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 
 	set_page_writeback(page);
+	ClearPageError(page);
 
 	/* LFS mode write path */
 	write_data_page(&dn, fio);
-- 
2.15.0.531.g2ccb3012c9-goog
