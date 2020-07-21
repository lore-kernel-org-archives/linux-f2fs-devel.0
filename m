Return-Path: <SRS0=FAg2=BA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F779C433E4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:11:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A1D20720;
	Tue, 21 Jul 2020 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VAkiA7og";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="AmEEEOoq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO4W9ZhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A1D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jxwk4-000210-1F; Tue, 21 Jul 2020 18:11:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jxwk2-00020s-BM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 18:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ttBIJ28xeHugc9JQ1ThOCtLbAxu2p+wFZVwsnXeonKY=; b=VAkiA7ogVfflvQNA1v+S12wPGi
 GoC2wfQdBzm886m83P4Z68OSF6taIZqwlNn0OrJPoVU/7JSA9UuQx5ebO474G14XM1fbJz0xjFqx5
 fKD5DQ+fUbinjbIvikZnCDlUMfF/7MfQqSeRYMdNHsr+Dq+YMImjIQJiCNf6NT7sgw5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ttBIJ28xeHugc9JQ1ThOCtLbAxu2p+wFZVwsnXeonKY=; b=A
 mEEEOoq8owjiib9WJnKvyDi577Ii42xsz/Kjz30BTrnjME3aoVLFvJiO/vuxq8XZWVvVjfyqOYvHK
 Y1JpKXBVyOzthEcGUUDM7Aco67P4ud5yrfOVUtokPq2R0cdCN9nv+OkTEmiOepMC/dBQOkzKIldeC
 clyYAzXnSld0mQ8Y=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jxwk0-00CQCZ-Db
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 18:11:50 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91CAF20720;
 Tue, 21 Jul 2020 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595355095;
 bh=8PmokV2OOLmhOJcGzxltydoC6SNc4ybchJ4kJJykcWM=;
 h=From:To:Cc:Subject:Date:From;
 b=kO4W9ZhKEjO67C15PxdhGd0mkQ4ex6CD4DjfWXWPsgSgIbHe4fJG7yGUMOTdvC5lF
 XsRirzo70YHXKkubXVARHQf+brNyq9xgFikJwXiEGCVZ4/C0mB1EIZl9kk4HqOYB9/
 3SVtABIpfYg/BronmpYSvNUciJR0vU/pTxWHv9eM=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Tue, 21 Jul 2020 11:10:12 -0700
Message-Id: <20200721181012.39308-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Headers-End: 1jxwk0-00CQCZ-Db
Subject: [f2fs-dev] [PATCH] fscrypt: restrict IV_INO_LBLK_* to AES-256-XTS
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
Cc: Satya Tangirala <satyat@google.com>, Paul Crowley <paulcrowley@google.com>,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

IV_INO_LBLK_* exist only because of hardware limitations, and currently
the only known use case for them involves AES-256-XTS.  Therefore, for
now only allow them in combination with AES-256-XTS.  This way we don't
have to worry about them being combined with other encryption modes.

(To be clear, combining IV_INO_LBLK_* with other encryption modes
*should* work just fine.  It's just not being tested, so we can't be
100% sure it works.  So with no known use case, it's best to disallow it
for now, just like we don't allow other weird combinations like
AES-256-XTS contents encryption with Adiantum filenames encryption.)

This can be relaxed later if a use case for other combinations arises.

Fixes: b103fb7653ff ("fscrypt: add support for IV_INO_LBLK_64 policies")
Fixes: e3b1078bedd3 ("fscrypt: add support for IV_INO_LBLK_32 policies")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/policy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 8a8ad0e44bb8..8e667aadf271 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -77,6 +77,20 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 	struct super_block *sb = inode->i_sb;
 	int ino_bits = 64, lblk_bits = 64;
 
+	/*
+	 * IV_INO_LBLK_* exist only because of hardware limitations, and
+	 * currently the only known use case for them involves AES-256-XTS.
+	 * That's also all we test currently.  For these reasons, for now only
+	 * allow AES-256-XTS here.  This can be relaxed later if a use case for
+	 * IV_INO_LBLK_* with other encryption modes arises.
+	 */
+	if (policy->contents_encryption_mode != FSCRYPT_MODE_AES_256_XTS) {
+		fscrypt_warn(inode,
+			     "Can't use %s policy with contents mode other than AES-256-XTS",
+			     type);
+		return false;
+	}
+
 	/*
 	 * It's unsafe to include inode numbers in the IVs if the filesystem can
 	 * potentially renumber inodes, e.g. via filesystem shrinking.
-- 
2.27.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
