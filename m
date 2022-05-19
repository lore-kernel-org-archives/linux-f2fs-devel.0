Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA466C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 21:24:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrndE-0000GA-Lv; Thu, 19 May 2022 21:24:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrndD-0000Fy-Hb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h851jffF4HydTlhi9113Ls9yOz76buDFb+EyokiKoHo=; b=b621uYoD45qZcx6kO06DiREnvq
 eI4uU4SMjVMv7SIItyf+iXo9er8UNCHlBOEx3TVSIafgsq+LDFTMFmAkVqV551wt1NJNQvuu01lmP
 Ld2NNn8aB8d9hcsFpp+lPpo+myBG4qDEI6LcpHSTHH4oa1IT5EyapxfBxzgjXC1z+Me0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h851jffF4HydTlhi9113Ls9yOz76buDFb+EyokiKoHo=; b=GMCd9DAVQa2y71N6Z+KCaGGtvv
 G7EA3J6remHFLCHgNXyzQuUIw4aDrohgg7GatsJ1+wmqNqLlTwZlutklCXGykKfFlyGKYv87xjVws
 xPWgDrjoa+icrjHFBgGMe4y/gMgg6yAOz4g6QtV6Bq6vRlMM6CT1CyDoAhIvTa6JttlU=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrndB-00AbRa-TF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:24:27 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 386E41F45F74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652995459;
 bh=fFOmrn+/umBKBn50FsqGJUi0n5hFO6w7rPmQU8rcBH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ymuf4yLMprmSqIAlH/4U5OgnLOcevabmJJmc+I4IaBfVH6vRU9vt972GUIee04vXU
 tBaa7Zc+yICssmOx/gxs/9FbrjdF1YV9clDwldrgTP9KDEyzL9frRk/t6zirBf7iCd
 EUnnkJfwzjhq1YPm9uTzVK+1XhXwZCKHwZYoYbaUretbI0F0kwi7Wj7XTJopAAvz5p
 HxNXDO28+gvxYR1tjLOG4O5Mz71ipAWWWv8aLhDoFsw8AGxnFkbXyAUMuNJrQu6kwf
 Qt/m7zT3P0P9u0v4h2k7lenmwkc9KrTBLF9Q7jIqdUotqLtUVnKSAeX+ONPW11/FO/
 5PfAyBtqL1sIA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 ebiggers@kernel.org
Date: Thu, 19 May 2022 17:23:55 -0400
Message-Id: <20220519212359.19442-5-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519212359.19442-1-krisman@collabora.com>
References: <20220519212359.19442-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nrndB-00AbRa-TF
Subject: [f2fs-dev] [PATCH v8 4/8] ext4: Reuse generic_ci_match for ci
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
Cc: linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
 kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Instead of reimplementing ext4_match_ci, use the new libfs helper.

It also adds a comment explaining why fname->cf_name.name must be
checked prior to the encryption hash optimization, because that tripped
me before.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  - Readd cf_name != NULL on hash verification and comment explaining it (eric)
---
 fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 64 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 206fcf8fdc16..eaf383740965 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1318,58 +1318,6 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Test whether a case-insensitive directory entry matches the filename
- * being searched for.  If quick is set, assume the name being looked up
- * is already in the casefolded form.
- *
- * Returns: 0 if the directory entry matches, more than 0 if it
- * doesn't match or less than zero on error.
- */
-static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-			   u8 *de_name, size_t de_name_len, bool quick)
-{
-	const struct super_block *sb = parent->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int ret;
-
-	if (IS_ENCRYPTED(parent)) {
-		const struct fscrypt_str encrypted_name =
-				FSTR_INIT(de_name, de_name_len);
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (ret < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, &entry);
-	else
-		ret = utf8_strncasecmp(um, name, &entry);
-	if (ret < 0) {
-		/* Handle invalid character sequence as either an error
-		 * or as an opaque byte sequence.
-		 */
-		if (sb_has_strict_encoding(sb))
-			ret = -EINVAL;
-		else if (name->len != entry.len)
-			ret = 1;
-		else
-			ret = !!memcmp(name->name, entry.name, entry.len);
-	}
-out:
-	kfree(decrypted_name.name);
-	return ret;
-}
-
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
@@ -1432,20 +1380,35 @@ static bool ext4_match(struct inode *parent,
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
-		if (fname->cf_name.name) {
-			if (IS_ENCRYPTED(parent)) {
-				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
-					fname->hinfo.minor_hash !=
-						EXT4_DIRENT_MINOR_HASH(de)) {
+		int ret;
 
-					return false;
-				}
-			}
-			return !ext4_ci_compare(parent, &fname->cf_name,
-						de->name, de->name_len, true);
+		/*
+		 * Just checking IS_ENCRYPTED(parent) below is not
+		 * sufficient to decide whether one can use the hash for
+		 * skipping the string comparison, because the key might
+		 * have been added right after
+		 * ext4_fname_setup_ci_filename().  In this case, a hash
+		 * mismatch will be a false negative.  Therefore, make
+		 * sure cf_name was properly initialized before
+		 * considering the calculated hash.
+		 */
+		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
+		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
+		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
+			return false;
+
+		ret = generic_ci_match(parent, fname->usr_fname,
+				       &fname->cf_name, de->name,
+				       de->name_len);
+		if (ret < 0) {
+			/*
+			 * Treat comparison errors as not a match.  The
+			 * only case where it happens is on a disk
+			 * corruption or ENOMEM.
+			 */
+			return false;
 		}
-		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
-						de->name_len, false);
+		return ret;
 	}
 #endif
 
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
