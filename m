Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE0606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OpwTeefG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jjR4CqOT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZnrzKyNM;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZzjL7xB6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pnyaJu98oRCjFc9boXSD8vPR2mgJ5fB6GMCi85yPRTw=; b=OpwTeefGa1uin9i5GaTD8/67Ht
	4nwBPevVhs6d0phgVbKXcoGmmKEIpWzdMUFZXFLE155oyDAlb4IpO/ga0AD3hGHkI72ulo+yPTsQB
	k8p5Fpx9WQbH3R/6Ws7IGR0jRLxt37nhyxy/vMECFoFOoE13uZQokPMh2My9osHxWqLQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUAPY-000000007ex-3gXH;
	Thu, 19 Nov 2026 22:15:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3Am__ag4KAD0rZqsgZjjtjqdshfnnfkd.bnl@flex--sarthakkukreti.bounces.google.com>)
 id 1xUAPX-000000007ek-2ryk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HIkGPbX/VCKnugEE3DStk2KmzUd3683NSoxPl+Lp+b8=; b=j
 jR4CqOT/7640wwyruvu2EOYU/TkL5Sk1BWxLKQLB8J3YFHjIWE+AwfBJVa9ZoloWDlh4l1mtJn+va
 6oq0kgzqA6iu4FrLn0X59u1RVEUNk6aeZnLc4IOJLW1HxbS8u2Qhe1qfDCOeZ4pPEAek/mWQLYzUM
 ynhWeX69R/5MvObQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HIkGPbX/VCKnugEE3DStk2KmzUd3683NSoxPl+Lp+b8=; b=ZnrzKyNM7GMtcFW9BQxoO7k94j
 xCQ6oH3lETRyxcRUXCPpspw5MfsbSuHrqIHCizSqOeofkTMq8MbvSU87keH1cRdSucWwRdO8lpJ5f
 jmuJZ/P15QZHnGYiDci3U0Y2VEGOmacxpGIuTBwhHJIpM+8uSMa2XIUtVysDSilXMpwM=;
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUAPW-000000005Ps-1IiG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:15:19 +0000
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-862a8fcc3caso390545a34.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795126512; x=1795731312;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HIkGPbX/VCKnugEE3DStk2KmzUd3683NSoxPl+Lp+b8=;
 b=ZzjL7xB6ANmuZLroyxEO7e4CqDUp5jgISelr3G57DTMmd7yhetH3GJO1cgGWdsTg7a
 bt7k2HkPqOXoDkuWSGWdqk1EpVvvAirRx7XmJi3bLpRSgqa1emwKMnyUlnNCuYXBJNf+
 qu9lFVwrBpaUjQfgmFDtPiSOh/R84OdP8zbt+FuHs6EzzyMXwkLfQJ3TlQjBCYMmmrxa
 ll4LO85zJuNTxoUU6VHVjQxT+ah5aNpHPPj53lJQ1GG4fEF9wjI1FibD585P7Xx3c7Vn
 ThhtW4yLcnM4uufKsvNi9xyy6J3UlBo8zzJT/0lYpIiqZZcjvmqKfAcO3XLc3xQuIusU
 3F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126512; x=1795731312;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HIkGPbX/VCKnugEE3DStk2KmzUd3683NSoxPl+Lp+b8=;
 b=KCwMsZ/t1OEx+BAm6zcK+RR6n6exkvhwoDjWKK/ybLdlLMvGHY6zX/exeZ+vqFUV4q
 W7S1PJ0APf0DYfFM+RPskDTc14UUwR3uMOKmpGSn34EPYKyNwEI1tJ64bJeCjAvIZnsO
 lL1h2y9NysOx1tZW9V0cLYB7rePMcy0Q9Sze1uE5gxh5eCZstA6Iuj0G+YW4Nfc/RHZk
 qVTQOmbRszzsqp9gGgTO4uv+XxMevipYH/77IouOrC8fitx5M9uEe3yq3DKkZ6oNlwM9
 9XqdLYVPNH13xpEyUmDS4WIbLd2wiBT8pnU+aXY9Z0Rum1wOdnoE4BL8xTc2smiUBk1x
 I4og==
X-Forwarded-Encrypted: i=1;
 AL+hErESJovxdtM9V3L7yXyIpf0WSdwznhbhSyCUFotW97tbzN1fnvt4B1FdG5lWnzLgZxb608tGU4rbKrzdoHPtturc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+zUFmLvswyMlBIuE9/8QLBYZyTZlXIvMBySPdZAzXK831kD8n
 haTWzhzb3cbh0Uy+yiHD+ZGtdloGYlaW8gM7guC4qAnAu3UQTiemDdVQDH3NVj5IAzQ2c/3Mkjd
 ElImndJScXie1IDqwkIe+Qx20OSNBJ49BGtCapA==
X-Received: from dycpq22.prod.google.com
 ([2002:a05:7301:fd16:b0:385:2e0b:4776])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:41cd:20b0:378:3227:b4dd with SMTP id
 5a478bee46e88-3856f03cacfmr632641eec.18.1795124994000; 
 Thu, 19 Nov 2026 13:49:54 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:43 -0800
In-Reply-To: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119214944.1480596-3-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xUAPW-000000005Ps-1IiG
Subject: [f2fs-dev] [PATCH v2 2/3] ext4: reject casefolded names that fold
 to ".", "..", or empty
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
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
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
empty strings (causing the first such file to be created on disk and
subsequent distinct ignorable-only names to collide with it), while
names with leading dots and ignorable characters fold to "." or "..",
colliding with on-disk "." and ".." entries and triggering
EXT4_ERROR_INODE in ext4_lookup().

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
index 354fc2d22df1..cd2c9b873cc6 100644
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
2.56.1.750.gf70dc682cf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
