From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: remove unneeded readahead in find_fsync_dnodes
Date: Wed,  4 May 2016 23:17:00 +0800
Message-ID: <1462375020-6420-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In find_fsync_dnodes, get_tmp_page will read dnode page synchronously,
previously, ra_meta_page did the same work, which is redundant, remove
it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 395c212..542f210 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -220,8 +220,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
-	ra_meta_pages(sbi, blkaddr, 1, META_POR, true);
-
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-- 
2.7.2
