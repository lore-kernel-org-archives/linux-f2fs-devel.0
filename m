Return-Path: <SRS0=YCmm=OT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59195C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Sep 2021 03:05:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F5F61350
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Sep 2021 03:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12F5F61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mVPuG-0007Gh-1G; Wed, 29 Sep 2021 03:05:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mVPu1-0007FQ-J4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Sep 2021 03:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uE06sabfWrwza96gT3c2V/AWCfa9bmEuJZvysAZ5tig=; b=LR+FJ6pllYcS5hwUiqHjXxBH7C
 Kbj3hyVjjrW6rObdmHtHFUd5XR9m6xzksjIV8nrxBbFSgvHqu+BNgWx37i4jubghcsaXI6FElha2p
 cniYwekzenW2gt138llOZXUcIDQVtOkJZs4le3wXdzwVsyAsVtLoIb+9OU0ml2TOsXv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uE06sabfWrwza96gT3c2V/AWCfa9bmEuJZvysAZ5tig=; b=F
 wtJfpFTzN1ulpX4/mbFI0ZS4AGz80Y6U0SxxFGGIX92NUH/4iISLdRhg6r8gpJp4cBC8BPpZjtbYv
 tsF0/LYc31/ajcLe6Grlb0S2wXTJI8pnNlUYp+2eRBZnD3K5kioLNqHuO9vU00IYMlejGRd3KxHUn
 cIZizSHffuG8C3p8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mVPu1-00020s-2T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Sep 2021 03:05:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB16E60F24;
 Wed, 29 Sep 2021 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632884695;
 bh=uKx3+P8SRHdwUFZd8YkUrLhfkgvBsO4avEN5WkWhal8=;
 h=From:To:Cc:Subject:Date:From;
 b=YPKRJcNJJzmNlIcaWZYinxzw9mR9AUIlcy22F8bmZJuR9QaQTEoTyzOi05t17eqiG
 fRuIL/fLZtlMYt0trt0S+o34hmAHrvEhru+4JES+lFpyKk0oMVwKF+ZvyH87KhYhTc
 WPXGcmM8haAiUl82AAS4LFw2bQpBIoa3chNJPyXtydvkyA7ZG5HuXhFeXxlF5VfC1q
 c/g/hVtKvQ9/9guoD2ol1SG7crcEUWvt68cbNJ46vhR9n+n5z3zlXt7qCVW62B1cVU
 7Zb4cbyCpNLpzceiTQx+PBlH3dRjoXDmrssKAeVvg41aFYK1E00pjChIBLLRgOmREg
 zf00tkJycMJaw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 29 Sep 2021 03:19:14 +0800
Message-Id: <20210928191914.32845-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mVPu1-00020s-2T
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong condition to trigger background
 checkpoint correctly
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_balance_fs_bg(), it needs to check both NAT_ENTRIES and INO_ENTRIES
memory usage to decide whether we should skip background checkpoint, otherwise
we may always skip checking INO_ENTRIES memory usage, so that INO_ENTRIES may
potentially cause high memory footprint.

Fixes: 493720a48543 ("f2fs: fix to avoid REQ_TIME and CP_TIME collision")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 53c7fa8f348c..f2473776c9e1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -587,7 +587,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		goto do_sync;
 
 	/* checkpoint is the only way to shrink partial cached entries */
-	if (f2fs_available_free_memory(sbi, NAT_ENTRIES) ||
+	if (f2fs_available_free_memory(sbi, NAT_ENTRIES) &&
 		f2fs_available_free_memory(sbi, INO_ENTRIES))
 		return;
 
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
