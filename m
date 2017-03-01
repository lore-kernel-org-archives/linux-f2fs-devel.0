From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: skip scanning free nid bitmap of full NAT
	blocks
Date: Wed, 1 Mar 2017 17:09:07 +0800
Message-ID: <20170301090907.82629-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cj0GP-00058N-V4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 09:09:37 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cj0GM-0003FV-KV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 09:09:37 +0000
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

This patch adds to account free nids for each NAT blocks, and while
scanning all free nid bitmap, do check count and skip lookuping in
full NAT block.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c |  1 +
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/node.c  | 34 ++++++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a77df377e2e8..ee2d0a485fc3 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -196,6 +196,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
 	si->base_mem += NM_I(sbi)->nat_blocks * NAT_ENTRY_BITMAP_SIZE;
 	si->base_mem += NM_I(sbi)->nat_blocks / 8;
+	si->base_mem += NM_I(sbi)->nat_blocks * sizeof(unsigned short);
 
 get_cache:
 	si->cache_mem = 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e2924981eeb..c0b33719dfa9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -557,6 +557,8 @@ struct f2fs_nm_info {
 	struct mutex build_lock;	/* lock for build free nids */
 	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
 	unsigned char *nat_block_bitmap;
+	unsigned short *free_nid_count;	/* free nid count of NAT block */
+	spinlock_t free_nid_lock;	/* protect updating of nid count */
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 94967171dee8..1a759d45b7e4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1823,7 +1823,8 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid, bool set)
+void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
+							bool set, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
@@ -1836,6 +1837,13 @@ void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid, bool set)
 		set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
 	else
 		clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+
+	spin_lock(&nm_i->free_nid_lock);
+	if (set)
+		nm_i->free_nid_count[nat_ofs]++;
+	else if (!build)
+		nm_i->free_nid_count[nat_ofs]--;
+	spin_unlock(&nm_i->free_nid_lock);
 }
 
 static void scan_nat_page(struct f2fs_sb_info *sbi,
@@ -1847,6 +1855,9 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
 	int i;
 
+	if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
+		return;
+
 	set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
 	i = start_nid % NAT_ENTRY_PER_BLOCK;
@@ -1861,7 +1872,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
 		if (blk_addr == NULL_ADDR)
 			freed = add_free_nid(sbi, start_nid, true);
-		update_free_nid_bitmap(sbi, start_nid, freed);
+		update_free_nid_bitmap(sbi, start_nid, freed, true);
 	}
 }
 
@@ -1877,6 +1888,8 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	for (i = 0; i < nm_i->nat_blocks; i++) {
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
+		if (!nm_i->free_nid_count[i])
+			continue;
 		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
 			nid_t nid;
 
@@ -2081,7 +2094,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
 		nm_i->available_nids--;
 
-		update_free_nid_bitmap(sbi, *nid, false);
+		update_free_nid_bitmap(sbi, *nid, false, false);
 
 		spin_unlock(&nm_i->nid_list_lock);
 		return true;
@@ -2137,7 +2150,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 
 	nm_i->available_nids++;
 
-	update_free_nid_bitmap(sbi, nid, true);
+	update_free_nid_bitmap(sbi, nid, true, false);
 
 	spin_unlock(&nm_i->nid_list_lock);
 
@@ -2467,11 +2480,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 			add_free_nid(sbi, nid, false);
 			spin_lock(&NM_I(sbi)->nid_list_lock);
 			NM_I(sbi)->available_nids++;
-			update_free_nid_bitmap(sbi, nid, true);
+			update_free_nid_bitmap(sbi, nid, true, false);
 			spin_unlock(&NM_I(sbi)->nid_list_lock);
 		} else {
 			spin_lock(&NM_I(sbi)->nid_list_lock);
-			update_free_nid_bitmap(sbi, nid, false);
+			update_free_nid_bitmap(sbi, nid, false, false);
 			spin_unlock(&NM_I(sbi)->nid_list_lock);
 		}
 	}
@@ -2651,6 +2664,14 @@ int init_free_nid_cache(struct f2fs_sb_info *sbi)
 								GFP_KERNEL);
 	if (!nm_i->nat_block_bitmap)
 		return -ENOMEM;
+
+	nm_i->free_nid_count = f2fs_kvzalloc(nm_i->nat_blocks *
+					sizeof(unsigned short), GFP_KERNEL);
+	if (!nm_i->free_nid_count)
+		return -ENOMEM;
+
+	spin_lock_init(&nm_i->free_nid_lock);
+
 	return 0;
 }
 
@@ -2730,6 +2751,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 
 	kvfree(nm_i->nat_block_bitmap);
 	kvfree(nm_i->free_nid_bitmap);
+	kvfree(nm_i->free_nid_count);
 
 	kfree(nm_i->nat_bitmap);
 	kfree(nm_i->nat_bits);
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
