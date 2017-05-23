From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/4] ext4: don't bother checking for encryption key in ->mmap()
Date: Mon, 22 May 2017 17:39:42 -0700
Message-ID: <20170523003945.14279-2-ebiggers3@gmail.com>
References: <20170523003945.14279-1-ebiggers3@gmail.com>
Return-path: <linux-ext4-owner@vger.kernel.org>
In-Reply-To: <20170523003945.14279-1-ebiggers3@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
To: linux-fscrypt@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Since only an open file can be mmap'ed, and we only allow open()ing an
encrypted file when its key is available, there is no need to check for
the key again before permitting each mmap().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/file.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 831fd6beebf0..f0039867b086 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -345,13 +345,6 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	if (ext4_encrypted_inode(inode)) {
-		int err = fscrypt_get_encryption_info(inode);
-		if (err)
-			return 0;
-		if (!fscrypt_has_encryption_key(inode))
-			return -ENOKEY;
-	}
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
-- 
2.13.0.303.g4ebf302169-goog
