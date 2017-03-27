From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: prevent waiter encountering incorrect
	discard states
Date: Mon, 27 Mar 2017 18:14:06 +0800
Message-ID: <20170327101406.56028-3-yuchao0@huawei.com>
References: <20170327101406.56028-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1csRfW-0007F0-S3
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:34 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1csRfV-0006p3-M6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:34 +0000
In-Reply-To: <20170327101406.56028-1-yuchao0@huawei.com>
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
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 57a81f9c8c14..9f9542c9fe47 100644
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
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
