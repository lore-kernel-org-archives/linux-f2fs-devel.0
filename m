From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH v2] f2fs: merge two uchar variable in struct
 node_info to reduce memory cost
Date: Mon, 15 Dec 2014 17:33:06 +0800
Message-ID: <000001d0184a$3f09d580$bd1d8080$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch moves one member of struct nat_entry: _flag_ to struct node_info,
so _version_ in struct node_info and _flag_ with unsigned char type will merge
to one 32-bit space in register/memory. Then the size of nat_entry will reduce
its size from 28 bytes to 24 bytes and slab memory using by f2fs will be
reduced.

changes from v1:
 o introduce inline copy_node_info() to copy valid data from node info suggested
   by Jaegeuk Kim, it can avoid bug.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |  4 ++--
 fs/f2fs/node.h | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f83326c..5aa54a0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -268,7 +268,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	e = __lookup_nat_cache(nm_i, ni->nid);
 	if (!e) {
 		e = grab_nat_entry(nm_i, ni->nid);
-		e->ni = *ni;
+		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
 	} else if (new_blkaddr == NEW_ADDR) {
 		/*
@@ -276,7 +276,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 		 * previous nat entry can be remained in nat cache.
 		 * So, reinitialize it with new information.
 		 */
-		e->ni = *ni;
+		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
 	}
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index d10b644..eb59167 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -29,6 +29,14 @@
 /* return value for read_node_page */
 #define LOCKED_PAGE	1
 
+/* For flag in struct node_info */
+enum {
+	IS_CHECKPOINTED,	/* is it checkpointed before? */
+	HAS_FSYNCED_INODE,	/* is the inode fsynced before? */
+	HAS_LAST_FSYNC,		/* has the latest node fsync mark? */
+	IS_DIRTY,		/* this nat entry is dirty? */
+};
+
 /*
  * For node information
  */
@@ -37,18 +45,11 @@ struct node_info {
 	nid_t ino;		/* inode number of the node's owner */
 	block_t	blk_addr;	/* block address of the node */
 	unsigned char version;	/* version of the node */
-};
-
-enum {
-	IS_CHECKPOINTED,	/* is it checkpointed before? */
-	HAS_FSYNCED_INODE,	/* is the inode fsynced before? */
-	HAS_LAST_FSYNC,		/* has the latest node fsync mark? */
-	IS_DIRTY,		/* this nat entry is dirty? */
+	unsigned char flag;	/* for node information bits */
 };
 
 struct nat_entry {
 	struct list_head list;	/* for clean or dirty nat list */
-	unsigned char flag;	/* for node information bits */
 	struct node_info ni;	/* in-memory node information */
 };
 
@@ -63,20 +64,30 @@ struct nat_entry {
 
 #define inc_node_version(version)	(++version)
 
+static inline void copy_node_info(struct node_info *dst,
+						struct node_info *src)
+{
+	dst->nid = src->nid;
+	dst->ino = src->ino;
+	dst->blk_addr = src->blk_addr;
+	dst->version = src->version;
+	/* should not copy flag here */
+}
+
 static inline void set_nat_flag(struct nat_entry *ne,
 				unsigned int type, bool set)
 {
 	unsigned char mask = 0x01 << type;
 	if (set)
-		ne->flag |= mask;
+		ne->ni.flag |= mask;
 	else
-		ne->flag &= ~mask;
+		ne->ni.flag &= ~mask;
 }
 
 static inline bool get_nat_flag(struct nat_entry *ne, unsigned int type)
 {
 	unsigned char mask = 0x01 << type;
-	return ne->flag & mask;
+	return ne->ni.flag & mask;
 }
 
 static inline void nat_reset_flag(struct nat_entry *ne)
-- 
2.1.2
