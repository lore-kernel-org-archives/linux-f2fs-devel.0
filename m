From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] f2fs: remove request_list check in is_idle()
Date: Tue, 16 Oct 2018 08:34:50 -0600
Message-ID: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <axboe@kernel.dk>) id 1gCQo3-0005Nk-Qi
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 14:58:47 +0000
Received: from mail-it1-f194.google.com ([209.85.166.194])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gCQo1-002l62-Nf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 14:58:47 +0000
Received: by mail-it1-f194.google.com with SMTP id p64-v6so32524544itp.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Oct 2018 07:58:45 -0700 (PDT)
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

This doesn't work on stacked devices, and it doesn't work on
blk-mq devices. The request_list is only used on legacy, which
we don't have much of anymore, and soon won't have any of.

Kill the check.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/f2fs/f2fs.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index abf925664d9c..58778992eca4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1356,13 +1356,6 @@ static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
 
 static inline bool is_idle(struct f2fs_sb_info *sbi)
 {
-	struct block_device *bdev = sbi->sb->s_bdev;
-	struct request_queue *q = bdev_get_queue(bdev);
-	struct request_list *rl = &q->root_rl;
-
-	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
-		return false;
-
 	return f2fs_time_over(sbi, REQ_TIME);
 }
 
-- 
2.17.1

-- 
Jens Axboe
