From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: remove redundant check of page type when
 submit bio
Date: Tue, 6 Feb 2018 08:21:45 +0800 (CST)
Message-ID: <25158d37.852.161687d6bab.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <kernelpatch@126.com>) id 1eir1L-0001WX-6t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 00:21:59 +0000
Received: from m15-15.126.com ([220.181.15.15])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1eir1I-0002NB-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 00:21:59 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch removes redundant check of page type when submit bio to
make the logic more clear.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7435830..55f5e8d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -203,13 +203,12 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 	if (!is_read_io(bio_op(bio))) {
 		unsigned int start;
 
-		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
-			current->plug && (type == DATA || type == NODE))
-			blk_finish_plug(current->plug);
-
 		if (type != DATA && type != NODE)
 			goto submit_io;
 
+		if (f2fs_sb_mounted_blkzoned(sbi->sb) && current->plug)
+			blk_finish_plug(current->plug);
+
 		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
 		start %= F2FS_IO_SIZE(sbi);
 
-- 
1.8.3.1
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
