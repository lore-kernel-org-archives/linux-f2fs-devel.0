From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: check in-memory nat version bitmap
Date: Sat, 7 Jan 2017 18:52:01 +0800
Message-ID: <3281eea5-df42-02e6-0ad1-bc170a8b4d92@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cPodJ-0005AG-Lu
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:53:57 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cPodE-000206-0i
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 Jan 2017 10:53:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds a mirror for nat version bitmap, and use it to detect
in-memory bitmap corruption which may be caused by bit-transition of
cache or memory overflow.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  3 +++
 fs/f2fs/node.c | 11 +++++++++++
 fs/f2fs/node.h | 15 +++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 72bff7d42ff5..9b507c6c6f3f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -540,6 +540,9 @@ struct f2fs_nm_info {

 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
+#ifdef CONFIG_F2FS_CHECK_FS
+	char *nat_bitmap_mir;		/* NAT bitmap mirror */
+#endif
 	int bitmap_size;		/* bitmap size */
 };

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 789354e64912..95af791112c2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2365,6 +2365,14 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 					GFP_KERNEL);
 	if (!nm_i->nat_bitmap)
 		return -ENOMEM;
+
+#ifdef CONFIG_F2FS_CHECK_FS
+	nm_i->nat_bitmap_mir = kmemdup(version_bitmap, nm_i->bitmap_size,
+					GFP_KERNEL);
+	if (!nm_i->nat_bitmap_mir)
+		return -ENOMEM;
+#endif
+
 	return 0;
 }

@@ -2439,6 +2447,9 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	up_write(&nm_i->nat_tree_lock);

 	kfree(nm_i->nat_bitmap);
+#ifdef CONFIG_F2FS_CHECK_FS
+	kfree(nm_i->nat_bitmap_mir);
+#endif
 	sbi->nm_info = NULL;
 	kfree(nm_i);
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 9278b21ee073..29ff783eb9c3 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -186,6 +186,12 @@ static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 static inline void get_nat_bitmap(struct f2fs_sb_info *sbi, void *addr)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
+
+#ifdef CONFIG_F2FS_CHECK_FS
+	if (memcmp(nm_i->nat_bitmap, nm_i->nat_bitmap_mir,
+						nm_i->bitmap_size))
+		f2fs_bug_on(sbi, 1);
+#endif
 	memcpy(addr, nm_i->nat_bitmap, nm_i->bitmap_size);
 }

@@ -203,6 +209,12 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
 		(seg_off << sbi->log_blocks_per_seg << 1) +
 		(block_off & (sbi->blocks_per_seg - 1)));

+#ifdef CONFIG_F2FS_CHECK_FS
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap) !=
+			f2fs_test_bit(block_off, nm_i->nat_bitmap_mir))
+		f2fs_bug_on(sbi, 1);
+#endif
+
 	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
 		block_addr += sbi->blocks_per_seg;

@@ -228,6 +240,9 @@ static inline void set_to_next_nat(struct f2fs_nm_info *nm_i, nid_t start_nid)
 	unsigned int block_off = NAT_BLOCK_OFFSET(start_nid);

 	f2fs_change_bit(block_off, nm_i->nat_bitmap);
+#ifdef CONFIG_F2FS_CHECK_FS
+	f2fs_change_bit(block_off, nm_i->nat_bitmap_mir);
+#endif
 }

 static inline nid_t ino_of_node(struct page *node_page)
-- 
2.8.2.295.g3f1c1d0



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
