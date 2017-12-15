From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 06/24] fscrypt: move fscrypt_operations
 declaration to fscrypt_supp.h
Date: Fri, 15 Dec 2017 09:42:07 -0800
Message-ID: <20171215174225.31583-7-ebiggers3@gmail.com>
References: <20171215174225.31583-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1ePu4Q-0005Ob-Q7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:46:50 +0000
Received: from mail-pg0-f68.google.com ([74.125.83.68])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1ePu4P-00054o-V4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:46:50 +0000
Received: by mail-pg0-f68.google.com with SMTP id f12so6255669pgo.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Dec 2017 09:46:49 -0800 (PST)
In-Reply-To: <20171215174225.31583-1-ebiggers3@gmail.com>
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Filesystems now only define their fscrypt_operations when they are
compiled with encryption support, so move the fscrypt_operations
declaration from fscrypt.h to fscrypt_supp.h.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fscrypt.h      | 18 ------------------
 include/linux/fscrypt_supp.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b671a4eef47f..33b95a91f720 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -54,24 +54,6 @@ struct fscrypt_name {
 #define fname_name(p)		((p)->disk_name.name)
 #define fname_len(p)		((p)->disk_name.len)
 
-/*
- * fscrypt superblock flags
- */
-#define FS_CFLG_OWN_PAGES (1U << 1)
-
-/*
- * crypto opertions for filesystems
- */
-struct fscrypt_operations {
-	unsigned int flags;
-	const char *key_prefix;
-	int (*get_context)(struct inode *, void *, size_t);
-	int (*set_context)(struct inode *, const void *, size_t, void *);
-	bool (*dummy_context)(struct inode *);
-	bool (*empty_dir)(struct inode *);
-	unsigned (*max_namelen)(struct inode *);
-};
-
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	28
 
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index e7dfa2974906..ce61caf26f40 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -11,6 +11,24 @@
 #ifndef _LINUX_FSCRYPT_SUPP_H
 #define _LINUX_FSCRYPT_SUPP_H
 
+/*
+ * fscrypt superblock flags
+ */
+#define FS_CFLG_OWN_PAGES (1U << 1)
+
+/*
+ * crypto operations for filesystems
+ */
+struct fscrypt_operations {
+	unsigned int flags;
+	const char *key_prefix;
+	int (*get_context)(struct inode *, void *, size_t);
+	int (*set_context)(struct inode *, const void *, size_t, void *);
+	bool (*dummy_context)(struct inode *);
+	bool (*empty_dir)(struct inode *);
+	unsigned (*max_namelen)(struct inode *);
+};
+
 struct fscrypt_ctx {
 	union {
 		struct {
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
