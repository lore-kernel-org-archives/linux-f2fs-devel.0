From: Chao Yu <chao2.yu@samsung.com>
Subject: [RFC PATCH 01/10] f2fs: move ext_lock out of struct
 extent_info
Date: Mon, 12 Jan 2015 15:08:52 +0800
Message-ID: <000501d02e36$ba5070d0$2ef15270$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YAZ8N-0005zm-UT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jan 2015 07:09:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YAZ8M-0000G1-2s
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jan 2015 07:09:55 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NI100GY1YK1UO50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jan 2015 16:09:37 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Move ext_lock out of struct extent_info, then in the following patches we can
use variables with struct extent_info type as a parameter to pass pure data.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c  | 12 ++++++------
 fs/f2fs/f2fs.h  |  6 +-----
 fs/f2fs/inode.c |  7 +++++++
 fs/f2fs/super.c |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a7b905c..fece5cc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -258,9 +258,9 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 	if (is_inode_flag_set(fi, FI_NO_EXTENT))
 		return 0;
 
-	read_lock(&fi->ext.ext_lock);
+	read_lock(&fi->ext_lock);
 	if (fi->ext.len == 0) {
-		read_unlock(&fi->ext.ext_lock);
+		read_unlock(&fi->ext_lock);
 		return 0;
 	}
 
@@ -284,10 +284,10 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 			bh_result->b_size = UINT_MAX;
 
 		stat_inc_read_hit(inode->i_sb);
-		read_unlock(&fi->ext.ext_lock);
+		read_unlock(&fi->ext_lock);
 		return 1;
 	}
-	read_unlock(&fi->ext.ext_lock);
+	read_unlock(&fi->ext_lock);
 	return 0;
 }
 
@@ -309,7 +309,7 @@ void update_extent_cache(struct dnode_of_data *dn)
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
-	write_lock(&fi->ext.ext_lock);
+	write_lock(&fi->ext_lock);
 
 	start_fofs = fi->ext.fofs;
 	end_fofs = fi->ext.fofs + fi->ext.len - 1;
@@ -366,7 +366,7 @@ void update_extent_cache(struct dnode_of_data *dn)
 		need_update = true;
 	}
 end_update:
-	write_unlock(&fi->ext.ext_lock);
+	write_unlock(&fi->ext_lock);
 	if (need_update)
 		sync_inode_page(dn);
 	return;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 209532c..beacda0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -271,7 +271,6 @@ enum {
 #define F2FS_MIN_EXTENT_LEN	16	/* minimum extent length */
 
 struct extent_info {
-	rwlock_t ext_lock;	/* rwlock for consistency */
 	unsigned int fofs;	/* start offset in a file */
 	u32 blk_addr;		/* start block address of the extent */
 	unsigned int len;	/* length of the extent */
@@ -303,6 +302,7 @@ struct f2fs_inode_info {
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
 	struct extent_info ext;		/* in-memory extent cache entry */
+	rwlock_t ext_lock;		/* rwlock for single extent cache */
 	struct inode_entry *dirty_dir;	/* the pointer of dirty dir */
 
 	struct radix_tree_root inmem_root;	/* radix tree for inmem pages */
@@ -313,21 +313,17 @@ struct f2fs_inode_info {
 static inline void get_extent_info(struct extent_info *ext,
 					struct f2fs_extent i_ext)
 {
-	write_lock(&ext->ext_lock);
 	ext->fofs = le32_to_cpu(i_ext.fofs);
 	ext->blk_addr = le32_to_cpu(i_ext.blk_addr);
 	ext->len = le32_to_cpu(i_ext.len);
-	write_unlock(&ext->ext_lock);
 }
 
 static inline void set_raw_extent(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
-	read_lock(&ext->ext_lock);
 	i_ext->fofs = cpu_to_le32(ext->fofs);
 	i_ext->blk_addr = cpu_to_le32(ext->blk_addr);
 	i_ext->len = cpu_to_le32(ext->len);
-	read_unlock(&ext->ext_lock);
 }
 
 struct f2fs_nm_info {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2d002e3..28dd26a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -130,7 +130,10 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
+	write_lock(&fi->ext_lock);
 	get_extent_info(&fi->ext, ri->i_ext);
+	write_unlock(&fi->ext_lock);
+
 	get_inline_info(fi, ri);
 
 	/* check data exist */
@@ -220,7 +223,11 @@ void update_inode(struct inode *inode, struct page *node_page)
 	ri->i_links = cpu_to_le32(inode->i_nlink);
 	ri->i_size = cpu_to_le64(i_size_read(inode));
 	ri->i_blocks = cpu_to_le64(inode->i_blocks);
+
+	read_lock(&F2FS_I(inode)->ext_lock);
 	set_raw_extent(&F2FS_I(inode)->ext, &ri->i_ext);
+	read_unlock(&F2FS_I(inode)->ext_lock);
+
 	set_raw_inline(F2FS_I(inode), ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e97974..8b8de7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -382,7 +382,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
-	rwlock_init(&fi->ext.ext_lock);
+	rwlock_init(&fi->ext_lock);
 	init_rwsem(&fi->i_sem);
 	INIT_RADIX_TREE(&fi->inmem_root, GFP_NOFS);
 	INIT_LIST_HEAD(&fi->inmem_pages);
-- 
2.2.1



------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
vanity: www.gigenet.com
