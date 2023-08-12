Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D18C04E69
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 12 Aug 2023 00:42:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qUchs-0001Nl-5z;
	Sat, 12 Aug 2023 00:42:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qUcho-0001NY-Ge
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Aug 2023 00:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=; b=lIoSSAQwHxGiamXbYYA7+O8lkJ
 dyGAxNO1fQX/6MsgVjmE2AiHP+aSlSwaWtjNM0SNCwzjlarMrq5gz5JEE1P/M778iTBDq7yCbXvYn
 vZFVsMEgjgytL5OlsUwW36gmmC1SmfgNqLrLWKTxXLEMFJqfVneDcnrgYwRo2PdI7Efo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=; b=EqiTcnbXipyin/KEaLTadiI6xa
 K1EfVXf4tiy7kijqqcsHyH1RxGuMsPPPUfWSwFs2kQ/87V9MtzYlFRiaE+DNRasL1M9ykoPFI/i4U
 GfpKqNYFdHOEgs90ZpO95Jpvu4G7r2bHKC08VdZ/u2qMzW1bbUiqe9IEj7MJ3C+40vMk=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qUchj-0002eA-5h for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Aug 2023 00:42:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFB4D1F385;
 Sat, 12 Aug 2023 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691800915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=;
 b=WPNMe74pRP9y1F4AfbMzA7v1wLaAk+rqQH4j7Fc2IBMN/lncSw4YpqM716vOqVqmsL7zjC
 AELb8iIU2hVGEdbcS6eTnI4op/H7W2sNkgx3DZnAXSs3b+rQnvpI0LT10+cr/UoQdkIIUP
 928H4kORANFovpX4ZSoZPfMpbAgCLKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691800915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gc3ImIlvvNAlNv89w2x2DqtkUeFquTvzH0e1HxxlakQ=;
 b=7bO/NmKNxiJ/5BFD5zAPqsdas9fCtjTJzsBfJlhynDqUada/lYz9mNV5xKH3cMHPZTSPUK
 9jxi+CQumQORzSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B712213592;
 Sat, 12 Aug 2023 00:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TcJ7JlPV1mQLEAAAMHmgww
 (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:41:55 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org
Date: Fri, 11 Aug 2023 20:41:37 -0400
Message-ID: <20230812004146.30980-2-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1qUchj-0002eA-5h
Subject: [f2fs-dev] [PATCH v5 01/10] fs: Expose helper to check if a
 directory needs casefolding
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
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In preparation to use it in ecryptfs, move needs_casefolding into a
public header and give it a namespaced name.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c         | 14 ++------------
 include/linux/fs.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..8d0b64cfd5da 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1381,16 +1381,6 @@ bool is_empty_dir_inode(struct inode *inode)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Determine if the name of a dentry should be casefolded.
- *
- * Return: if names will need casefolding
- */
-static bool needs_casefold(const struct inode *dir)
-{
-	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
-}
-
 /**
  * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
  * @dentry:	dentry whose name we are checking against
@@ -1411,7 +1401,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	char strbuf[DNAME_INLINE_LEN];
 	int ret;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !dir_is_casefolded(dir))
 		goto fallback;
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
@@ -1453,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	const struct unicode_map *um = sb->s_encoding;
 	int ret = 0;
 
-	if (!dir || !needs_casefold(dir))
+	if (!dir || !dir_is_casefolded(dir))
 		return 0;
 
 	ret = utf8_casefold_hash(um, dentry, str);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6867512907d6..e3b631c6d24a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3213,6 +3213,27 @@ static inline bool dir_relax_shared(struct inode *inode)
 	return !IS_DEADDIR(inode);
 }
 
+/**
+ * dir_is_casefolded - Safely determine if filenames inside of a
+ * directory should be casefolded.
+ * @dir: The directory inode to be checked
+ *
+ * Filesystems should usually rely on this instead of checking the
+ * S_CASEFOLD flag directly when handling inodes, to avoid surprises
+ * with corrupted volumes.  Checking i_sb->s_encoding ensures the
+ * filesystem knows how to deal with case-insensitiveness.
+ *
+ * Return: if names will need casefolding
+ */
+static inline bool dir_is_casefolded(const struct inode *dir)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
+#else
+	return false;
+#endif
+}
+
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
