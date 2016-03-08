From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: declare static functions
Date: Tue,  8 Mar 2016 10:32:53 -0800
Message-ID: <1457461973-49976-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Just to avoid sparse warnings.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7b805f7..771166d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1101,7 +1101,7 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 /*
  * readahead MAX_RA_NODE number of node pages.
  */
-void ra_node_pages(struct page *parent, int start)
+static void ra_node_pages(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
 	struct blk_plug plug;
@@ -1121,7 +1121,7 @@ void ra_node_pages(struct page *parent, int start)
 	blk_finish_plug(&plug);
 }
 
-struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
+static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
 	struct page *page;
-- 
2.6.3

