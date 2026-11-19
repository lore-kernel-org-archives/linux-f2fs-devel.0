Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43133606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lIxCcdy9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JJlfvDcV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EfN858kv;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ijl46/KI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LLkrdgkvbHXl3wnXLPgBqcGKlZ31ls8I2AJOkOFMnNk=; b=lIxCcdy9osX9TRcPINUmjnbAA4
	Ujao/igJX4HWghxqS/kq6RGpQORyqHE+VoL7UzJa8q89e7mSiNnV8B61LQdxR9Pnf0ZwVwtzrZ0VS
	PYiZBuvuALQmTzXkvWpDXAS7o+pX7s94xkUQRdhKjzT1PvxVUL46BDMG02tPmkM2HTyw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUA7L-000000006PA-2fCY;
	Thu, 19 Nov 2026 21:56:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3_27_ag4KADooWnpdWggqgnapeckkcha.Yki@flex--sarthakkukreti.bounces.google.com>)
 id 1xUA7J-000000006P3-1zi3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F+2hOopmrqVojtJDaVmiIa/Ykk5HH2rozBQfm3Mp9xM=; b=J
 JlfvDcVsEj6wh7HVrjuAVc5ohLsJO0WmDmvJDf8ZsT9Mj5qWi2ps+vjAH4sp5nsAVHqzECrTpUcqe
 bQi4sOpOCbuSaL0umz8jcqUdLAIisRT+OEvIFG/N0RejiAlhESFvpEq6RYtskjtUh8AWIIvdq1E0B
 JlD4rG8MLiwt9JTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F+2hOopmrqVojtJDaVmiIa/Ykk5HH2rozBQfm3Mp9xM=; b=EfN858kvS3YEEmSRgovx7Rn0eQ
 wiTnMSGiqPVDOEtKyxIx7m/RTbE8rv9yH0VqjkGLEaONIhkt6eW5yJbB7A7aGwkM2fgcRtSNcXG31
 kAndsBO4GBXWLzBywhj7eO00emGz2TZLjDAineG8tUaMSLTMN+LhezKIR6JLsdVzR4iw=;
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUA7I-000000004j7-0R4A
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 21:56:29 +0000
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55c5cbc838aso6130901cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795125382; x=1795730182;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F+2hOopmrqVojtJDaVmiIa/Ykk5HH2rozBQfm3Mp9xM=;
 b=Ijl46/KINJEr7gnTsToR+UDo7lfZPx9OOhSzqtVaapegCIWbjdLNMfFC5alSpnKO+H
 yfhmy7VU4nNNzzPCBaYcJUfBoA0X7w0cglPcRG9rQ0e+/6i6fNZenGFDsKbYqcuKdh9t
 9u+4vXz357l4m0aB/5dmocETk4MNla4tGZz0ZT7UDYAVTalOZSbiMtTxgdfWI+7C9xqG
 +YCxepE4WBT0wCIZwnNA6bohR7S9sGnT+jHgHjdj+xhaNAJJu9tsyK4aIdzFSPXgFJPd
 BqrCVaOmfHfJwCP3hNzG8LKzkltNhcNxmJKSoVrfPla4acqCgZlJuFi0ze8Z04TQQiXo
 OD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125382; x=1795730182;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+2hOopmrqVojtJDaVmiIa/Ykk5HH2rozBQfm3Mp9xM=;
 b=IzBnFImtD+i5CiYWOXpgOy7xfCz66nIVqM1evms4pVFiP+KhQ3PvwGwg0UN5NUQnfh
 W5faDdz4M5BVJ89WZ51kawvMNUU84sVuD89oWjE1bkN6SdGJI5FJscUTuT9yeXUK9B1J
 d5lFLQ6NfhDTOzgIVTHt5xa91HqDWaFyHXAYbesFLITIOHi0N3GT+Vu4VC9DPfgzB5rd
 XC3WW+PSiLBBPXTCdd6sFjOfk1uwt9ZorNJqLnuNoohP9mNH8JXUN6dkJH7EzYHqIJNZ
 2+Rw0pxk/RivbXd82WZcDxQYimGrGNim4px6umRI9tp38UUH/9HbjuVy7tg7+NRfgA61
 sYhw==
X-Forwarded-Encrypted: i=1;
 AL+hErGCdmT/i0XxYiFCEOJz8MNSxPijzIDO7j604FtvorkoakByv97zqsa82cb1aXUf/a84BZY+ZZpDslLl9MnI5NKj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MQuSBLFVLzftf6O0xY6bhTkkmUXbywJznd+xwG6OQjk7O/Ed/
 EOpu9D/1Zr7rED4BIHMIqLzjdHbsQplWTz9IXJ7efUVtL/waJTzXnS2cA89y3hr0CRMCkUgCSUj
 bO7fiDTEJO4szjsfZaVI2YtCsqivzYIuWEJfLKg==
X-Received: from dlbrl2.prod.google.com ([2002:a05:7022:f502:b0:1a3:c305:2584])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id
 a92af1059eb24-1b5568b9e59mr1130134c88.24.1795124991172; 
 Thu, 19 Nov 2026 13:49:51 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:42 -0800
In-Reply-To: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119214944.1480596-2-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xUA7I-000000004j7-0R4A
Subject: [f2fs-dev] [PATCH v2 1/3] libfs: reject casefolded names that fold
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

Unicode normalization and casefolding (utf8_casefold()) strips code
points with the Default_Ignorable_Code_Point property. As a result:

1. A filename consisting of "." or ".." followed by ignorable characters
   (e.g. ".\xe2\x80\xae" or "..\xe2\x80\xae") bypasses VFS special-entry
   handling during path walk, but casefolds to "." or "..".
2. A filename consisting solely of ignorable characters (e.g.
   "\xe2\x80\xae") casefolds to the empty string "" (length 0), causing
   any two distinct ignorable-only filenames to compare and hash as
   equal.

Update generic_ci_d_hash(), generic_ci_match(), and
generic_ci_validate_strict_name() to reject case-insensitive hashing,
matching, and creation of filenames that casefold to "", ".", or "..",
while preserving exact byte-equality matches (such as NFS export lookups
of literal ".."). Using a 3-byte stack buffer with utf8_casefold()
detects all three cases in O(1) space without heap allocations.

Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Fixes: c843843e714c ("fs: Add standard casefolding support")
Co-developed-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/libfs.c         | 32 +++++++++++++++++++++++++++++---
 include/linux/fs.h | 31 ++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46e0205154e7..77997f88e475 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1828,13 +1828,21 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
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
@@ -1907,10 +1915,28 @@ int generic_ci_match(const struct inode *parent,
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
index 5b3a100aba77..22c411e046ce 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3368,28 +3368,26 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
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
@@ -3399,6 +3397,13 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir,
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
2.56.1.750.gf70dc682cf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
