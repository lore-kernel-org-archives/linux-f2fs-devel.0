From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs crypto: fix to release buffer for fname crypto
Date: Wed, 13 May 2015 18:20:54 +0800
Message-ID: <00d401d08d66$98623d20$c926b760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes memory leak issue in error path of f2fs_fname_setup_filename().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_fname.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index e3a1bdc..016c4b6 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -425,7 +425,7 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (!f2fs_encrypted_inode(dir) || is_dot_dotdot(iname)) {
 		fname->disk_name.name = (unsigned char *)iname->name;
 		fname->disk_name.len = iname->len;
-		goto out;
+		return 0;
 	}
 	ret = f2fs_setup_fname_crypto(dir);
 	if (ret)
@@ -435,14 +435,13 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 		ret = f2fs_fname_crypto_alloc_buffer(dir, iname->len,
 						     &fname->crypto_buf);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = f2fs_fname_encrypt(dir, iname, &fname->crypto_buf);
 		if (ret < 0)
 			goto out;
 		fname->disk_name.name = fname->crypto_buf.name;
 		fname->disk_name.len = fname->crypto_buf.len;
-		ret = 0;
-		goto out;
+		return 0;
 	}
 	if (!lookup) {
 		ret = -EACCES;
@@ -476,8 +475,9 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 		fname->disk_name.name = fname->crypto_buf.name;
 		fname->disk_name.len = fname->crypto_buf.len;
 	}
-	ret = 0;
+	return 0;
 out:
+	f2fs_fname_crypto_free_buffer(&fname->crypto_buf);
 	return ret;
 }
 
-- 
2.3.3
