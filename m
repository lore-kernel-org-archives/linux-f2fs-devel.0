From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] fsck.f2fs: check file types
Date: Thu, 26 Mar 2015 17:03:06 -0700
Message-ID: <1427414589-66956-3-git-send-email-jaegeuk@kernel.org>
References: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkE-0005wX-Ql
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHkD-0007cS-44 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:26 +0000
In-Reply-To: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
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

If the file type is mismatched, we should drop that inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e803fa0..8db8f27 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -189,6 +189,30 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	return 0;
 }
 
+static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u32 mode)
+{
+	if (ftype >= F2FS_FT_MAX)
+		return 0;
+	if (S_ISLNK(mode) && ftype != F2FS_FT_SYMLINK)
+		goto err;
+	if (S_ISREG(mode) && ftype != F2FS_FT_REG_FILE)
+		goto err;
+	if (S_ISDIR(mode) && ftype != F2FS_FT_DIR)
+		goto err;
+	if (S_ISCHR(mode) && ftype != F2FS_FT_CHRDEV)
+		goto err;
+	if (S_ISBLK(mode) && ftype != F2FS_FT_BLKDEV)
+		goto err;
+	if (S_ISFIFO(mode) && ftype != F2FS_FT_FIFO)
+		goto err;
+	if (S_ISSOCK(mode) && ftype != F2FS_FT_SOCK)
+		goto err;
+	return 0;
+err:
+	ASSERT_MSG("mismatch i_mode [0x%x] [0x%x vs. 0x%x]", nid, ftype, mode);
+	return -1;
+}
+
 static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 			struct f2fs_node *node_blk,
 			enum FILE_TYPE ftype, enum NODE_TYPE ntype,
@@ -272,6 +296,10 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
+	if (ntype == TYPE_INODE &&
+		__check_inode_mode(nid, ftype, le32_to_cpu(node_blk->i.i_mode)))
+		return -EINVAL;
+
 	/* workaround to fix later */
 	if (ftype != F2FS_FT_ORPHAN ||
 			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0)
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
