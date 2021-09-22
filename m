Return-Path: <SRS0=RrLa=OM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AABC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Sep 2021 15:27:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B35660F21
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Sep 2021 15:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B35660F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mT49f-0003Ov-OT; Wed, 22 Sep 2021 15:27:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mT49e-0003Oo-Sw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Sep 2021 15:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ha/QDIzTLuWoK7zr1at00zvswB851ryXVplCGrP5cYg=; b=LDt0NIDfwDB5SPQSAqA33j1q+d
 YyukGVf+xMF2rJqYHSuFqboSQLGRK3m8IxMP7Qr8HI32ClLty+zP4b0xYEqGIvjrhHvv2CIq+L8Vr
 lSlbCe/e55Xwg4sFeEIJCD0UL5zwzNKYU8zShQF8FRkxcme1k3xEjcvPuBejzT2siYCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ha/QDIzTLuWoK7zr1at00zvswB851ryXVplCGrP5cYg=; b=D
 coem/bvxqhZM2uXeVJmdwvkQE7Pu5+QHt/nRgwadAKMZbvZnXxPpTkEs7kn8MVQ4mL+rTjfDfwk/Q
 1Axcjwc+Jzf7JfIIeXEOS1RKsPYMZ3LB2Wzq2ibSW8hYx/cVVhb1HuKYi6xPAvDA9Yk+j0IWhs4Zs
 44OhFPQFbrqtG4Us=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mT49e-001maE-8G
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Sep 2021 15:27:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E34861168;
 Wed, 22 Sep 2021 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632324440;
 bh=ovV4urk3GlFS7e1HLPM5jlLAOz+tjnV1IqgTo1O9svM=;
 h=From:To:Cc:Subject:Date:From;
 b=eo05KFjBJaxgt7DoeZ/1sjWOZ8jeiyUiibfEP585IltwSmx02D5s0T9vTTRjzA5KF
 1NAtUYGs5CDz5qQFFtVoaIi2DX3oKxjRaHWCfvigLHIoJigYPdP57xQIM9FOSL3Oii
 66Y6scUdY3RnAoXEtsaS6p7DRmLAKfpQV8JkYrGN9g28EfJVQcO+I2Nhr68luqz3Z6
 X3SRx0onTuETYf4+aDEOiB8xD9WHZi3t4GtGkUUkSXCvGj1wzJch3YDe2XBqj1QNGd
 lK2ePpoEKzkzj1kBE9VLwOBUqPiSfaJKhWVZmsTWvCHQNWngeRyT62tEVaigvqS4+6
 8zScPDUctzjZQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 22 Sep 2021 23:27:05 +0800
Message-Id: <20210922152705.720071-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mT49e-001maE-8G
Subject: [f2fs-dev] [PATCH] f2fs: fix incorrect return value in
 f2fs_sanity_check_ckpt()
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
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As Pavel Machek reported in [1]

This code looks quite confused: part of function returns 1 on
corruption, part returns -errno. The problem is not stable-specific.

[1] https://lkml.org/lkml/2021/9/19/207

Let's fix to make 'insane cp_payload case' to return 1 rater than
EFSCORRUPTED, so that return value can be kept consistent for all
error cases, it can avoid confusion of code logic.

Fixes: 65ddf6564843 ("f2fs: fix to do sanity check for sb/cp fields correctly")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8d6d0657a470..e3975cb8e3e8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3487,7 +3487,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
 		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
 			  cp_payload, nat_bits_blocks);
-		return -EFSCORRUPTED;
+		return 1;
 	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
