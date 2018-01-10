From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: speed up defragment on sparse file
Date: Wed, 10 Jan 2018 18:18:52 +0800
Message-ID: <20180110101852.12170-2-yuchao0@huawei.com>
References: <20180110101852.12170-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZDTc-0000FV-Sr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 10:19:20 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZDTb-0007VT-GG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 10:19:20 +0000
In-Reply-To: <20180110101852.12170-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We have supported to get next page offset with valid mapping crossing
hole in f2fs_map_blocks, utilizing it to speed up defragment on sparse
file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c |  6 +++++-
 fs/f2fs/file.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 882b5acc2b6f..d671657ade8a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1012,8 +1012,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 					*map->m_next_pgofs = pgofs + 1;
 				goto sync_out;
 			}
-			if (flag != F2FS_GET_BLOCK_FIEMAP)
+			if (flag != F2FS_GET_BLOCK_FIEMAP) {
+				/* for defragment case */
+				if (map->m_next_pgofs)
+					*map->m_next_pgofs = pgofs + 1;
 				goto sync_out;
+			}
 		}
 	}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2fb3bab05872..ac22ecda7787 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2086,10 +2086,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 					struct f2fs_defragment *range)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
-			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE };
+	struct f2fs_map_blocks map = { .m_next_extent = NULL,
+					.m_seg_type = NO_CHECK_TYPE };
 	struct extent_info ei = {0,0,0};
-	pgoff_t pg_start, pg_end;
+	pgoff_t pg_start, pg_end, next_pgofs;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
 	block_t blk_end = 0;
@@ -2123,6 +2123,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	}
 
 	map.m_lblk = pg_start;
+	map.m_next_pgofs = &next_pgofs;
 
 	/*
 	 * lookup mapping info in dnode page cache, skip defragmenting if all
@@ -2136,7 +2137,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			goto out;
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
-			map.m_lblk++;
+			map.m_lblk = next_pgofs;
 			continue;
 		}
 
@@ -2181,7 +2182,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			goto clear_out;
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
-			map.m_lblk++;
+			map.m_lblk = next_pgofs;
 			continue;
 		}
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
