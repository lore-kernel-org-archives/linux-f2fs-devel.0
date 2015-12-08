From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] back-up raw_super in sbi
Date: Tue, 8 Dec 2015 21:17:13 +0800
Message-ID: <1449580633-17880-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1a6I7j-00005r-Lp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 13:16:07 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a6I7d-0006Yq-Ud
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 13:16:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: hebiao6@huawei.com, stuart.li@huawei.com

write_checkpoint() tries to get cp_blkaddr from superblock buffer,
if the buffer happen to be destroied by something else, it may
bring in unpredictable effect on f2fs.

this patch fix it by back-up a raw_super copy.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c |  3 ++-
 fs/f2fs/f2fs.h       | 10 ++++++++++
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/super.c      | 12 ++++++++----
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f661d80..1e342fd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -276,13 +276,14 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 						long nr_to_write)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, end = LONG_MAX, prev = LONG_MAX;
+	pgoff_t index, end = LONG_MAX, prev = LONG_MAX;
 	struct pagevec pvec;
 	long nwritten = 0;
 	struct writeback_control wbc = {
 		.for_reclaim = 0,
 	};
 
+	index = __start_cp_addr(sbi);
 	pagevec_init(&pvec, 0);
 
 	while (index <= end) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0052ae8..6afb56c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1167,6 +1167,16 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
+static inline block_t __start_main_addr(struct f2fs_sb_info *sbi)
+{
+	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->main_blkaddr);
+}
+
+static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
+{
+	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
+}
+
 static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
 						struct inode *inode)
 {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7bcbc6e..7d2b0bb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1161,7 +1161,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 	pagevec_init(&pvec, 0);
 
 next_step:
-	index = 0;
+	index = __start_main_addr(sbi);
 	end = LONG_MAX;
 
 	while (index <= end) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bd7e9c6..d394711 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1040,6 +1040,9 @@ static int read_raw_super_block(struct super_block *sb,
 	struct f2fs_super_block *super;
 	int err = 0;
 
+	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
+	if (!super)
+		return -ENOMEM;
 retry:
 	buffer = sb_bread(sb, block);
 	if (!buffer) {
@@ -1055,9 +1058,8 @@ retry:
 		}
 	}
 
-	super = (struct f2fs_super_block *)
-		((char *)(buffer)->b_data + F2FS_SUPER_OFFSET);
-
+	memcpy(super, buffer->b_data + F2FS_SUPER_OFFSET,
+					sizeof(struct f2fs_super_block));
 	/* sanity checking of raw super */
 	if (sanity_check_raw_super(sb, super)) {
 		brelse(buffer);
@@ -1090,8 +1092,10 @@ retry:
 
 out:
 	/* No valid superblock */
-	if (!*raw_super)
+	if (!*raw_super) {
+		kfree(super);
 		return err;
+	}
 
 	return 0;
 }
-- 
1.9.1


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
