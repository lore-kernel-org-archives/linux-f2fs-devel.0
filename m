Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D781C64ED6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Feb 2023 06:21:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPdpz-0004Wu-1r;
	Wed, 08 Feb 2023 06:21:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pPdpx-0004Wm-S7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JkFM0WcenL3jza42LrOkjPhnbb7eCgnerOySPiYQcI0=; b=MJjd/XBfKD75HuJWlYM63sre7w
 f5Naoo8664do5kjbnYXHxsxjvqPbWiksG7V1rYQz5xb/4t4HCr8HxF6COucukfVD0NDHEOX9xl5fI
 QJAtvc7DfohVaJzPFdt+rkmrvYhI90wpIQu54qufPenquhIupzBLNz3N7mbOaIfRLftE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JkFM0WcenL3jza42LrOkjPhnbb7eCgnerOySPiYQcI0=; b=kfhePfzVK/w0Qc+lcM+mgOtDA0
 YMa/oCwM7lNK+l8Amsi814ES2GtJ5ldfmUNKnADN25tc+GNTUjAxGyizXM+0oPI8TIsB3NurRxFXn
 BHi/yen5qKwmioa32uuUEOkainOz3/utBIL5i8Jux5nhnXDtQZP7rRQNJLeGERUtsy04=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPdpu-0008Qj-Ej for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 06:21:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B2818614D7;
 Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC55DC433D2;
 Wed,  8 Feb 2023 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675837295;
 bh=rXzimvd4PWdjTx5BBrxxERaITqXWUNGccCwAWr6IKjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bqgr3pjenH4hhu5yGdWxOmuBDTfjE4KLBRmr1eWNY3senk1DChomHChHvaaxF6sbw
 WFt0IatwITKGVY/itxERVpapqWkjt5alhkueEyIKT84lQoCu0gAZ4T1uEu4FJf33/o
 heMAhP1Ezd9x0FPiBMslUu7RBEXu3HgMborHvzBMxsapUwcOEVrGe3o0JmYKEwck9m
 S2m6eg9Fv1O+XZQUCAASPtvuI1I1bozwdJGolV70KdhTahQQadD71tVagZeGiTGqSg
 zLKtosWgeOdtBPa38BSfliQolz1TEODI3gol34EYGKeYBQmVPlK7+cRjlDgxXc/dC3
 T73UdOlm3P/mQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue,  7 Feb 2023 22:21:03 -0800
Message-Id: <20230208062107.199831-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pPdpu-0008Qj-Ej
Subject: [f2fs-dev] [PATCH 1/5] fscrypt: add the test dummy encryption key
 on-demand
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

When the key for an inode is not found but the inode is using the
test_dummy_encryption policy, automatically add the
test_dummy_encryption key to the filesystem keyring.  This eliminates
the need for all the individual filesystems to do this at mount time,
which is a bit tricky to clean up from on failure.

Note: this covers the call to fscrypt_find_master_key() from inode key
setup, but not from the fscrypt ioctls.  So, this isn't *exactly* the
same as the key being present from the very beginning.  I think we can
tolerate that, though, since the inode key setup caller is the only one
that actually matters in the context of test_dummy_encryption.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h |  1 +
 fs/crypto/keysetup.c        | 25 +++++++++++++++++++++++--
 fs/crypto/policy.c          |  3 +--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 316a778cec0ff..17dd33d9a522e 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -651,6 +651,7 @@ bool fscrypt_policies_equal(const union fscrypt_policy *policy1,
 			    const union fscrypt_policy *policy2);
 int fscrypt_policy_to_key_spec(const union fscrypt_policy *policy,
 			       struct fscrypt_key_specifier *key_spec);
+const union fscrypt_policy *fscrypt_get_dummy_policy(struct super_block *sb);
 bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			      const struct inode *inode);
 int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 94757ccd30568..20323c0ba4c5e 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -438,6 +438,7 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 				     bool need_dirhash_key,
 				     struct fscrypt_master_key **mk_ret)
 {
+	struct super_block *sb = ci->ci_inode->i_sb;
 	struct fscrypt_key_specifier mk_spec;
 	struct fscrypt_master_key *mk;
 	int err;
@@ -450,8 +451,28 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	if (err)
 		return err;
 
-	mk = fscrypt_find_master_key(ci->ci_inode->i_sb, &mk_spec);
-	if (!mk) {
+	mk = fscrypt_find_master_key(sb, &mk_spec);
+	if (unlikely(!mk)) {
+		const union fscrypt_policy *dummy_policy =
+			fscrypt_get_dummy_policy(sb);
+
+		/*
+		 * Add the test_dummy_encryption key on-demand.  In principle,
+		 * it should be added at mount time.  Do it here instead so that
+		 * the individual filesystems don't need to worry about adding
+		 * this key at mount time and cleaning up on mount failure.
+		 */
+		if (dummy_policy &&
+		    fscrypt_policies_equal(dummy_policy, &ci->ci_policy)) {
+			struct fscrypt_dummy_policy tmp = { dummy_policy };
+
+			err = fscrypt_add_test_dummy_key(sb, &tmp);
+			if (err)
+				return err;
+			mk = fscrypt_find_master_key(sb, &mk_spec);
+		}
+	}
+	if (unlikely(!mk)) {
 		if (ci->ci_policy.version != FSCRYPT_POLICY_V1)
 			return -ENOKEY;
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 893661b523769..69dca4ff5f488 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -53,8 +53,7 @@ int fscrypt_policy_to_key_spec(const union fscrypt_policy *policy,
 	}
 }
 
-static const union fscrypt_policy *
-fscrypt_get_dummy_policy(struct super_block *sb)
+const union fscrypt_policy *fscrypt_get_dummy_policy(struct super_block *sb)
 {
 	if (!sb->s_cop->get_dummy_policy)
 		return NULL;
-- 
2.39.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
