From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] f2fs: super: constify fscrypt_operations structure
Date: Sat, 11 Feb 2017 15:50:46 +0530
Message-ID: <1486808446-23373-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Declare fscrypt_operations structure as const as it is only stored in
the s_cop field of a super_block structure. This field is of type const,
so fscrypt_operations structure having this property can be made const
too.

File size before: fs/f2fs/super.o
   text	   data	    bss	    dec	    hex	filename
  54131	  31355	    184	  85670	  14ea6	fs/f2fs/super.o

File size after: fs/f2fs/super.o
   text	   data	    bss	    dec	    hex	filename
  54227	  31259	    184	  85670	  14ea6	fs/f2fs/super.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 46fd30d..b17ca61 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1176,7 +1176,7 @@ static unsigned f2fs_max_namelen(struct inode *inode)
 			inode->i_sb->s_blocksize : F2FS_NAME_LEN;
 }
 
-static struct fscrypt_operations f2fs_cryptops = {
+static const struct fscrypt_operations f2fs_cryptops = {
 	.get_context	= f2fs_get_context,
 	.key_prefix	= f2fs_key_prefix,
 	.set_context	= f2fs_set_context,
@@ -1185,7 +1185,7 @@ static unsigned f2fs_max_namelen(struct inode *inode)
 	.max_namelen	= f2fs_max_namelen,
 };
 #else
-static struct fscrypt_operations f2fs_cryptops = {
+static const struct fscrypt_operations f2fs_cryptops = {
 	.is_encrypted	= f2fs_encrypted_inode,
 };
 #endif
-- 
1.9.1
