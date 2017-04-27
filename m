From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: introduce CP_TRIMMED_FLAG to avoid
	unneeded discard
Date: Thu, 27 Apr 2017 20:40:40 +0800
Message-ID: <20170427124040.74399-2-yuchao0@huawei.com>
References: <20170427124040.74399-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3ikH-0004TU-FR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 12:42:05 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3ijp-00046s-38
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 12:42:05 +0000
In-Reply-To: <20170427124040.74399-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce CP_TRIMMED_FLAG to indicate all invalid block were trimmed
before umount, so once we do mount with image which contain the flag,
we don't record invalid blocks as undiscard one, when fstrim is being
triggered, we can avoid issuing redundant discard commands.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c    |  3 +++
 fs/f2fs/f2fs.h          |  1 +
 fs/f2fs/segment.c       | 28 ++++++++++++++++++++--------
 fs/f2fs/super.c         |  7 +++++++
 include/linux/f2fs_fs.h |  1 +
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 27578903eeb6..ea9c317b5916 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1059,6 +1059,9 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
 		disable_nat_bits(sbi, false);
 
+	if (cpc->reason & CP_TRIMMED)
+		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
+
 	if (cpc->reason & CP_UMOUNT)
 		__set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 	else
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 453eaa943a21..c6fce1631289 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -130,6 +130,7 @@ enum {
 #define	CP_SYNC		0x00000004
 #define	CP_RECOVERY	0x00000008
 #define	CP_DISCARD	0x00000010
+#define CP_TRIMMED	0x00000020
 
 #define DEF_BATCHED_TRIM_SECTIONS	2048
 #define BATCHED_TRIM_SEGMENTS(sbi)	\
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a2cd10cdff60..e4dd1e4a42c9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2989,10 +2989,17 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 
 			/* build discard map only one time */
 			if (f2fs_discard_en(sbi)) {
-				memcpy(se->discard_map, se->cur_valid_map,
-							SIT_VBLOCK_MAP_SIZE);
-				sbi->discard_blks += sbi->blocks_per_seg -
-							se->valid_blocks;
+				if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
+					memset(se->discard_map, 0xff,
+						SIT_VBLOCK_MAP_SIZE);
+				} else {
+					memcpy(se->discard_map,
+						se->cur_valid_map,
+						SIT_VBLOCK_MAP_SIZE);
+					sbi->discard_blks +=
+						sbi->blocks_per_seg -
+						se->valid_blocks;
+				}
 			}
 
 			if (sbi->segs_per_sec > 1)
@@ -3016,10 +3023,15 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 		seg_info_from_raw_sit(se, &sit);
 
 		if (f2fs_discard_en(sbi)) {
-			memcpy(se->discard_map, se->cur_valid_map,
-						SIT_VBLOCK_MAP_SIZE);
-			sbi->discard_blks += old_valid_blocks -
-						se->valid_blocks;
+			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
+				memset(se->discard_map, 0xff,
+							SIT_VBLOCK_MAP_SIZE);
+			} else {
+				memcpy(se->discard_map, se->cur_valid_map,
+							SIT_VBLOCK_MAP_SIZE);
+				sbi->discard_blks += old_valid_blocks -
+							se->valid_blocks;
+			}
 		}
 
 		if (sbi->segs_per_sec > 1)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4cd3bee6775f..9a14b2590337 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -797,6 +797,13 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	f2fs_wait_discard_bios(sbi);
 
+	if (!sbi->discard_blks) {
+		struct cp_control cpc = {
+			.reason = CP_UMOUNT | CP_TRIMMED,
+		};
+		write_checkpoint(sbi, &cpc);
+	}
+
 	/* write_checkpoint can update stat informaion */
 	f2fs_destroy_stats(sbi);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 093549e10ee2..b6feed6547ce 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -114,6 +114,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
