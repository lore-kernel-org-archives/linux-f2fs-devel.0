From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: delay awaking discard thread
Date: Tue, 25 Apr 2017 00:21:34 +0800
Message-ID: <20170424162135.5566-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d2gmF-0007dt-Ey
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 16:23:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d2gmD-0003EF-LS
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 16:23:51 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

It's better to delay awaking discard thread while queuing discard commands
in checkpoint, it will help to give more chances for merging big and small
discard.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d4bda1e54475..8097b4c8c7c7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -971,7 +971,6 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 		blkstart -= FDEV(devi).start_blk;
 	}
 	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
-	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
 	return 0;
 }
 
@@ -1338,6 +1337,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		SM_I(sbi)->dcc_info->nr_discards -= total_len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
+
+	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
 }
 
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
