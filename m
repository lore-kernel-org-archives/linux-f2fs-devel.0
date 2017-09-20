From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 10/25] fscrypt: new helper function -
 fscrypt_prepare_setattr()
Date: Wed, 20 Sep 2017 15:45:50 -0700
Message-ID: <20170920224605.22030-11-ebiggers3@gmail.com>
References: <20170920224605.22030-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1dunlt-0003lo-24
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:09 +0000
Received: from mail-pg0-f68.google.com ([74.125.83.68])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dunls-0003Cd-58
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:08 +0000
Received: by mail-pg0-f68.google.com with SMTP id j16so2375837pga.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2017 15:47:08 -0700 (PDT)
In-Reply-To: <20170920224605.22030-1-ebiggers3@gmail.com>
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, Michael Halcrow <mhalcrow@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Introduce a helper function for filesystems to call when processing
->setattr() on a possibly-encrypted inode.  It handles enforcing that an
encrypted file can only be truncated if its encryption key is available.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fscrypt_notsupp.h |  8 ++++++++
 include/linux/fscrypt_supp.h    | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/fscrypt_notsupp.h b/include/linux/fscrypt_notsupp.h
index e9b437605f9c..b0dd2d1756b2 100644
--- a/include/linux/fscrypt_notsupp.h
+++ b/include/linux/fscrypt_notsupp.h
@@ -218,4 +218,12 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 	return 0;
 }
 
+static inline int fscrypt_prepare_setattr(struct dentry *dentry,
+					  struct iattr *attr)
+{
+	if (IS_ENCRYPTED(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 #endif	/* _LINUX_FSCRYPT_NOTSUPP_H */
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index 2b99bc01c59b..bdd01e02435b 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -270,4 +270,29 @@ static inline int fscrypt_prepare_lookup(struct inode *dir,
 	return 0;
 }
 
+/**
+ * fscrypt_prepare_setattr - prepare to change a possibly-encrypted inode's attributes
+ * @dentry: dentry through which the inode is being changed
+ * @attr: attributes to change
+ *
+ * Prepare for ->setattr() on a possibly-encrypted inode.  On an encrypted file,
+ * most attribute changes are allowed even without the encryption key.  However,
+ * without the encryption key we do have to forbid truncates.  This is needed
+ * because the size being truncated to may not be a multiple of the filesystem
+ * block size, and in that case we'd have to decrypt the final block, zero the
+ * portion past i_size, and re-encrypt it.  (We *could* allow truncating to a
+ * filesystem block boundary, but it's simpler to just forbid all truncates ---
+ * and we already forbid all other contents modifications without the key.)
+ *
+ * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
+ * if a problem occurred while setting up the encryption key.
+ */
+static inline int fscrypt_prepare_setattr(struct dentry *dentry,
+					  struct iattr *attr)
+{
+	if (IS_ENCRYPTED(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE))
+		return fscrypt_require_key(d_inode(dentry));
+	return 0;
+}
+
 #endif	/* _LINUX_FSCRYPT_SUPP_H */
-- 
2.14.1.821.g8fa685d3b7-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
