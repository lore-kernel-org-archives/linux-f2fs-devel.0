From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/8] fsck.f2fs: fix missing dentries
Date: Thu,  2 Apr 2015 10:50:54 -0700
Message-ID: <1427997055-10715-7-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjH3-0001Ku-RG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjH2-0002eU-Lc for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:25 +0000
In-Reply-To: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
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

If a directory has no dot and dotdot dentries, fsck.f2fs sets inline_dots for
the inode so that f2fs module can handle that properly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 42 +++++++++++++++++++++++++++---------------
 fsck/fsck.h       |  1 +
 include/f2fs_fs.h |  1 +
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d83f5a8..8211159 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -476,7 +476,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct child_info child = {0, 0};
+	struct child_info child = {2, 0, 0};
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
@@ -631,26 +631,38 @@ check:
 		}
 	}
 skip_blkcnt_fix:
-	if (ftype == F2FS_FT_DIR)
-		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
-				le32_to_cpu(node_blk->footer.ino),
-				node_blk->i.i_name,
-				le32_to_cpu(node_blk->i.i_current_depth),
-				child.files);
 	if (ftype == F2FS_FT_ORPHAN)
 		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
 				le32_to_cpu(node_blk->footer.ino),
 				node_blk->i.i_name,
 				(u32)i_blocks);
 
-	if (ftype == F2FS_FT_DIR && i_links != child.links) {
-		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
-				nid, i_links, child.links);
-		if (config.fix_on) {
-			node_blk->i.i_links = cpu_to_le32(child.links);
-			need_fix = 1;
-			FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
+	if (ftype == F2FS_FT_DIR) {
+		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
+				le32_to_cpu(node_blk->footer.ino),
+				node_blk->i.i_name,
+				le32_to_cpu(node_blk->i.i_current_depth),
+				child.files);
+
+		if (i_links != child.links) {
+			ASSERT_MSG("ino: 0x%x i_links: %u, real links: %u",
+					nid, i_links, child.links);
+			if (config.fix_on) {
+				node_blk->i.i_links = cpu_to_le32(child.links);
+				need_fix = 1;
+				FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
 						nid, i_links, child.links);
+			}
+		}
+		if (child.dots < 2 &&
+				!(node_blk->i.i_inline & F2FS_INLINE_DOTS)) {
+			ASSERT_MSG("ino: 0x%x dots: %u",
+					nid, child.dots);
+			if (config.fix_on) {
+				node_blk->i.i_inline |= F2FS_INLINE_DOTS;
+				need_fix = 1;
+				FIX_MSG("Dir: 0x%x set inline_dots", nid);
+			}
 		}
 	}
 
@@ -877,7 +889,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 							name_len == 2)) {
 				i++;
 				free(name);
-				child->links++;
+				child->dots++;
 				continue;
 			}
 		}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 97e2385..5eac45c 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -22,6 +22,7 @@ struct orphan_info {
 struct child_info {
 	u32 links;
 	u32 files;
+	u8 dots;
 };
 
 struct f2fs_fsck {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6ce58c2..d23ae1b 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -436,6 +436,7 @@ struct f2fs_extent {
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
+#define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 
 #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
 						F2FS_INLINE_XATTR_ADDRS - 1))
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
