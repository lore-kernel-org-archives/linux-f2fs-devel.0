From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: fix to build free nids from readaheaded nat pages
Date: Fri, 24 Jul 2015 18:26:26 +0800
Message-ID: <006001d0c5fb$4a25f890$de71e9b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When there is no enough free nids in free nid cache, we will try to
readahead FREE_NID_PAGES:4 nat pages into page cache of meta_inode,
then, reading nat entries in nat page for adding free nids to free nid
cache.

But when traversing all nat pages we readaheaded in a circulation,
our exit condition is not set right, one more nat page will be scanned
without readaheading, resulting worse read performance.

This patch fixes to read the correct number nat pages to avoid bad
performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7dd2b9d..ac91107 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1532,7 +1532,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 		if (unlikely(nid >= nm_i->max_nid))
 			nid = 0;
 
-		if (i++ == FREE_NID_PAGES)
+		if (++i >= FREE_NID_PAGES)
 			break;
 	}
 
-- 
2.4.2
