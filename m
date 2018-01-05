From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 03/11] fscrypt: move fscrypt_info_cachep
 declaration to fscrypt_private.h
Date: Fri,  5 Jan 2018 10:44:54 -0800
Message-ID: <20180105184502.48473-4-ebiggers3@gmail.com>
References: <20180105184502.48473-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eXXBM-0000Ux-5A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 18:57:32 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eXXBL-0006w1-EY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 18:57:32 +0000
Received: by mail-it0-f65.google.com with SMTP id z6so2620659iti.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jan 2018 10:57:31 -0800 (PST)
In-Reply-To: <20180105184502.48473-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

The fscrypt_info kmem_cache is internal to fscrypt; filesystems don't
need to access it.  So move its declaration into fscrypt_private.h.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h  | 1 +
 include/linux/fscrypt_supp.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index c0b4f5597e1a..823c43a00bf7 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -72,6 +72,7 @@ typedef enum {
 #define FS_CTX_HAS_BOUNCE_BUFFER_FL		0x00000002
 
 /* crypto.c */
+extern struct kmem_cache *fscrypt_info_cachep;
 extern int fscrypt_initialize(unsigned int cop_flags);
 extern struct workqueue_struct *fscrypt_read_workqueue;
 extern int fscrypt_do_page_crypto(const struct inode *inode,
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index ad40780d4653..33d641e27c18 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -17,7 +17,6 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 }
 
 /* crypto.c */
-extern struct kmem_cache *fscrypt_info_cachep;
 extern struct fscrypt_ctx *fscrypt_get_ctx(const struct inode *, gfp_t);
 extern void fscrypt_release_ctx(struct fscrypt_ctx *);
 extern struct page *fscrypt_encrypt_page(const struct inode *, struct page *,
-- 
2.16.0.rc0.223.g4a4ac83678-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
