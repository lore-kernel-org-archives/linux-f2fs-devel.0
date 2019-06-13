From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: introduce get_checkpoint_version()
 for cleanup
Date: Thu, 13 Jun 2019 16:09:03 +0800
Message-ID: <20190613080903.4828-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbKoJ-0005Fl-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:10:15 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbKoG-004jgN-IZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:10:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index aecd0cd..8d5d5cf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -780,6 +780,24 @@ static int verify_checksum_chksum(struct f2fs_checkpoint *cp)
 	return 0;
 }
 
+static void *get_checkpoint_version(block_t cp_addr)
+{
+	void *cp_page;
+
+	cp_page = malloc(PAGE_SIZE);
+	ASSERT(cp_page);
+
+	if (dev_read_block(cp_page, cp_addr) < 0)
+		ASSERT(0);
+
+	if (verify_checksum_chksum((struct f2fs_checkpoint *)cp_page))
+		goto out;
+	return cp_page;
+out:
+	free(cp_page);
+	return NULL;
+}
+
 void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 				unsigned long long *version)
 {
@@ -788,34 +806,23 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	unsigned long long cur_version = 0, pre_version = 0;
 
 	/* Read the 1st cp block in this CP pack */
-	cp_page_1 = malloc(PAGE_SIZE);
-	ASSERT(cp_page_1);
-
-	if (dev_read_block(cp_page_1, cp_addr) < 0)
-		goto invalid_cp1;
+	cp_page_1 = get_checkpoint_version(cp_addr);
+	if (!cp_page_1)
+		return NULL;
 
 	cp = (struct f2fs_checkpoint *)cp_page_1;
-	if (verify_checksum_chksum(cp))
-		goto invalid_cp1;
-
 	if (get_cp(cp_pack_total_block_count) > sbi->blocks_per_seg)
 		goto invalid_cp1;
 
 	pre_version = get_cp(checkpoint_ver);
 
 	/* Read the 2nd cp block in this CP pack */
-	cp_page_2 = malloc(PAGE_SIZE);
-	ASSERT(cp_page_2);
-
 	cp_addr += get_cp(cp_pack_total_block_count) - 1;
-
-	if (dev_read_block(cp_page_2, cp_addr) < 0)
-		goto invalid_cp2;
+	cp_page_2 = get_checkpoint_version(cp_addr);
+	if (!cp_page_2)
+		goto invalid_cp1;
 
 	cp = (struct f2fs_checkpoint *)cp_page_2;
-	if (verify_checksum_chksum(cp))
-		goto invalid_cp2;
-
 	cur_version = get_cp(checkpoint_ver);
 
 	if (cur_version == pre_version) {
@@ -824,7 +831,6 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 		return cp_page_1;
 	}
 
-invalid_cp2:
 	free(cp_page_2);
 invalid_cp1:
 	free(cp_page_1);
-- 
2.18.0.rc1
