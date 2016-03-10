From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: support access control via key management
Date: Wed,  9 Mar 2016 16:52:48 -0800
Message-ID: <1457571168-56724-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Through this patch, user can assign its key into a specific normal files.
Then, other users who do not have that key cannot open the files.
Later, owner can drop its key from the files for other users to access
the files again.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 20 +++++++++++++++++
 fs/f2fs/file.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/xattr.c |  7 ++++++
 fs/f2fs/xattr.h |  1 +
 4 files changed, 97 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bbe2cd1..cbc115b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -212,6 +212,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 
+#define F2FS_IOC_KEYCTL		_IOW(F2FS_IOCTL_MAGIC, 9, struct f2fs_key)
+
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
@@ -235,6 +237,20 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #endif
 
+#define F2FS_KEY_SIZE	8
+#define F2FS_KEY_DESC_PREFIX		"f2fs:"
+#define F2FS_KEY_DESC_PREFIX_SIZE	5
+
+enum f2fs_key_mode {
+	F2FS_SET_KEY,
+	F2FS_DROP_KEY,
+};
+
+struct f2fs_key {
+	u8 key[F2FS_KEY_SIZE];
+	u8 mode;
+};
+
 struct f2fs_defragment {
 	u64 start;
 	u64 len;
@@ -358,6 +374,7 @@ struct f2fs_map_blocks {
 #define FADVISE_LOST_PINO_BIT	0x02
 #define FADVISE_ENCRYPT_BIT	0x04
 #define FADVISE_ENC_NAME_BIT	0x08
+#define FADVISE_KEY_BIT		0x10
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
@@ -370,6 +387,9 @@ struct f2fs_map_blocks {
 #define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
 #define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
 #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
+#define file_has_key(inode)	is_file(inode, FADVISE_KEY_BIT)
+#define file_set_key(inode)	set_file(inode, FADVISE_KEY_BIT)
+#define file_clear_key(inode)	clear_file(inode, FADVISE_KEY_BIT)
 
 #define DEF_DIR_LEVEL		0
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b41c357..80f6b29 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/mount.h>
 #include <linux/pagevec.h>
 #include <linux/random.h>
+#include <keys/user-type.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -438,6 +439,40 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int validate_access_key(struct inode *inode)
+{
+	u8 full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
+					(F2FS_KEY_SIZE * 2) + 1];
+	struct key *keyring_key = NULL;
+	u8 key[F2FS_KEY_SIZE];
+	int ret;
+
+	ret = f2fs_getxattr(inode, F2FS_XATTR_INDEX_KEY,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				key, F2FS_KEY_SIZE, NULL);
+	if (ret != F2FS_KEY_SIZE)
+		return -EINVAL;
+
+	memcpy(full_key_descriptor, F2FS_KEY_DESC_PREFIX,
+					F2FS_KEY_DESC_PREFIX_SIZE);
+	sprintf(full_key_descriptor + F2FS_KEY_DESC_PREFIX_SIZE,
+					"%*phN", F2FS_KEY_SIZE, key);
+	full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
+					(2 * F2FS_KEY_SIZE)] = '\0';
+	keyring_key = request_key(&key_type_logon, full_key_descriptor, NULL);
+	if (IS_ERR(keyring_key))
+		return PTR_ERR(keyring_key);
+
+	if (keyring_key->type != &key_type_logon) {
+		printk_once(KERN_WARNING
+				"%s: key type must be logon\n", __func__);
+		key_put(keyring_key);
+		return -ENOKEY;
+	}
+	key_put(keyring_key);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret = generic_file_open(inode, filp);
@@ -453,6 +488,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (f2fs_encrypted_inode(dir) &&
 			!fscrypt_has_permitted_context(dir, inode))
 		return -EPERM;
+
+	if (file_has_key(inode))
+		return validate_access_key(inode);
 	return ret;
 }
 
@@ -1532,6 +1570,35 @@ static bool uuid_is_nonzero(__u8 u[16])
 	return false;
 }
 
+static int f2fs_ioc_keyctl(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_key key;
+	void *value = key.key;
+	int type = XATTR_CREATE;
+
+	if (copy_from_user(&key, (u8 __user *)arg, sizeof(key)))
+		return -EFAULT;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (key.mode == F2FS_DROP_KEY) {
+		int ret = validate_access_key(inode);
+
+		if (ret)
+			return ret;
+
+		value = NULL;
+		type = XATTR_REPLACE;
+	}
+
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_KEY,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				value, F2FS_KEY_SIZE, NULL, type);
+}
+
 static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct fscrypt_policy policy;
@@ -1845,6 +1912,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_shutdown(filp, arg);
 	case FITRIM:
 		return f2fs_ioc_fitrim(filp, arg);
+	case F2FS_IOC_KEYCTL:
+		return f2fs_ioc_keyctl(filp, arg);
 	case F2FS_IOC_SET_ENCRYPTION_POLICY:
 		return f2fs_ioc_set_encryption_policy(filp, arg);
 	case F2FS_IOC_GET_ENCRYPTION_POLICY:
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 06a72dc..5b02b31 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -550,6 +550,13 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
+	if (index == F2FS_XATTR_INDEX_KEY &&
+			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT)) {
+		if (value)
+			file_set_key(inode);
+		else
+			file_clear_key(inode);
+	}
 
 	if (ipage)
 		update_inode(inode, ipage);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 79dccc8..cb5282c 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -37,6 +37,7 @@
 #define F2FS_XATTR_INDEX_ADVISE			7
 /* Should be same as EXT4_XATTR_INDEX_ENCRYPTION */
 #define F2FS_XATTR_INDEX_ENCRYPTION		9
+#define F2FS_XATTR_INDEX_KEY			10
 
 #define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
 
-- 
2.6.3

