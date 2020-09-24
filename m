Return-Path: <SRS0=IJe+=DB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E80C2D0E2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:29:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A922520888;
	Thu, 24 Sep 2020 04:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ai/ipnT7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZDqf2W3L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf+3f9n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A922520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLIsm-0005ir-IK; Thu, 24 Sep 2020 04:29:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kLIsl-0005ic-J1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TbrEBwUdVvDU1tRzSSgU5l3vBRGb0g9W1miMXRIMUJk=; b=ai/ipnT7oCBP2UNpx7Trmy/+BY
 gEqgcSTlxTespcLXMUUvKILjcD4jyzkus5MqopQlfgGVWdpibPM8k5cwW9MYz8mHH7vtcffgUyLbk
 tZT4MArl6vQOY08osS8enimTsVsJALYsbam4PfQL86Q5HZXR6/TMYAybqJVrK1h9UkTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TbrEBwUdVvDU1tRzSSgU5l3vBRGb0g9W1miMXRIMUJk=; b=ZDqf2W3L8kp9xnNI7IPBBVjV0h
 ys87lI8CqcXfWBB11SQf1M9JO8h2osw86LxQBeGPhmKviXD0bhJMEfWR3OF3URtFLBGS4huEYFAqL
 jwdt+95WGEKvnr38dUzT7b7PWWixVPI304Otsf7FqCWs7IYRjkKGAO/A+BhYlORof+qk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLIsc-005Y0V-5d
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 04:29:23 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 67FAA238E4;
 Thu, 24 Sep 2020 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600921741;
 bh=zkbK3kc+vjesm/oo0BR3v4YFB7mgYl6/SjNVtaJC49I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tf+3f9n9whDLE3nRQBGBiXSBPyJBU5+wbl0Pzxy1oCesqnjN+hwcu1TZ3Crt7oe8w
 +VrERYCOeGY6zv1gmE8R4l1E5n4V+56OUhJTmCp+u35lAl+nOOoxMwnY0FVDRfpiKR
 lmE8PryChQoOaSxuK9i2Ja8Q4GUSoNu1QyPdPDhE=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 23 Sep 2020 21:26:24 -0700
Message-Id: <20200924042624.98439-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924042624.98439-1-ebiggers@kernel.org>
References: <20200924042624.98439-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kLIsc-005Y0V-5d
Subject: [f2fs-dev] [PATCH 2/2] fscrypt: rename DCACHE_ENCRYPTED_NAME to
 DCACHE_NOKEY_NAME
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

Originally we used the term "encrypted name" or "ciphertext name" to
mean the encoded filename that is shown when an encrypted directory is
listed without its key.  But these terms are ambiguous since they also
mean the filename stored on-disk.  "Encrypted name" is especially
ambiguous since it could also be understood to mean "this filename is
encrypted on-disk", similar to "encrypted file".

So we've started calling these encoded names "no-key names" instead.

Therefore, rename DCACHE_ENCRYPTED_NAME to DCACHE_NOKEY_NAME to avoid
confusion about what this flag means.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c       |  2 +-
 fs/crypto/hooks.c       |  7 +++----
 include/linux/dcache.h  |  2 +-
 include/linux/fscrypt.h | 12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 391acea4bc96..c65979452844 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -541,7 +541,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	 * reverting to no-key names without evicting the directory's inode
 	 * -- which implies eviction of the dentries in the directory.
 	 */
-	if (!(dentry->d_flags & DCACHE_ENCRYPTED_NAME))
+	if (!(dentry->d_flags & DCACHE_NOKEY_NAME))
 		return 1;
 
 	/*
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index ca996e1c92d9..20b0df47fe6a 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -61,7 +61,7 @@ int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 		return err;
 
 	/* ... in case we looked up no-key name before key was added */
-	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME)
+	if (dentry->d_flags & DCACHE_NOKEY_NAME)
 		return -ENOKEY;
 
 	if (!fscrypt_has_permitted_context(dir, inode))
@@ -86,8 +86,7 @@ int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return err;
 
 	/* ... in case we looked up no-key name(s) before key was added */
-	if ((old_dentry->d_flags | new_dentry->d_flags) &
-	    DCACHE_ENCRYPTED_NAME)
+	if ((old_dentry->d_flags | new_dentry->d_flags) & DCACHE_NOKEY_NAME)
 		return -ENOKEY;
 
 	if (old_dir != new_dir) {
@@ -116,7 +115,7 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 	if (fname->is_nokey_name) {
 		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_ENCRYPTED_NAME;
+		dentry->d_flags |= DCACHE_NOKEY_NAME;
 		spin_unlock(&dentry->d_lock);
 		d_set_d_op(dentry, &fscrypt_d_ops);
 	}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 65d975bf9390..6f95c3300cbb 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -213,7 +213,7 @@ struct dentry_operations {
 
 #define DCACHE_MAY_FREE			0x00800000
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
-#define DCACHE_ENCRYPTED_NAME		0x02000000 /* Encrypted name (dir key was unavailable) */
+#define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index bc9ec727e993..f1757e73162d 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -100,15 +100,15 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
 }
 
 /*
- * When d_splice_alias() moves a directory's encrypted alias to its decrypted
- * alias as a result of the encryption key being added, DCACHE_ENCRYPTED_NAME
- * must be cleared.  Note that we don't have to support arbitrary moves of this
- * flag because fscrypt doesn't allow encrypted aliases to be the source or
- * target of a rename().
+ * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
+ * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
+ * cleared.  Note that we don't have to support arbitrary moves of this flag
+ * because fscrypt doesn't allow no-key names to be the source or target of a
+ * rename().
  */
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
-	dentry->d_flags &= ~DCACHE_ENCRYPTED_NAME;
+	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
 }
 
 /* crypto.c */
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
