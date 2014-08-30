From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/17] fsck.f2fs: fix inode block inconsistency
Date: Fri, 29 Aug 2014 17:28:56 -0700
Message-ID: <1409358544-54740-9-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYB-00056o-0i
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:51 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYA-0000Oi-1X for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:50 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch is to fix inode block inconsistency such as iblocks and ilinks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 61 +++++++++++++++++++++++++++++++++----------------------
 include/f2fs_fs.h |  1 +
 lib/libf2fs_io.c  |  5 +++++
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 49d9ccc..17cf29b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -319,6 +319,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	unsigned int idx = 0;
+	int need_fix = 0;
 	int ret;
 
 	if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0)
@@ -339,8 +340,11 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			if (find_and_dec_hard_link_list(sbi, nid)) {
 				ASSERT_MSG("[0x%x] needs more i_links=0x%x",
 						nid, i_links);
-				if (config.fix_cnt)
-					printf("TODO: i_links++\n");
+				if (config.fix_cnt) {
+					node_blk->i.i_links =
+						cpu_to_le32(i_links + 1);
+					need_fix = 1;
+				}
 			}
 			/* No need to go deep into the node */
 			return;
@@ -366,8 +370,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					&child_cnt, &child_files,
 					(i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version);
-			if (!ret)
+			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
+			} else if (config.fix_cnt) {
+				node_blk->i.i_addr[idx] = 0;
+				need_fix = 1;
+			}
 		}
 	}
 
@@ -386,10 +394,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
 					ftype, ntype, blk_cnt);
-			if (!ret)
+			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
-			else if (config.fix_cnt)
-				printf("TODO delete i_nid[idx] = 0;\n");
+			} else if (config.fix_cnt) {
+				node_blk->i.i_nid[idx] = 0;
+				need_fix = 1;
+			}
 		}
 	}
 check:
@@ -404,28 +414,31 @@ check:
 				le32_to_cpu(node_blk->footer.ino),
 				node_blk->i.i_name,
 				(u32)i_blocks);
-	if ((ftype == F2FS_FT_DIR && i_links != child_cnt) ||
-						(i_blocks != *blk_cnt)) {
-		if (!config.fix_cnt)
-			print_node_info(node_blk);
-
-		/* node_blk, ni.blkaddr, child_cnt, *blk_cnt */
-		if (config.fix_cnt)
-			printf("TODO fix_inode_block\n");
-		else
-			print_node_info(node_blk);
-		DBG(1, "blk   cnt [0x%x]\n", *blk_cnt);
-		DBG(1, "child cnt [0x%x]\n", child_cnt);
-	}
-	if (i_blocks != *blk_cnt)
+
+	if (i_blocks != *blk_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_blocks: %lu, but has %u blocks",
-						nid, i_blocks, *blk_cnt);
-	if (ftype == F2FS_FT_DIR && i_links != child_cnt)
+				nid, i_blocks, *blk_cnt);
+		if (config.fix_cnt) {
+			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
+			need_fix = 1;
+		}
+	}
+	if (ftype == F2FS_FT_DIR && i_links != child_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
-						nid, i_links, child_cnt);
+				nid, i_links, child_cnt);
+		if (config.fix_cnt) {
+			node_blk->i.i_links = cpu_to_le32(child_cnt);
+			need_fix = 1;
+		}
+	}
+
 	if (ftype == F2FS_FT_ORPHAN && i_links)
 		ASSERT_MSG("ino: 0x%x is orphan inode, but has i_links: %u",
-						nid, i_links);
+				nid, i_links);
+	if (need_fix) {
+		ret = dev_write_block(node_blk, ni->blk_addr);
+		ASSERT(ret >= 0);
+	}
 }
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index c3cc2aa..3b75bff 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -676,6 +676,7 @@ extern void f2fs_finalize_device(struct f2fs_configuration *);
 
 extern int dev_read(void *, __u64, size_t);
 extern int dev_write(void *, __u64, size_t);
+extern int dev_write_block(void *, __u64);
 extern int dev_write_dump(void *, __u64, size_t);
 /* All bytes in the buffer must be 0 use dev_fill(). */
 extern int dev_fill(void *, __u64, size_t);
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index d5ced53..0c89ee4 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -46,6 +46,11 @@ int dev_write(void *buf, __u64 offset, size_t len)
 	return 0;
 }
 
+int dev_write_block(void *buf, __u64 blk_addr)
+{
+	return dev_write(buf, blk_addr * F2FS_BLKSIZE, F2FS_BLKSIZE);
+}
+
 int dev_write_dump(void *buf, __u64 offset, size_t len)
 {
 	if (lseek64(config.dump_fd, (off64_t)offset, SEEK_SET) < 0)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
