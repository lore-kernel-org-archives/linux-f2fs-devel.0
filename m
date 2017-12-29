From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: Remove unused ckpt_valid_map info
Date: Fri, 29 Dec 2017 10:11:09 +0800
Message-ID: <1514513469-9141-2-git-send-email-heyunlei@huawei.com>
References: <1514513469-9141-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eUkMC-0006Us-60
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:25:12 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUkM7-0004Eb-U1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 02:25:12 +0000
In-Reply-To: <1514513469-9141-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

Remove unused ckpt_valid_map info.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/f2fs.h  |  6 ------
 fsck/mount.c | 12 +++---------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 34b2481..58081bc 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -65,12 +65,6 @@ struct f2fs_nm_info {
 struct seg_entry {
 	unsigned short valid_blocks;    /* # of valid blocks */
 	unsigned char *cur_valid_map;   /* validity bitmap of blocks */
-	/*
-	 * # of valid blocks and the validity bitmap stored in the the last
-	 * checkpoint pack. This information is used by the SSR mode.
-	 */
-	unsigned short ckpt_valid_blocks;
-	unsigned char *ckpt_valid_map;
 	unsigned char type;             /* segment type like CURSEG_XXX_TYPE */
 	unsigned char orig_type;        /* segment type like CURSEG_XXX_TYPE */
 	unsigned long long mtime;       /* modification time of the segment */
diff --git a/fsck/mount.c b/fsck/mount.c
index 665fa4b..bab58aa 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1086,10 +1086,7 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	for (start = 0; start < TOTAL_SEGS(sbi); start++) {
 		sit_i->sentries[start].cur_valid_map
 			= calloc(SIT_VBLOCK_MAP_SIZE, 1);
-		sit_i->sentries[start].ckpt_valid_map
-			= calloc(SIT_VBLOCK_MAP_SIZE, 1);
-		if (!sit_i->sentries[start].cur_valid_map
-				|| !sit_i->sentries[start].ckpt_valid_map)
+		if (!sit_i->sentries[start].cur_valid_map)
 			return -ENOMEM;
 	}
 
@@ -1396,9 +1393,7 @@ void seg_info_from_raw_sit(struct seg_entry *se,
 		struct f2fs_sit_entry *raw_sit)
 {
 	se->valid_blocks = GET_SIT_VBLOCKS(raw_sit);
-	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(raw_sit);
 	memcpy(se->cur_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
-	memcpy(se->ckpt_valid_map, raw_sit->valid_map, SIT_VBLOCK_MAP_SIZE);
 	se->type = GET_SIT_TYPE(raw_sit);
 	se->orig_type = GET_SIT_TYPE(raw_sit);
 	se->mtime = le64_to_cpu(raw_sit->mtime);
@@ -2398,10 +2393,9 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
 	free(sbi->nm_info);
 
 	/* free sit_info */
-	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
+	for (i = 0; i < TOTAL_SEGS(sbi); i++)
 		free(sit_i->sentries[i].cur_valid_map);
-		free(sit_i->sentries[i].ckpt_valid_map);
-	}
+
 	free(sit_i->sit_bitmap);
 	free(sm_i->sit_info);
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
