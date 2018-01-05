From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 05/11] fscrypt: split
 fscrypt_dummy_context_enabled() into supp/notsupp versions
Date: Fri,  5 Jan 2018 10:44:56 -0800
Message-ID: <20180105184502.48473-6-ebiggers3@gmail.com>
References: <20180105184502.48473-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eXXBO-0003Q1-44
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 18:57:34 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eXXBN-0001do-A8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 18:57:34 +0000
Received: by mail-it0-f68.google.com with SMTP id r6so2708371itr.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jan 2018 10:57:33 -0800 (PST)
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

fscrypt_dummy_context_enabled() accesses ->s_cop, which now is only set
when the filesystem is built with encryption support.  This didn't
actually matter because no filesystems called it.  However, it will
start being used soon, so fix it by moving it from fscrypt.h to
fscrypt_supp.h and stubbing it out in fscrypt_notsupp.h.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fscrypt.h         | 8 --------
 include/linux/fscrypt_notsupp.h | 5 +++++
 include/linux/fscrypt_supp.h    | 6 ++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 0f94d087a6d1..b671a4eef47f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -75,14 +75,6 @@ struct fscrypt_operations {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	28
 
-static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
-{
-	if (inode->i_sb->s_cop->dummy_context &&
-				inode->i_sb->s_cop->dummy_context(inode))
-		return true;
-	return false;
-}
-
 static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
 					u32 filenames_mode)
 {
diff --git a/include/linux/fscrypt_notsupp.h b/include/linux/fscrypt_notsupp.h
index 812dc701a5b3..81e02201b215 100644
--- a/include/linux/fscrypt_notsupp.h
+++ b/include/linux/fscrypt_notsupp.h
@@ -19,6 +19,11 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 	return false;
 }
 
+static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
+{
+	return false;
+}
+
 /* crypto.c */
 static inline struct fscrypt_ctx *fscrypt_get_ctx(const struct inode *inode,
 						  gfp_t gfp_flags)
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index fd6ee089ced0..e7dfa2974906 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -31,6 +31,12 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 	return (inode->i_crypt_info != NULL);
 }
 
+static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
+{
+	return inode->i_sb->s_cop->dummy_context &&
+		inode->i_sb->s_cop->dummy_context(inode);
+}
+
 /* crypto.c */
 extern struct fscrypt_ctx *fscrypt_get_ctx(const struct inode *, gfp_t);
 extern void fscrypt_release_ctx(struct fscrypt_ctx *);
-- 
2.16.0.rc0.223.g4a4ac83678-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
