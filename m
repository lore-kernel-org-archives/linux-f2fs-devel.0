From: Yunlei He <heyunlei@huawei.com>
Subject: [f2fs-dev][PATCH v2] f2fs: fix a problem of using memory after free
Date: Mon, 19 Dec 2016 20:10:48 +0800
Message-ID: <20161219121048.15452-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: bintian.wang@huawei.com, heyunlei@huwei.com, fanofcode.li@samsung.com, stable@vger.kernel.org, houpengyang@huawei.com, Yunlei He <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fix a problem of using memory after free
in function __try_merge_extent_node.

Fixes: 0f825ee6e873 ("f2fs: add new interfaces for extent tree")
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/extent_cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4db44da..e02c3d8 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -352,11 +352,12 @@ static struct extent_node *__try_merge_extent_node(struct inode *inode,
 	}
 
 	if (next_ex && __is_front_mergeable(ei, &next_ex->ei)) {
-		if (en)
-			__release_extent_node(sbi, et, prev_ex);
 		next_ex->ei.fofs = ei->fofs;
 		next_ex->ei.blk = ei->blk;
 		next_ex->ei.len += ei->len;
+		if (en)
+			__release_extent_node(sbi, et, prev_ex);
+
 		en = next_ex;
 	}
 
-- 
2.10.1
