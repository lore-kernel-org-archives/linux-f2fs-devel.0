Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C8606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aksmQL5p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gDiE2fF7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DAWYfFGe;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RvwwNW8D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8wCTQLcz3EdFs3J+ubIElLw0sig24BPaaCsHUjCFDAE=; b=aksmQL5parew/wIhir8DP1y4MW
	V8pWwPFkvJuWsPOQOIBviMS7FgQZ2kP8YZYHX/QDYuu0gLBOSE7Km9Su4fm+1zqBNP4N97G2diyo3
	kBY7stfq1ExCacoVNKj2T6DFk9FK3Q2Mcz5/veEuvLW3ScmddGPENPOyyn6U74/DiMAE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRlYs-000000008Ks-4BN6;
	Fri, 13 Nov 2026 07:19:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <39LP2ag4KAJUHzGI6z99J9G3I75DD5A3.1DB@flex--sarthakkukreti.bounces.google.com>)
 id 1xRlYr-000000008Kb-0ph9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=; b=g
 DiE2fF7vkFSvEZW1Pzjp0Hr8lyEfaLTMYPtsYtxjpS/xE+FEmYOXaxmSAnpYOV2IrO3/PeA1HHqJh
 1zOp3pHUBcsA+hog9t6f6gpY2WEAeInQ7d34Yn+uKXiwV6mm729eVDXAsrl0QbBm9Nvv2koYkD2cw
 AdNa9cnY0Aq26giU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=; b=DAWYfFGe6efJ9nYUgs05WK78NR
 tYd38yPvYN+mdyc15EwwgKlHZaZTgREczFiyocaIMXIdLZTMn9NJWD6fIgJAmBp6roqsfFe8I6jkz
 f5mUAUOD4/V5S0quM7WELcmLhXDUqkZX1bNqfk3OOx6JpAx3Mx9qzKdklBEa8nfeDDWM=;
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRlYp-000000001xv-35Cs
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:19:01 +0000
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55b9c13273dso438721cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 23:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794554334; x=1795159134;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=;
 b=RvwwNW8DfZNif88hlVf9g/8r3PEcAbJC8DSsTVDbqbbl/5dFNG8YKx/Xjyq+R+8HVq
 93kBXI4UdrKizegkGpytx6aeewr0Nvr8nBCbgiKQyVVriHfQlRAa16HDMlKpF/LQP+Vi
 deH43RV1AIolY0x5wVVB3014qPMwyLI+MauF/kdSQkQBpIivITIcvCmFn1ejfM/RhG3A
 MnYTBjktI8B6WKT8GCub84zcgPt4OJrF9Ay8V1H3N65ExQItAQt7H41j3OqTp1CmMscr
 RcPFTH2bonsvmo2ggoHRM3VvLY7AWr215QYJonfHNylmafsrDVgbwr9FpTaOAr4+QWF+
 IeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794554334; x=1795159134;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Q39/lqYC3Xf6FzX/Bx2LJs4jpalM5B4swG5E0jDvX4=;
 b=OBjQdW977ga45FpYe26+4frmooSVUMR6C188eRc8mn4/gzVK5RQGrUjK00FZWDkAnw
 Mh9Zswq4TJ+fMRHRa1dPKfomLIjyGCMvHfQQ5KjXwySYxE7nIXVL1eQHvivEiRkweD8t
 7BqCwrELoALVW1LMg0/6P+864mcbbV3o9E+Ys5ZNt4R6AHtaqrCa1NTOhPUcN4ZR73RH
 APLKOYo6X8byyGt/z1k+3Ad+rx6dCBowdk9OHe/lCAJtNm6KMxXNwVYV9c8DmD2giXSY
 QUYWjECxLrgi6vwGquAQ5UqIW6EVxzOpbhdQvgeQlFO0vvrx9hLPkp7NN0Fwg8sgE8uw
 FCKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGuY+FZU7IxnrjKS+K9Ieyyymm58j2VnVgVK67vrl5xqtvgreU/5Pk5suxZXlQMnFkiemRjL411JXrjwWQFsDCX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9vNg/GNwBtoSFwPcyg7L3tCZwG4uXTatl7zU3zrb15vJs/72pn
 A+SOx0+MowHSXf2fr/1Oq4u8+wmG3OBzWEvSu4irRvIcJ53Z8hQiuLGbbHEpAAU5QP1l3J50Dm/
 LtEaAd/yD/bz1nveuzw1drMogNenpmnzI5glMTQ==
X-Received: from dycmq8.prod.google.com ([2002:a05:7301:788:b0:369:fbca:f649])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:6185:20b0:379:3c04:2cdd with SMTP id
 5a478bee46e88-379686a7f3amr1357207eec.31.1794552820371; 
 Thu, 12 Nov 2026 22:53:40 -0800 (PST)
Date: Thu, 12 Nov 2026 22:53:30 -0800
In-Reply-To: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261113065332.929085-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113065332.929085-2-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRlYp-000000001xv-35Cs
Subject: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold to
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

Unicode normalization and casefolding (utf8_casefold()) strips code
points with the Default_Ignorable_Code_Point property, such as U+202E
(RIGHT-TO-LEFT OVERRIDE) or U+200B (ZERO WIDTH SPACE). As a result:

1. A filename consisting of "." or ".." followed by ignorable characters
   (e.g. ".\xe2\x80\xae" or "..\xe2\x80\xae") bypasses VFS special-entry
   handling during path walk, but casefolds to "." or "..".
2. A filename consisting solely of ignorable characters (e.g.
   "\xe2\x80\xae") casefolds to the empty string "" (length 0), causing
   any two distinct ignorable-only filenames to compare and hash as
   equal.

Update generic_ci_d_hash(), generic_ci_d_compare(), generic_ci_match(),
and generic_ci_validate_strict_name() to reject case-insensitive
hashing, matching, and creation of filenames that casefold to "", ".",
or "..", while preserving exact byte-equality matches (such as NFS
export lookups of literal ".."). Using a 3-byte stack buffer with
utf8_casefold() detects all three cases in O(1) space without heap
allocations.

Fixes: c843843e714c ("fs: Add standard casefolding support")
Co-developed-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/libfs.c         | 50 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h | 31 ++++++++++++++++------------
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 27d7dc16fcb0..54296dfb8444 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1801,8 +1801,11 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 {
 	const struct dentry *parent;
 	const struct inode *dir;
+	const struct unicode_map *um;
 	union shortname_store strbuf;
+	unsigned char buf[3];
 	struct qstr qstr;
+	int cf_len;
 
 	/*
 	 * Attempt a case-sensitive match first. It is cheaper and
@@ -1821,6 +1824,19 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	if (!dir || !IS_CASEFOLDED(dir))
 		return 1;
 
+	if (name_is_dot_dotdot(str, len) ||
+	    name_is_dot_dotdot(name->name, name->len))
+		return 1;
+
+	/*
+	 * utf8_strncasecmp() only matches if both names casefold to the same
+	 * byte sequence, so checking @name covers @qstr as well.
+	 */
+	um = dentry->d_sb->s_encoding;
+	cf_len = utf8_casefold(um, name, buf, sizeof(buf));
+	if (cf_len == 0 || (cf_len > 0 && name_is_dot_dotdot(buf, cf_len)))
+		return 1;
+
 	qstr.len = len;
 	qstr.name = str;
 	/*
@@ -1839,7 +1855,7 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		barrier();
 	}
 
-	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
+	return utf8_strncasecmp(um, name, &qstr);
 }
 EXPORT_SYMBOL(generic_ci_d_compare);
 
@@ -1855,13 +1871,21 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	unsigned char buf[3];
 	int ret;
 
 	if (!dir || !IS_CASEFOLDED(dir))
 		return 0;
 
 	ret = utf8_casefold_hash(um, dentry, str);
-	if (ret < 0 && sb_has_strict_encoding(sb))
+	if (ret < 0) {
+		if (sb_has_strict_encoding(sb))
+			return -EINVAL;
+		return 0;
+	}
+
+	ret = utf8_casefold(um, str, buf, sizeof(buf));
+	if (ret == 0 || (ret > 0 && name_is_dot_dotdot(buf, ret)))
 		return -EINVAL;
 	return 0;
 }
@@ -1934,10 +1958,28 @@ int generic_ci_match(const struct inode *parent,
 	    !memcmp(name->name, dirent.name, dirent.len))
 		goto out;
 
-	if (folded_name->name)
+	if (name_is_dot_dotdot(dirent.name, dirent.len) ||
+	    name_is_dot_dotdot(name->name, name->len) ||
+	    (folded_name->name &&
+	     (!folded_name->len ||
+	      name_is_dot_dotdot(folded_name->name, folded_name->len)))) {
+		res = 1;
+		goto out;
+	}
+
+	if (folded_name->name) {
 		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
-	else
+	} else {
+		unsigned char buf[3];
+		int cf_len = utf8_casefold(um, name, buf, sizeof(buf));
+
+		if (cf_len == 0 ||
+		    (cf_len > 0 && name_is_dot_dotdot(buf, cf_len))) {
+			res = 1;
+			goto out;
+		}
 		res = utf8_strncasecmp(um, name, &dirent);
+	}
 
 out:
 	kfree(decrypted_name.name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..84f5ce2bb9ad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3356,28 +3356,26 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  * generic_ci_validate_strict_name - Check if a given name is suitable
  * for a directory
  *
- * This functions checks if the proposed filename is valid for the
- * parent directory. That means that only valid UTF-8 filenames will be
- * accepted for casefold directories from filesystems created with the
- * strict encoding flag.  That also means that any name will be
- * accepted for directories that doesn't have casefold enabled, or
- * aren't being strict with the encoding.
+ * This function checks if the proposed filename is valid for the
+ * parent directory. Names that casefold to "", ".", or ".." are
+ * rejected for all casefolded directories. When the filesystem is
+ * created with the strict encoding flag, only valid UTF-8 filenames
+ * are accepted for casefolded directories.
  *
  * @dir: inode of the directory where the new file will be created
  * @name: name of the new file
  *
  * Return:
- * * True: if the filename is suitable for this directory. It can be
- *   true if a given name is not suitable for a strict encoding
- *   directory, but the directory being used isn't strict
- * * False if the filename isn't suitable for this directory. This only
- *   happens when a directory is casefolded and the filesystem is strict
- *   about its encoding.
+ * * True: if the filename is suitable for this directory.
+ * * False: if the filename isn't suitable for this directory.
  */
 static inline bool generic_ci_validate_strict_name(struct inode *dir,
 						   const struct qstr *name)
 {
-	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
+	unsigned char buf[3];
+	int len;
+
+	if (!IS_CASEFOLDED(dir))
 		return true;
 
 	/*
@@ -3387,6 +3385,13 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir,
 	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
 		return true;
 
+	len = utf8_casefold(dir->i_sb->s_encoding, name, buf, sizeof(buf));
+	if (len == 0 || (len > 0 && name_is_dot_dotdot(buf, len)))
+		return false;
+
+	if (!sb_has_strict_encoding(dir->i_sb))
+		return true;
+
 	return !utf8_validate(dir->i_sb->s_encoding, name);
 }
 #else
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
