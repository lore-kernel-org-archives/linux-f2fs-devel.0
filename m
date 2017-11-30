From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/7] f2fs: inject fault to kvmalloc
Date: Thu, 30 Nov 2017 19:28:18 +0800
Message-ID: <20171130112823.100494-2-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1O-00026W-Qm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1M-0007dN-Hs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
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

This patch supports to inject fault into kvmalloc/kvzalloc.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 19 +++++++++++++++++++
 fs/f2fs/file.c    |  6 ++++--
 fs/f2fs/node.c    |  6 +++---
 fs/f2fs/segment.c | 16 +++++++++-------
 fs/f2fs/super.c   |  1 +
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b714d17d689..f6477aa76ba9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -45,6 +45,7 @@
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 enum {
 	FAULT_KMALLOC,
+	FAULT_KVMALLOC,
 	FAULT_PAGE_ALLOC,
 	FAULT_PAGE_GET,
 	FAULT_ALLOC_BIO,
@@ -2431,6 +2432,24 @@ static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
 	return f2fs_kmalloc(sbi, size, flags | __GFP_ZERO);
 }
 
+static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
+					size_t size, gfp_t flags)
+{
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
+		f2fs_show_injection_info(FAULT_KVMALLOC);
+		return NULL;
+	}
+#endif
+	return kvmalloc(size, flags);
+}
+
+static inline void *f2fs_kvzalloc(struct f2fs_sb_info *sbi,
+					size_t size, gfp_t flags)
+{
+	return f2fs_kvmalloc(sbi, size, flags | __GFP_ZERO);
+}
+
 static inline int get_extra_isize(struct inode *inode)
 {
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c952eebe3b16..6723d48819e9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1113,11 +1113,13 @@ static int __exchange_data_block(struct inode *src_inode,
 	while (len) {
 		olen = min((pgoff_t)4 * ADDRS_PER_BLOCK, len);
 
-		src_blkaddr = kvzalloc(sizeof(block_t) * olen, GFP_KERNEL);
+		src_blkaddr = f2fs_kvzalloc(F2FS_I_SB(src_inode),
+					sizeof(block_t) * olen, GFP_KERNEL);
 		if (!src_blkaddr)
 			return -ENOMEM;
 
-		do_replace = kvzalloc(sizeof(int) * olen, GFP_KERNEL);
+		do_replace = f2fs_kvzalloc(F2FS_I_SB(src_inode),
+					sizeof(int) * olen, GFP_KERNEL);
 		if (!do_replace) {
 			kvfree(src_blkaddr);
 			return -ENOMEM;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2d6da4f26b83..80c37a094631 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2726,17 +2726,17 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-	nm_i->free_nid_bitmap = kvzalloc(nm_i->nat_blocks *
+	nm_i->free_nid_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks *
 					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
 	if (!nm_i->free_nid_bitmap)
 		return -ENOMEM;
 
-	nm_i->nat_block_bitmap = kvzalloc(nm_i->nat_blocks / 8,
+	nm_i->nat_block_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks / 8,
 								GFP_KERNEL);
 	if (!nm_i->nat_block_bitmap)
 		return -ENOMEM;
 
-	nm_i->free_nid_count = kvzalloc(nm_i->nat_blocks *
+	nm_i->free_nid_count = f2fs_kvzalloc(sbi, nm_i->nat_blocks *
 					sizeof(unsigned short), GFP_KERNEL);
 	if (!nm_i->free_nid_count)
 		return -ENOMEM;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e665a227b2c9..ce6bf4290dbe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3385,13 +3385,14 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 
 	SM_I(sbi)->sit_info = sit_i;
 
-	sit_i->sentries = kvzalloc(MAIN_SEGS(sbi) *
+	sit_i->sentries = f2fs_kvzalloc(sbi, MAIN_SEGS(sbi) *
 					sizeof(struct seg_entry), GFP_KERNEL);
 	if (!sit_i->sentries)
 		return -ENOMEM;
 
 	bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
-	sit_i->dirty_sentries_bitmap = kvzalloc(bitmap_size, GFP_KERNEL);
+	sit_i->dirty_sentries_bitmap = f2fs_kvzalloc(sbi, bitmap_size,
+								GFP_KERNEL);
 	if (!sit_i->dirty_sentries_bitmap)
 		return -ENOMEM;
 
@@ -3425,7 +3426,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	if (sbi->segs_per_sec > 1) {
-		sit_i->sec_entries = kvzalloc(MAIN_SECS(sbi) *
+		sit_i->sec_entries = f2fs_kvzalloc(sbi, MAIN_SECS(sbi) *
 					sizeof(struct sec_entry), GFP_KERNEL);
 		if (!sit_i->sec_entries)
 			return -ENOMEM;
@@ -3476,12 +3477,12 @@ static int build_free_segmap(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->free_info = free_i;
 
 	bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
-	free_i->free_segmap = kvmalloc(bitmap_size, GFP_KERNEL);
+	free_i->free_segmap = f2fs_kvmalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!free_i->free_segmap)
 		return -ENOMEM;
 
 	sec_bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
-	free_i->free_secmap = kvmalloc(sec_bitmap_size, GFP_KERNEL);
+	free_i->free_secmap = f2fs_kvmalloc(sbi, sec_bitmap_size, GFP_KERNEL);
 	if (!free_i->free_secmap)
 		return -ENOMEM;
 
@@ -3661,7 +3662,7 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
 
-	dirty_i->victim_secmap = kvzalloc(bitmap_size, GFP_KERNEL);
+	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!dirty_i->victim_secmap)
 		return -ENOMEM;
 	return 0;
@@ -3684,7 +3685,8 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
 	bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
 
 	for (i = 0; i < NR_DIRTY_TYPE; i++) {
-		dirty_i->dirty_segmap[i] = kvzalloc(bitmap_size, GFP_KERNEL);
+		dirty_i->dirty_segmap[i] = f2fs_kvzalloc(sbi, bitmap_size,
+								GFP_KERNEL);
 		if (!dirty_i->dirty_segmap[i])
 			return -ENOMEM;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 26538ee1c143..dca579b7fd50 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -43,6 +43,7 @@ static struct kmem_cache *f2fs_inode_cachep;
 
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
+	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
 	[FAULT_PAGE_GET]	= "page get",
 	[FAULT_ALLOC_BIO]	= "alloc bio",
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
