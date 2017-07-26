From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 2/7] fscrypt: rename ->ci_master_key to
 ->ci_master_key_descriptor
Date: Wed, 26 Jul 2017 11:19:24 -0700
Message-ID: <20170726181929.99880-3-ebiggers3@gmail.com>
References: <20170726181929.99880-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1daQx0-0000xX-6T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 18:22:26 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1daQwu-0002YT-9v
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 18:22:21 +0000
Received: by mail-pf0-f194.google.com with SMTP id m21so1718815pfj.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Jul 2017 11:22:20 -0700 (PDT)
In-Reply-To: <20170726181929.99880-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, Michael Halcrow <mhalcrow@google.com>, Alex Cope <alexcope@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In struct fscrypt_info, ->ci_master_key is the master key descriptor,
not the master key itself.  In preparation for introducing a struct
fscrypt_master_key and making ->ci_master_key point to it, rename the
existing ->ci_master_key to ->ci_master_key_descriptor.

Acked-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 2 +-
 fs/crypto/keyinfo.c         | 4 ++--
 fs/crypto/policy.c          | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 8329fb905ac6..4b0205accae9 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -110,7 +110,7 @@ struct fscrypt_info {
 	u8 ci_data_mode;
 	u8 ci_filename_mode;
 	u8 ci_flags;
-	u8 ci_master_key[FS_KEY_DESCRIPTOR_SIZE];
+	u8 ci_master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
 };
 
 typedef enum {
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 7e664a11340a..5591fd24e4b2 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -293,8 +293,8 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
 	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
 	crypt_info->ci_flags = ctx.flags;
-	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
-				sizeof(crypt_info->ci_master_key));
+	memcpy(crypt_info->ci_master_key_descriptor, ctx.master_key_descriptor,
+	       FS_KEY_DESCRIPTOR_SIZE);
 
 	res = determine_cipher_type(crypt_info, inode, &cipher_str, &keysize);
 	if (res)
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index d6beb48f08fc..fe525da9e79c 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -226,7 +226,8 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 	child_ci = child->i_crypt_info;
 
 	if (parent_ci && child_ci) {
-		return memcmp(parent_ci->ci_master_key, child_ci->ci_master_key,
+		return memcmp(parent_ci->ci_master_key_descriptor,
+			      child_ci->ci_master_key_descriptor,
 			      FS_KEY_DESCRIPTOR_SIZE) == 0 &&
 			(parent_ci->ci_context_version ==
 			 child_ci->ci_context_version) &&
@@ -284,7 +285,7 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	ctx.contents_encryption_mode = ci->ci_data_mode;
 	ctx.filenames_encryption_mode = ci->ci_filename_mode;
 	ctx.flags = ci->ci_flags;
-	memcpy(ctx.master_key_descriptor, ci->ci_master_key,
+	memcpy(ctx.master_key_descriptor, ci->ci_master_key_descriptor,
 	       FS_KEY_DESCRIPTOR_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 	if (ctx.version != FSCRYPT_CONTEXT_V1)
-- 
2.14.0.rc0.400.g1c36432dff-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
