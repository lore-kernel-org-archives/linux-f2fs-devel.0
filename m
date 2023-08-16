Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2ABC04A94
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Aug 2023 05:08:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qW8ld-0004rG-HQ;
	Wed, 16 Aug 2023 05:08:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qW8lY-0004r9-Rm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 05:08:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvR8t/YzHMWvpnpSVARUorIz3ynKvoiahBpzw9vzaYc=; b=MtUsY+Q+kNvFpr4AgwPwg3G33S
 FdmfxRLKRoi5uFykWOawdbaBk7ZAjXkKQqB67sPh1ixcwAe4kDo1lVpoRigJ84z2e7VUnCQltfhhN
 9TcEIUmpU0bubePcWv+GT2h4SPa2pdKfqY59HHE7OlmG9EZ8SdTa9v/WuCk88iivJBCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uvR8t/YzHMWvpnpSVARUorIz3ynKvoiahBpzw9vzaYc=; b=YJPM+9bLqcgFrIsuF/Gwt0mprN
 2C6ck/WaG/DvcQ5bCw9X900GzdD7Zub8skP33JQfDlYZvp5Fpjlxk3YW6KTxQeZz6oi2Z4kWXzNLK
 rWG0RumuLz4QboytJLvcFnWYUZkM5z2KA9xlAV7hatfYgsFZ06Mi8s7DiJdN3ts8mlCY=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qW8lY-006njN-Iz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 05:08:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FECA2197D;
 Wed, 16 Aug 2023 05:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692162494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvR8t/YzHMWvpnpSVARUorIz3ynKvoiahBpzw9vzaYc=;
 b=Zux8ymEN6jYAuvL/c0gVYquNa1mE2Kro7dZzxPAgeaseIOXV81x3dmwudiFAGaNSwZgnZK
 7UJo/0tuYsA6uFuAmuSWAQ/KnwGz6jnBoECdEpU8o6fAYxqMtKZpl/vPiW9NwM/iQZuJ14
 FxJU0iV0i0iTsUhm3uBDz3T73VHg+mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692162494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvR8t/YzHMWvpnpSVARUorIz3ynKvoiahBpzw9vzaYc=;
 b=A9Fj6h94KbZ2qaU4v8Qg1JupqENww/dmMXlFCKpDigVEqd0ByOd0Gku+v1Z1fq1qeuLmGg
 e5UDav/UuGob1fAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 287D0133F2;
 Wed, 16 Aug 2023 05:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hflUBL5Z3GTkTgAAMHmgww
 (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:14 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org
Date: Wed, 16 Aug 2023 01:07:58 -0400
Message-ID: <20230816050803.15660-5-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1qW8lY-006njN-Iz
Subject: [f2fs-dev] [PATCH v6 4/9] fs: Add DCACHE_CASEFOLDED_NAME flag
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
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

This flag marks a negative or positive dentry as being created after a
case-insensitive lookup operation.  It is useful to differentiate
dentries this way to detect whether the negative dentry can be trusted
during a case-insensitive lookup.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Fix EXPORT_SYMBOL (Eric, kernel test bot)
Changes since v4:
  - Fixup names of functions to reflect flag name change (Eric)

Changes since v2:
  -  Rename DCACHE_CASEFOLD_LOOKUP -> DCACHE_CASEFOLDED_NAME (Eric)
---
 fs/dcache.c            | 8 ++++++++
 include/linux/dcache.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..91e5cd4c4237 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1958,6 +1958,14 @@ void d_set_fallthru(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_set_fallthru);
 
+void d_set_casefolded_name(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_CASEFOLDED_NAME;
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL(d_set_casefolded_name);
+
 static unsigned d_flags_for_inode(struct inode *inode)
 {
 	unsigned add_flags = DCACHE_REGULAR_TYPE;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9362e4ef0bad..ccbb5c4db7ce 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
+#define DCACHE_CASEFOLDED_NAME		0x08000000 /* Dentry comes from a casefold directory */
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
@@ -496,6 +497,13 @@ static inline bool d_is_fallthru(const struct dentry *dentry)
 	return dentry->d_flags & DCACHE_FALLTHRU;
 }
 
+extern void d_set_casefolded_name(struct dentry *dentry);
+
+static inline bool d_is_casefolded_name(const struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_CASEFOLDED_NAME;
+}
+
 
 extern int sysctl_vfs_cache_pressure;
 
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
