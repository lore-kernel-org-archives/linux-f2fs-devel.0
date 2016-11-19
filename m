From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] dump.f2fs: fix an error in dump nat pack num
Date: Sat, 19 Nov 2016 21:24:41 +0800
Message-ID: <20161119132441.417-2-heyunlei@huawei.com>
References: <20161119132441.417-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c85X6-00028t-01
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Nov 2016 13:18:16 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c85X5-0001OZ-5t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Nov 2016 13:18:15 +0000
In-Reply-To: <20161119132441.417-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch fix an error in dump nat pack num

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8e7c85c..5d0d3d9 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -34,7 +34,7 @@ void nat_dump(struct f2fs_sb_info *sbi)
 	pgoff_t block_addr;
 	char buf[BUF_SZ];
 	int seg_off;
-	int fd, ret, pack = 1;
+	int fd, ret, pack;
 	unsigned int i;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
@@ -47,7 +47,7 @@ void nat_dump(struct f2fs_sb_info *sbi)
 	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
 	ASSERT(fd >= 0);
 
-	for (block_off = 0; block_off < nr_nat_blks; block_off++) {
+	for (block_off = 0; block_off < nr_nat_blks; pack = 1, block_off++) {
 
 		seg_off = block_off >> sbi->log_blocks_per_seg;
 		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-- 
2.10.1


------------------------------------------------------------------------------
