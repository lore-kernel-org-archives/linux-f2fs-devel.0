From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs-tools: change to use #pragma pack(push,
 1)
Date: Wed, 14 Mar 2018 09:08:38 +0900
Message-ID: <20180314000839.33075-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1evtyM-0004pW-61
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Mar 2018 00:08:50 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1evtyH-00DcCM-7c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Mar 2018 00:08:46 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Hyojun Kim <hyojun@google.com>

From: Hyojun Kim <hyojun@google.com>

It was reported that #pragma pack(1) could create unwanted
influences. pack(push, 1) and pack(pop) are used instead.

Signed-off-by: Hyojun Kim <hyojun@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 80 ++-----------------------------------------------------
 include/quota.h   | 11 ++------
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3121e0e..c460050 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -569,17 +569,12 @@ enum {
 /*
  * For superblock
  */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
+#pragma pack(push, 1)
 struct f2fs_device {
 	__u8 path[MAX_PATH_LEN];
 	__le32 total_segments;
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_super_block {
 	__le32 magic;			/* Magic Number */
 	__le16 major_ver;		/* Major Version */
@@ -639,9 +634,6 @@ struct f2fs_super_block {
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
 #define CP_UMOUNT_FLAG		0x00000001
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_checkpoint {
 	__le64 checkpoint_ver;		/* checkpoint block version number */
 	__le64 user_block_count;	/* # of user blocks */
@@ -683,9 +675,6 @@ struct f2fs_checkpoint {
  */
 #define F2FS_ORPHANS_PER_BLOCK	1020
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_orphan_block {
 	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */
 	__le32 reserved;	/* reserved */
@@ -698,9 +687,6 @@ struct f2fs_orphan_block {
 /*
  * For NODE structure
  */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
 	__le32 blk_addr;	/* start block address of the extent */
@@ -767,9 +753,6 @@ struct f2fs_extent {
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
 	__u8 i_advise;			/* file hints */
@@ -813,16 +796,10 @@ struct f2fs_inode {
 } __attribute__((packed));
 
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct direct_node {
 	__le32 addr[ADDRS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct indirect_node {
 	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
@@ -836,9 +813,6 @@ enum {
 
 #define XATTR_NODE_OFFSET	((((unsigned int)-1) << OFFSET_BIT_SHIFT) \
 				>> OFFSET_BIT_SHIFT)
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct node_footer {
 	__le32 nid;		/* node id */
 	__le32 ino;		/* inode nunmber */
@@ -847,9 +821,6 @@ struct node_footer {
 	__le32 next_blkaddr;	/* next node page block address */
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
 	union {
@@ -868,18 +839,12 @@ struct f2fs_node {
 
 #define DEFAULT_NAT_ENTRY_RATIO		20
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
 	__le32 ino;		/* inode number */
 	__le32 block_addr;	/* block address */
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_nat_block {
 	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -916,18 +881,12 @@ struct f2fs_nat_block {
 	((le16_to_cpu((raw_sit)->vblocks) & ~SIT_VBLOCKS_MASK)	\
 	 >> SIT_VBLOCKS_SHIFT)
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_sit_entry {
 	__le16 vblocks;				/* reference above */
 	__u8 valid_map[SIT_VBLOCK_MAP_SIZE];	/* bitmap for valid blocks */
 	__le64 mtime;				/* segment age for cleaning */
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_sit_block {
 	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -953,16 +912,10 @@ struct f2fs_sit_block {
 #define SUM_ENTRIES_SIZE	(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
 /* a summary entry for a 4KB-sized block in a segment */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_summary {
 	__le32 nid;		/* parent node id */
 	union {
 		__u8 reserved[3];
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 		struct {
 			__u8 version;		/* node version number */
 			__le16 ofs_in_node;	/* block index in parent node */
@@ -974,9 +927,6 @@ struct f2fs_summary {
 #define SUM_TYPE_NODE		(1)
 #define SUM_TYPE_DATA		(0)
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct summary_footer {
 	unsigned char entry_type;	/* SUM_TYPE_XXX */
 	__le32 check_sum;		/* summary checksum */
@@ -1008,49 +958,31 @@ enum {
 	SIT_JOURNAL
 };
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct nat_journal_entry {
 	__le32 nid;
 	struct f2fs_nat_entry ne;
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct nat_journal {
 	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
 	__u8 reserved[NAT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct sit_journal_entry {
 	__le32 segno;
 	struct f2fs_sit_entry se;
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct sit_journal {
 	struct sit_journal_entry entries[SIT_JOURNAL_ENTRIES];
 	__u8 reserved[SIT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_extra_info {
 	__le64 kbytes_written;
 	__u8 reserved[EXTRA_INFO_RESERVED];
 } __attribute__((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_journal {
 	union {
 		__le16 n_nats;
@@ -1065,9 +997,6 @@ struct f2fs_journal {
 } __attribute__((packed));
 
 /* 4KB-sized summary block structure */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_summary_block {
 	struct f2fs_summary entries[ENTRIES_IN_SUM];
 	struct f2fs_journal journal;
@@ -1107,9 +1036,6 @@ typedef __le32	f2fs_hash_t;
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_dir_entry {
 	__le32 hash_code;	/* hash code of file name */
 	__le32 ino;		/* inode number */
@@ -1118,9 +1044,6 @@ struct f2fs_dir_entry {
 } __attribute__((packed));
 
 /* 4KB-sized directory entry block */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct f2fs_dentry_block {
 	/* validity bitmap for directory entries in each block */
 	__u8 dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
@@ -1128,6 +1051,7 @@ struct f2fs_dentry_block {
 	struct f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK];
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __attribute__((packed));
+#pragma pack(pop)
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
diff --git a/include/quota.h b/include/quota.h
index cfb9861..f578621 100644
--- a/include/quota.h
+++ b/include/quota.h
@@ -44,18 +44,13 @@ enum quota_type {
 
 #define QT_TREEOFF	1	/* Offset of tree in file in blocks */
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
+#pragma pack(push, 1)
 struct v2_disk_dqheader {
 	u_int32_t dqh_magic;	/* Magic number identifying file */
 	u_int32_t dqh_version;	/* File version */
 } __attribute__ ((packed));
 
 /* Header with type and version specific information */
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct v2_disk_dqinfo {
 	u_int32_t dqi_bgrace;	/* Time before block soft limit becomes hard limit */
 	u_int32_t dqi_igrace;	/* Time before inode soft limit becomes hard limit */
@@ -65,9 +60,6 @@ struct v2_disk_dqinfo {
 	u_int32_t dqi_free_entry;	/* Number of block with at least one free entry */
 } __attribute__ ((packed));
 
-#ifdef ANDROID_WINDOWS_HOST
-#pragma pack(1)
-#endif
 struct v2r1_disk_dqblk {
 	__le32 dqb_id;  	/* id this quota applies to */
 	__le32 dqb_pad;
@@ -82,5 +74,6 @@ struct v2r1_disk_dqblk {
 	__le64 dqb_btime;       /* time limit for excessive disk use */
 	__le64 dqb_itime;       /* time limit for excessive inode use */
 } __attribute__ ((packed));
+#pragma pack(pop)
 
 #endif
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
