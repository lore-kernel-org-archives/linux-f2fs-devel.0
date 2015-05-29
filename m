From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs crypto: clean up error handling in f2fs_fname_setup_filename
Date: Fri, 29 May 2015 11:04:37 -0700
Message-ID: <1432922678-22578-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Sync with:
  ext4 crypto: clean up error handling in ext4_fname_setup_filename

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto_fname.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 81852cc..ab377d4 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -392,15 +392,13 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 			return ret;
 		ret = f2fs_fname_encrypt(dir, iname, &fname->crypto_buf);
 		if (ret < 0)
-			goto out;
+			goto errout;
 		fname->disk_name.name = fname->crypto_buf.name;
 		fname->disk_name.len = fname->crypto_buf.len;
 		return 0;
 	}
-	if (!lookup) {
-		ret = -EACCES;
-		goto out;
-	}
+	if (!lookup)
+		return -EACCES;
 
 	/* We don't have the key and we are doing a lookup; decode the
 	 * user-supplied name
@@ -408,19 +406,17 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (iname->name[0] == '_')
 		bigname = 1;
 	if ((bigname && (iname->len != 33)) ||
-	    (!bigname && (iname->len > 43))) {
-		ret = -ENOENT;
-	}
+	    (!bigname && (iname->len > 43)))
+		return -ENOENT;
+
 	fname->crypto_buf.name = kmalloc(32, GFP_KERNEL);
-	if (fname->crypto_buf.name == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (fname->crypto_buf.name == NULL)
+		return -ENOMEM;
 	ret = digest_decode(iname->name + bigname, iname->len - bigname,
 				fname->crypto_buf.name);
 	if (ret < 0) {
 		ret = -ENOENT;
-		goto out;
+		goto errout;
 	}
 	fname->crypto_buf.len = ret;
 	if (bigname) {
@@ -430,7 +426,7 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 		fname->disk_name.len = fname->crypto_buf.len;
 	}
 	return 0;
-out:
+errout:
 	f2fs_fname_crypto_free_buffer(&fname->crypto_buf);
 	return ret;
 }
-- 
2.1.1
