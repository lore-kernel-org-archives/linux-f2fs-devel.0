From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix to store and retrieve i_rdev correctly
Date: Tue, 08 Oct 2013 18:11:40 +0900
Message-ID: <1381223500-6582-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VTTKz-0002Bt-KH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 09:12:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTTKx-0003g6-JL for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 09:12:17 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MUC003VLEVLT431@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 18:12:09 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously f2fs stores i_rdev information into i_addr.
But, if inline_xattr is set, f2fs should avoid using i_addr fields.
So, this patch adds to use i_nid fields instead of i_addrs when inline_xattr
is set.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/inode.c | 63 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c8c0580..fab657f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -37,6 +37,45 @@ void f2fs_set_inode_flags(struct inode *inode)
 		inode->i_flags |= S_DIRSYNC;
 }
 
+static void get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+{
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		__le32 *rdev;
+
+		if (is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR))
+			rdev = ri->i_nid;
+		else
+			rdev = ri->i_addr;
+
+		if (rdev[0])
+			inode->i_rdev = old_decode_dev(le32_to_cpu(rdev[0]));
+		else
+			inode->i_rdev = new_decode_dev(le32_to_cpu(rdev[1]));
+	}
+}
+
+static void set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
+{
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		__le32 *rdev;
+
+		if (is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR))
+			rdev = ri->i_nid;
+		else
+			rdev = ri->i_addr;
+
+		if (old_valid_dev(inode->i_rdev)) {
+			rdev[0] = cpu_to_le32(old_encode_dev(inode->i_rdev));
+			rdev[1] = 0;
+		} else {
+			rdev[0] = 0;
+			rdev[1] = cpu_to_le32(new_encode_dev(inode->i_rdev));
+			rdev[2] = 0;
+		}
+	}
+}
+
 static int do_read_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
@@ -73,10 +112,6 @@ static int do_read_inode(struct inode *inode)
 	inode->i_ctime.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
 	inode->i_mtime.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
 	inode->i_generation = le32_to_cpu(ri->i_generation);
-	if (ri->i_addr[0])
-		inode->i_rdev = old_decode_dev(le32_to_cpu(ri->i_addr[0]));
-	else
-		inode->i_rdev = new_decode_dev(le32_to_cpu(ri->i_addr[1]));
 
 	fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
@@ -84,8 +119,13 @@ static int do_read_inode(struct inode *inode)
 	fi->flags = 0;
 	fi->i_advise = ri->i_advise;
 	fi->i_pino = le32_to_cpu(ri->i_pino);
+
 	get_extent_info(&fi->ext, ri->i_ext);
 	get_inline_info(fi, ri);
+
+	/* get rdev by using inline_info */
+	get_inode_rdev(inode, ri);
+
 	f2fs_put_page(node_page, 1);
 	return 0;
 }
@@ -179,21 +219,10 @@ void update_inode(struct inode *inode, struct page *node_page)
 	ri->i_pino = cpu_to_le32(F2FS_I(inode)->i_pino);
 	ri->i_generation = cpu_to_le32(inode->i_generation);
 
-	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
-		if (old_valid_dev(inode->i_rdev)) {
-			ri->i_addr[0] =
-				cpu_to_le32(old_encode_dev(inode->i_rdev));
-			ri->i_addr[1] = 0;
-		} else {
-			ri->i_addr[0] = 0;
-			ri->i_addr[1] =
-				cpu_to_le32(new_encode_dev(inode->i_rdev));
-			ri->i_addr[2] = 0;
-		}
-	}
-
+	set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
 	set_page_dirty(node_page);
+
 	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
 }
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
