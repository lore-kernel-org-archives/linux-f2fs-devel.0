From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: wait for discard completion after
	submission
Date: Wed, 22 Feb 2017 20:28:49 -0800
Message-ID: <20170223042850.43456-3-jaegeuk@kernel.org>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgl1b-0002nf-B2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:03 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgl1a-0008Un-JL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:03 +0000
In-Reply-To: <20170223042850.43456-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We don't need to wait for each discard commands when unmounting the image.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 567019940e9b..d76e49c3d1b4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -676,8 +676,12 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = &(dcc->discard_cmd_list);
 	struct discard_cmd *dc, *tmp;
+	struct blk_plug plug;
 
 	mutex_lock(&dcc->cmd_lock);
+
+	blk_start_plug(&plug);
+
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 
 		if (blkaddr == NULL_ADDR) {
@@ -686,9 +690,6 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 				submit_bio(dc->bio);
 				atomic_inc(&dcc->submit_discard);
 			}
-			wait_for_completion_io(&dc->wait);
-
-			__remove_discard_cmd(sbi, dc);
 			continue;
 		}
 
@@ -699,6 +700,15 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 				__remove_discard_cmd(sbi, dc);
 		}
 	}
+	blk_finish_plug(&plug);
+
+	/* this comes from f2fs_put_super */
+	if (blkaddr == NULL_ADDR) {
+		list_for_each_entry_safe(dc, tmp, wait_list, list) {
+			wait_for_completion_io(&dc->wait);
+			__remove_discard_cmd(sbi, dc);
+		}
+	}
 	mutex_unlock(&dcc->cmd_lock);
 }
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
