From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] resize.f2fs: modify condition for resize
Date: Mon, 7 Nov 2016 21:25:58 +0800
Message-ID: <20161107132558.27636-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c3jq2-0002hr-Dg
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Nov 2016 13:19:50 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c3jq0-0001He-Ih
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 07 Nov 2016 13:19:50 +0000
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

it better to decide resize or not by sector num.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/main.c   | 4 ++--
 fsck/resize.c | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 7e8fdf3..64537cc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -444,9 +444,9 @@ static int do_resize(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
-	if (c.target_sectors ==
+	if (c.target_sectors <=
 			(get_sb(block_count) << get_sb(log_sectors_per_block))) {
-		ASSERT_MSG("Nothing to resize; it's same");
+		ASSERT_MSG("Nothing to resize, now only support resize to expand\n");
 		return -1;
 	}
 	return f2fs_resize(sbi);
diff --git a/fsck/resize.c b/fsck/resize.c
index 7691524..46aa30e 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -579,11 +579,6 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
-	if (old_main_blkaddr > new_main_blkaddr) {
-		MSG(0, "\tError: Support resize to expand only\n");
-		return -1;
-	}
-
 	err = -EAGAIN;
 	if (new_main_blkaddr < end_blkaddr) {
 		err = f2fs_defragment(sbi, old_main_blkaddr, offset,
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
