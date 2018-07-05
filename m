From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to detect looped node chain
 correctly
Date: Thu, 5 Jul 2018 19:37:00 +0800
Message-ID: <20180705113701.3466-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fb2aM-0006Vj-Hz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Jul 2018 11:38:06 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fb2aK-00HRcS-MK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Jul 2018 11:38:06 +0000
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

Below dmesg was printed when testing generic/388 of fstest:

F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22
F2FS-fs (zram1): Mounted with checkpoint version = 22300d0e
F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22

The reason is that we initialize free_blocks with free blocks of
filesystem, so if filesystem is full, free_blocks can be zero,
below condition will be true, so that, it will fail recovery.

if (++loop_cnt >= free_blocks ||
	blkaddr == next_blkaddr_of_node(page))

To fix this issue, initialize free_blocks with correct value which
includes over-privision blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 3051a5e5dfc7..0d927ae26c48 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -241,8 +241,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	struct page *page = NULL;
 	block_t blkaddr;
 	unsigned int loop_cnt = 0;
-	unsigned int free_blocks = sbi->user_block_count -
-					valid_user_blocks(sbi);
+	unsigned int free_blocks = MAIN_SEGS(sbi) * sbi->blocks_per_seg -
+						valid_user_blocks(sbi);
 	int err = 0;
 
 	/* get node pages in the current segment */
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
