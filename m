Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6DFC47DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jan 2024 18:48:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rQtui-0000LV-GM;
	Fri, 19 Jan 2024 18:48:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1rQtug-0000LL-5l
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Jan 2024 18:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=; b=JvJDrZE899WqCnoOiPHoc1vDTd
 OXsyrWjfgy4Wb4udB+H20es6G8J04G6J38LUyQqGzdncpAS5nZFZYG5sxPkJDSWgRZ3K5tOOZDpEp
 sbEc51PotcGbPCQwI0yMcxVK9KaeY/t3cnP8uyDZCcP6FaTVvpW0SLPYy79SDOSIyvVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=; b=Lt0TrCZW3JZucrVHbXa9pAEYQg
 isa9Q1nqeQBfy5emOtZd/c5OugGEUXGqtgAw1WMRM8D7gzeaVmC+1WqgTCxSilmPCYNJBWgT6LOeD
 1vEOgYMDfLArNuf/lrdMaEvGuZk/xOF3fBXd2iFD8O85N2MXRYMihkVLzuVy5aL1xJMk=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rQtub-0001at-40 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Jan 2024 18:48:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4906E21FBA;
 Fri, 19 Jan 2024 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705690086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
 b=yTB6iGVTtAKVjDSux6UHrYx7magPfOqOABjcRFOfaeg8vufI6w78rY/hln+hc2MC2rCuOS
 DxWrsuM9DgodEomoAlYTPJa5DWTD9VRKXxpZQigbwuXdBN/9wGBKSFMQ8CrOENp+Qi3mX1
 ZQRKfk3E1bFD7NkTucPf+2R6GadPC6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705690086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
 b=HGnckEejwWeYgmdjAfxABzuiLKczXOtzBsUcs6lQqJevyNXkrSH1IJyBwALuqI+ddCWMoM
 6A/wGdv4EKaADjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705690086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
 b=yTB6iGVTtAKVjDSux6UHrYx7magPfOqOABjcRFOfaeg8vufI6w78rY/hln+hc2MC2rCuOS
 DxWrsuM9DgodEomoAlYTPJa5DWTD9VRKXxpZQigbwuXdBN/9wGBKSFMQ8CrOENp+Qi3mX1
 ZQRKfk3E1bFD7NkTucPf+2R6GadPC6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705690086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icfpDa9cQWSMCJ3qgTlqcSwaA2iZOw9bqJdb6XgXsH8=;
 b=HGnckEejwWeYgmdjAfxABzuiLKczXOtzBsUcs6lQqJevyNXkrSH1IJyBwALuqI+ddCWMoM
 6A/wGdv4EKaADjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD995136F5;
 Fri, 19 Jan 2024 18:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gP1SHOXDqmVEDAAAD6G6ig
 (envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 18:48:05 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, ebiggers@kernel.org, jaegeuk@kernel.org,
 tytso@mit.edu
Date: Fri, 19 Jan 2024 15:47:35 -0300
Message-ID: <20240119184742.31088-4-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119184742.31088-1-krisman@suse.de>
References: <20240119184742.31088-1-krisman@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.18 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.08)[88.02%]
X-Headers-End: 1rQtub-0001at-40
Subject: [f2fs-dev] [PATCH v3 03/10] fscrypt: Drop d_revalidate for valid
 dentries during lookup
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
 linux-ext4@vger.kernel.org, amir73il@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Unencrypted and encrypted-dentries where the key is available don't need
to be revalidated with regards to fscrypt, since they don't go stale
from under VFS and the key cannot be removed for the encrypted case
without evicting the dentry.  Mark them with d_set_always_valid, to
avoid unnecessary revalidation, in preparation to always configuring
d_op through sb->s_d_op.

Since the filesystem might have other features that require
revalidation, only apply this optimization if the d_revalidate handler
is fscrypt_d_revalidate itself.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/crypto/hooks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 41df986d1230..53381acc83e7 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -127,6 +127,15 @@ int fscrypt_prepare_lookup_dentry(struct inode *dir,
 	spin_lock(&dentry->d_lock);
 	if (nokey_name) {
 		dentry->d_flags |= DCACHE_NOKEY_NAME;
+	} else if (dentry->d_flags & DCACHE_OP_REVALIDATE &&
+		   dentry->d_op->d_revalidate == fscrypt_d_revalidate) {
+		/*
+		 * Unencrypted dentries and encrypted dentries where the
+		 * key is available are always valid from fscrypt
+		 * perspective. Avoid the cost of calling
+		 * fscrypt_d_revalidate unnecessarily.
+		 */
+		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
 	}
 	spin_unlock(&dentry->d_lock);
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
