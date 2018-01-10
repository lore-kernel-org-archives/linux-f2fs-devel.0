From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to caclulate required free section
 correctly
Date: Wed, 10 Jan 2018 18:18:51 +0800
Message-ID: <20180110101852.12170-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZDTc-0000FP-Py
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 10:19:20 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZDTb-0008W3-EL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 10:19:20 +0000
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

When calculating required free section during file defragmenting, we
should skip holes in file, otherwise we will probably fail to defrag
sparse file with large size.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 926757e6065c..2fb3bab05872 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2140,10 +2140,12 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			continue;
 		}
 
-		if (blk_end && blk_end != map.m_pblk) {
+		if (blk_end && blk_end != map.m_pblk)
 			fragmented = true;
-			break;
-		}
+
+		/* record total count of block that we're going to move */
+		total += map.m_len;
+
 		blk_end = map.m_pblk + map.m_len;
 
 		map.m_lblk += map.m_len;
@@ -2152,10 +2154,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	if (!fragmented)
 		goto out;
 
-	map.m_lblk = pg_start;
-	map.m_len = pg_end - pg_start;
-
-	sec_num = (map.m_len + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
+	sec_num = (total + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
 
 	/*
 	 * make sure there are enough free section for LFS allocation, this can
@@ -2167,6 +2166,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		goto out;
 	}
 
+	map.m_lblk = pg_start;
+	map.m_len = pg_end - pg_start;
+	total = 0;
+
 	while (map.m_lblk < pg_end) {
 		pgoff_t idx;
 		int cnt = 0;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
