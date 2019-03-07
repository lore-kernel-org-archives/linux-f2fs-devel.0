From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't trigger read IO for beyond EOF page
Date: Thu, 7 Mar 2019 17:31:30 +0800
Message-ID: <20190307093130.28556-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_mpage_readpages(), if page is beyond EOF, we should just
zero out it, but previously, before checking previous mapping
info, we missed to check filesize boundary, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fa6318549af5..912fdcc2dbb8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1551,6 +1551,9 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (last_block > last_block_in_file)
 			last_block = last_block_in_file;
 
+		/* just zeroing out page which is beyond EOF */
+		if (block_in_file >= last_block)
+			goto zero_out;
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -1563,16 +1566,11 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		 * Then do more f2fs_map_blocks() calls until we are
 		 * done with this page.
 		 */
-		map.m_flags = 0;
+		map.m_lblk = block_in_file;
+		map.m_len = last_block - block_in_file;
 
-		if (block_in_file < last_block) {
-			map.m_lblk = block_in_file;
-			map.m_len = last_block - block_in_file;
-
-			if (f2fs_map_blocks(inode, &map, 0,
-						F2FS_GET_BLOCK_DEFAULT))
-				goto set_error_page;
-		}
+		if (f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT))
+			goto set_error_page;
 got_it:
 		if ((map.m_flags & F2FS_MAP_MAPPED)) {
 			block_nr = map.m_pblk + block_in_file - map.m_lblk;
@@ -1587,6 +1585,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 								DATA_GENERIC))
 				goto set_error_page;
 		} else {
+zero_out:
 			zero_user_segment(page, 0, PAGE_SIZE);
 			if (!PageUptodate(page))
 				SetPageUptodate(page);
-- 
2.18.0.rc1
