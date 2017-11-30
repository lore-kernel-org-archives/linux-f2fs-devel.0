From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: allocate full free nat block in prior
Date: Thu, 30 Nov 2017 19:32:11 +0800
Message-ID: <20171130113211.62990-3-yuchao0@huawei.com>
References: <20171130113211.62990-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN50-0003SM-KH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN4z-0000t3-Cn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:34 +0000
In-Reply-To: <20171130113211.62990-1-yuchao0@huawei.com>
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

In this patch, during alloc_nid, we start to allocate free nid from
nat block which contains the most free nids, it will make all dirty
nat entries locating in the same nat block, result in reducing nat
writes during checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/node.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fd9c8d1bffd5..83d1f697388b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -731,6 +731,8 @@ struct f2fs_nm_info {
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
 	unsigned int available_free_nids;	/* available free nid count in bitmaps */
 	unsigned int valid_bitmap_count;	/* valid bitmap count */
+	unsigned int current_nat_block;	/* current nat block in allocation */
+	unsigned int next_free_nid_pos;	/* next free nid position */
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fb52622727ea..528e3af13070 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1905,30 +1905,68 @@ static void scan_nat_page(struct f2fs_sb_info *sbi, unsigned int nat_ofs)
 	scan_curseg_cache(sbi, start_nid, start_nid + NAT_ENTRY_PER_BLOCK);
 }
 
-static nid_t lookup_free_nid_bitmap(struct f2fs_sb_info *sbi)
+static nid_t lookup_in_target_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int nat_ofs = nm_i->current_nat_block;
+	unsigned int next_pos = nm_i->next_free_nid_pos;
+
+	if (test_bit_le(next_pos, nm_i->free_nid_bitmap[nat_ofs]))
+		goto got_it;
+
+	next_pos = find_next_bit_le(nm_i->free_nid_bitmap[nat_ofs],
+					NAT_ENTRY_PER_BLOCK, next_pos);
+	if (next_pos < NAT_ENTRY_PER_BLOCK)
+		goto got_it;
+
+	next_pos = find_next_bit_le(nm_i->free_nid_bitmap[nat_ofs],
+							next_pos, 0);
+	if (next_pos < NAT_ENTRY_PER_BLOCK)
+		goto got_it;
+
+	f2fs_bug_on(sbi, 1);
+	return 0;
+got_it:
+	nm_i->next_free_nid_pos = next_pos + 1;
+	return nat_ofs * NAT_ENTRY_PER_BLOCK + next_pos;
+}
+
+static void find_target_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int i;
-	nid_t nid = 0;
+	unsigned int max_count = 0;
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
-		unsigned int idx = 0;
-
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
 		if (!nm_i->free_nid_count[i])
 			continue;
+		if (nm_i->free_nid_count[i] == NAT_ENTRY_PER_BLOCK) {
+			nm_i->current_nat_block = i;
+			break;
+		}
+		if (nm_i->free_nid_count[i] > max_count) {
+			max_count = nm_i->free_nid_count[i];
+			nm_i->current_nat_block = i;
+		}
+	}
 
-		idx = find_next_bit_le(nm_i->free_nid_bitmap[i],
-					NAT_ENTRY_PER_BLOCK, idx);
-		if (idx >= NAT_ENTRY_PER_BLOCK)
-			continue;
+	nm_i->next_free_nid_pos = 0;
+}
 
-		nid = i * NAT_ENTRY_PER_BLOCK + idx;
-		break;
-	}
+static nid_t lookup_free_nid_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int nat_ofs = nm_i->current_nat_block;
+	nid_t nid = 0;
+
+	if (nat_ofs == nm_i->nat_blocks || !nm_i->free_nid_count[nat_ofs])
+		find_target_bitmap(sbi);
 
+	nid = lookup_in_target_bitmap(sbi);
 	f2fs_bug_on(sbi, !nid);
+
 	return nid;
 }
 
@@ -2557,6 +2595,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
 	nm_i->available_free_nids = 0;
 	nm_i->valid_bitmap_count = 0;
+	nm_i->current_nat_block = nm_i->nat_blocks;
+	nm_i->next_free_nid_pos = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
