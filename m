From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: write dirty meta pages collectively
Date: Tue, 17 Dec 2013 17:31:58 +0900
Message-ID: <1387269118-22410-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vsq5d-00074F-9K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 08:33:17 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vsq5b-0002vl-5H
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 08:33:17 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MXX00G3BZR75I60@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Dec 2013 17:33:07 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch enhances writing dirty meta pages collectively in background.
During the file data writes, it'd better avoid to write small dirty meta pages
frequently.
So let's give a chance to collect a number of dirty meta pages for a while.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f8c0749..2004b7b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -108,17 +108,19 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(mapping->host->i_sb);
 	struct block_device *bdev = sbi->sb->s_bdev;
+	int nrpages = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
 	long written;
 
 	if (wbc->for_kupdate)
 		return 0;
 
-	if (get_pages(sbi, F2FS_DIRTY_META) == 0)
+	/* collect a number of dirty meta pages and write together */
+	if (get_pages(sbi, F2FS_DIRTY_META) < nrpages)
 		return 0;
 
 	/* if mounting is failed, skip writing node pages */
 	mutex_lock(&sbi->cp_mutex);
-	written = sync_meta_pages(sbi, META, bio_get_nr_vecs(bdev));
+	written = sync_meta_pages(sbi, META, nrpages);
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write -= written;
 	return 0;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
