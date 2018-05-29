From: youngjun yoo <youngjun.willow@gmail.com>
Subject: [PATCH 3/3] fs: f2fs: insert space around that ':' and ', '
Date: Wed, 30 May 2018 04:34:58 +0900
Message-ID: <20180529193458.GA8924@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willow72@willow72>) id 1fNkOj-0001kF-45
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:35:09 +0000
Received: from [210.115.226.247] (helo=willow72)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1fNkOh-009QqK-Nl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:35:09 +0000
Content-Disposition: inline
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

clean up checkpatch error:
ERROR: space required after that ':'
ERROR: space required after that ','
Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index df8b02b..fcf26b4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1476,7 +1476,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		last_off = map.m_lblk + map.m_len - 1;
 
 		/* update new size to the failed position */
-		new_size = (last_off == pg_end) ? offset + len:
+		new_size = (last_off == pg_end) ? offset + len :
 					(loff_t)(last_off + 1) << PAGE_SHIFT;
 	} else {
 		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
@@ -2113,7 +2113,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	struct inode *inode = file_inode(filp);
 	struct f2fs_map_blocks map = { .m_next_extent = NULL,
 					.m_seg_type = NO_CHECK_TYPE };
-	struct extent_info ei = {0,0,0};
+	struct extent_info ei = {0, 0, 0};
 	pgoff_t pg_start, pg_end, next_pgofs;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
