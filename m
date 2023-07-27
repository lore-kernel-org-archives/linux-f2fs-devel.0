Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD0C04E69
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 17:29:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qP4nV-0004sC-KY;
	Thu, 27 Jul 2023 17:29:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qP4nS-0004rr-LK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 17:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=; b=Hd9pifKcXJaV/Ted75pEUYu5B0
 CNSsFXMIeEfUjCSpdJy+GYJ4uj9aqNGTirgZ/IGvTo9FrCi0+/KqJcaOwcPNcj0LcmFf8Jbnc88tG
 9vHubvvSzxpfW1/eoJaNQrsQMlOi0c8WyYIqp+DcAfQ4zJmrk21UfNZdBnUb0dMlY+FU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=; b=DwgjPWRUvHAi105gl3z5+BguZk
 hpCCDQVLE35G36hx6b+p/h8g/Kle5Q8VvG7BYZCWtFPprYsZjiISKxzKOluXOxToJjycpuFlVEAau
 axsJvhMJDARLAIQCGoMT2WYxxDKoagSsCp4pboLpgfUSasMCu8YJdP6hkEQZGvaccW5I=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qP4nN-004oJs-7l for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 17:29:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90E131F88F;
 Thu, 27 Jul 2023 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690478934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=;
 b=rOkOCarpeK0rdsiVu53BMJwMjBjURI+WWOnOImW/UMfOuCT9TxPAtGrQwHEftnWYbGqxRg
 55isdToflB6gjJ4ixZCTnOSxZzMxrHrDlEfYMFWrqXZOrWoU2ecYSafFOovgslzyChnwUy
 zRop+mGW/dMK0Y3qrxvmVYvOFVOKi60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690478934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=;
 b=3EkSCxwp49ojkp/N9SbHUMPFUbhZU0WdMrVNyd2Zz2AeudWjiHNqCePlISR0WkV7KTlm/m
 csvbVWmufulL6zDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B44F13902;
 Thu, 27 Jul 2023 17:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k3HEEFapwmTOaAAAMHmgww
 (envelope-from <krisman@suse.de>); Thu, 27 Jul 2023 17:28:54 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org
Date: Thu, 27 Jul 2023 13:28:40 -0400
Message-ID: <20230727172843.20542-5-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727172843.20542-1-krisman@suse.de>
References: <20230727172843.20542-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1qP4nN-004oJs-7l
Subject: [f2fs-dev] [PATCH v4 4/7] libfs: Chain encryption checks after
 case-insensitive revalidation
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

Support encrypted dentries in generic_ci_d_revalidate by chaining
fscrypt_d_revalidate at the tail of the d_revalidate.  This allows
filesystem to just call generic_ci_d_revalidate and let it handle any
case-insensitive dentry (encrypted or not).

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Enable negative dentries of encrypted filesystems (Eric)
---
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ed04c4dcc312..44c02993adb4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1513,7 +1513,7 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 			}
 		}
 	}
-	return 1;
+	return fscrypt_d_revalidate(dentry, flags);
 }
 
 static const struct dentry_operations generic_ci_dentry_ops = {
@@ -1533,7 +1533,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
