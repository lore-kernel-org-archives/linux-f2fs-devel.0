Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B6EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Aug 2023 18:29:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qVcK6-0007z1-4P;
	Mon, 14 Aug 2023 18:29:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qVcK5-0007yv-0O
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 18:29:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nctkTiwcRi1hy+vBzyEUcxt31D0RM2Rl7WRVgnTybic=; b=fZ3JEIcd/IB7PVNPIIbSLknAFy
 60Hc0XGKHAibNVudWs9ADLb8IYoeDkByZY6WGbCD7gDS/f2Tu4QTK3knKLlul5tctbwD5V4XXHLhE
 VA8WRwq2ZfuECwHhxN5RdIbdXAA2VQk1EEd4GZ8EyHS5ilxnfhiMmSiNdRqe39ESkUYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nctkTiwcRi1hy+vBzyEUcxt31D0RM2Rl7WRVgnTybic=; b=c52P3XRGxyKH4M8YhqQfYJGe91
 SbIJhkWGLgzLhm9qiiqxPxnL9D0V+3fx/+uvMB3CxdkAu4Zl8aDOG3+5TzfJjkAi7SoHbyD3Fb2IB
 Cm3pyfUT4PS0b5ThwEaK4TP+/rQ1e+TFf+vUHeuNwDgTNQpEs/anKck4x9WERlFmOTIc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qVcK4-005f0D-PB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 18:29:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 81FF961275;
 Mon, 14 Aug 2023 18:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8DC433CA;
 Mon, 14 Aug 2023 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692037777;
 bh=TwLV5UwTulr/DDiB634rcf+NgwfPvOt5lHyqVyHUL/o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IJAA8GczDBa0f8X2Pqv9nyTEui8jCtPFWj0e9Ple1qHue9uONq19sLDMI17uyO07+
 TXHjb90lEzczne07U5ml1GpJRfcN/NuF7kygZgI32FsFkZ8zp5e3ZwJQvQhK5MSNcQ
 unbS7+Bi6Tj97vMm1gviMijGdn+cPMkmWj/9NQYo49PWLgirKuescuU2PvlkOsfA95
 8sx/kgDgan/zz7juyAhnjjtmupZMR78e9AkCFXkX1pKuvAQEAltroGj5p6Hpl+D2C6
 sDjjeIkULyfYncQaAIuwiMj3+xZ42lbv6kgsQzbOTfkwCNAFE+/ePXqWWxh7H39Tq5
 q8HEhvLosPZWA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Date: Mon, 14 Aug 2023 11:29:02 -0700
Message-ID: <20230814182903.37267-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
References: <20230814182903.37267-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1qVcK4-005f0D-PB
Subject: [f2fs-dev] [PATCH 2/3] ext4: remove redundant checks of s_encoding
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
Cc: linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that ext4 does not allow inodes with the casefold flag to be
instantiated when unsupported, it's unnecessary to repeatedly check for
support later on during random filesystem operations.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/hash.c  | 2 +-
 fs/ext4/namei.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 46c3423ddfa1..deabe29da7fb 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -300,7 +300,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
 
-	if (len && IS_CASEFOLDED(dir) && um &&
+	if (len && IS_CASEFOLDED(dir) &&
 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
 		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
 		if (!buff)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..f9a5663b9d23 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1445,7 +1445,7 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
-	if (!IS_CASEFOLDED(dir) || !dir->i_sb->s_encoding ||
+	if (!IS_CASEFOLDED(dir) ||
 	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
 		cf_name->name = NULL;
 		return 0;
@@ -1496,7 +1496,7 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
+	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
 			struct qstr cf = {.name = fname->cf_name.name,
@@ -2393,7 +2393,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
+	    utf8_validate(sb->s_encoding, &dentry->d_name))
 		return -EINVAL;
 #endif
 
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
