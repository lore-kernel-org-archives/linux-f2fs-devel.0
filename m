From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/17] f2fs_dentry_hash: avoid casting unsigned
	char to singed char
Date: Fri, 29 Aug 2014 17:28:48 -0700
Message-ID: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWXn-0005Q4-Ka
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:27 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWXm-0001kQ-AN for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This can hurt when calculating hash value, resulting in false alarm.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       |  5 +++--
 include/f2fs_fs.h |  2 +-
 lib/libf2fs.c     | 31 ++++++++++++-------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2d8dffb..303ba8d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -542,11 +542,12 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 			continue;
 		}
 
-		name_len = le32_to_cpu(de_blk->dentry[i].name_len);
+		name_len = le16_to_cpu(de_blk->dentry[i].name_len);
 		name = calloc(name_len + 1, 1);
 		memcpy(name, de_blk->filename[i], name_len);
+		hash_code = f2fs_dentry_hash((const unsigned char *)name,
+								name_len);
 
-		hash_code = f2fs_dentry_hash((const char *)name, name_len);
 		ASSERT(le32_to_cpu(de_blk->dentry[i].hash_code) == hash_code);
 
 		ftype = de_blk->dentry[i].file_type;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9ade334..aebb1d2 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -679,7 +679,7 @@ extern int dev_fill(void *, __u64, size_t);
 extern int dev_read_block(void *, __u64);
 extern int dev_read_blocks(void *, __u64, __u32 );
 
-f2fs_hash_t f2fs_dentry_hash(const char *, int);
+f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
 extern struct f2fs_configuration config;
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 6168c5c..01ef4e9 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -235,7 +235,8 @@ static void TEA_transform(unsigned int buf[4], unsigned int const in[])
 
 }
 
-static void str2hashbuf(const char *msg, int len, unsigned int *buf, int num)
+static void str2hashbuf(const unsigned char *msg, int len,
+					unsigned int *buf, int num)
 {
 	unsigned pad, val;
 	int i;
@@ -269,24 +270,17 @@ static void str2hashbuf(const char *msg, int len, unsigned int *buf, int num)
  * @param len           name lenth
  * @return              return on success hash value, errno on failure
  */
-f2fs_hash_t f2fs_dentry_hash(const char *name, int len)
+f2fs_hash_t f2fs_dentry_hash(const unsigned char *name, int len)
 {
 	__u32 hash;
 	f2fs_hash_t	f2fs_hash;
-	const char	*p;
+	const unsigned char	*p;
 	__u32 in[8], buf[4];
 
 	/* special hash codes for special dentries */
-	if (name[0] == '.') {
-		if (name[1] == '\0') {
-			f2fs_hash = F2FS_DOT_HASH;
-			goto exit;
-		}
-		if (name[1] == '.' && name[2] == '\0') {
-			f2fs_hash = F2FS_DDOT_HASH;
-			goto exit;
-		}
-	}
+	if ((len <= 2) && (name[0] == '.') &&
+		(name[1] == '.' || name[1] == '\0'))
+		return 0;
 
 	/* Initialize the default seed for the hash checksum functions */
 	buf[0] = 0x67452301;
@@ -295,18 +289,17 @@ f2fs_hash_t f2fs_dentry_hash(const char *name, int len)
 	buf[3] = 0x10325476;
 
 	p = name;
-	while (len > 0) {
+	while (1) {
 		str2hashbuf(p, len, in, 4);
 		TEA_transform(buf, in);
-		len -= 16;
 		p += 16;
+		if (len <= 16)
+			break;
+		len -= 16;
 	}
 	hash = buf[0];
 
-	f2fs_hash = hash;
-exit:
-	f2fs_hash &= ~F2FS_HASH_COL_BIT;
-
+	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
 	return f2fs_hash;
 }
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
