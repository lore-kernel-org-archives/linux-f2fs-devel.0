From: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 06/54] f2fs: f2fs_read_end_io: comment on
	direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:55 +0800
Message-ID: <1482854250-13481-7-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tom.leiming@gmail.com>) id 1cLu9c-0001Ee-0b
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 15:59:08 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cLu9a-0007Ln-U2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 Dec 2016 15:59:07 +0000
Received: by mail-pg0-f66.google.com with SMTP id b1so12788956pgc.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 27 Dec 2016 07:59:06 -0800 (PST)
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>, "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ac262564fa6..5d1a192e1c3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -55,6 +55,10 @@ static void f2fs_read_end_io(struct bio *bio)
 	int i;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
+	/*
+	 * It is still safe to retrieve the 1st page of the bio
+	 * in this way after supporting multipage bvec.
+	 */
 	if (time_to_inject(F2FS_P_SB(bio->bi_io_vec->bv_page), FAULT_IO))
 		bio->bi_error = -EIO;
 #endif
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
