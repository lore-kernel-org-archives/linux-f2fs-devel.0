Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A57C4743E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 01:26:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE60161090;
	Mon,  7 Jun 2021 01:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE60161090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lq42Q-0004Jf-Mp; Mon, 07 Jun 2021 01:26:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1lq42P-0004JR-GV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 01:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4eauDPIRJyrUlKPEAE55P2pOOGtpMAalUs3NRxAwWIk=; b=WXcXDBCFzm7CC4+08xKgND+s7Q
 PJmqRYYCLs8v+RHmUv9dCvOf19sYFZr8IqzjcMfwb89KYsTNYZkRJETVJM0axiMHoT2RUw0WgFxuo
 QW3IOjzHwLfyRN8/L0c2jJHGtwtQ2L7VDrzLdPISkKTfjuKlZk/bWlGX84jJ12mhY9H8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4eauDPIRJyrUlKPEAE55P2pOOGtpMAalUs3NRxAwWIk=; b=P
 lhO+xXpyejgjFRco3U5ZorfVCawqaDWRRV+vI6TsBi50z1Tu5SxgvBllRxcgASapfDuIdZX84LA8c
 c4VlgdLKbGnBb2bXA8Mcome0o/w9tT3LpseQzovcflKbc+XkppNDy4pDDHY54z6689IJxh0ZgUsh9
 xeNffqS/g1DNcsTc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lq42H-0005ni-PN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 01:26:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6659261042;
 Sat,  5 Jun 2021 07:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622879486;
 bh=oU7rLWlDtRnK5OqhhwuLiZAyphz7z0h1gnj2095cQ6I=;
 h=From:To:Cc:Subject:Date:From;
 b=mxwCu6VYqyEjqlKtghQAP7PY6VGEj1y1vow00zcCuVswe9XHCAT1vSXlSfqG5Pf9j
 q4+Eq+S7y/6Mo+hGQGPm8yB6eGJms+1wBM3XrAPbrVm6vIt0ChyGFubUig2hkJ7BCu
 GAjOh1kDH36YqLxqYiydv4EuSjqivVWgqiSUoZyatLA9toVGzX2CsTORZfIfU1ysRQ
 WCIGZemvg3C+qhFlVvdoJJtQuLUiNebiDqiSmb1LbrwCeXHBnby99/y5D2HNR5m+Yj
 vz1FklyBBFCFwcqLGlnrdgsqgH9raF95XqmkuI+UpGGo8qCMswub/ls32E75CR1dfp
 M2LxfUXgsR1gw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Sat,  5 Jun 2021 00:50:33 -0700
Message-Id: <20210605075033.54424-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Headers-End: 1lq42H-0005ni-PN
Subject: [f2fs-dev] [PATCH v2] fscrypt: fix derivation of SipHash keys on
 big endian CPUs
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
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Typically, the cryptographic APIs that fscrypt uses take keys as byte
arrays, which avoids endianness issues.  However, siphash_key_t is an
exception.  It is defined as 'u64 key[2];', i.e. the 128-bit key is
expected to be given directly as two 64-bit words in CPU endianness.

fscrypt_derive_dirhash_key() and fscrypt_setup_iv_ino_lblk_32_key()
forgot to take this into account.  Therefore, the SipHash keys used to
index encrypted+casefolded directories differ on big endian vs. little
endian platforms, as do the SipHash keys used to hash inode numbers for
IV_INO_LBLK_32-encrypted directories.  This makes such directories
non-portable between these platforms.

Fix this by always using the little endian order.  This is a breaking
change for big endian platforms, but this should be fine in practice
since these features (encrypt+casefold support, and the IV_INO_LBLK_32
flag) aren't known to actually be used on any big endian platforms yet.

Fixes: aa408f835d02 ("fscrypt: derive dirhash key for casefolded directories")
Fixes: e3b1078bedd3 ("fscrypt: add support for IV_INO_LBLK_32 policies")
Cc: <stable@vger.kernel.org> # v5.6+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: Fixed fscrypt_setup_iv_ino_lblk_32_key() too, not just
    fscrypt_derive_dirhash_key().

 fs/crypto/keysetup.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 261293fb70974..bca9c6658a7c5 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -210,15 +210,40 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	return err;
 }
 
+/*
+ * Derive a SipHash key from the given fscrypt master key and the given
+ * application-specific information string.
+ *
+ * Note that the KDF produces a byte array, but the SipHash APIs expect the key
+ * as a pair of 64-bit words.  Therefore, on big endian CPUs we have to do an
+ * endianness swap in order to get the same results as on little endian CPUs.
+ */
+static int fscrypt_derive_siphash_key(const struct fscrypt_master_key *mk,
+				      u8 context, const u8 *info,
+				      unsigned int infolen, siphash_key_t *key)
+{
+	int err;
+
+	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf, context, info, infolen,
+				  (u8 *)key, sizeof(*key));
+	if (err)
+		return err;
+
+	BUILD_BUG_ON(sizeof(*key) != 16);
+	BUILD_BUG_ON(ARRAY_SIZE(key->key) != 2);
+	le64_to_cpus(&key->key[0]);
+	le64_to_cpus(&key->key[1]);
+	return 0;
+}
+
 int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk)
 {
 	int err;
 
-	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf, HKDF_CONTEXT_DIRHASH_KEY,
-				  ci->ci_nonce, FSCRYPT_FILE_NONCE_SIZE,
-				  (u8 *)&ci->ci_dirhash_key,
-				  sizeof(ci->ci_dirhash_key));
+	err = fscrypt_derive_siphash_key(mk, HKDF_CONTEXT_DIRHASH_KEY,
+					 ci->ci_nonce, FSCRYPT_FILE_NONCE_SIZE,
+					 &ci->ci_dirhash_key);
 	if (err)
 		return err;
 	ci->ci_dirhash_key_initialized = true;
@@ -253,10 +278,9 @@ static int fscrypt_setup_iv_ino_lblk_32_key(struct fscrypt_info *ci,
 		if (mk->mk_ino_hash_key_initialized)
 			goto unlock;
 
-		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-					  HKDF_CONTEXT_INODE_HASH_KEY, NULL, 0,
-					  (u8 *)&mk->mk_ino_hash_key,
-					  sizeof(mk->mk_ino_hash_key));
+		err = fscrypt_derive_siphash_key(mk,
+						 HKDF_CONTEXT_INODE_HASH_KEY,
+						 NULL, 0, &mk->mk_ino_hash_key);
 		if (err)
 			goto unlock;
 		/* pairs with smp_load_acquire() above */

base-commit: 77f30bfcfcf484da7208affd6a9e63406420bf91
-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
