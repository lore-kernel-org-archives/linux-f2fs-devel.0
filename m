Return-Path: <SRS0=k77w=4Y=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C222DC10F26
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:37:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920AE206E6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="cvPK6zqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PYc1iTc8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SLW4zs9s";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="G0s2YXUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920AE206E6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yNGF/BzEDz4Hfz7nR1G4dcbrqaT1/nZnXZLlfov8o18=; b=cvPK6zqIMjNxKxKHZUso2KKqy
	VClfdr55lvwdpK5tyISvjX/vFGIVZ9PjpMHxg7PPHCrh5c2d7a2XpbWtrfdUsiJn1sNx8dfWe5L63
	h8/QuuErfC/Nn64FijSCjbCTXiFzK7V0om8c3hDx504iBuEtWKaVmpGv9MhYTr24AQlFE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jAPKm-0004gp-Sg; Sat, 07 Mar 2020 02:37:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3wAhjXgYKAFc2GDH3C5DD5A3.1DB@flex--drosen.bounces.google.com>)
 id 1jAPKi-0004gT-B2
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Mar 2020 02:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W0NRqN4tKUIiubnsRHwnrkHz9xP0jc5bUIehefjfrK0=; b=PYc1iTc88leqRoanerCGqgvxU
 O3kKCSCSRXt2+C7rHWslCSnnA0SyykshWcN5hip4tAhtyj5t1pHwAyr3OFI+vJV0BvEz1dIy0Mkko
 TNn0IguZtzf1BP/IvOqoJQUrdl8O+vdNORQW68cZ+wXG9FWt4dGIFAOqOAAArepMd+MWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W0NRqN4tKUIiubnsRHwnrkHz9xP0jc5bUIehefjfrK0=; b=SLW4zs9sdj1p0IPB/jHJk1qVNH
 S/j6XGFRC+XYMtEStF4W+JqWDkkldF53visPfQyB4j2J04cy6KFF2wbG0z4NNBgJfCMmBkW598bEL
 pFmL9gU9vayZJxDPob0wlNY47lBrJijQ5PGLoZor3kbDk/FQwkOYtLWc77fTteNRUgKk=;
Received: from mail-pl1-f201.google.com ([209.85.214.201])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jAPKg-000uCh-19
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Mar 2020 02:36:56 +0000
Received: by mail-pl1-f201.google.com with SMTP id f20so652813plj.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Mar 2020 18:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=W0NRqN4tKUIiubnsRHwnrkHz9xP0jc5bUIehefjfrK0=;
 b=G0s2YXUs60QGYd1azRm9N+DEtQUa9U2sfAd7n5dRhxO4cGELADBu0RCaWtuzEoewXq
 1VwOG8xo3CB9fbum61PZal2AG/c+LDNuGpC5Dn34tE/7BTiNV7muT/IgD/5qvclPBYsk
 NSksw1pSB68xMWgFtawTFTriTdVmMrqzLqA1fu4hLkqzoe2cf9WuUIC4XADWtB98O0ZP
 Is0GE72LBQG5PVK60mFNlIYkSAAEJG9mDWg9xSGIh35AOUDLTbDtW0UrjNt3C1uYMYei
 R+Ls5Xyc6wNjOVdx/6KOdhkjZoQQphnTOmOyurHwqzeKiBMk6KoHk01PPlq5KUHg417s
 P61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=W0NRqN4tKUIiubnsRHwnrkHz9xP0jc5bUIehefjfrK0=;
 b=rzCBo0Fwghn6ZC1Kd1hzoomimH7i9liZTPHG3dOXw4GYyowTLPx0T9RXd5ClDN62Fu
 rRZYZEWd5TAiK9a7eADssPnccx1q7rwJpfbRnJ6NxtmHfSk4dtBXGHeZLCKJ4Pk9BMeh
 8ra6fS1exdgl8+jgivNVAVq162Z2szZB/Z2/ExWmwXqefOD9KbzA2wZZ6G8IF/FFQKXZ
 s3VVt1dBUz8xgfAGmhYLVwuIjqbQg5sBqQUyqjhExfobi6FnljXtCKSG/dErHpHfBYGo
 G1qiiAwPcSaxrdsdIQQeqVgK4mZ9rtqpzuysQtcuJDrdhZXInIpI0r92YJS4a9bX6RR9
 +fnA==
X-Gm-Message-State: ANhLgQ2VUyiAnaCHQT25wKsTgNGGsu7j1ZNRMFVncE82kYGArU8ffcyM
 x83mid7KIArkOWm8GezgH9UE3CpqHoE=
X-Google-Smtp-Source: ADFU+vu+t300mRWdVo2OXw72+/s87iy5D1YclwxP2iiwivGLHC6RCrgND3FdQ3hsIGdTsdhsQ7keJGHqVng=
X-Received: by 2002:a65:6715:: with SMTP id u21mr5823467pgf.17.1583548608053; 
 Fri, 06 Mar 2020 18:36:48 -0800 (PST)
Date: Fri,  6 Mar 2020 18:36:09 -0800
In-Reply-To: <20200307023611.204708-1-drosen@google.com>
Message-Id: <20200307023611.204708-7-drosen@google.com>
Mime-Version: 1.0
References: <20200307023611.204708-1-drosen@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
To: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>, 
 linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Richard Weinberger <richard@nod.at>
X-Headers-End: 1jAPKg-000uCh-19
Subject: [f2fs-dev] [PATCH v8 6/8] libfs: Add generic function for setting
 dentry_ops
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Daniel Rosenberg <drosen@google.com>, linux-doc@vger.kernel.org,
 kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This adds a function to set dentry operations at lookup time that will
work for both encrypted files and casefolded filenames.

A filesystem that supports both features simultaneously can use this
function during lookup preperations to set up its dentry operations once
fscrypt no longer does that itself.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0eaa63a9ae037..bdda03c8ece9e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1474,4 +1474,54 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return ret;
 }
 EXPORT_SYMBOL(generic_ci_d_hash);
+
+static const struct dentry_operations generic_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+};
+#endif
+
+#ifdef CONFIG_FS_ENCRYPTION
+static const struct dentry_operations generic_encrypted_dentry_ops = {
+	.d_revalidate = fscrypt_d_revalidate,
+};
+#endif
+
+#if IS_ENABLED(CONFIG_UNICODE) && IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+	.d_revalidate = fscrypt_d_revalidate,
+};
+#endif
+
+/**
+ * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
+ * @dir:	parent of dentry whose ops to set
+ * @dentry:	dentry to set ops on
+ *
+ * This function sets the dentry ops for the given dentry to handle both
+ * casefolding and encryption of the dentry name.
+ */
+void generic_set_encrypted_ci_d_ops(struct inode *dir, struct dentry *dentry)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	if (dentry->d_flags & DCACHE_ENCRYPTED_NAME) {
+#ifdef CONFIG_UNICODE
+		if (dir->i_sb->s_encoding) {
+			d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
+			return;
+		}
 #endif
+		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
+		return;
+	}
+#endif
+#ifdef CONFIG_UNICODE
+	if (dir->i_sb->s_encoding) {
+		d_set_d_op(dentry, &generic_ci_dentry_ops);
+		return;
+	}
+#endif
+}
+EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8d20a3daa49a0..dc433bc4f0602 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3389,6 +3389,8 @@ static inline bool needs_casefold(const struct inode *dir)
 	return false;
 }
 #endif
+extern void generic_set_encrypted_ci_d_ops(struct inode *dir,
+					   struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
-- 
2.25.1.481.gfbce0eb801-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
