From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: remove unneeded disable_nat_bits()
Date: Thu,  4 Oct 2018 11:15:20 +0800
Message-ID: <20181004031520.4096-3-chao@kernel.org>
References: <20181004031520.4096-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004031520.4096-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Commit 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
added disable_nat_bits() in error path of __get_nat_bitmaps(), but it's
unneeded, beause we will fail mount, we won't have chance to change nid
usage status w/o nat full/empty bitmaps.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8c0367cfb1bb..2b34206486d8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2879,10 +2879,8 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 		struct page *page;
 
 		page = f2fs_get_meta_page(sbi, nat_bits_addr++);
-		if (IS_ERR(page)) {
-			disable_nat_bits(sbi, true);
+		if (IS_ERR(page))
 			return PTR_ERR(page);
-		}
 
 		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
 					page_address(page), F2FS_BLKSIZE);
-- 
2.18.0
