From: Chao Yu <chao@kernel.org>
Subject: [PATCH] Revert "f2fs: handle dirty segments inside
 refresh_sit_entry"
Date: Sat, 28 Oct 2017 19:57:09 +0800
Message-ID: <20171028115709.4622-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e8PkJ-0004A7-Fh
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 11:57:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e8PkI-0000iv-Iw
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 11:57:47 +0000
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

From: Yunlong Song <yunlong.song@huawei.com>

This reverts commit 5e443818fa0b2a2845561ee25bec181424fb2889

The commit should be reverted because call sequence of below two parts
of code must be kept:
a. update sit information, it needs to be updated before segment
allocation since latter allocation may trigger SSR, and SSR allocation
needs latest valid block information of all segments.
b. update segment status, it needs to be updated after segment allocation
since we can skip updating current opened segment status.

Fixes: 5e443818fa0b ("f2fs: handle dirty segments inside refresh_sit_entry")
Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0de1761928d3..644706000e31 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1899,9 +1899,6 @@ void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)
 	update_sit_entry(sbi, new, 1);
 	if (GET_SEGNO(sbi, old) != NULL_SEGNO)
 		update_sit_entry(sbi, old, -1);
-
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, old));
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, new));
 }
 
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
@@ -2540,13 +2537,22 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	stat_inc_block_count(sbi, curseg);
 
+	/*
+	 * SIT information should be updated before segment allocation,
+	 * since SSR needs latest valid block information.
+	 */
+	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+
 	if (!__has_curseg_space(sbi, type))
 		sit_i->s_ops->allocate_segment(sbi, type, false);
+
 	/*
-	 * SIT information should be updated after segment allocation,
-	 * since we need to keep dirty segments precisely under SSR.
+	 * segment dirty status should be updated after segment allocation,
+	 * so we just need to update status only one time after previous
+	 * segment being closed.
 	 */
-	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
 	mutex_unlock(&sit_i->sentry_lock);
 
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
