From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: Limit pragma pack(1) only for Windows
 Host
Date: Thu, 14 Dec 2017 10:27:35 -0800
Message-ID: <20171214182735.35044-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ePYET-0007b6-9x
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 18:27:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePYES-0004HR-7V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 18:27:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Hyojun Kim <hyojun@google.com>

From: Hyojun Kim <hyojun@google.com>

A side-effect was found for #pragma pack(1), which were added for
Windows SDK support. Limiting it with ANDROID_WINDOWS_HOST.

Signed-off-by: Hyojun Kim <hyojun@google.com>
---
 include/f2fs_fs.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/quota.h   |  6 ++++++
 2 files changed, 58 insertions(+)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d8d199f..782c936 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -556,13 +556,17 @@ enum {
 /*
  * For superblock
  */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_device {
 	__u8 path[MAX_PATH_LEN];
 	__le32 total_segments;
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_super_block {
 	__le32 magic;			/* Magic Number */
 	__le16 major_ver;		/* Major Version */
@@ -619,7 +623,9 @@ struct f2fs_super_block {
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
 #define CP_UMOUNT_FLAG		0x00000001
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_checkpoint {
 	__le64 checkpoint_ver;		/* checkpoint block version number */
 	__le64 user_block_count;	/* # of user blocks */
@@ -656,7 +662,9 @@ struct f2fs_checkpoint {
  */
 #define F2FS_ORPHANS_PER_BLOCK	1020
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_orphan_block {
 	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */
 	__le32 reserved;	/* reserved */
@@ -669,7 +677,9 @@ struct f2fs_orphan_block {
 /*
  * For NODE structure
  */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
 	__le32 blk_addr;	/* start block address of the extent */
@@ -736,7 +746,9 @@ struct f2fs_extent {
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
 	__u8 i_advise;			/* file hints */
@@ -778,12 +790,16 @@ struct f2fs_inode {
 } __attribute__((packed));
 
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct direct_node {
 	__le32 addr[ADDRS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct indirect_node {
 	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
@@ -797,7 +813,9 @@ enum {
 
 #define XATTR_NODE_OFFSET	((((unsigned int)-1) << OFFSET_BIT_SHIFT) \
 				>> OFFSET_BIT_SHIFT)
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct node_footer {
 	__le32 nid;		/* node id */
 	__le32 ino;		/* inode nunmber */
@@ -806,7 +824,9 @@ struct node_footer {
 	__le32 next_blkaddr;	/* next node page block address */
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
 	union {
@@ -823,14 +843,18 @@ struct f2fs_node {
 #define NAT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_nat_entry))
 #define NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
 	__le32 ino;		/* inode number */
 	__le32 block_addr;	/* block address */
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_nat_block {
 	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -867,14 +891,18 @@ struct f2fs_nat_block {
 	((le16_to_cpu((raw_sit)->vblocks) & ~SIT_VBLOCKS_MASK)	\
 	 >> SIT_VBLOCKS_SHIFT)
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_sit_entry {
 	__le16 vblocks;				/* reference above */
 	__u8 valid_map[SIT_VBLOCK_MAP_SIZE];	/* bitmap for valid blocks */
 	__le64 mtime;				/* segment age for cleaning */
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_sit_block {
 	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -900,12 +928,16 @@ struct f2fs_sit_block {
 #define SUM_ENTRIES_SIZE	(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
 /* a summary entry for a 4KB-sized block in a segment */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_summary {
 	__le32 nid;		/* parent node id */
 	union {
 		__u8 reserved[3];
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 		struct {
 			__u8 version;		/* node version number */
 			__le16 ofs_in_node;	/* block index in parent node */
@@ -917,7 +949,9 @@ struct f2fs_summary {
 #define SUM_TYPE_NODE		(1)
 #define SUM_TYPE_DATA		(0)
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct summary_footer {
 	unsigned char entry_type;	/* SUM_TYPE_XXX */
 	__le32 check_sum;		/* summary checksum */
@@ -949,37 +983,49 @@ enum {
 	SIT_JOURNAL
 };
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct nat_journal_entry {
 	__le32 nid;
 	struct f2fs_nat_entry ne;
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct nat_journal {
 	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
 	__u8 reserved[NAT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct sit_journal_entry {
 	__le32 segno;
 	struct f2fs_sit_entry se;
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct sit_journal {
 	struct sit_journal_entry entries[SIT_JOURNAL_ENTRIES];
 	__u8 reserved[SIT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_extra_info {
 	__le64 kbytes_written;
 	__u8 reserved[EXTRA_INFO_RESERVED];
 } __attribute__((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_journal {
 	union {
 		__le16 n_nats;
@@ -994,7 +1040,9 @@ struct f2fs_journal {
 } __attribute__((packed));
 
 /* 4KB-sized summary block structure */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_summary_block {
 	struct f2fs_summary entries[ENTRIES_IN_SUM];
 	struct f2fs_journal journal;
@@ -1034,7 +1082,9 @@ typedef __le32	f2fs_hash_t;
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_dir_entry {
 	__le32 hash_code;	/* hash code of file name */
 	__le32 ino;		/* inode number */
@@ -1043,7 +1093,9 @@ struct f2fs_dir_entry {
 } __attribute__((packed));
 
 /* 4KB-sized directory entry block */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct f2fs_dentry_block {
 	/* validity bitmap for directory entries in each block */
 	__u8 dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
diff --git a/include/quota.h b/include/quota.h
index 80dbdc6..cfb9861 100644
--- a/include/quota.h
+++ b/include/quota.h
@@ -44,14 +44,18 @@ enum quota_type {
 
 #define QT_TREEOFF	1	/* Offset of tree in file in blocks */
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct v2_disk_dqheader {
 	u_int32_t dqh_magic;	/* Magic number identifying file */
 	u_int32_t dqh_version;	/* File version */
 } __attribute__ ((packed));
 
 /* Header with type and version specific information */
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct v2_disk_dqinfo {
 	u_int32_t dqi_bgrace;	/* Time before block soft limit becomes hard limit */
 	u_int32_t dqi_igrace;	/* Time before inode soft limit becomes hard limit */
@@ -61,7 +65,9 @@ struct v2_disk_dqinfo {
 	u_int32_t dqi_free_entry;	/* Number of block with at least one free entry */
 } __attribute__ ((packed));
 
+#ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
+#endif
 struct v2r1_disk_dqblk {
 	__le32 dqb_id;  	/* id this quota applies to */
 	__le32 dqb_pad;
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
