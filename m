From: Fan Li <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix to reset variable correctlly
Date: Tue, 15 Dec 2015 17:02:41 +0800
Message-ID: <006301d13717$7325fd20$5971f760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_map_blocks will set m_flags and m_len to 0, so we don't need to
reset m_flags ourselves, but have to reset m_len to correct value
before use it again.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/file.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9949d0f..2c8050c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1700,7 +1700,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	}
 
 	map.m_lblk = pg_start;
-	map.m_len = pg_end - pg_start;
 
 	/*
 	 * lookup mapping info in dnode page cache, skip defragmenting if all
@@ -1708,14 +1707,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * in logical blocks.
 	 */
 	while (map.m_lblk < pg_end) {
-		map.m_flags = 0;
+		map.m_len = pg_end - map.m_lblk;
 		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
 		if (err)
 			goto out;
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			map.m_lblk++;
-			map.m_len--;
 			continue;
 		}
 
@@ -1726,7 +1724,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		blk_end = map.m_pblk + map.m_len;
 
 		map.m_lblk += map.m_len;
-		map.m_len = pg_end - map.m_lblk;
 	}
 
 	if (!fragmented)
@@ -1752,14 +1749,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		int cnt = 0;
 
 do_map:
-		map.m_flags = 0;
+		map.m_len = pg_end - map.m_lblk;
 		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_READ);
 		if (err)
 			goto clear_out;
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			map.m_lblk++;
-			map.m_len--;
 			continue;
 		}
 
@@ -1784,7 +1780,6 @@ do_map:
 		}
 
 		map.m_lblk = idx;
-		map.m_len = pg_end - idx;
 
 		if (idx < pg_end && cnt < blk_per_seg)
 			goto do_map;
-- 
1.7.9.5
