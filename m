From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 4/4] f2fs: arguments cleanup of finding file flow functions
Date: Tue, 24 Jun 2014 18:21:23 +0800
Message-ID: <53A95123.40409@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?7J207LC966eM?= <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/dir.c  |   28 +++++++++++++---------------
 fs/f2fs/f2fs.h |    2 +-
 fs/f2fs/hash.c |    4 +++-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ba510fb..06f4833 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,8 +77,8 @@ static unsigned long dir_block_index(unsigned int level,
 	return bidx;
 }
 
-static bool early_match_name(const char *name, size_t namelen,
-			f2fs_hash_t namehash, struct f2fs_dir_entry *de)
+static bool early_match_name(size_t namelen, f2fs_hash_t namehash,
+				struct f2fs_dir_entry *de)
 {
 	if (le16_to_cpu(de->name_len) != namelen)
 		return false;
@@ -90,7 +90,7 @@ static bool early_match_name(const char *name, size_t namelen,
 }
 
 static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
-			const char *name, size_t namelen, int *max_slots,
+			struct qstr *name, int *max_slots,
 			f2fs_hash_t namehash, struct page **res_page)
 {
 	unsigned long bit_pos = 0, bit_start = 0;
@@ -114,9 +114,10 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 			break;
 
 		de = &dentry_blk->dentry[bit_pos];
-		if (early_match_name(name, namelen, namehash, de)) {
+		if (early_match_name(name->len, namehash, de)) {
 			if (!memcmp(dentry_blk->filename[bit_pos],
-							name, namelen)) {
+							name->name,
+							name->len)) {
 				*res_page = dentry_page;
 				return de;
 			}
@@ -131,10 +132,10 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 }
 
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
-		unsigned int level, const char *name, size_t namelen,
+			unsigned int level, struct qstr *name,
 			f2fs_hash_t namehash, struct page **res_page)
 {
-	int s = GET_DENTRY_SLOTS(namelen);
+	int s = GET_DENTRY_SLOTS(name->len);
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block;
 	struct page *dentry_page;
@@ -159,8 +160,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			continue;
 		}
 
-		de = find_in_block(dentry_page, name, namelen,
-					&max_slots, namehash, res_page);
+		de = find_in_block(dentry_page, name, &max_slots,
+					namehash, res_page);
 		if (de)
 			break;
 
@@ -186,8 +187,6 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 			struct qstr *child, struct page **res_page)
 {
-	const char *name = child->name;
-	size_t namelen = child->len;
 	unsigned long npages = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
 	f2fs_hash_t name_hash;
@@ -199,12 +198,11 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 
 	*res_page = NULL;
 
-	name_hash = f2fs_dentry_hash(name, namelen);
+	name_hash = f2fs_dentry_hash(child);
 	max_depth = F2FS_I(dir)->i_current_depth;
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, name,
-				namelen, name_hash, res_page);
+		de = find_in_level(dir, level, child, name_hash, res_page);
 		if (de)
 			break;
 	}
@@ -459,7 +457,7 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	int err = 0;
 	int i;
 
-	dentry_hash = f2fs_dentry_hash(name->name, name->len);
+	dentry_hash = f2fs_dentry_hash(name);
 	level = 0;
 	current_depth = F2FS_I(dir)->i_current_depth;
 	if (F2FS_I(dir)->chash == dentry_hash) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ec480b1..ae3b4ac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1158,7 +1158,7 @@ void f2fs_msg(struct super_block *, const char *, const char *, ...);
 /*
  * hash.c
  */
-f2fs_hash_t f2fs_dentry_hash(const char *, size_t);
+f2fs_hash_t f2fs_dentry_hash(const struct qstr *);
 
 /*
  * node.c
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 6eb8d26..948d17bf 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -69,12 +69,14 @@ static void str2hashbuf(const char *msg, size_t len, unsigned int *buf, int num)
 		*buf++ = pad;
 }
 
-f2fs_hash_t f2fs_dentry_hash(const char *name, size_t len)
+f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info)
 {
 	__u32 hash;
 	f2fs_hash_t f2fs_hash;
 	const char *p;
 	__u32 in[8], buf[4];
+	const char *name = name_info->name;
+	size_t len = name_info->len;
 
 	if ((len <= 2) && (name[0] == '.') &&
 		(name[1] == '.' || name[1] == '\0'))
-- 
1.7.7

