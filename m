Return-Path: <SRS0=IJe+=DB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC1DC4346E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:29:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F9E20888;
	Thu, 24 Sep 2020 04:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="US8EVHtX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HTvc31S7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehSyDEp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F9E20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLIsj-0005i9-GH; Thu, 24 Sep 2020 04:29:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kLIsh-0005hp-7t
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wb3vi0ApJZ5oDIBU10TPmIbVLLvTLL07lQ5HlxTb9D8=; b=US8EVHtXqs1jawY3mS63BSj7M8
 2SEGdoiRQZXwPuOuIvNCuZpnhPO7RTbzqiPO5Q/Rs4s7whPFRs8dNfQ+Xqjb9b4/Xp5OyG++tpbio
 f+Kam/ZZz/WXiwfs/AbLX+HOwKh1okkcGGvu7w+AtXkMKxCyWQBXfvJ5P6ColO6xj5Iw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wb3vi0ApJZ5oDIBU10TPmIbVLLvTLL07lQ5HlxTb9D8=; b=HTvc31S7KJ9LuMfjuXvj9zcSW+
 qhCdd0vveWsojn/fRCunrArbHi8jamg1EN3nBJKm73SMBEScsWp6MH8KyHsCOUNbE2y71NbDcH8dT
 1XQ19sIz7EEK51/9/GJdXi0PWlzjik4/oqxWD6PCBMBH0K22HA9ZEmVzTIeFH74zxYpU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLIsb-005Y0U-U1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:19 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21041238D6;
 Thu, 24 Sep 2020 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600921741;
 bh=O1BPWmS0nDcBXKHTSqB+q3k9JtbCvkyYKK42a+iy7L0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ehSyDEp3qjOv4/OH0nOoWQHDG3FBvBr+o+8GDbnCY6waBzmguHWIyBO3N8B5om25h
 UGJI6O/ZGkdTdkv46nMz0jWzho9zVow+TuTueiW9EBClTZU3ZBQ4pTUk7PbWP9Ly/i
 xPsbB9sfSBMRj7lRcGv1Qsx8JcxGHCkB5E9lbqw0=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 23 Sep 2020 21:26:23 -0700
Message-Id: <20200924042624.98439-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kLIsb-005Y0U-U1
Subject: [f2fs-dev] [PATCH 1/2] fscrypt: don't call no-key names "ciphertext
 names"
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Currently we're using the term "ciphertext name" ambiguously because it
can mean either the actual ciphertext filename, or the encoded filename
that is shown when an encrypted directory is listed without its key.
The latter we're now usually calling the "no-key name"; and while it's
derived from the ciphertext name, it's not the same thing.

To avoid this ambiguity, rename fscrypt_name::is_ciphertext_name to
fscrypt_name::is_nokey_name, and update comments that say "ciphertext
name" (or "encrypted name") to say "no-key name" instead when warranted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c       | 16 ++++++++--------
 fs/crypto/hooks.c       |  6 +++---
 fs/f2fs/dir.c           |  2 +-
 include/linux/fscrypt.h | 15 +++++++--------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f47b581d8a94..391acea4bc96 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -382,9 +382,9 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
  * directory's encryption key, then @iname is the plaintext, so we encrypt it to
  * get the disk_name.
  *
- * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
- * we decode it to get the fscrypt_nokey_name.  Non-@lookup operations will be
- * impossible in this case, so we fail them with ENOKEY.
+ * Else, for keyless @lookup operations, @iname should be a no-key name, so we
+ * decode it to get the struct fscrypt_nokey_name.  Non-@lookup operations will
+ * be impossible in this case, so we fail them with ENOKEY.
  *
  * If successful, fscrypt_free_filename() must be called later to clean up.
  *
@@ -429,7 +429,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	}
 	if (!lookup)
 		return -ENOKEY;
-	fname->is_ciphertext_name = true;
+	fname->is_nokey_name = true;
 
 	/*
 	 * We don't have the key and we are doing a lookup; decode the
@@ -538,17 +538,17 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/*
 	 * Plaintext names are always valid, since fscrypt doesn't support
-	 * reverting to ciphertext names without evicting the directory's inode
+	 * reverting to no-key names without evicting the directory's inode
 	 * -- which implies eviction of the dentries in the directory.
 	 */
 	if (!(dentry->d_flags & DCACHE_ENCRYPTED_NAME))
 		return 1;
 
 	/*
-	 * Ciphertext name; valid if the directory's key is still unavailable.
+	 * No-key name; valid if the directory's key is still unavailable.
 	 *
-	 * Although fscrypt forbids rename() on ciphertext names, we still must
-	 * use dget_parent() here rather than use ->d_parent directly.  That's
+	 * Although fscrypt forbids rename() on no-key names, we still must use
+	 * dget_parent() here rather than use ->d_parent directly.  That's
 	 * because a corrupted fs image may contain directory hard links, which
 	 * the VFS handles by moving the directory's dentry tree in the dcache
 	 * each time ->lookup() finds the directory and it already has a dentry
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 42f5ee9f592d..ca996e1c92d9 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -60,7 +60,7 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 	if (err)
 		return err;
 
-	/* ... in case we looked up ciphertext name before key was added */
+	/* ... in case we looked up no-key name before key was added */
 	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME)
 		return -ENOKEY;
 
@@ -85,7 +85,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		return err;
 
-	/* ... in case we looked up ciphertext name(s) before key was added */
+	/* ... in case we looked up no-key name(s) before key was added */
 	if ((old_dentry->d_flags | new_dentry->d_flags) &
 	    DCACHE_ENCRYPTED_NAME)
 		return -ENOKEY;
@@ -114,7 +114,7 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 	if (err && err != -ENOENT)
 		return err;
 
-	if (fname->is_ciphertext_name) {
+	if (fname->is_nokey_name) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
 		spin_unlock(&dentry->d_lock);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 414bc94fbd54..53fbc4dd6e48 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -111,7 +111,7 @@ static int __f2fs_setup_filename(const struct inode *dir,
 #ifdef CONFIG_FS_ENCRYPTION
 	fname->crypto_buf = crypt_name->crypto_buf;
 #endif
-	if (crypt_name->is_ciphertext_name) {
+	if (crypt_name->is_nokey_name) {
 		/* hash was decoded from the no-key name */
 		fname->hash = cpu_to_le32(crypt_name->hash);
 	} else {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index fc67c4cbaa96..bc9ec727e993 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -35,7 +35,7 @@ struct fscrypt_name {
 	u32 hash;
 	u32 minor_hash;
 	struct fscrypt_str crypto_buf;
-	bool is_ciphertext_name;
+	bool is_nokey_name;
 };
 
 #define FSTR_INIT(n, l)		{ .name = n, .len = l }
@@ -730,17 +730,16 @@ static inline int fscrypt_prepare_rename(struct inode *old_dir,
  * @fname: (output) the name to use to search the on-disk directory
  *
  * Prepare for ->lookup() in a directory which may be encrypted by determining
- * the name that will actually be used to search the directory on-disk.  Lookups
- * can be done with or without the directory's encryption key; without the key,
- * filenames are presented in encrypted form.  Therefore, we'll try to set up
- * the directory's encryption key, but even without it the lookup can continue.
+ * the name that will actually be used to search the directory on-disk.  If the
+ * directory's encryption key is available, then the lookup is assumed to be by
+ * plaintext name; otherwise, it is assumed to be by no-key name.
  *
  * This also installs a custom ->d_revalidate() method which will invalidate the
  * dentry if it was created without the key and the key is later added.
  *
- * Return: 0 on success; -ENOENT if key is unavailable but the filename isn't a
- * correctly formed encoded ciphertext name, so a negative dentry should be
- * created; or another -errno code.
+ * Return: 0 on success; -ENOENT if the directory's key is unavailable but the
+ * filename isn't a valid no-key name, so a negative dentry should be created;
+ * or another -errno code.
  */
 static inline int fscrypt_prepare_lookup(struct inode *dir,
 					 struct dentry *dentry,
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
