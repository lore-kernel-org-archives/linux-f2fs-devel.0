From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/6] f2fs: don't need to get f2fs_lock_op for the
 inline_data test
Date: Fri, 27 Dec 2013 13:00:15 +0900
Message-ID: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcS-0006K0-VC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:53 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcR-0004oc-NZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:52 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG00F3W5UL6G90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 13:01:33 +0900 (KST)
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

This patch locates checking the inline_data prior to calling f2fs_lock_op()
in truncate_blocks(), since getting the lock is unnecessary.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dd80e72..7ef2d6a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -261,14 +261,14 @@ static int truncate_blocks(struct inode *inode, u64 from)
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
+	if (f2fs_has_inline_data(inode))
+		goto done;
+
 	free_from = (pgoff_t)
 			((from + blocksize - 1) >> (sbi->log_blocksize));
 
 	f2fs_lock_op(sbi);
 
-	if (f2fs_has_inline_data(inode))
-		goto done;
-
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, free_from, LOOKUP_NODE);
 	if (err) {
@@ -295,9 +295,8 @@ static int truncate_blocks(struct inode *inode, u64 from)
 	f2fs_put_dnode(&dn);
 free_next:
 	err = truncate_inode_blocks(inode, free_from);
-done:
 	f2fs_unlock_op(sbi);
-
+done:
 	/* lastly zero out the first data page */
 	truncate_partial_data_page(inode, from);
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
