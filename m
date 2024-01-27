Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D98AC47422
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Jan 2024 00:11:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rTWHo-0007zI-5H;
	Sat, 27 Jan 2024 00:11:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1rTWHl-0007yl-RI
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jan 2024 00:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=; b=gVzvfbMZBfTAt6+MDjmTDN8T+G
 1umpHroiS1ceB5zqjjfB9FODIDFo3TXCk/7VHrHvUOzSmh5Iw70Skd6niyoV5gCZgimZJtuHFDG3B
 7C1qyol61ql9pMURnqsFQ/Z8bD1GYYyZXyD6FHPJeu4RtExL0S6qYX7Ix3zpwW/FghaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=; b=KaM8qaMSPSQdwycBK+4+yu5ufs
 R11HkEGOyReAS9KX9dNBZxUuav/5iLaSCzN8kP2L3Iz8zUl0Mc56IigtYjmWyFmJB9Prh4Oo6/mBr
 6LYgpwkdyFYNoyjFL+yMfVMoAQ3ETw6QCCq9FBkL2yUEnEJfbbFgFDt7MJUJC5h+OEdo=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rTWHk-0006vu-5U for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jan 2024 00:11:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C482239F;
 Sat, 27 Jan 2024 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706314249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
 b=O8t7KyvcpU78x8YMMV4nnTSEJWGCM62S4OSB2Mn+Z4V3J/GU4QnHPKbAxaXSEqyBn/V6/4
 YLMGc3KmJ85K7RZ5VTno8Mq5zNcshduc0WSTBgRAmDGr1F30r4YWXgess96AqEXz/SLe/u
 e/UzCR242Cws+UzNWNmgWoiy4xhPFnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706314249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
 b=NjCCYKoz9rIUIiidbWjwT7/LP7a3AGpGHudAMPdkA6rVv7YCBnm93EgEg7nyKICfVukAfO
 Fl4TT24O4UyPxEBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706314249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
 b=O8t7KyvcpU78x8YMMV4nnTSEJWGCM62S4OSB2Mn+Z4V3J/GU4QnHPKbAxaXSEqyBn/V6/4
 YLMGc3KmJ85K7RZ5VTno8Mq5zNcshduc0WSTBgRAmDGr1F30r4YWXgess96AqEXz/SLe/u
 e/UzCR242Cws+UzNWNmgWoiy4xhPFnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706314249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7ZNiObuWDS9LBRJ78fuLAlJGd+uQndWdyw51G7pKEU=;
 b=NjCCYKoz9rIUIiidbWjwT7/LP7a3AGpGHudAMPdkA6rVv7YCBnm93EgEg7nyKICfVukAfO
 Fl4TT24O4UyPxEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C268713998;
 Sat, 27 Jan 2024 00:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 82j1HghKtGV2EQAAD6G6ig
 (envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:48 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
 tytso@mit.edu
Date: Fri, 26 Jan 2024 21:10:08 -0300
Message-ID: <20240127001013.2845-9-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127001013.2845-1-krisman@suse.de>
References: <20240127001013.2845-1-krisman@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O8t7Kyvc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NjCCYKoz
X-Spamd-Result: default: False [2.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[17.98%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 69C482239F
X-Spamd-Bar: ++
X-Headers-End: 1rTWHk-0006vu-5U
Subject: [f2fs-dev] [PATCH v4 08/12] libfs: Add helper to choose dentry
 operations at mount-time
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
 amir73il@gmail.com, Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In preparation to drop the similar helper that sets d_op at lookup time,
add a version to set the right d_op filesystem-wide, through sb->s_d_op.
The operations structures are shared across filesystems supporting
fscrypt and/or casefolding, therefore we can keep it in common libfs
code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

---
changes since v3:
  - Fix typo in comment (Eric)
---
 fs/libfs.c         | 28 ++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index c4be0961faf0..0aa388ee82ff 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1822,6 +1822,34 @@ void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
 }
 EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
 
+/**
+ * generic_set_sb_d_ops - helper for choosing the set of
+ * filesystem-wide dentry operations for the enabled features
+ * @sb: superblock to be configured
+ *
+ * Filesystems supporting casefolding and/or fscrypt can call this
+ * helper at mount-time to configure sb->s_d_op to best set of dentry
+ * operations required for the enabled features. The helper must be
+ * called after these have been configured, but before the root dentry
+ * is created.
+ */
+void generic_set_sb_d_ops(struct super_block *sb)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb->s_encoding) {
+		sb->s_d_op = &generic_ci_dentry_ops;
+		return;
+	}
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	if (sb->s_cop) {
+		sb->s_d_op = &generic_encrypted_dentry_ops;
+		return;
+	}
+#endif
+}
+EXPORT_SYMBOL(generic_set_sb_d_ops);
+
 /**
  * inode_maybe_inc_iversion - increments i_version
  * @inode: inode with the i_version that should be updated
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e6667ece5e64..c985d9392b61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,7 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern void generic_set_sb_d_ops(struct super_block *sb);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
