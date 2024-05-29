Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935BAC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 May 2024 08:27:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sCEeL-0000xj-31;
	Wed, 29 May 2024 08:27:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1sCEeK-0000x0-06
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 May 2024 08:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wc1JtWOVmrB2CV32gyfScI48NCD5kZJAIHJGSX5uxbc=; b=IGznl3ymMwhQ1HJMOhxv1Lxp7S
 6yJlRwojMlTR25l2vJZQi0r40OYc/QN95Jamm7rrxnkd7uzVIQoi3nX5xMl5eearO5OMkNO8C455n
 M2ACdi3iQhy3K1rtQrJS/yy7gn5azxAdECFVUHAmiBVsQrFb9avfFPzLADRUfOTQM0xA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wc1JtWOVmrB2CV32gyfScI48NCD5kZJAIHJGSX5uxbc=; b=Q1ZtfCul2XcgMpxml4dvLiN8b1
 7zLm3X1pUicTyS1DB9csA/OvlfuYUsBAM99YBDyuhFiad/N3+4/wH7xpqk/4YYWWODuAwZdGLX4dN
 mi4wE5xtX2z2zzXLb3Sfa0d4wmKPnSLuEdJoi8zOEAKmzwmbUedxwZji+ePGv3OB2fj8=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sCEeL-00007Z-5U for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 May 2024 08:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716971212;
 bh=RaApyMUGWRaAMpiSoFeoKzdLOeZPjYqhNYx85qIghjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=23b4AKpMfUa4MKq2wIrIxP6qx/75ESo8YvHmjUrjc8eQY6NZ31OyWpfjyZAis4i2K
 tVZSB8Z5jfCLGfw9GutWzbZGvbooD5F6gssciVRj1xpbuFI96g3+VttMTnc6lfiTCM
 KR/wALJsv1B0c8oV+aH+iDd7ZlPe5BjDI5NhgAxiqPVnWy0FRPUReN0/uA6iZLOr86
 cAePhkHO6GLWVUvD2MzQrZT2UTyY9tgX2LNxpIURqFwbiiAxCRXvQjcbeqRYsp0nXL
 e/HHVUf5+oaJIT1QUC8nxOcIY+0+xk3HxzFg9rfEze+654m6ADFb2nNHtrPUheyDg3
 a3t+RZLhwpu1A==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E0013782175;
 Wed, 29 May 2024 08:26:51 +0000 (UTC)
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu
Date: Wed, 29 May 2024 11:26:32 +0300
Message-Id: <20240529082634.141286-6-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082634.141286-1-eugen.hristev@collabora.com>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1sCEeL-00007Z-5U
Subject: [f2fs-dev] [PATCH v17 5/7] f2fs: Reuse generic_ci_match for ci
 comparisons
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
From: Eugen Hristev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: krisman@suse.de, brauner@kernel.org, jack@suse.cz, ebiggers@google.com,
 Eugen Hristev <eugen.hristev@collabora.com>, viro@zeniv.linux.org.uk,
 kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Now that ci_match is part of libfs, make f2fs reuse it instead of having
a different implementation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c | 58 ++++-----------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bdf980e25adb..cbd7a5e96a37 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -185,58 +185,6 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	return f2fs_find_target_dentry(&d, fname, max_slots);
 }
 
-#if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Test whether a case-insensitive directory entry matches the filename
- * being searched for.
- *
- * Returns 1 for a match, 0 for no match, and -errno on an error.
- */
-static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
-			       const u8 *de_name, u32 de_name_len)
-{
-	const struct super_block *sb = dir->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int res;
-
-	if (IS_ENCRYPTED(dir)) {
-		const struct fscrypt_str encrypted_name =
-			FSTR_INIT((u8 *)de_name, de_name_len);
-
-		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
-			return -EINVAL;
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (res < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	res = utf8_strncasecmp_folded(um, name, &entry);
-	/*
-	 * In strict mode, ignore invalid names.  In non-strict mode,
-	 * fall back to treating them as opaque byte sequences.
-	 */
-	if (res < 0 && !sb_has_strict_encoding(sb)) {
-		res = name->len == entry.len &&
-				memcmp(name->name, entry.name, name->len) == 0;
-	} else {
-		/* utf8_strncasecmp_folded returns 0 on match */
-		res = (res == 0);
-	}
-out:
-	kfree(decrypted_name.name);
-	return res;
-}
-#endif /* CONFIG_UNICODE */
-
 static inline int f2fs_match_name(const struct inode *dir,
 				   const struct f2fs_filename *fname,
 				   const u8 *de_name, u32 de_name_len)
@@ -245,8 +193,10 @@ static inline int f2fs_match_name(const struct inode *dir,
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (fname->cf_name.name)
-		return f2fs_match_ci_name(dir, &fname->cf_name,
-					  de_name, de_name_len);
+		return generic_ci_match(dir, fname->usr_fname,
+					&fname->cf_name,
+					de_name, de_name_len);
+
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
