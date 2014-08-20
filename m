From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: fix incorrect calculation with
 total/free inode num
Date: Wed, 20 Aug 2014 18:36:46 +0800
Message-ID: <008001cfbc62$bb9959c0$32cc0d40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XK3H4-0004ah-My
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 10:37:50 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XK3H2-00066H-JN
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 10:37:50 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NAL0080IPIFP000@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Aug 2014 19:37:27 +0900 (KST)
Content-language: zh-cn
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Theoretically, our total inodes number is the same as total node number, but
there are three node ids are reserved in f2fs, they are 0, 1 (node nid), and 2
(meta nid), and they should never be used by user, so our total/free inode
number calculated in ->statfs is wrong.

This patch indroduces F2FS_RESERVED_NODE_NUM and then fixes this issue by
recalculating total/free inode number with the macro.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c          | 2 +-
 fs/f2fs/super.c         | 4 ++--
 include/linux/f2fs_fs.h | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d3d90d2..b21a04d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1967,7 +1967,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
-	nm_i->available_nids = nm_i->max_nid - 3;
+	nm_i->available_nids = nm_i->max_nid - F2FS_RESERVED_NODE_NUM;
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 657582f..85d0ae3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -505,8 +505,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree = buf->f_blocks - valid_user_blocks(sbi) - ovp_count;
 	buf->f_bavail = user_block_count - valid_user_blocks(sbi);
 
-	buf->f_files = sbi->total_node_count;
-	buf->f_ffree = sbi->total_node_count - valid_inode_count(sbi);
+	buf->f_files = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
+	buf->f_ffree = buf->f_files - valid_inode_count(sbi);
 
 	buf->f_namelen = F2FS_NAME_LEN;
 	buf->f_fsid.val[0] = (u32)id;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6ff0b0b..0ed77f3 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -24,6 +24,9 @@
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 
+/* 0, 1(node nid), 2(meta nid) are reserved node id */
+#define F2FS_RESERVED_NODE_NUM		3
+
 #define F2FS_ROOT_INO(sbi)	(sbi->root_ino_num)
 #define F2FS_NODE_INO(sbi)	(sbi->node_ino_num)
 #define F2FS_META_INO(sbi)	(sbi->meta_ino_num)
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
