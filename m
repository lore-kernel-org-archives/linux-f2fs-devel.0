From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: Allocate and stat mem used by free nid
 bitmap more accurately
Date: Wed, 27 Jun 2018 14:46:21 +0800
Message-ID: <1530081981-25514-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fY4R0-0004R0-4t
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 07:00:10 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fY4Qy-00A0Pk-03
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 07:00:10 +0000
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
Cc: zhangdianfang@huawei.com

This patch used f2fs_bitmap_size macro to calculate mem used by
free nid bitmap, and stat used mem including aligned part.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/debug.c         | 3 ++-
 fs/f2fs/node.c          | 2 +-
 include/linux/f2fs_fs.h | 5 -----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 2d65e77..214a968 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -215,7 +215,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += sizeof(struct f2fs_nm_info);
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
 	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
-	si->base_mem += NM_I(sbi)->nat_blocks * NAT_ENTRY_BITMAP_SIZE;
+	si->base_mem += NM_I(sbi)->nat_blocks *
+				f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK);
 	si->base_mem += NM_I(sbi)->nat_blocks / 8;
 	si->base_mem += NM_I(sbi)->nat_blocks * sizeof(unsigned short);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 47d0e64..872140f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2760,7 +2760,7 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
 		nm_i->free_nid_bitmap[i] = f2fs_kvzalloc(sbi,
-				NAT_ENTRY_BITMAP_SIZE_ALIGNED, GFP_KERNEL);
+			f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK), GFP_KERNEL);
 		if (!nm_i->free_nid_bitmap)
 			return -ENOMEM;
 	}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index aa5db8b..f70f8ac 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -304,11 +304,6 @@ struct f2fs_node {
  * For NAT entries
  */
 #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
-#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
-#define NAT_ENTRY_BITMAP_SIZE_ALIGNED				\
-	((NAT_ENTRY_BITMAP_SIZE + BITS_PER_LONG - 1) /		\
-	BITS_PER_LONG * BITS_PER_LONG)
-
 
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
