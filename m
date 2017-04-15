From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: trace __submit_discard_cmd
Date: Sat, 15 Apr 2017 14:09:38 +0800
Message-ID: <20170415060938.43694-3-yuchao0@huawei.com>
References: <20170415060938.43694-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1czGuS-000789-Ci
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:12 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1czGuR-0004J2-3T
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:12 +0000
In-Reply-To: <20170415060938.43694-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Add an even class f2fs_discard for introducing f2fs_queue_discard, then
use f2fs_{queue,issue}_discard to trace __{queue,submit}_discard_cmd.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c           |  4 +++-
 include/trace/events/f2fs.h | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8a2fa3076df5..08b9e3806a50 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -763,6 +763,8 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (dc->state != D_PREP)
 		return;
 
+	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
+
 	dc->error = __blkdev_issue_discard(dc->bdev,
 				SECTOR_FROM_BLOCK(dc->start),
 				SECTOR_FROM_BLOCK(dc->len),
@@ -942,7 +944,7 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	block_t lblkstart = blkstart;
 
-	trace_f2fs_issue_discard(bdev, blkstart, blklen);
+	trace_f2fs_queue_discard(bdev, blkstart, blklen);
 
 	if (sbi->s_ndevs) {
 		int devi = f2fs_target_device_index(sbi, blkstart);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1714c75822de..2e8f68f244d4 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1129,7 +1129,7 @@ TRACE_EVENT(f2fs_write_checkpoint,
 		__entry->msg)
 );
 
-TRACE_EVENT(f2fs_issue_discard,
+DECLARE_EVENT_CLASS(f2fs_discard,
 
 	TP_PROTO(struct block_device *dev, block_t blkstart, block_t blklen),
 
@@ -1153,6 +1153,20 @@ TRACE_EVENT(f2fs_issue_discard,
 		(unsigned long long)__entry->blklen)
 );
 
+DEFINE_EVENT(f2fs_discard, f2fs_queue_discard,
+
+	TP_PROTO(struct block_device *dev, block_t blkstart, block_t blklen),
+
+	TP_ARGS(dev, blkstart, blklen)
+);
+
+DEFINE_EVENT(f2fs_discard, f2fs_issue_discard,
+
+	TP_PROTO(struct block_device *dev, block_t blkstart, block_t blklen),
+
+	TP_ARGS(dev, blkstart, blklen)
+);
+
 TRACE_EVENT(f2fs_issue_reset_zone,
 
 	TP_PROTO(struct block_device *dev, block_t blkstart),
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
