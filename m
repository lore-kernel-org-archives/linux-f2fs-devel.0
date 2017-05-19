From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: wake up all waiters in
	f2fs_submit_discard_endio
Date: Fri, 19 May 2017 23:46:44 +0800
Message-ID: <20170519154645.20121-2-chao@kernel.org>
References: <20170519154645.20121-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dBk9I-0005XY-P9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:49:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dBk9I-00025d-2T
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:49:04 +0000
In-Reply-To: <20170519154645.20121-1-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

There could be more than one waiter waiting discard IO completion, so we
need use complete_all() instead of complete() in f2fs_submit_discard_endio
to avoid hungtask.

Fixes: 	ec9895add2c5 ("f2fs: don't hold cmd_lock during waiting discard
command")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d310b82caef1..2b11119d9071 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -751,7 +751,7 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 
 	dc->error = bio->bi_error;
 	dc->state = D_DONE;
-	complete(&dc->wait);
+	complete_all(&dc->wait);
 	bio_put(bio);
 }
 
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
