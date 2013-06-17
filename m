From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: recover wrong pino after checkpoint during
	fsync
Date: Mon, 17 Jun 2013 21:09:04 +0900
Message-ID: <1371470944-15012-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UoYFg-00069C-AS
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jun 2013 12:09:40 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UoYFQ-0003Rl-2L for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jun 2013 12:09:40 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MOJ007X8DQQ35E0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jun 2013 21:08:58 +0900 (KST)
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

If a file is linked, f2fs loose its parent inode number so that fsync calls
for the linked file should do checkpoint all the time.
But, if we can recover its parent inode number after the checkpoint, we can
adjust roll-forward mechanism for the further fsync calls, which is able to
improve the fsync performance significatly.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c     |  2 +-
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    | 31 ++++++++++++++++++++++++++++++-
 fs/f2fs/namei.c   |  2 +-
 fs/f2fs/node.h    | 15 +++++++++++----
 fs/f2fs/segment.c |  2 +-
 6 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 69ca049..4f21452 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -356,7 +356,7 @@ static struct page *init_inode_metadata(struct inode *inode,
 	 * We lost i_pino from now on.
 	 */
 	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK)) {
-		set_cp_file(inode);
+		file_lost_pino(inode);
 		inc_nlink(inode);
 	}
 	return page;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3e7cb33..863a5e91 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -151,7 +151,7 @@ struct extent_info {
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
  */
 #define FADVISE_COLD_BIT	0x01
-#define FADVISE_CP_BIT		0x02
+#define FADVISE_LOST_PINO_BIT	0x02
 
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fda226f..d2d2b7d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -102,6 +102,24 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
 	.remap_pages	= generic_file_remap_pages,
 };
 
+static int get_parent_ino(struct inode *inode, nid_t *pino)
+{
+	struct dentry *dentry;
+
+	inode = igrab(inode);
+	dentry = d_find_any_alias(inode);
+	iput(inode);
+	if (!dentry)
+		return 0;
+
+	inode = igrab(dentry->d_parent->d_inode);
+	dput(dentry);
+
+	*pino = inode->i_ino;
+	iput(inode);
+	return 1;
+}
+
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -134,7 +152,7 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
 		need_cp = true;
-	else if (is_cp_file(inode))
+	else if (file_wrong_pino(inode))
 		need_cp = true;
 	else if (!space_for_roll_forward(sbi))
 		need_cp = true;
@@ -142,8 +160,19 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		need_cp = true;
 
 	if (need_cp) {
+		nid_t pino;
+
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
+		if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
+					get_parent_ino(inode, &pino)) {
+			F2FS_I(inode)->i_pino = pino;
+			file_got_pino(inode);
+			mark_inode_dirty_sync(inode);
+			ret = f2fs_write_inode(inode, NULL);
+			if (ret)
+				goto out;
+		}
 	} else {
 		/* if there is no written node page, write its inode page */
 		while (!sync_node_pages(sbi, inode->i_ino, &wbc)) {
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 810444e..64c0716 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -112,7 +112,7 @@ static inline void set_cold_files(struct f2fs_sb_info *sbi, struct inode *inode,
 	int count = le32_to_cpu(sbi->raw_super->extension_count);
 	for (i = 0; i < count; i++) {
 		if (is_multimedia_file(name, extlist[i])) {
-			set_cold_file(inode);
+			file_set_cold(inode);
 			break;
 		}
 	}
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index a503661..c65fb4f 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -285,10 +285,17 @@ static inline void set_file(struct inode *inode, int type)
 	F2FS_I(inode)->i_advise |= type;
 }
 
-#define is_cold_file(inode)	is_file(inode, FADVISE_COLD_BIT)
-#define is_cp_file(inode)	is_file(inode, FADVISE_CP_BIT)
-#define set_cold_file(inode)	set_file(inode, FADVISE_COLD_BIT)
-#define set_cp_file(inode)	set_file(inode, FADVISE_CP_BIT)
+static inline void clear_file(struct inode *inode, int type)
+{
+	F2FS_I(inode)->i_advise &= ~type;
+}
+
+#define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
+#define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
+#define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_clear_cold(inode)	clear_file(inode, FADVISE_COLD_BIT)
+#define file_got_pino(inode)	clear_file(inode, FADVISE_LOST_PINO_BIT)
 
 static inline int is_cold_data(struct page *page)
 {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b15debc..0e1a60a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -796,7 +796,7 @@ static int __get_segment_type_6(struct page *page, enum page_type p_type)
 
 		if (S_ISDIR(inode->i_mode))
 			return CURSEG_HOT_DATA;
-		else if (is_cold_data(page) || is_cold_file(inode))
+		else if (is_cold_data(page) || file_is_cold(inode))
 			return CURSEG_COLD_DATA;
 		else
 			return CURSEG_WARM_DATA;
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
