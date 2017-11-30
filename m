From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: avoid unneeded free nid building
Date: Thu, 30 Nov 2017 19:32:09 +0800
Message-ID: <20171130113211.62990-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN50-0003ST-OF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN4z-0001AF-JW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:34 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds nm_i::valid_bitmap_count to count current valid free
nid bitmap, with it we can skip running into __build_free_nids more
early.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f08e0feb38c1..fd9c8d1bffd5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -730,6 +730,7 @@ struct f2fs_nm_info {
 	unsigned char *nat_block_bitmap;
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
 	unsigned int available_free_nids;	/* available free nid count in bitmaps */
+	unsigned int valid_bitmap_count;	/* valid bitmap count */
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d2c9dcb0cbf8..4c758747980c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1882,6 +1882,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 	nat_blk = page_address(page);
 
 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
+	nm_i->valid_bitmap_count++;
 
 	i = nid % NAT_ENTRY_PER_BLOCK;
 
@@ -1969,6 +1970,16 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool mount)
 
 void build_free_nids(struct f2fs_sb_info *sbi, bool mount)
 {
+	/*
+	 * do not try to load nid bitmap from NAT blocks if all nid
+	 * bitmaps are available now.
+	 */
+	if (NM_I(sbi)->valid_bitmap_count >= NM_I(sbi)->nat_blocks) {
+		if (!mount)
+			cond_resched();
+		return;
+	}
+
 	mutex_lock(&NM_I(sbi)->build_lock);
 	__build_free_nids(sbi, mount);
 	mutex_unlock(&NM_I(sbi)->build_lock);
@@ -2489,6 +2500,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 			break;
 
 		__set_bit_le(i, nm_i->nat_block_bitmap);
+		nm_i->valid_bitmap_count++;
 
 		nid = i * NAT_ENTRY_PER_BLOCK;
 		last_nid = nid + NAT_ENTRY_PER_BLOCK;
@@ -2505,6 +2517,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 			break;
 
 		__set_bit_le(i, nm_i->nat_block_bitmap);
+		nm_i->valid_bitmap_count++;
 	}
 
 	scan_curseg_cache(sbi, 0, nm_i->max_nid);
@@ -2529,6 +2542,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
 				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
 	nm_i->available_free_nids = 0;
+	nm_i->valid_bitmap_count = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
