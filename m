Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E61C27C52
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:34:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sF7e0-0006Wi-9H;
	Thu, 06 Jun 2024 07:34:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1sF7dy-0006Wa-Rc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1qNqrk9UnddbyEYqJThGAAsnQfkC+hRRjEDw1I3Dmw=; b=j9vh+Gn1SKvpnKMvgoJXCSk+Kj
 xUUqUJ8X0SEhQqGIhBXqyFy+MWZM1Kit50yoeNUkYnZqcCDrDy/0K7GRuSKgJCzxyVZKQDHac+2ey
 2hW7hIawJsM/dUooo4cs7Opn3NiJc296kd2e5yRPDbhRibyl90IqxYY6W5dVuCIbIf8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a1qNqrk9UnddbyEYqJThGAAsnQfkC+hRRjEDw1I3Dmw=; b=MdyGDOPvMCH6VM8mpdrlj2Duie
 AXxRT9EVD8GUfEDpymk9rArKWxa1VFFKimXn7qYrwn0c6IlKZ2FccntmAOtsCBOI9+WPV/YJy+LHh
 EpwF1S1zUr3NBsQq3s1dNyz+nDGeHGeAZuKaxcmIAXk6PAUIgIJkzVV29XC2onT4oPNs=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sF7dy-0001xB-Vx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 07:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717659275;
 bh=XtEHiBrDSf4ce/QizppJREOQW0pGgY68GGnjXcbrJYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fBkkX++I18I7bSLdl+E9++h7LlHjEqSgLyuRKmIfLuNaFNmSlzC8xVzqvU1jYGjua
 r0lHU/jHcSe4iEhElLN9+yzuiCRXurnRfXep8HZBg4yFNEHnje+B+Ou6K/vBhzersS
 hFrZ4EVSc919hcSKgerPHHzH+/DUiUALnY6luH8ROYB819LZJFtw5tYSFy92YQ66Fs
 JXyRvGSzOY28SXnt76mj67+0TP5rUl3BtkcYdYo3ZWeqvlm/STpq9mMPE/etDhMWia
 qIMXPHBJ6SwdxflvhlRp4pzoyux0TQy63JlM4Ak5RbNC9Y3MMq+Td8M6k7LS6m6EDn
 xDpItX3aYx3lg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA42337821D4;
 Thu,  6 Jun 2024 07:34:34 +0000 (UTC)
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, adilger.kernel@dilger.ca, tytso@mit.edu
Date: Thu,  6 Jun 2024 10:33:47 +0300
Message-Id: <20240606073353.47130-2-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1sF7dy-0001xB-Vx
Subject: [f2fs-dev] [PATCH v18 1/7] ext4: Simplify the handling of cached
 casefolded names
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

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.10-rc1]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..deffd7431c8b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2511,7 +2511,7 @@ struct ext4_filename {
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a630b27a4cc6..ec4c9bfc1057 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1445,7 +1445,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1455,18 +1456,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return 0;
 	}
 
-	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
-	if (!cf_name->name)
+	buf = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
+	if (!buf)
 		return -ENOMEM;
 
-	len = utf8_casefold(dir->i_sb->s_encoding,
-			    iname, cf_name->name,
-			    EXT4_NAME_LEN);
+	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
 	if (len <= 0) {
-		kfree(cf_name->name);
-		cf_name->name = NULL;
+		kfree(buf);
+		buf = NULL;
 	}
+	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
+
 	if (!IS_ENCRYPTED(dir))
 		return 0;
 
@@ -1503,8 +1504,6 @@ static bool ext4_match(struct inode *parent,
 	if (IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1513,8 +1512,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			return !ext4_ci_compare(parent, &cf, de->name,
-							de->name_len, true);
+			return !ext4_ci_compare(parent, &fname->cf_name,
+						de->name, de->name_len, true);
 		}
 		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
 						de->name_len, false);
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
