From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: remove unused sbi->trigger_ssr_threshold
Date: Thu,  4 Oct 2018 11:15:19 +0800
Message-ID: <20181004031520.4096-2-chao@kernel.org>
References: <20181004031520.4096-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004031520.4096-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Commit a2a12b679f36 ("f2fs: export SSR allocation threshold") introduced
two threshold .min_ssr_sections and .trigger_ssr_threshold, but only
.min_ssr_sections is used, so just remove redundant one for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4d30c090399..2297492fc56d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1218,7 +1218,6 @@ struct f2fs_sb_info {
 	unsigned int total_valid_node_count;	/* valid node block count */
 	loff_t max_file_blocks;			/* max block index of file */
 	int dir_level;				/* directory level */
-	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
 	int readdir_ra;				/* readahead inode in readdir */
 
 	block_t user_block_count;		/* # of user blocks */
-- 
2.18.0
