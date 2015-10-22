From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: fix to skip shrinking extent nodes
Date: Thu, 22 Oct 2015 18:24:12 +0800
Message-ID: <031a01d10cb3$e3dd5e70$ab981b50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_shrink_extent_tree we should stop shrink flow if we have already
shrunk enough nodes in extent cache.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index a38ee9b..7ddba81 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -620,7 +620,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 			write_unlock(&et->lock);
 
 			if (node_cnt + tree_cnt >= nr_shrink)
-				break;
+				goto unlock_out;
 		}
 	}
 unlock_out:
-- 
2.6.1
