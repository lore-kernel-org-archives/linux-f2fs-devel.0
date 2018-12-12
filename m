From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: clean up checkpoint flow
Date: Wed, 12 Dec 2018 18:12:32 +0800
Message-ID: <20181212101232.54289-3-yuchao0@huawei.com>
References: <20181212101232.54289-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212101232.54289-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch cleans up checkpoint flow a bit:
- remove unneeded circulation of flushing meta pages.
- don't flush nat_bits pages in prior to other checkpoint pages.
- add bug_on to check remained meta pages after flushing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0a6b5dc0d717..623536b8e0c0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1328,11 +1328,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	int err;
 
 	/* Flush all the NAT/SIT pages */
-	while (get_pages(sbi, F2FS_DIRTY_META)) {
-		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-		if (unlikely(f2fs_cp_error(sbi)))
-			break;
-	}
+	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
+					!f2fs_cp_error(sbi));
 
 	/*
 	 * modify checkpoint
@@ -1405,14 +1403,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
 			f2fs_update_meta_page(sbi, nm_i->nat_bits +
 					(i << F2FS_BLKSIZE_BITS), blk + i);
-
-		/* Flush all the NAT BITS pages */
-		while (get_pages(sbi, F2FS_DIRTY_META)) {
-			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
-							FS_CP_META_IO);
-			if (unlikely(f2fs_cp_error(sbi)))
-				break;
-		}
 	}
 
 	/* write out checkpoint buffer at block 0 */
@@ -1448,6 +1438,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
+					!f2fs_cp_error(sbi));
 
 	/* wait for previous submitted meta pages writeback */
 	f2fs_wait_on_all_pages_writeback(sbi);
-- 
2.18.0.rc1
