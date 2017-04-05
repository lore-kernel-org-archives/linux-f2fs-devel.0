From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: prevent waiter encountering incorrect
	discard states
Date: Wed, 5 Apr 2017 18:26:26 +0800
Message-ID: <20170405102626.60148-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cvi9q-00011U-Fi
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:27:22 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cvi9f-0001Yt-3R
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:27:22 +0000
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

In f2fs_submit_discard_endio, we will wake up waiter before setting
discard command states, so waiter may use incorrect states. Change
the order between complete() and states setting to fix this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: use wait_for_completion_io before releasing discard entry to avoid
use-after-free.
 fs/f2fs/segment.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24911c5679d6..ec19cfcfcd24 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -717,9 +717,9 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 {
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 
-	complete(&dc->wait);
 	dc->error = bio->bi_error;
 	dc->state = D_DONE;
+	complete(&dc->wait);
 	bio_put(bio);
 }
 
@@ -807,8 +807,7 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len) {
-			if (dc->state == D_SUBMIT)
-				wait_for_completion_io(&dc->wait);
+			wait_for_completion_io(&dc->wait);
 			__punch_discard_cmd(sbi, dc, blkaddr);
 		}
 	}
@@ -868,8 +867,10 @@ static int issue_discard_thread(void *data)
 	blk_finish_plug(&plug);
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->state == D_DONE)
+		if (dc->state == D_DONE) {
+			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
+		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
