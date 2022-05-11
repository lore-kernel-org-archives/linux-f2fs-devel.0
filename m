Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB299C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 May 2022 19:32:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nos4B-0006tv-Or; Wed, 11 May 2022 19:32:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nos4A-0006tn-Io
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 19:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BYzV+Kq63BcnPRGcLIBle4+l7znVktkdtB9biD2PhRQ=; b=ODF987z8PtuT2oIOnFA0AmWE1e
 4oPBiXeNgrNV8LfwDDP27aEAxXUzdCBDHFBmRKEYohDYv5/ALFVVv1MhHum5ZmaoGH9zxmrEX0sl3
 UG/bTg5FFHD/3QVGu3nYFT6zNfYBFh6/b3Etz/DaTIDxi8GqSmACETc6P4UhRUJNv4Is=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BYzV+Kq63BcnPRGcLIBle4+l7znVktkdtB9biD2PhRQ=; b=IfSMTNJ0EQKf/X/GUX8xIAnPu+
 oy8GEgRiqDHe1giYljU1MJkOFMZ78Fk9t3wQLvtt23wR9Y/CV9Ry6WUxh3nvLumtSX+ysFefRUAZ4
 GC17Sh5R/7mCe9EsmIamJn1id5LszynAuP6wpFR1GumitlXEO7kNqwtA5lX2J1/6L/rA=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nos47-0093gE-J2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 19:32:09 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 0E8FE1F42934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652297521;
 bh=C3L+p6EH4hujqYdx/16YEZ4+aJcVzY1o6iSj/4Lilj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gUsF6LXVIf8FKQoVylJPyqvOgQyO9tjvrlWPNxm1ZUtFGbY8VnJu5BMPK+pirBpOu
 LvwgXyUCw4KhxmW71+jxOim1kdy9pNq65+lIMXrzytJTwdef1qeoDEcQ7B1UCE9Qyv
 A2kWZ6fWhj3ZNxnAB3y29dJsiFOdDlRE4M7SZHp/0k1+KwatTNj4YQuUCRvVZ5r0uo
 JWK7st8E4Xswr94U/di4BOxEAahPZOJr00UAfR9DXGpnaqagY1wkh2059QXcorvyKE
 TOyX546tEJrxIcN1jvEXptkU/9hIRH7jIf5IhVLmxUjL0+UXgbHDe37LWLUrCUVKx7
 5YNcj2AzKFjig==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org
Date: Wed, 11 May 2022 15:31:38 -0400
Message-Id: <20220511193146.27526-3-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nos47-0093gE-J2
Subject: [f2fs-dev] [PATCH v4 02/10] ext4: Simplify the handling of cached
 insensitive names
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
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

--
Changes since v1:
  - Simplify hunk (eric)
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a743b1e3b89e..93a28fcb2e22 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2490,7 +2490,7 @@ struct ext4_filename {
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 59eb3ecfdea7..84fdb23f09b8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1382,7 +1382,8 @@ static int ext4_match_ci(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1392,18 +1393,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
 
@@ -1443,8 +1444,6 @@ static bool ext4_match(struct inode *parent,
 		int ret;
 
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1453,7 +1452,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			ret = ext4_match_ci(parent, &cf, de->name,
+
+			ret = ext4_match_ci(parent, &fname->cf_name, de->name,
 					    de->name_len, true);
 		} else {
 			ret = ext4_match_ci(parent, fname->usr_fname,
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
