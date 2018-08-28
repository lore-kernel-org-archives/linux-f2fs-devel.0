From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: try to recover cp_payload from valid
 cp pack
Date: Tue, 28 Aug 2018 21:59:26 +0800
Message-ID: <20180828135926.109119-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fueXP-0002IV-9d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 14:00:07 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fueXM-000zKH-5b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 14:00:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

If sb checksum is not enabled, and cp pack is valid due to no
crc inconsistence, let's try to recover cp_payload based on
cp_pack_start_sum in cp pack.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/f2fs.h  |  5 +++++
 fsck/mount.c | 10 +++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index d2164449db15..0d0d5e2cc399 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -259,6 +259,11 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 	return 0;
 }
 
+static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
+{
+	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+}
+
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
diff --git a/fsck/mount.c b/fsck/mount.c
index 4f0c3fc0db50..9421f5953cd8 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -945,12 +945,16 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	}
 
 	cp_pack_start_sum = __start_sum_addr(sbi);
-	cp_payload = get_sb(cp_payload);
+	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
 		cp_pack_start_sum > blocks_per_seg - 1 -
 			NR_CURSEG_TYPE) {
-		MSG(0, "\tWrong cp_pack_start_sum(%u)\n", cp_pack_start_sum);
-		return 1;
+		MSG(0, "\tWrong cp_pack_start_sum(%u) or cp_payload(%u)\n",
+			cp_pack_start_sum, cp_payload);
+		if ((get_sb(feature) & F2FS_FEATURE_SB_CHKSUM))
+			return 1;
+		set_sb(cp_payload, cp_pack_start_sum - 1);
+		update_superblock(sb, SB_ALL);
 	}
 
 	return 0;
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
