Return-Path: <SRS0=F/Dq=E7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFCC2D0E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2020 00:25:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D102168B;
	Wed, 25 Nov 2020 00:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j95B2GoK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="B/POuxQJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Hr4pEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D102168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1khicO-0005bc-KI; Wed, 25 Nov 2020 00:25:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1khicN-0005bU-75
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 00:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E6Y2GUQrl7l3+VaGadnnLAYONHPT0cZa/DEl6sZYVU8=; b=j95B2GoKkGVGrt4MU3tV1DM5HA
 dB9NtnqN1OZkcTKnW+8xq7aPo4kp5BWTpRTi2wO8h5dwkcYEi3VTk2vTdySnSOXM2cu/ASPck3J0I
 vHTwSw4tFXr/ZEKMi22alq0z9kSFnYEIAfWAsuA9SaMW7bOwf32qP+QFxGDkxB2i6iOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E6Y2GUQrl7l3+VaGadnnLAYONHPT0cZa/DEl6sZYVU8=; b=B/POuxQJZNE/OJSxcz+zzPc4gs
 4SuRBAQz6amf1+vM5QOcVbIkufTFrqgQVNHhGqj0fHFb/Idlh32PKWbGWCVaqHEqRFKmJ5AWwx0HT
 ymIB5dFKQJgLUvRqaLRVnjUcgmUAdBOUCZxjUK8hLyvq2f/FAbtBjO6hV/xn+G75C734=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1khicJ-00E1RU-98
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Nov 2020 00:25:07 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB7B221741;
 Wed, 25 Nov 2020 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606263887;
 bh=vkE7h+iUKXjV3iZ6UKyjh74RIw0I8dTdzi+DtGmbbUg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q8Hr4pEJjWrF853VUCGWht1AfsKT2ByRq7EkZLk3ST0W88Ft8c5g+aDmZlRZkb3Ao
 pNIpg88N6acanGv9fJUVEenvHI2MW6dEQ5AXU91Uhz9UhD4neBNOsXTE/BilRpwcxk
 K7nOP0zDryiaAyBWv757MmUD+ZWi+BGM3UeNV0kE=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue, 24 Nov 2020 16:23:35 -0800
Message-Id: <20201125002336.274045-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125002336.274045-1-ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1khicJ-00E1RU-98
Subject: [f2fs-dev] [PATCH 8/9] fscrypt: unexport
 fscrypt_get_encryption_info()
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
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that fscrypt_get_encryption_info() is only called from files in
fs/crypto/ (due to all key setup now being handled by higher-level
helper functions instead of directly by filesystems), unexport it and
move its declaration to fscrypt_private.h.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 2 ++
 fs/crypto/keysetup.c        | 1 -
 include/linux/fscrypt.h     | 7 +------
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 16dd55080127..c1c302656c34 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -571,6 +571,8 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk);
 
+int fscrypt_get_encryption_info(struct inode *inode);
+
 /**
  * fscrypt_require_key() - require an inode's encryption key
  * @inode: the inode we need the key for
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 50675b42d5b7..6339b3069a40 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -589,7 +589,6 @@ int fscrypt_get_encryption_info(struct inode *inode)
 		res = 0;
 	return res;
 }
-EXPORT_SYMBOL(fscrypt_get_encryption_info);
 
 /**
  * fscrypt_prepare_new_inode() - prepare to create a new inode in a directory
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a07610f27926..4b163f5e58e9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -75,7 +75,7 @@ struct fscrypt_operations {
 static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
 {
 	/*
-	 * Pairs with the cmpxchg_release() in fscrypt_get_encryption_info().
+	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
 	 * I.e., another task may publish ->i_crypt_info concurrently, executing
 	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
 	 * ACQUIRE the memory the other task published.
@@ -200,7 +200,6 @@ int fscrypt_ioctl_remove_key_all_users(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_key_status(struct file *filp, void __user *arg);
 
 /* keysetup.c */
-int fscrypt_get_encryption_info(struct inode *inode);
 int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 			      bool *encrypt_ret);
 void fscrypt_put_encryption_info(struct inode *inode);
@@ -408,10 +407,6 @@ static inline int fscrypt_ioctl_get_key_status(struct file *filp,
 }
 
 /* keysetup.c */
-static inline int fscrypt_get_encryption_info(struct inode *inode)
-{
-	return -EOPNOTSUPP;
-}
 
 static inline int fscrypt_prepare_new_inode(struct inode *dir,
 					    struct inode *inode,
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
