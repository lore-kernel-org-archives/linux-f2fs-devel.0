From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: xfstests/091 failures
Date: Mon, 8 Feb 2016 17:23:42 -0800
Message-ID: <20160209012342.GA25381@jaegeuk.gateway>
References: <20160208045838.GC19486@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aSx20-00055t-MD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:23:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSx1z-0006s4-H5 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:23:52 +0000
Content-Disposition: inline
In-Reply-To: <20160208045838.GC19486@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dave,

Thank you for the report.

I've figured out that there is a bug in f2fs_insert_range, which dropps a dirty
data page when flushing blocks after finsert is done.
That is caused by not updating i_size instantly.

I wrote a patch for this like below.

Thanks,

>From 108daea1bd02014d118aa1dbc83553671f6848e9 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 8 Feb 2016 14:17:38 -0800
Subject: [PATCH] f2fs: increase i_size to avoid missing data

When finsert is doing with dirting pages, we should increase i_size right away.
Otherwise, the moved page is able to be dropped by the following
filemap_write_and_wait_range before updating i_size.
Especially, it can be done by
	if ((page->index >= end_index + 1) || !offset)
		goto out;
in f2fs_write_data_page.

This should resolve the below xfstests/091 failure reported by Dave.

$ diff -u tests/generic/091.out /home/dave/src/xfstests-dev/results//f2fs/generic/091.out.bad
--- tests/generic/091.out       2014-01-20 16:57:33.000000000 +1100
+++ /home/dave/src/xfstests-dev/results//f2fs/generic/091.out.bad       2016-02-08 15:21:02.701375087 +1100
@@ -1,7 +1,18 @@
 QA output created by 091
 fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
+mapped writes DISABLED
+skipping insert range behind EOF
+skipping insert range behind EOF
+truncating to largest ever: 0x11e00
+dowrite: write: Invalid argument
+LOG DUMP (7 total operations):
+1(  1 mod 256): SKIPPED (no operation)
+2(  2 mod 256): SKIPPED (no operation)
+3(  3 mod 256): FALLOC   0x2e0f2 thru 0x3134a  (0x3258 bytes) PAST_EOF
+4(  4 mod 256): SKIPPED (no operation)
+5(  5 mod 256): SKIPPED (no operation)
+6(  6 mod 256): TRUNCATE UP    from 0x0 to 0x11e00
+7(  7 mod 256): WRITE    0x73400 thru 0x79fff  (0x6c00 bytes) HOLE
+Log of operations saved to "/mnt/test/junk.fsxops"; replay with --replay-ops
+Correct content saved for comparison
+(maybe hexdump "/mnt/test/junk" vs "/mnt/test/junk.fsxgood")

Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e210b5..a4362d4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -891,7 +891,7 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 		psrc = get_lock_data_page(inode, src, true);
 		if (IS_ERR(psrc))
 			return PTR_ERR(psrc);
-		pdst = get_new_data_page(inode, NULL, dst, false);
+		pdst = get_new_data_page(inode, NULL, dst, true);
 		if (IS_ERR(pdst)) {
 			f2fs_put_page(psrc, 1);
 			return PTR_ERR(pdst);
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
