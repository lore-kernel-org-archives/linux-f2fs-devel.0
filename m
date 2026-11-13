Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8A606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DIO2Xsz9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kk3+ct0V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NlXuD1C2;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mOOOvMM7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vmqPsG5C5+btVjydH3WqCuqy03uMsBB13Zvj5oDPS2A=; b=DIO2Xsz9q4Y6O5y0H5HnN1BRdm
	BjH30PnBU1mQfMovId1SJkNXwBF7PTiFnyGakh9leRUvpNqDkmvlgGMI/+c9aUwSfGPDRtW/RPqvx
	ndBW0xTCFcxT2LBKnTb40xekLRuMBmOodahFeP60NvOEFC+zMkup7lJy6C/u/23zM4Yc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRmGK-000000004ls-22dw;
	Fri, 13 Nov 2026 08:03:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <39rP2ag4KAJcJ1IK81BBLBI5K97FF7C5.3FD@flex--sarthakkukreti.bounces.google.com>)
 id 1xRmGI-000000004lk-2MhT
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=; b=k
 k3+ct0VRKHcAYgQkkmTX9n7AOH3ufGVn1wjNPJEaa5kgZ/K5IvtOArL/xtrYFYE/MQjUGiwAZijqk
 XNAl7glU9eANChxPJX0SNMwmSoQzOT/Lty7LOI4fEiFG6J0So04dLVBJ4V8BO4Nb4BtqItM+MvSIJ
 KSknXSqYBT13RuVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=; b=NlXuD1C2FyKqDXDxkL0fX6myZH
 5ZdCY2WEk2hBVGwHNfJnZ6eQ9G6H3ZIh5HWGuXl6+ppMCgzyb8pohelvnQh/Dh/zG7lyWDALPc7gN
 73CAjjT2a3hkJhPOH0ccOngc1fKeoEcOsrS2EbjuJhNLln+uMQLk8LfmS9SbArORDCDA=;
Received: from mail-qk1-f200.google.com ([209.85.222.200])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRmGH-0000000088U-0pdf
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 08:03:54 +0000
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2005ce21so120492085a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 00:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794557027; x=1795161827;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=;
 b=mOOOvMM7ytiI5Bd16qBj9mOtwDwsHJG7sKSuhOw7n2aZOBfuHtiZk3p+vTpY+61/Qs
 f8HVnBV6zhs6gcNANqvsxFCTH5R0+HGj8eTG9Qx/qVY2tqprlRQogujGT4/0+jnySrCg
 wyrhZAmffS+zyXptkRyjJKC0VxtDHoQ1D9jj8R8Jm6Hi3gxNql9O9rYIjS2IiBxxx+nt
 awIo4s4pXoYqrvizwcTK3bY9yY5G0rKaieMuql1Q0TONbLJC8AVBHqMJfDoXp9gjj994
 wnU+e1I16vR5svL5yS3TSJrK1WkSB0MIq/alAcUhn5dDZJCi03nttQL30M5L3NVG6xr2
 3S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794557027; x=1795161827;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32C0FxBlQriZemWnWfi76aDhbmP3Z0qG7c56b0ARCqE=;
 b=0ehNgZPQtM82Tyuhsdulz7XfMTLOK62y5LFEAU/sUasv7R6hHQN0vvyNrMuV1tn26W
 Sq2Yy/fpP04LJd3TLnWVU99H2ZHGie6aDcelsfKHUKICR6AFfDyQ/fqMtzUDBjusVBFR
 oLUjUloSaRKWoldJi8NNyrhfNiQGqCGZfY5Xi+5v7pVqW/Llfp1ybhY2HKdzkheTA61n
 NdBkmahd/NQW11rUpHsachprP9wTl9lgx6blBHBRsAe0qTyrKJeX1gXQObe56qg46u5P
 qFyAQKwxn29acJUJS8gyJfDQQgTlRrFVJwifu9sFRB6aunqMYnbsWuN4CUw5Z9bOcVy3
 wVaw==
X-Forwarded-Encrypted: i=1;
 AL+hErGilwBUitOvWCwkakb10xOUNWQYuVjoQOe46yeBnUAq29HGddk5bkXep+MZwNfkink2D5U79NINqRmajkKMP9eq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8nPNtgr3BC+HZwFBPv9GdtxUsJYdw1/cIIPgSG/M28ACMZfYGi
 SeoygFDPGzJBBAEiFcVZD3M+e369MmjS2/kbGR/jn2j2RGG/BtaEw3bLXGQav65N1ESvoPHLC5D
 ukZ9RhomsDukhITxOWB7aLGRerUt61DI/iRB73Q==
X-Received: from dyp12.prod.google.com ([2002:a05:693c:65cc:b0:36c:9b55:8436])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1a05:b0:369:f035:661 with SMTP id
 5a478bee46e88-37967315a1emr1295500eec.15.1794552822463; 
 Thu, 12 Nov 2026 22:53:42 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:31 -0800
In-Reply-To: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-3-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRmGH-0000000088U-0pdf
Subject: [f2fs-dev] [PATCH 2/3] ext4: reject casefolded names that fold to
 ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: Eric Biggers <ebiggers@google.com>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Filenames consisting solely of ignorable Unicode characters fold to
empty strings, while names with leading dots and ignorable characters
fold to "." or "..". Allowing such names to be created or looked up in
casefolded directories collides with on-disk "." and ".." entries (which
triggers EXT4_ERROR_INODE in ext4_lookup()) and introduces duplicate
entries that e2fsck flags as corruption.

Skip casefolding when the lookup name is literally "." or "..", reject
any non-dot names that fold to "", ".", or ".." in
ext4_fname_setup_ci_filename(), and fall back to opaque byte hashing in
ext4fs_dirhash() when utf8_casefold() yields "", ".", or "..".

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Co-developed-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/ext4/hash-test.c | 14 ++++++++++++++
 fs/ext4/hash.c      |  2 +-
 fs/ext4/namei.c     |  9 +++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/hash-test.c b/fs/ext4/hash-test.c
index 49b0d874c833..a8b206a6d751 100644
--- a/fs/ext4/hash-test.c
+++ b/fs/ext4/hash-test.c
@@ -541,6 +541,20 @@ static void test_ext4fs_dirhash_casefold_fallback(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret_plain, 0);
 	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
 	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
+
+	ret_cf = ext4fs_dirhash(&ei->vfs_inode, ".\xe2\x80\xae", 4, &folded_dir);
+	ret_plain = ext4fs_dirhash(plain_dir, ".\xe2\x80\xae", 4, &plain);
+	KUNIT_ASSERT_EQ(test, ret_cf, 0);
+	KUNIT_ASSERT_EQ(test, ret_plain, 0);
+	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
+	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
+
+	ret_cf = ext4fs_dirhash(&ei->vfs_inode, "\xe2\x80\xae", 3, &folded_dir);
+	ret_plain = ext4fs_dirhash(plain_dir, "\xe2\x80\xae", 3, &plain);
+	KUNIT_ASSERT_EQ(test, ret_cf, 0);
+	KUNIT_ASSERT_EQ(test, ret_plain, 0);
+	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
+	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
 }
 #endif
 
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 978bd92da0ad..65019de4af93 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -327,7 +327,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			return -ENOMEM;
 
 		dlen = utf8_casefold(um, &qstr, buff, PATH_MAX);
-		if (dlen < 0) {
+		if (dlen <= 0 || name_is_dot_dotdot(buff, dlen)) {
 			kfree(buff);
 			goto opaque_seq;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a6386c1d237f..096f78ea5df4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1368,7 +1368,8 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	int len;
 
 	if (!IS_CASEFOLDED(dir) ||
-	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
+	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir)) ||
+	    name_is_dot_dotdot(iname->name, iname->len)) {
 		cf_name->name = NULL;
 		return 0;
 	}
@@ -1378,9 +1379,13 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return -ENOMEM;
 
 	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
-	if (len <= 0) {
+	if (len < 0) {
 		kfree(buf);
 		buf = NULL;
+	} else if (len == 0 || name_is_dot_dotdot(buf, len)) {
+		kfree(buf);
+		cf_name->name = NULL;
+		return -EINVAL;
 	}
 	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
