From: Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH 2/5] fscrypt: use ENOTDIR when setting encryption policy on nondirectory
Date: Mon,  5 Dec 2016 11:12:45 -0800
Message-ID: <1480965168-38747-3-git-send-email-ebiggers@google.com>
References: <1480965168-38747-1-git-send-email-ebiggers@google.com>
Return-path: <linux-ext4-owner@vger.kernel.org>
In-Reply-To: <1480965168-38747-1-git-send-email-ebiggers@google.com>
Sender: linux-ext4-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As part of an effort to clean up fscrypt-related error codes, make
FS_IOC_SET_ENCRYPTION_POLICY fail with ENOTDIR when the file descriptor
does not refer to a directory.  This is more descriptive than EINVAL,
which was ambiguous with some of the other error cases.

I am not aware of any users who might be relying on the previous error
code of EINVAL, which was never documented anywhere, and in some buggy
kernels did not exist at all as the S_ISDIR() check was missing.

This failure case will be exercised by an xfstest.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index b96a10e..1118f3a 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -116,7 +116,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 
 	if (!inode_has_encryption_context(inode)) {
 		if (!S_ISDIR(inode->i_mode))
-			ret = -EINVAL;
+			ret = -ENOTDIR;
 		else if (!inode->i_sb->s_cop->empty_dir)
 			ret = -EOPNOTSUPP;
 		else if (!inode->i_sb->s_cop->empty_dir(inode))
-- 
2.8.0.rc3.226.g39d4020

