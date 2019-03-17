From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 3/5] fs,
 fscrypt: clear DCACHE_ENCRYPTED_NAME when unaliasing directory
Date: Sun, 17 Mar 2019 13:04:42 -0700
Message-ID: <20190317200444.5967-4-ebiggers@kernel.org>
References: <20190317200444.5967-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1h5c41-0004Ii-Cr
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Mar 2019 20:07:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5c3z-0043Cq-JN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Mar 2019 20:07:21 +0000
In-Reply-To: <20190317200444.5967-1-ebiggers@kernel.org>
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
Cc: linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Sarthak Kukreti <sarthakkukreti@chromium.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make __d_move() clear DCACHE_ENCRYPTED_NAME on the source dentry.  This
is needed for when d_splice_alias() moves a directory's encrypted alias
to its decrypted alias as a result of the encryption key being added.

Otherwise, the decrypted alias will incorrectly be invalidated on the
next lookup, causing problems such as unmounting a mount the user just
mount()ed there.

Note that we don't have to support arbitrary moves of this flag because
fscrypt doesn't allow dentries with DCACHE_ENCRYPTED_NAME to be the
source or target of a rename().

Fixes: 28b4c263961c ("ext4 crypto: revalidate dentry after adding or removing the key")
Reported-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/dcache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index aac41adf4743..e27d11151d0e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2718,6 +2718,20 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		kfree_rcu(old_name, u.head);
 }
 
+static void fscrypt_update_flags(struct dentry *dentry)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	/*
+	 * When d_splice_alias() moves a directory's encrypted alias to its
+	 * decrypted alias as a result of the encryption key being added,
+	 * DCACHE_ENCRYPTED_NAME must be cleared.  Note that we don't have to
+	 * support arbitrary moves of this flag because fscrypt doesn't allow
+	 * encrypted aliases to be the source or target of a rename().
+	 */
+	dentry->d_flags &= ~DCACHE_ENCRYPTED_NAME;
+#endif
+}
+
 /*
  * __d_move - move a dentry
  * @dentry: entry to move
@@ -2795,6 +2809,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	list_move(&dentry->d_child, &dentry->d_parent->d_subdirs);
 	__d_rehash(dentry);
 	fsnotify_update_flags(dentry);
+	fscrypt_update_flags(dentry);
 
 	write_seqcount_end(&target->d_seq);
 	write_seqcount_end(&dentry->d_seq);
-- 
2.21.0
