From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: fix check order in -p1
Date: Mon,  7 May 2018 11:53:13 -0700
Message-ID: <20180507185313.75217-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fFlGH-0006Hq-25
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 18:53:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFlGD-00BAYH-92
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 18:53:24 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Checking nat entries with nat_area_bitmap should be done before quota check,
since fsck_chk_quota_node() unsets quota inode numbers in nat_area_bitmap.
It causes for -p1 to conduct full scan.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 91c8529..688f24b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1788,19 +1788,7 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 	if (fsck_chk_orphan_node(sbi))
 		return -EINVAL;
 
-	/* 5. check quota inode simply */
-	if (fsck_chk_quota_node(sbi))
-		return -EINVAL;
-
-	if (fsck->nat_valid_inode_cnt != le32_to_cpu(cp->valid_inode_count)) {
-		ASSERT_MSG("valid inode does not match: nat_valid_inode_cnt %u,"
-				" valid_inode_count %u",
-				fsck->nat_valid_inode_cnt,
-				le32_to_cpu(cp->valid_inode_count));
-		return -EINVAL;
-	}
-
-	/*check nat entry with sit_area_bitmap*/
+	/* 5. check nat entry -- must be done before quota check */
 	for (i = 0; i < fsck->nr_nat_entries; i++) {
 		u32 blk = le32_to_cpu(fsck->entries[i].block_addr);
 		nid_t ino = le32_to_cpu(fsck->entries[i].ino);
@@ -1840,6 +1828,18 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 		}
 	}
 
+	/* 6. check quota inode simply */
+	if (fsck_chk_quota_node(sbi))
+		return -EINVAL;
+
+	if (fsck->nat_valid_inode_cnt != le32_to_cpu(cp->valid_inode_count)) {
+		ASSERT_MSG("valid inode does not match: nat_valid_inode_cnt %u,"
+				" valid_inode_count %u",
+				fsck->nat_valid_inode_cnt,
+				le32_to_cpu(cp->valid_inode_count));
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
