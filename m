From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix to write node pages with WRITE_SYNC
Date: Mon, 03 Mar 2014 14:07:18 +0900
Message-ID: <1393823238-31989-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WKL7t-0003bL-G4
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Mar 2014 05:09:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WKL7r-0000Ki-Da
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Mar 2014 05:09:17 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1U00FHUGZ668A0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Mar 2014 14:09:06 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: hbx7d@yandex.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes performance regression of dbench reported by
Alex <hbx7d@yandex.com>.

This issue was revealed by Phoronix tests results:
http://www.phoronix.com/scan.php?page=article&item=linux_314_ssdfs&num=2

It turns out that we need to assign WRITE_SYNC to the node writes, if
fsync is triggered.

The performance numbers are like below, which is measured by Alex.
1. 355MB/s       ext4
2. 225MB/s       f2fs : WRITE for node writes
3. 525MB/s       f2fs : WRITE_SYNC for node writes

Reported-And-Tested-by: Alex <hbx7d@yandex.com>.
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 00f937e..a4cc1d6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -115,7 +115,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0;
 	bool need_cp = false;
 	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_NONE,
+		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
 		.for_reclaim = 0,
 	};
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
