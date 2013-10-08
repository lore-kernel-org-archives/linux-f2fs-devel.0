From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid unnecessary checkpoints
Date: Tue, 08 Oct 2013 09:33:15 +0900
Message-ID: <1381192395-30296-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VTLFJ-0000sX-RY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 00:33:53 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTLFH-0002c6-Rt for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 00:33:53 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MUB009ZQQW8GP90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 09:33:45 +0900 (KST)
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

During the f2fs_put_super procedure, we don't need to conduct checkpoint all
the time, since we don't need to do that if superblock is clean.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fde8e6a..539c009 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -372,7 +372,9 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_destroy_stats(sbi);
 	stop_gc_thread(sbi);
 
-	write_checkpoint(sbi, true);
+	/* We don't need to do checkpoint when it's clean */
+	if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
+		write_checkpoint(sbi, true);
 
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
