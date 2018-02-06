From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] dump.f2fs: correct the seg type in ssa_dump
Date: Tue, 6 Feb 2018 16:47:14 +0800
Message-ID: <20180206084714.136306-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <zhengjunling@huawei.com>) id 1eiyuh-0008N1-N4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 08:47:39 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiyug-0006kt-9V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 08:47:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Fix the mixed using of "ret" in ssa_dump.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/dump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8772a62..23e4f47 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -195,7 +195,7 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 {
 	struct f2fs_summary_block *sum_blk;
 	char buf[BUF_SZ];
-	int segno, i, ret;
+	int segno, type, i, ret;
 	int fd;
 
 	fd = open("dump_ssa", O_CREAT|O_WRONLY|O_TRUNC, 0666);
@@ -208,10 +208,10 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 	ASSERT(ret >= 0);
 
 	for (segno = start_ssa; segno < end_ssa; segno++) {
-		sum_blk = get_sum_block(sbi, segno, &ret);
+		sum_blk = get_sum_block(sbi, segno, &type);
 
 		memset(buf, 0, BUF_SZ);
-		switch (ret) {
+		switch (type) {
 		case SEG_TYPE_CUR_NODE:
 			snprintf(buf, BUF_SZ, "\n\nsegno: %x, Current Node\n", segno);
 			break;
@@ -240,8 +240,8 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 			ret = write(fd, buf, strlen(buf));
 			ASSERT(ret >= 0);
 		}
-		if (ret == SEG_TYPE_NODE || ret == SEG_TYPE_DATA ||
-					ret == SEG_TYPE_MAX)
+		if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX)
 			free(sum_blk);
 	}
 	close(fd);
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
