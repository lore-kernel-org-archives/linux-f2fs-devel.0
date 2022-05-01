Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AE1C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  1 May 2022 05:13:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nl1tG-00018p-Jd; Sun, 01 May 2022 05:13:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nl1tD-00018B-JI
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 May 2022 05:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2IjJB40DxzY+x+YTYyAcBYZxinzkCbKTjxtD37k/6k=; b=KND2lg6XPHMJHqdl0obwno9XE5
 HaTeA9ZeUpbAa1feD5XG2xiTKEFM+kllRlLIySm84ZLLlBC8UhECS6OBFpBo9HuPilGXCzVgKzbmY
 x01+Pn93rhw+gSszi2OvrBaMqqDJy9et6kn0TbpNdGKc+UkuSGoiNp1sQbD27yV+inFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C2IjJB40DxzY+x+YTYyAcBYZxinzkCbKTjxtD37k/6k=; b=d1yhmGRHUXzblYYsJt6sRCJ9kW
 x6/eDLp1iDpyZ0yBgBmwVPDKmtppKSdvzxhM5vyZCjzYmGRfDofx1zvF9h/5BhsoCNSTLDNkXOyhh
 CS6qduwxlH6iAxbQlLsZ5iffOmRBi6LC2ZEnyOVJ0vrDrAT5Cim7fx8NaHkB67Z0a9BM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nl1t9-00087T-Kr
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 May 2022 05:12:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 50820611B5;
 Sun,  1 May 2022 05:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFCC385B3;
 Sun,  1 May 2022 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651381969;
 bh=YtbThwNrWRFAZXwtYRqFAKhwGVU0Vesj5yuz5dRPcmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MkAOdZMy+onRagtGNOdJpAzL1DW55+hzoi7zktbWQo9H6S/w9w9ALLtjpXHhZwGRk
 hMM0mWitK7vfAbZmNo4mvlEFAtyIgEeHsKXsh4ZQ/98HM/HORdDpSSIeb/gmoHKTtV
 OVV65+5Kb5sAo0Gt6geHveAksXvgvDJR9nn+NGmrTbJreVn/ag1DHkg/7eNlUKMLcg
 JE9X3tHtEPvENAF8lUdbZ6PbeAjlVteM+ZdufTlCrf1kKxKiV4eVl7Ynq4Kwuvw+dZ
 p34Za8SPotxTLZmT5ZIckiX/jXOJZUbVFO7Nk6LvCI4xSKsIUKfnOpdPpdrR5wuRX5
 kuuvpGTMadRUQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 30 Apr 2022 22:08:57 -0700
Message-Id: <20220501050857.538984-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501050857.538984-1-ebiggers@kernel.org>
References: <20220501050857.538984-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nl1t9-00087T-Kr
Subject: [f2fs-dev] [PATCH v2 7/7] fscrypt: remove
 fscrypt_set_test_dummy_encryption()
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
Cc: Jeff Layton <jlayton@kernel.org>, Lukas Czerner <lczerner@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that all its callers have been converted to
fscrypt_parse_test_dummy_encryption() and fscrypt_add_test_dummy_key()
instead, fscrypt_set_test_dummy_encryption() can be removed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/policy.c      | 13 -------------
 include/linux/fscrypt.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 5f858cee1e3b0..d0a8921577def 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -802,19 +802,6 @@ bool fscrypt_dummy_policies_equal(const struct fscrypt_dummy_policy *p1,
 }
 EXPORT_SYMBOL_GPL(fscrypt_dummy_policies_equal);
 
-/* Deprecated, do not use */
-int fscrypt_set_test_dummy_encryption(struct super_block *sb, const char *arg,
-				      struct fscrypt_dummy_policy *dummy_policy)
-{
-	struct fs_parameter param = {
-		.type = fs_value_is_string,
-		.string = arg ? (char *)arg : "",
-	};
-	return fscrypt_parse_test_dummy_encryption(&param, dummy_policy) ?:
-		fscrypt_add_test_dummy_key(sb, dummy_policy);
-}
-EXPORT_SYMBOL_GPL(fscrypt_set_test_dummy_encryption);
-
 /**
  * fscrypt_show_test_dummy_encryption() - show '-o test_dummy_encryption'
  * @seq: the seq_file to print the option to
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 099b881e63e49..11db6d61d4244 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -284,8 +284,6 @@ int fscrypt_parse_test_dummy_encryption(const struct fs_parameter *param,
 				    struct fscrypt_dummy_policy *dummy_policy);
 bool fscrypt_dummy_policies_equal(const struct fscrypt_dummy_policy *p1,
 				  const struct fscrypt_dummy_policy *p2);
-int fscrypt_set_test_dummy_encryption(struct super_block *sb, const char *arg,
-				struct fscrypt_dummy_policy *dummy_policy);
 void fscrypt_show_test_dummy_encryption(struct seq_file *seq, char sep,
 					struct super_block *sb);
 static inline bool
-- 
2.36.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
