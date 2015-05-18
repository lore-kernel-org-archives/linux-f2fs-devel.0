From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs crypto: zero next free dnode block
Date: Mon, 18 May 2015 18:00:06 +0800
Message-ID: <003101d09151$85408140$8fc183c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now page cache of meta inode is used by garbage collection for encrypted page,
it may contain random data, so we should zero it before issuing discard.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 16aa66e..bdf874a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -504,7 +504,7 @@ void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	if (err) {
 		struct page *page = grab_meta_page(sbi, blkaddr);
-		/* zero-filled page */
+		memset(page_address(page), 0, F2FS_BLKSIZE);
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 	}
-- 
2.3.3
