Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F08C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Dec 2023 00:05:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rDZEk-00026Y-K5;
	Thu, 14 Dec 2023 00:05:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1rDZEj-00026P-Qt
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Dec 2023 00:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=; b=ES4SynoeoEgxf3+nzP5Nn5uRin
 75LRHPejoCad0XfQfrinCpxidj5kJKvoZtdTM8CU2l1V38ApdxfHSsBzuUsAG4eMsS/JPjj9u9R0A
 3IvTfu5WBhHPtigKwTFpAhssJg6ohlwp15kAJ3In7SCLbJt89dNP5e9TVqi8zmELvjEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=; b=aqWb5ffnYOKkRnYZgwOwikxTHN
 xnCD9xFBZzfmJbLcFglc5me79MyV0QDubczZ6zZQQJ9L7Kp97sQXCaNzD0tgk4FTlcSsx1qEoZvkw
 imTWOWl7AcfBCSBH0UzTiLnuALBWWA6nC2vsZqKV0iz2JPStLMoA2omPtCUywb8rHUq8=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rDZEf-00084l-F7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Dec 2023 00:05:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED091F78D;
 Wed, 13 Dec 2023 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702510841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
 b=DTcCefQyx55pwmL2mGR0MioA8apjC56cyXfk2vmBVnRWw8plloJ0H4aRv8Zg7A1QvuGiLg
 E0Fn5HfJ+IryBDFwP0A9mNQ9lhHGYUS8fMTMYKi+B4dihu2p5WGw3i7zhs7mJnUDOzAzvs
 5jZ2h+QV2B/BPn9bN4XYiaFv7DxDIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702510841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
 b=0keUagkY9BeVDBral8DE309qVmkAahULA87OHFvpChAXnthK972UkaI1+BHl+zBK7/+UC0
 fVmasfbAKqkKkFAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702510841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
 b=DTcCefQyx55pwmL2mGR0MioA8apjC56cyXfk2vmBVnRWw8plloJ0H4aRv8Zg7A1QvuGiLg
 E0Fn5HfJ+IryBDFwP0A9mNQ9lhHGYUS8fMTMYKi+B4dihu2p5WGw3i7zhs7mJnUDOzAzvs
 5jZ2h+QV2B/BPn9bN4XYiaFv7DxDIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702510841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
 b=0keUagkY9BeVDBral8DE309qVmkAahULA87OHFvpChAXnthK972UkaI1+BHl+zBK7/+UC0
 fVmasfbAKqkKkFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3271377F;
 Wed, 13 Dec 2023 23:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iYN9LPhAemVhPgAAD6G6ig
 (envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:40 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, ebiggers@kernel.org, jaegeuk@kernel.org,
 tytso@mit.edu
Date: Wed, 13 Dec 2023 18:40:24 -0500
Message-ID: <20231213234031.1081-2-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213234031.1081-1-krisman@suse.de>
References: <20231213234031.1081-1-krisman@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Headers-End: 1rDZEf-00084l-F7
Subject: [f2fs-dev] [PATCH 1/8] dcache: Add helper to disable d_revalidate
 for a specific dentry
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

Case-insensitive wants d_compare/d_hash for every dentry in the
filesystem, while fscrypt needs d_revalidate only for DCACHE_NOKEY_NAME.
This means we currently can't use sb->s_d_op to set case-insensitive
hooks in fscrypt+case-insensitive filesystems without paying the cost to
call d_revalidate for every dentry in the filesystem.

In preparation to doing exactly that, add a way to disable d_revalidate
later.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/dcache.c            | 10 ++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..1f5464cd3bd1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1911,6 +1911,16 @@ struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 }
 EXPORT_SYMBOL(d_alloc_name);
 
+void d_set_always_valid(struct dentry *dentry)
+{
+	if (!(dentry->d_flags & DCACHE_OP_REVALIDATE))
+		return;
+
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
+	spin_unlock(&dentry->d_lock);
+}
+
 void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 {
 	WARN_ON_ONCE(dentry->d_op);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..d2ce151b2d8e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -225,6 +225,7 @@ extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
+extern void d_set_always_valid(struct dentry *dentry);
 extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
 
 /* allocate/de-allocate */
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
