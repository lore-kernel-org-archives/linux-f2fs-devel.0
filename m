From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: enable small discard by default
Date: Tue, 25 Apr 2017 00:21:35 +0800
Message-ID: <20170424162135.5566-2-chao@kernel.org>
References: <20170424162135.5566-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1d2gmH-0007cI-OR
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 16:23:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d2gmH-0006wW-0D
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 16:23:53 +0000
In-Reply-To: <20170424162135.5566-1-chao@kernel.org>
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

This patch start to enable 4K granularity small discard by default
when realtime discard is on, so, in seriously fragmented space,
small size discard can be issued in time to avoid useless storage
space occupying of invalid filesystem's data, then performance of
flash storage can be recovered.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 4 ++--
 fs/f2fs/segment.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d9a8d9101e..c620e98dcaa6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -230,8 +230,8 @@ struct discard_cmd_control {
 	struct list_head wait_list;		/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
-	int nr_discards;			/* # of discards in the list */
-	int max_discards;			/* max. discards to be issued */
+	unsigned int nr_discards;		/* # of discards in the list */
+	unsigned int max_discards;		/* max. discards to be issued */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8097b4c8c7c7..eebe721f43c1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1365,7 +1365,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->issing_discard, 0);
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
-	dcc->max_discards = 0;
+	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
