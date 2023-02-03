Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F062C64EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Feb 2023 21:01:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pO3BL-0004ff-Ht;
	Fri, 03 Feb 2023 21:01:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1pO3BJ-0004fS-Em
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Feb 2023 21:01:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=; b=ETDwJpWbYlDSJfLDv2NOFKqcXj
 E5jQntWpOxBZekfmtmyjuChRQCK2wmw8wGZNadLBTBf/8XTRwsZYIml1uvFOZHMLnz6PjvnOhMgy5
 1aalaqi7uLJxukmujNhzbx+hYVCYDSTpBO/n+vtkMjPHnVh4Semyc1U4zGhpluHlH49k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=; b=WiFYC+HaSf3sQdqQHSvEzoHkIz
 TsYHPpFO/UlGIrcgQq2MSo0/IjeVxZq9FvNCvM7eL7rgfhDui7vtmyHefrVPsqtDO5geGxhkJmK2D
 cU8eqLhm95kZDPhF6ZNFZ2sDQTB68jMQVvFZmX37p6SzqsqHzfzazqYf7O/G2LF4EJzw=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pO3BH-00ASxb-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Feb 2023 21:01:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC3D5C344;
 Fri,  3 Feb 2023 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1675458065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=;
 b=ce4uKgVbpi/C7iswQ4w2hmqw5AERgDlwLmsxLhsNG9XzA2Cs+yMdYNxuqVqhhivMUaaThu
 DDBrpxmdV2q7iF3Cihhvy5UQbeV8+bGp8qa4ViP4rCK63x/XaexdByB/TcJ5v/LQj7IXNF
 M6BH3fFK8N+3zFpek9wOCWm/ZjWbEDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1675458065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbJ8A7z8OuIv+MdnkMNKw5FRm+lvF7JY4gxwIronnVI=;
 b=oYtHj8ESCbnCzDrWnQsC8plCxvJxONqie2yhTg2S14+cejnGgzdEt3pvquAToiYfDTyXcp
 5QkpH8uOuYWBt9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C9371358A;
 Fri,  3 Feb 2023 21:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xUrWMRB23WP0JgAAMHmgww
 (envelope-from <krisman@suse.de>); Fri, 03 Feb 2023 21:01:04 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
 ebiggers@kernel.org, jack@suse.cz
Date: Fri,  3 Feb 2023 18:00:36 -0300
Message-Id: <20230203210039.16289-5-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230203210039.16289-1-krisman@suse.de>
References: <20230203210039.16289-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1pO3BH-00ASxb-Oh
Subject: [f2fs-dev] [PATCH v2 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Preserve the existing behavior for encrypted directories, by rejecting
negative dentries of encrypted+casefolded directories.  This allows
generic_ci_d_revalidate to be used by filesystems with both features
enabled, as long as the directory is either casefolded or encrypted, but
not both at the same time.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e3daca88d1d3..26a06fd5f5a1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1478,6 +1478,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 		const struct inode *dir = READ_ONCE(parent->d_inode);
 
 		if (dir && needs_casefold(dir)) {
+			if (IS_ENCRYPTED(dir))
+				return 0;
+
 			if (!d_is_casefold_lookup(dentry))
 				return 0;
 
@@ -1487,7 +1490,8 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 				return 0;
 		}
 	}
-	return 1;
+
+	return fscrypt_d_revalidate(dentry, flags);
 }
 
 static const struct dentry_operations generic_ci_dentry_ops = {
@@ -1507,7 +1511,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.35.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
