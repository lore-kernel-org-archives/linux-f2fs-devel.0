Return-Path: <SRS0=dtVZ=C2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4FFC433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2020 04:13:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A93522204;
	Thu, 17 Sep 2020 04:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VqHSgf42";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="G3DSyQN3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBiN5rds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A93522204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kIlIo-0002wi-Vc; Thu, 17 Sep 2020 04:13:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kIlIb-0002v3-Sg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 04:13:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AGEkovunS7dU2Ykk0C3iWfQOmlfDqLZBafXQ/zScJJ8=; b=VqHSgf42fkgDaozKsJWUH0c7nO
 /NhN3LEcwmJntUP1USksBqJ2an2eZhGROkFV9QNAbOANAX1OdfYopnGbAqieRaOQozKio7D5hVDoh
 WLBEgUMzfTvE6C0Qef/lbQJ4ZdHdPQmLg2kHpCSjuElfi0/nLNaLR0mUT8jVtjqXhJIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AGEkovunS7dU2Ykk0C3iWfQOmlfDqLZBafXQ/zScJJ8=; b=G3DSyQN3yUx7CD7NP82rC/km5L
 wU+K/hej/SI+QjCAwMMqPVg/KwdKohxGB9A9mCwqjMXNVTAIvZ4MFAIwB6aP5J4XyjFH176XeiZ5I
 9L2Yjfj9bRHmY8XZDo/ghfELwEvSZWm0qRSjrv2n9l3th9xvGQviQ2jFMlTFhXP6RM+s=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kIlIY-00DZe6-As
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Sep 2020 04:13:33 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29B3521D7F;
 Thu, 17 Sep 2020 04:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600315990;
 bh=ZzMv1pUhY0NvnbJHjrS2ra7ESt6vtXPBJHTWIdsGFCY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rBiN5rdstflHX1It/vJX6MDn0Ra/3t+jyzeqs5yBDq9mOlzDoS5YBNrAfmfXthztF
 I7/1sT0nuq74DNCTvjM6CzObqwT702hidEHtOiXnpFWbZ0K0C5eA4q7LTCh4pikwvV
 0QSOSfG7cfsP3i34K7E+BadmEiPvsm9a882Jz/NE=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 16 Sep 2020 21:11:31 -0700
Message-Id: <20200917041136.178600-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917041136.178600-1-ebiggers@kernel.org>
References: <20200917041136.178600-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kIlIY-00DZe6-As
Subject: [f2fs-dev] [PATCH v3 08/13] fscrypt: require that
 fscrypt_encrypt_symlink() already has key
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
Cc: Daniel Rosenberg <drosen@google.com>, Jeff Layton <jlayton@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that all filesystems have been converted to use
fscrypt_prepare_new_inode(), the encryption key for new symlink inodes
is now already set up whenever we try to encrypt the symlink target.
Enforce this rather than try to set up the key again when it may be too
late to do so safely.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/hooks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 491b252843eb9..7748db5092409 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -217,9 +217,13 @@ int __fscrypt_encrypt_symlink(struct inode *inode, const char *target,
 	struct fscrypt_symlink_data *sd;
 	unsigned int ciphertext_len;
 
-	err = fscrypt_require_key(inode);
-	if (err)
-		return err;
+	/*
+	 * fscrypt_prepare_new_inode() should have already set up the new
+	 * symlink inode's encryption key.  We don't wait until now to do it,
+	 * since we may be in a filesystem transaction now.
+	 */
+	if (WARN_ON_ONCE(!fscrypt_has_encryption_key(inode)))
+		return -ENOKEY;
 
 	if (disk_link->name) {
 		/* filesystem-provided buffer */
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
