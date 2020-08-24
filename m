Return-Path: <SRS0=HdqB=CC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FEC43619
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2020 06:35:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDE222BED;
	Mon, 24 Aug 2020 06:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GucLsyPb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="YsY2FxnS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQyQZQJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE222BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kA5oV-0002Dw-3N; Mon, 24 Aug 2020 06:18:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kA5oR-0002Cd-TH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Aug 2020 06:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KYJKxdi2jX57bDldWHEqwLlixJMvjiC/d66O4DoM/Cw=; b=GucLsyPbJp7gDmmT6bOaujQyAM
 AyKmuFPSZHWsUY7966+uZUJQtrImITNdaBW/j5cUoyrGhhKP0VZYbHg+GUCCsuFAcb4Bh93xymzgW
 794NJyCq0pDW7Z2DeqUR8X1jvNk5oPOpioSVCYNTmv5BevmdPSwv9GL9EHZwjkwy/8O0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KYJKxdi2jX57bDldWHEqwLlixJMvjiC/d66O4DoM/Cw=; b=YsY2FxnSaIK7U6zwv4qdJ7qLUW
 p4xrdDKPqp0DujiE9Goiyx8p2JzaIuYrXqY7ZMgPFc8pcli9RRlX5ZukygWeSdA99V/JrmcWfAPpn
 IM4ayVeIuayGT2aXT+1LFr/hGZ07fZ96bIgFFHNeMp1uT/Px7HI7fqExxPsYEJEAfLIM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kA5oQ-002Evm-P7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Aug 2020 06:18:35 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 446D122B43;
 Mon, 24 Aug 2020 06:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598249900;
 bh=FMdqhGKiPJuHGox4c9HjS2vaN3+8vR0i3HMKgJxF+vQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SQyQZQJniVjChBFXxR3bF0x16R3eYZIA7rLFQeyDxK8kI1KwERQ2Wj5lm2hjVxMmg
 3Nxe/eWfi8Gq+7jcCSMCpgVFWl4M/qnEc4H3H+EjikdTyTQ7njVV+jR+9X8cw/bdtG
 QW0t7i1axoHJILN6yvBCn6ZUt3hNXnc1AUNSCwU0=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Sun, 23 Aug 2020 23:17:11 -0700
Message-Id: <20200824061712.195654-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824061712.195654-1-ebiggers@kernel.org>
References: <20200824061712.195654-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kA5oQ-002Evm-P7
Subject: [f2fs-dev] [RFC PATCH 7/8] fscrypt: remove fscrypt_inherit_context()
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
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that all filesystems have been converted to use
fscrypt_prepare_new_inode() and fscrypt_set_context(),
fscrypt_inherit_context() is no longer used.  So remove it.

Also change __fscrypt_encrypt_symlink() to no longer set up the inode's
key, since it's guaranteed to be set up already now that all filesystems
have been converted to fscrypt_prepare_new_inode().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/hooks.c       | 10 +++++++---
 fs/crypto/policy.c      | 37 -------------------------------------
 include/linux/fscrypt.h |  9 ---------
 3 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 09fb8aa0f2e93..b69cd29a01a2f 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -217,9 +217,13 @@ int __fscrypt_encrypt_symlink(struct inode *inode, const char *target,
 	struct fscrypt_symlink_data *sd;
 	unsigned int ciphertext_len;
 
-	err = fscrypt_require_key(inode);
-	if (err)
-		return err;
+	/*
+	 * fscrypt_prepare_new_inode() should have already set up the inode's
+	 * encryption key.  We don't wait until now to do it, since we may be in
+	 * a filesystem transaction now.
+	 */
+	if (WARN_ON_ONCE(!fscrypt_has_encryption_key(inode)))
+		return -ENOKEY;
 
 	if (disk_link->name) {
 		/* filesystem-provided buffer */
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index fbe4933206469..2220ef48d5846 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -625,43 +625,6 @@ int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 }
 EXPORT_SYMBOL(fscrypt_has_permitted_context);
 
-/**
- * fscrypt_inherit_context() - Sets a child context from its parent
- * @parent: Parent inode from which the context is inherited.
- * @child:  Child inode that inherits the context from @parent.
- * @fs_data:  private data given by FS.
- * @preload:  preload child i_crypt_info if true
- *
- * Return: 0 on success, -errno on failure
- */
-int fscrypt_inherit_context(struct inode *parent, struct inode *child,
-						void *fs_data, bool preload)
-{
-	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
-	union fscrypt_context ctx;
-	int ctxsize;
-	struct fscrypt_info *ci;
-	int res;
-
-	res = fscrypt_get_encryption_info(parent);
-	if (res < 0)
-		return res;
-
-	ci = fscrypt_get_info(parent);
-	if (ci == NULL)
-		return -ENOKEY;
-
-	get_random_bytes(nonce, FSCRYPT_FILE_NONCE_SIZE);
-	ctxsize = fscrypt_new_context_from_policy(&ctx, &ci->ci_policy, nonce);
-
-	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
-	res = parent->i_sb->s_cop->set_context(child, &ctx, ctxsize, fs_data);
-	if (res)
-		return res;
-	return preload ? fscrypt_get_encryption_info(child): 0;
-}
-EXPORT_SYMBOL(fscrypt_inherit_context);
-
 /**
  * fscrypt_set_context() - Set the fscrypt context of a new inode
  * @inode: A new inode
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 726131dfa0a9b..4ee636e9e1fca 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -156,8 +156,6 @@ int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
-int fscrypt_inherit_context(struct inode *parent, struct inode *child,
-			    void *fs_data, bool preload);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
 
 struct fscrypt_dummy_context {
@@ -343,13 +341,6 @@ static inline int fscrypt_has_permitted_context(struct inode *parent,
 	return 0;
 }
 
-static inline int fscrypt_inherit_context(struct inode *parent,
-					  struct inode *child,
-					  void *fs_data, bool preload)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int fscrypt_set_context(struct inode *inode, void *fs_data)
 {
 	return -EOPNOTSUPP;
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
