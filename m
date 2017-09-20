From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 05/25] fscrypt: new helper function -
 fscrypt_require_key()
Date: Wed, 20 Sep 2017 15:45:45 -0700
Message-ID: <20170920224605.22030-6-ebiggers3@gmail.com>
References: <20170920224605.22030-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <ebiggers3@gmail.com>) id 1dunln-00080O-8X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:03 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dunlm-0006nV-BZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Sep 2017 22:47:03 +0000
Received: by mail-pg0-f66.google.com with SMTP id j16so2375737pga.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2017 15:47:02 -0700 (PDT)
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

Add a helper function which checks if an inode is encrypted, and if so,
tries to set up its encryption key.  This is a pattern which is
duplicated in multiple places in each of ext4, f2fs, and ubifs --- for
example, when a regular file is asked to be opened or truncated.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fscrypt_notsupp.h |  8 ++++++++
 include/linux/fscrypt_supp.h    | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/fscrypt_notsupp.h b/include/linux/fscrypt_notsupp.h
index 3f1325ec4646..3cfc953fef71 100644
--- a/include/linux/fscrypt_notsupp.h
+++ b/include/linux/fscrypt_notsupp.h
@@ -174,4 +174,12 @@ static inline int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	return -EOPNOTSUPP;
 }
 
+/* hooks.c */
+static inline int fscrypt_require_key(struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 #endif	/* _LINUX_FSCRYPT_NOTSUPP_H */
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index 32e2fcf13b01..b6d4b5d303a3 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -142,4 +142,32 @@ extern void fscrypt_pullback_bio_page(struct page **, bool);
 extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
 				 unsigned int);
 
+/* hooks.c */
+
+/**
+ * fscrypt_require_key - require an inode's encryption key
+ * @inode: the inode we need the key for
+ *
+ * If the inode is encrypted, set up its encryption key if not already done.
+ * Then require that the key be present and return -ENOKEY otherwise.
+ *
+ * No locks are needed, and currently the key will live as long as the struct
+ * inode --- so it won't go away from under you.
+ *
+ * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
+ * if a problem occurred while setting up the encryption key.
+ */
+static inline int fscrypt_require_key(struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode)) {
+		int err = fscrypt_get_encryption_info(inode);
+
+		if (err)
+			return err;
+		if (!fscrypt_has_encryption_key(inode))
+			return -ENOKEY;
+	}
+	return 0;
+}
+
 #endif	/* _LINUX_FSCRYPT_SUPP_H */
-- 
2.14.1.821.g8fa685d3b7-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
