Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD66C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Aug 2023 05:08:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qW8lc-0000pO-3J;
	Wed, 16 Aug 2023 05:08:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qW8lZ-0000pH-Vq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 05:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZLSJltA607r7xtpPPkkvUfJUZbMcdXItzz2TC+sxABk=; b=WqyHotkYW7gZ7ApIbP4J5cmn/c
 Fjpia8LAxwi0TlAwhhp+svwdlM9J7fs/DzUwtzVsc8kqFtPi4z2IZrZniSfrskyW1WZNr6+0EOEHZ
 FnxYoIHduwNwR+50mU2DCMdAdeJ64EPbOE7kRu8ruB4myV7Fm0jf3UUnlu9SHvH1A7eI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZLSJltA607r7xtpPPkkvUfJUZbMcdXItzz2TC+sxABk=; b=M7l436U6sar13N8AJ76+X20pYV
 E9NUgvK/UcJEtM0cIgDoCUQE03LsbzwFyJwd7b8VBNDJCbhcuGUXSBRyUk3ffq/gQJdF7TUpk+Mwp
 pJCjSNIWt12XR/Hc1/kc1gbQkiZE6r/FAUDWdBA9n9Cva1R5rwC7kh2qiB69zwWZ9A8U=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qW8lX-006njI-29 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 05:08:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6571F74C;
 Wed, 16 Aug 2023 05:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692162491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLSJltA607r7xtpPPkkvUfJUZbMcdXItzz2TC+sxABk=;
 b=UXCPOlBQfl0uX0Z3GW1I23JInEVamvazeasPJM5I/PnETBSB3pdBpRXeqTvgS7uiarx4Vh
 7as5Wg4S+egZci0DAjILoEUCIDYdk04FH3crvrQ+hGK3mLmBaGZkht+SnYkZpqgtK3Neyg
 01fIrB6LU6LVXtYCpmeS87NsTuI0Dqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692162491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLSJltA607r7xtpPPkkvUfJUZbMcdXItzz2TC+sxABk=;
 b=MXEFtInMMgcdw24DHLLbuC3HDv00crA8yG58I9y56jWtX/mnueEvRMIckOx5s/a7Wt/C8M
 Q+dAmSQ+YJ3urkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3FA5133F2;
 Wed, 16 Aug 2023 05:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zKPBNbpZ3GTcTgAAMHmgww
 (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:10 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org
Date: Wed, 16 Aug 2023 01:07:56 -0400
Message-ID: <20230816050803.15660-3-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1qW8lX-006njI-29
Subject: [f2fs-dev] [PATCH v6 2/9] 9p: Split ->weak_revalidate from
 ->revalidate
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

In preparation to change the signature of dentry_ops->revalidate, avoid
reusing the handler directly for d_weak_revalidate in 9p.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/9p/vfs_dentry.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index f16f73581634..0c6fa1f53530 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -94,9 +94,15 @@ static int v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 }
 
+static int v9fs_lookup_weak_revalidate(struct dentry *dentry,
+				       unsigned int flags)
+{
+	return v9fs_lookup_revalidate(dentry, flags);
+}
+
 const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
-	.d_weak_revalidate = v9fs_lookup_revalidate,
+	.d_weak_revalidate = v9fs_lookup_weak_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
 	.d_release = v9fs_dentry_release,
 };
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
