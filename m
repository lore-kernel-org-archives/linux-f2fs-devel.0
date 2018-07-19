From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: restrict setting up inode.i_advise
Date: Thu, 19 Jul 2018 23:57:54 +0800
Message-ID: <20180719155754.15678-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In order to give advise to f2fs to recognize hot/cold file, it is possible
that we can set specific bit in inode.i_advise through setxattr(), but
there are several bits which are used internally, such as encrypt_bit,
keep_size_bit, they should never be changed through setxattr().

So that this patch 1) adds FADVISE_MODIFIABLE_BITS to filter modifiable
bits user given, 2) supports to clear {hot,cold}_file bits.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/xattr.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ff3b80da32f3..5501532d7039 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -609,6 +609,8 @@ enum {
 #define FADVISE_HOT_BIT		0x20
 #define FADVISE_VERITY_BIT	0x40	/* reserved */
 
+#define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
+
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_set_cold(inode)	set_file(inode, FADVISE_COLD_BIT)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 708271871f94..34c98de6144e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -100,12 +100,22 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		const char *name, const void *value,
 		size_t size, int flags)
 {
+	unsigned char old_advise = F2FS_I(inode)->i_advise;
+	unsigned char new_advise;
+
 	if (!inode_owner_or_capable(inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
 
-	F2FS_I(inode)->i_advise |= *(char *)value;
+	new_advise = *(char *)value;
+	if (new_advise & ~FADVISE_MODIFIABLE_BITS)
+		return -EINVAL;
+
+	new_advise = new_advise & FADVISE_MODIFIABLE_BITS;
+	new_advise |= old_advise & ~FADVISE_MODIFIABLE_BITS;
+
+	F2FS_I(inode)->i_advise = new_advise;
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
-- 
2.16.2.17.g38e79b1fd
