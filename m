From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] f2fs: merge equivalent flags F2FS_GET_BLOCK_[READ|DIO]
Date: Wed, 9 Aug 2017 17:27:30 +0800
Message-ID: <1502270850-34212-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

Currently, the two flags F2FS_GET_BLOCK_[READ|DIO] are totally equivalent
and can be used interchangably in all scenarios they are involved in. 
Neither of the flags is referenced in f2fs_map_blocks(), making them both 
the default case. To remove the ambiguity, this patch merges both flags
into F2FS_GET_BLOCK_DEFAULT, and introduces an enum for all distinct flags.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/data.c |  4 ++--
 fs/f2fs/f2fs.h | 13 +++++++------
 fs/f2fs/file.c |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c43262d..67da4f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1044,7 +1044,7 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DIO, NULL);
+						F2FS_GET_BLOCK_DEFAULT, NULL);
 }
 
 static int get_data_block_bmap(struct inode *inode, sector_t iblock,
@@ -1244,7 +1244,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			map.m_len = last_block - block_in_file;
 
 			if (f2fs_map_blocks(inode, &map, 0,
-						F2FS_GET_BLOCK_READ))
+						F2FS_GET_BLOCK_DEFAULT))
 				goto set_error_page;
 		}
 got_it:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cea329f..2f20b6b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -514,12 +514,13 @@ struct f2fs_map_blocks {
 };
 
 /* for flag in get_data_block */
-#define F2FS_GET_BLOCK_READ		0
-#define F2FS_GET_BLOCK_DIO		1
-#define F2FS_GET_BLOCK_FIEMAP		2
-#define F2FS_GET_BLOCK_BMAP		3
-#define F2FS_GET_BLOCK_PRE_DIO		4
-#define F2FS_GET_BLOCK_PRE_AIO		5
+enum {
+	F2FS_GET_BLOCK_DEFAULT,
+	F2FS_GET_BLOCK_FIEMAP,
+	F2FS_GET_BLOCK_BMAP,
+	F2FS_GET_BLOCK_PRE_DIO,
+	F2FS_GET_BLOCK_PRE_AIO,
+};
 
 /*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2b33b8..3eebd49 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2074,7 +2074,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 */
 	while (map.m_lblk < pg_end) {
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto out;
 
@@ -2116,7 +2116,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 do_map:
 		map.m_len = pg_end - map.m_lblk;
-		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
+		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
 		if (err)
 			goto clear_out;
 
-- 
1.8.3.1
