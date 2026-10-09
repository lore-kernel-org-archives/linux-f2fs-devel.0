Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497EBCA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JZ51zLM+RxAUqM8rd/HXMc/grVFH8Dhd35EupX3Bpao=; b=dlbwDhFy6y7KoN0Ut4oiJBM6u7
	lF7R+1pzHwwzlFvhKWfCs1AyVXbIrRbmcV5/FoskTza+VGU63gWfaksg1kLm1QGEAlUyEUUtYiqTM
	bafj5gMJctf2pNB14Ebmsp8PdUPLCYaPOcvS+fzj+EBC2OljgTrnrZzMR4Y2MB55P4ZY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF1gP-0003ve-9n;
	Fri, 09 Oct 2026 03:54:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xF1gO-0003vV-AN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 03:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iTv62O+i0V/5mafMWrJRbaNT9UDYAejB8Uyj1t+bCdE=; b=QQxATgjX2BWCj/EEgSdTbMMd2B
 ZDgHTjCn4/PLyT/sgiob6wns0YyvP5azM0ruqt8rLmYiLBlTU2skLcK2ld+pEJ1cvQUsIJo+IC4Ps
 iPEHr5+QmginivRwfpBxxLQpMgOc7DiMRec8HcP2M1P0NrSmlYABSH8hg9KecdlAsEtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iTv62O+i0V/5mafMWrJRbaNT9UDYAejB8Uyj1t+bCdE=; b=l
 Dp120hvJzIaACi4TE16mAo88DTkIcJnqZI/c/r5HhnfHt1rgOungUmstize1xJxfPlSz9zR2+7vEb
 VudNR2ntK8WtSOIXgDfNaW07wRMFVEwaz1LTqYd/+ZcPDxSqnDAmfxYqSgEFjqgs4t6BTMA5StN/v
 gIithcYMwCu1izY0=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF1gN-0004Ni-Qn for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 03:54:08 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-873a4edb243so4318395b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 20:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791518042; x=1792122842; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iTv62O+i0V/5mafMWrJRbaNT9UDYAejB8Uyj1t+bCdE=;
 b=ITZakoszgANaV3LXAyzQN2WSRuFCm+awjPyD5dR/pVS/l+q6/cVR3wwY6403VD/UY9
 r40wD1HVGbJXlj7/1zV6P/2UWV9Wacc2dM5FIj0hMQ120MNogZznWg9PASrX8k1ijKtG
 m46V4AoFGCW1Dph6CjUFxa4rbW1wzVmqpFQ5rUN7ewwf/xboV/wc+FDspF4ebU5B02gM
 yyrpB2nIMLuHgwb6jwK+717TQVIme0mHu8XXALmrOfjhjbtXfEyCncQER6Fo/0uEjCmG
 OeyR0QxWknHPRoFRQ79gTLfZY3nKfTR90avWD0ntXLQKbKoPZz6m/P7Bfjrp+dnYttSg
 VLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791518042; x=1792122842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iTv62O+i0V/5mafMWrJRbaNT9UDYAejB8Uyj1t+bCdE=;
 b=mYywB074zUZ9gUqzTeD3YwEiC7aWMlilN7Z1BwXA37NBQL5fo51rHOWMjpqFVpz0XN
 91BseXDxTq8aPiu4neBe4MhRwLZoomA/kx/qYYwM21DJW9Ct5XEQcIoYyUP9rqvleCfb
 /cIflRw6S1R2ooBHAELh84+XpHCk8Gm8X5rXybX4brxR5ycKh+PSTEoHsAh8036n6QFc
 G56iEzGIbjSmTu7jFt7ZpTR3K3qem97+k/cWCVudA1Xzo/wMkWytvZ25Szqb+x2qkoR2
 Dr4kvC9qFMKVXBVlN13xsBF/tneHE4rTi/fnEDSD5x7PPjfgmX3eWy4x68OY97LmPYBG
 f6dg==
X-Gm-Message-State: AFq9FYKMc2QIL0pTGflI61UU50am77Lspb2WLI7zJ3RUd92DlFjvFBHE
 qaEG0sbEpqSv8XBOKVlHjsIinTodSToa88/1H6F5azpqCGnOzu3iud2g
X-Gm-Gg: AYBFou2eNVDWTUEPEsBcEilB5q5evYFBL8/50c68aCEZ0EzeamcqJ1pSsZWpNjlrPgq
 O7U3WLl8BxGW/fsHW3k/DSBsinFItsP9xVb27fyMuIOMClFRUHoj5/koWbq4Xk526yLi1vNBPb7
 XEU1rm9wN63d61vk86D4BnRLdjCehgF9D4dLEk0KiEGJwTMFcxQV/LkWHQy4g+qIXeksihGfzy6
 0GZhkznRy7u3Ipv1Af+FHfcj26lRs0NtN4IQB618aPjOLyNgnVvhWSvmoDhM1TT7L0PdSDOtndV
 8JRbwCOKmDLPlxG5mCYa+/2CedvMO5cc3Jy6TbRuLc2dIe6SpInCRXWSmUSieMN5/tdJulc7xeZ
 lepaFQpBxxq/1ekzLW0Pq1th7/hrzc391vqmrCxVClwviZCCw1Uzclbnahhg7JgUpHT1O1HLaYe
 X9bcDAU7smPssjxH2O86rthZMtRkbrEjXm+US7jgjiD7XOyA5XxdgLhde9hkC17AXMvi1O/v7Js
 PBUD2H0rT3PODthKha2+FchOdxYPwefXOQ=
X-Received: by 2002:a05:6a00:9508:b0:881:a5b6:7954 with SMTP id
 d2e1a72fcca58-897c7cd4565mr540962b3a.39.1791518042044; 
 Thu, 08 Oct 2026 20:54:02 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-897ffffd763sm33882b3a.1.2026.10.08.20.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 20:54:01 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri,  9 Oct 2026 11:53:54 +0800
Message-ID: <20261009035354.3330915-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xF1gN-0004Ni-Qn
Subject: [f2fs-dev] [PATCH] f2fs: avoid cache writeback busy loop with zero
 thresholds
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When both cache writeback thresholds are zero,
f2fs_should_wake_up_cache_wb() returns true even with no dirty caches.
This makes wait_event_freezable_timeout() return immediately and the
writeback thread busy-loop instead of waiting for its periodic timeout.

Return false when both thresholds are disabled so periodic writeback
can proceed without busy-looping.

Fixes: d7f084b1ad93 ("f2fs: cache: wake up f2fs_writeback when exceeding threshold")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Based on f2fs/dev-test at ce439a2b0690.

 fs/f2fs/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index c76c4660606c5..88d4e479c8469 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -740,7 +740,8 @@ static inline bool f2fs_should_wake_up_cache_wb(struct f2fs_sb_info *sbi)
 	    nr_dirty < cache_thread->cache_wb_dirty_threshold)
 		return false;
 
-	return true;
+	return cache_thread->cache_wb_total_threshold ||
+		cache_thread->cache_wb_dirty_threshold;
 }
 
 static int f2fs_cache_writeback_kthread(void *data)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
