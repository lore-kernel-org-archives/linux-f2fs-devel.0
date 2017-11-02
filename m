From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 3/9] dump/fsck: introduce print_xattr_entry
Date: Thu, 2 Nov 2017 11:56:06 +0800
Message-ID: <20171102035612.217263-4-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cN-0007Fb-1b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:35 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eA6cL-00047w-1a
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:34 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch exports read_all_xattrs to allow dump/fsck to get all xattrs,
and introduces print_xattr_entry which tries to parse an xattr entry
accroding to its xattr index.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/dump.c  |  18 ++++-----
 fsck/fsck.h  |   7 +++-
 fsck/mount.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fsck/xattr.c |   2 +-
 fsck/xattr.h |  54 +++++++++++++++++++++++++-
 5 files changed, 188 insertions(+), 16 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 128dc53..90fd073 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -419,17 +419,17 @@ void dump_node(struct f2fs_sb_info *sbi, nid_t nid, int force)
 	if (le32_to_cpu(node_blk->footer.ino) == ni.ino &&
 			le32_to_cpu(node_blk->footer.nid) == ni.nid &&
 			ni.ino == ni.nid) {
-		print_node_info(node_blk, force);
+		print_node_info(sbi, node_blk, force);
 		dump_file(sbi, &ni, node_blk, force);
 	} else {
-		print_node_info(node_blk, force);
+		print_node_info(sbi, node_blk, force);
 		MSG(force, "Invalid (i)node block\n\n");
 	}
 
 	free(node_blk);
 }
 
-static void dump_node_from_blkaddr(u32 blk_addr)
+static void dump_node_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 {
 	struct f2fs_node *node_blk;
 	int ret;
@@ -441,9 +441,9 @@ static void dump_node_from_blkaddr(u32 blk_addr)
 	ASSERT(ret >= 0);
 
 	if (c.dbg_lv > 0)
-		print_node_info(node_blk, 0);
+		print_node_info(sbi, node_blk, 0);
 	else
-		print_inode_info(&node_blk->i, 1);
+		print_inode_info(sbi, node_blk, 1);
 
 	free(node_blk);
 }
@@ -567,7 +567,7 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 
 	/* print inode */
 	if (c.dbg_lv > 0)
-		dump_node_from_blkaddr(ino_ni.blk_addr);
+		dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
 
 	if (type == SEG_TYPE_CUR_DATA || type == SEG_TYPE_DATA) {
 		MSG(0, "FS Userdata Area: Data block from 0x%x\n", blk_addr);
@@ -575,7 +575,7 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 					nid, ni.blk_addr);
 		MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
 					ni.ino, ino_ni.blk_addr);
-		dump_node_from_blkaddr(ino_ni.blk_addr);
+		dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
 		dump_data_offset(ni.blk_addr,
 			le16_to_cpu(sum_entry.ofs_in_node));
 	} else {
@@ -583,13 +583,13 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		if (ni.ino == ni.nid) {
 			MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
 					ni.ino, ino_ni.blk_addr);
-			dump_node_from_blkaddr(ino_ni.blk_addr);
+			dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
 		} else {
 			MSG(0, " - Node block        : id = 0x%x from 0x%x\n",
 					nid, ni.blk_addr);
 			MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
 					ni.ino, ino_ni.blk_addr);
-			dump_node_from_blkaddr(ino_ni.blk_addr);
+			dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
 			dump_node_offset(ni.blk_addr);
 		}
 	}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 1e8ed0b..f8caa46 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -141,8 +141,8 @@ int convert_encrypted_name(unsigned char *, int, unsigned char *, int);
 
 extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
-extern void print_node_info(struct f2fs_node *, int);
-extern void print_inode_info(struct f2fs_inode *, int);
+extern void print_node_info(struct f2fs_sb_info *, struct f2fs_node *, int);
+extern void print_inode_info(struct f2fs_sb_info *, struct f2fs_node *, int);
 extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
 extern struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *,
 				unsigned int, int *);
@@ -228,4 +228,7 @@ int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
 int inode_set_selinux(struct f2fs_sb_info *, u32, const char *);
 int f2fs_find_path(struct f2fs_sb_info *, char *, nid_t *);
 
+/* xattr.c */
+void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *);
+
 #endif /* _FSCK_H_ */
diff --git a/fsck/mount.c b/fsck/mount.c
index d8bc50c..d631547 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -9,7 +9,9 @@
  * published by the Free Software Foundation.
  */
 #include "fsck.h"
+#include "xattr.h"
 #include <locale.h>
+#include <linux/posix_acl.h>
 
 u32 get_free_segments(struct f2fs_sb_info *sbi)
 {
@@ -35,8 +37,116 @@ void update_free_segments(struct f2fs_sb_info *sbi)
 	i++;
 }
 
-void print_inode_info(struct f2fs_inode *inode, int name)
+void print_acl(char *value, int size)
 {
+	struct f2fs_acl_header *hdr = (struct f2fs_acl_header *)value;
+	struct f2fs_acl_entry *entry = (struct f2fs_acl_entry *)(hdr + 1);
+	const char *end = value + size;
+	int i, count;
+
+	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION)) {
+		MSG(0, "Invalid ACL version [0x%x : 0x%x]\n",
+				le32_to_cpu(hdr->a_version), F2FS_ACL_VERSION);
+		return;
+	}
+
+	count = f2fs_acl_count(size);
+	if (count <= 0) {
+		MSG(0, "Invalid ACL value size %d\n", size);
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		if ((char *)entry > end) {
+			MSG(0, "Invalid ACL entries count %d\n", count);
+			return;
+		}
+
+		switch (le16_to_cpu(entry->e_tag)) {
+		case ACL_USER_OBJ:
+		case ACL_GROUP_OBJ:
+		case ACL_MASK:
+		case ACL_OTHER:
+			MSG(0, "tag:0x%x perm:0x%x\n",
+					le16_to_cpu(entry->e_tag),
+					le16_to_cpu(entry->e_perm));
+			entry = (struct f2fs_acl_entry *)((char *)entry +
+					sizeof(struct f2fs_acl_entry_short));
+			break;
+		case ACL_USER:
+			MSG(0, "tag:0x%x perm:0x%x uid:%u\n",
+					le16_to_cpu(entry->e_tag),
+					le16_to_cpu(entry->e_perm),
+					le32_to_cpu(entry->e_id));
+			entry = (struct f2fs_acl_entry *)((char *)entry +
+					sizeof(struct f2fs_acl_entry));
+			break;
+		case ACL_GROUP:
+			MSG(0, "tag:0x%x perm:0x%x gid:%u\n",
+					le16_to_cpu(entry->e_tag),
+					le16_to_cpu(entry->e_perm),
+					le32_to_cpu(entry->e_id));
+			entry = (struct f2fs_acl_entry *)((char *)entry +
+					sizeof(struct f2fs_acl_entry));
+			break;
+		default:
+			MSG(0, "Unknown ACL tag 0x%x\n",
+					le16_to_cpu(entry->e_tag));
+			return;
+		}
+	}
+}
+
+void print_xattr_entry(struct f2fs_xattr_entry *ent)
+{
+	char *value = (char *)(ent->e_name + le16_to_cpu(ent->e_name_len));
+	struct fscrypt_context *ctx;
+	int i;
+
+	MSG(0, "\nxattr: e_name_index:%d e_name:", ent->e_name_index);
+	for (i = 0; i < le16_to_cpu(ent->e_name_len); i++)
+		MSG(0, "%c", ent->e_name[i]);
+	MSG(0, " e_name_len:%d e_value_size:%d e_value:\n",
+			ent->e_name_len, le16_to_cpu(ent->e_value_size));
+
+	switch (ent->e_name_index) {
+	case F2FS_XATTR_INDEX_POSIX_ACL_ACCESS:
+	case F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT:
+		print_acl(value, le16_to_cpu(ent->e_value_size));
+		break;
+	case F2FS_XATTR_INDEX_USER:
+	case F2FS_XATTR_INDEX_SECURITY:
+	case F2FS_XATTR_INDEX_TRUSTED:
+	case F2FS_XATTR_INDEX_LUSTRE:
+		for (i = 0; i < le16_to_cpu(ent->e_value_size); i++)
+			MSG(0, "%02X", value[i]);
+		MSG(0, "\n");
+		break;
+	case F2FS_XATTR_INDEX_ENCRYPTION:
+		ctx = (struct fscrypt_context *)value;
+		MSG(0, "format: %d\n", ctx->format);
+		MSG(0, "contents_encryption_mode: 0x%x\n", ctx->contents_encryption_mode);
+		MSG(0, "filenames_encryption_mode: 0x%x\n", ctx->filenames_encryption_mode);
+		MSG(0, "flags: 0x%x\n", ctx->flags);
+		MSG(0, "master_key_descriptor: ");
+		for (i = 0; i < FS_KEY_DESCRIPTOR_SIZE; i++)
+			MSG(0, "%02X", ctx->master_key_descriptor[i]);
+		MSG(0, "\nnonce: ");
+		for (i = 0; i < FS_KEY_DERIVATION_NONCE_SIZE; i++)
+			MSG(0, "%02X", ctx->nonce[i]);
+		MSG(0, "\n");
+		break;
+	default:
+		break;
+	}
+}
+
+void print_inode_info(struct f2fs_sb_info *sbi,
+			struct f2fs_node *node, int name)
+{
+	struct f2fs_inode *inode = &node->i;
+	void *xattr_addr;
+	struct f2fs_xattr_entry *ent;
 	unsigned char en[F2FS_NAME_LEN + 1];
 	unsigned int i = 0;
 	int namelen = le32_to_cpu(inode->i_namelen);
@@ -111,17 +221,24 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	DISP_u32(inode, i_nid[3]);	/* indirect */
 	DISP_u32(inode, i_nid[4]);	/* double indirect */
 
+	xattr_addr = read_all_xattrs(sbi, node);
+	list_for_each_xattr(ent, xattr_addr) {
+		print_xattr_entry(ent);
+	}
+	free(xattr_addr);
+
 	printf("\n");
 }
 
-void print_node_info(struct f2fs_node *node_block, int verbose)
+void print_node_info(struct f2fs_sb_info *sbi,
+			struct f2fs_node *node_block, int verbose)
 {
 	nid_t ino = le32_to_cpu(node_block->footer.ino);
 	nid_t nid = le32_to_cpu(node_block->footer.nid);
 	/* Is this inode? */
 	if (ino == nid) {
 		DBG(verbose, "Node ID [0x%x:%u] is inode\n", nid, nid);
-		print_inode_info(&node_block->i, verbose);
+		print_inode_info(sbi, node_block, verbose);
 	} else {
 		int i;
 		u32 *dump_blk = (u32 *)node_block;
diff --git a/fsck/xattr.c b/fsck/xattr.c
index 3f5c7d3..1d0f7d3 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -20,7 +20,7 @@
 #define XATTR_CREATE 0x1
 #define XATTR_REPLACE 0x2
 
-static void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
+void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
 {
 	struct f2fs_xattr_header *header;
 	void *txattr_addr;
diff --git a/fsck/xattr.h b/fsck/xattr.h
index b414629..beed3bb 100644
--- a/fsck/xattr.h
+++ b/fsck/xattr.h
@@ -31,10 +31,62 @@ struct f2fs_xattr_entry {
 	char e_name[0];		/* attribute name */
 };
 
+#define FS_KEY_DESCRIPTOR_SIZE 8
+#define FS_KEY_DERIVATION_NONCE_SIZE 16
+
+struct fscrypt_context {
+	u8 format;
+	u8 contents_encryption_mode;
+	u8 filenames_encryption_mode;
+	u8 flags;
+	u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+	u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
+} __attribute__((packed));
+
+#define F2FS_ACL_VERSION	0x0001
+
+struct f2fs_acl_entry {
+	__le16 e_tag;
+	__le16 e_perm;
+	__le32 e_id;
+};
+
+struct f2fs_acl_entry_short {
+	__le16 e_tag;
+	__le16 e_perm;
+};
+
+struct f2fs_acl_header {
+	__le32 a_version;
+};
+
+static inline int f2fs_acl_count(int size)
+{
+	ssize_t s;
+	size -= sizeof(struct f2fs_acl_header);
+	s = size - 4 * sizeof(struct f2fs_acl_entry_short);
+	if (s < 0) {
+		if (size % sizeof(struct f2fs_acl_entry_short))
+			return -1;
+		return size / sizeof(struct f2fs_acl_entry_short);
+	} else {
+		if (s % sizeof(struct f2fs_acl_entry))
+			return -1;
+		return s / sizeof(struct f2fs_acl_entry) + 4;
+	}
+}
+
 #define XATTR_ROUND	(3)
 
 #define XATTR_SELINUX_SUFFIX "selinux"
-#define F2FS_XATTR_INDEX_SECURITY	6
+#define F2FS_XATTR_INDEX_USER			1
+#define F2FS_XATTR_INDEX_POSIX_ACL_ACCESS	2
+#define F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT	3
+#define F2FS_XATTR_INDEX_TRUSTED		4
+#define F2FS_XATTR_INDEX_LUSTRE			5
+#define F2FS_XATTR_INDEX_SECURITY		6
+#define F2FS_XATTR_INDEX_ENCRYPTION		9
+
 #define IS_XATTR_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
 
 #define XATTR_HDR(ptr)		((struct f2fs_xattr_header *)(ptr))
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
