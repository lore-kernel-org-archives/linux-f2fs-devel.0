From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 1/2] sload.f2fs: let dir_buckets/dir_block_index
 supports dir_level
Date: Fri, 17 Mar 2017 22:01:04 +0800
Message-ID: <ac6d4e19-6d7a-77be-9469-6b06369e63d0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cosRV-0003kW-0t
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 14:01:21 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cosRP-0007UI-2v
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 14:01:21 +0000
Received: by mail-it0-f65.google.com with SMTP id u69so4114929ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 07:01:15 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

The dir_level in the filesystem maybe larger than zero,
supports it.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/dir.c  | 38 ++++++--------------------------------
 fsck/f2fs.h | 37 +++++++++++++++++++++++++++++++++++++
 fsck/fsck.c | 27 ---------------------------
 3 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index d817d27..d684b5d 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -16,34 +16,6 @@
 #include "fsck.h"
 #include "node.h"
 
-static unsigned int dir_buckets(unsigned int level)
-{
-	if (level < MAX_DIR_HASH_DEPTH / 2)
-		return 1 << level;
-	else
-		return MAX_DIR_BUCKETS;
-}
-
-static unsigned int bucket_blocks(unsigned int level)
-{
-	if (level < MAX_DIR_HASH_DEPTH / 2)
-		return 2;
-	else
-		return 4;
-}
-
-static unsigned long dir_block_index(unsigned int level,
-		int dir_level, unsigned int idx)
-{
-	unsigned long i;
-	unsigned long bidx = 0;
-
-	for (i = 0; i < level; i++)
-		bidx += dir_buckets(i + dir_level) * bucket_blocks(i);
-	bidx += idx * bucket_blocks(level);
-	return bidx;
-}
-
 static int room_for_filename(const u8 *bitmap, int slots, int max_slots)
 {
 	int bit_start = 0;
@@ -136,14 +108,15 @@ static int find_in_level(struct f2fs_sb_info *sbi,struct f2fs_node *dir,
 	int max_slots = 214;
 	nid_t ino = le32_to_cpu(dir->footer.ino);
 	f2fs_hash_t namehash;
+	unsigned int dir_level = dir->i.i_dir_level;
 	int ret = 0;
 
 	namehash = f2fs_dentry_hash(de->name, de->len);
 
-	nbucket = dir_buckets(level);
+	nbucket = dir_buckets(level, dir_level);
 	nblock = bucket_blocks(level);
 
-	bidx = dir_block_index(level, 0, le32_to_cpu(namehash) % nbucket);
+	bidx = dir_block_index(level, dir_level, le32_to_cpu(namehash) % nbucket);
 	end_block = bidx + nblock;
 
 	dentry_blk = calloc(BLOCK_SZ, 1);
@@ -237,6 +210,7 @@ static int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
 	nid_t pino = le32_to_cpu(parent->footer.ino);
 	nid_t ino = le32_to_cpu(child->footer.ino);
 	umode_t mode = le16_to_cpu(child->i.i_mode);
+	unsigned int dir_level = parent->i.i_dir_level;
 	int ret;
 
 	if (parent == NULL || child == NULL)
@@ -262,9 +236,9 @@ start:
 	if (level == current_depth)
 		++current_depth;
 
-	nbucket = dir_buckets(level);
+	nbucket = dir_buckets(level, dir_level);
 	nblock = bucket_blocks(level);
-	bidx = dir_block_index(level, 0, le32_to_cpu(dentry_hash) % nbucket);
+	bidx = dir_block_index(level, dir_level, le32_to_cpu(dentry_hash) % nbucket);
 
 	for (block = bidx; block <= (bidx + nblock - 1); block++) {
 
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 5c8eea5..b621912 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -465,4 +465,41 @@ extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_
 #define IS_SUM_NODE_SEG(footer)		(footer.entry_type == SUM_TYPE_NODE)
 #define IS_SUM_DATA_SEG(footer)		(footer.entry_type == SUM_TYPE_DATA)
 
+static inline unsigned int dir_buckets(unsigned int level, int dir_level)
+{
+	if (level + dir_level < MAX_DIR_HASH_DEPTH / 2)
+		return 1 << (level + dir_level);
+	else
+		return MAX_DIR_BUCKETS;
+}
+
+static inline unsigned int bucket_blocks(unsigned int level)
+{
+	if (level < MAX_DIR_HASH_DEPTH / 2)
+		return 2;
+	else
+		return 4;
+}
+
+static inline unsigned long dir_block_index(unsigned int level,
+				int dir_level, unsigned int idx)
+{
+	unsigned long i;
+	unsigned long bidx = 0;
+
+	for (i = 0; i < level; i++)
+		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
+	bidx += idx * bucket_blocks(level);
+	return bidx;
+}
+
+static inline int is_dot_dotdot(const unsigned char *name, const int len)
+{
+	if (len == 1 && name[0] == '.')
+		return 1;
+	if (len == 2 && name[0] == '.' && name[1] == '.')
+		return 1;
+	return 0;
+}
+
 #endif /* _F2FS_H_ */
diff --git a/fsck/fsck.c b/fsck/fsck.c
index cbd29cc..afd83e5 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1084,33 +1084,6 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 	return 0;
 }
 
-static unsigned int dir_buckets(unsigned int level, int dir_level)
-{
-	if (level + dir_level < MAX_DIR_HASH_DEPTH / 2)
-		return 1 << (level + dir_level);
-	else
-		return MAX_DIR_BUCKETS;
-}
-
-static unsigned int bucket_blocks(unsigned int level)
-{
-	if (level < MAX_DIR_HASH_DEPTH / 2)
-		return 2;
-	else
-		return 4;
-}
-
-static unsigned long dir_block_index(unsigned int level,
-				int dir_level, unsigned int idx)
-{
-	unsigned long i;
-	unsigned long bidx = 0;
-
-	for (i = 0; i < level; i++)
-		bidx += dir_buckets(i, dir_level) * bucket_blocks(i);
-	bidx += idx * bucket_blocks(level);
-	return bidx;
-}
 
 static int __get_current_level(int dir_level, u32 pgofs)
 {
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
