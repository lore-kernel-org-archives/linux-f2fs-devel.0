Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A32CD37AC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 03:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cOW6R6bV+0cn9hYGDgO1HBD3TsL4BTzmhrWCYe9QntY=; b=Tg7Mii9/jsF4BbfPUly19gGqo4
	UoJtwYU2YypEUITd2vt/96bF0aMbMPUKM9zZpSA5dqr+dsrvL+bjrH5J4UKERTrqWKj6dcUzP1W9L
	hzZZ110UfNAWw24VU2JXH9vav0MKjieQcORELM7oqdlSg6WLETJ9SdoWb5DoXhJl/hEI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wN0V4-0003uR-DP;
	Wed, 13 May 2026 03:43:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3E-4DagsKAFY7CyBB20562B4CC492.0CA@flex--joannechien.bounces.google.com>)
 id 1wN0V3-0003uK-P9 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 03:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=; b=gtIVFpjlbO+UTNH2XfbR76zvxb
 c0RxN1+j0qz/rXq17+F8z7h6uYe1ZsmptXBZap8bThCz1RSqlJsTDNWGSkke0QzIDZlB1GnZgNEAs
 waXvfIgINd1BptTfKjVFaqvbVSJcktpZGG1KL1SgAaJDewSZwHCGXGDKSjLPENEjM9rc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=; b=iY/3vwN8a8fw1LOJ4+QKkRz0HP
 a2lImced+bVdLktheO4LNUMlKCbELIS1Ttxhp2sHJCBB0qGvZvFy2l8r6G2V9xV0U70K2+TQhZkCB
 VGrv6Q2ny/eLLg34yainC4ePSJzNjpBPCrZhZyqSQBhjGYGO3OOjcK54RUWIsvE+M90I=;
Received: from mail-dl1-f73.google.com ([74.125.82.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN0V1-0007Y9-Nz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 03:43:09 +0000
Received: by mail-dl1-f73.google.com with SMTP id
 a92af1059eb24-132d631edaaso17010593c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778643783; x=1779248583;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=;
 b=oaybTh9wfhzGcljum11wlFEuV/jvXtdYHaU04e/Uge+gMCbIcd5JBZPwHbtVrycEDa
 14lxmOhJDscQubTRK9rg6qB4SpGM7r36WknXqcimsm85XpLHeHMl/UZORMYFK6DKty3/
 g/hiXTkfqVAp5f3OSNYEa+xaH2QL6B5zQxsa4FB1121vrqumATZ7A0t2+/5Skh7D96Uf
 UpH4aJW74bhS2u9df4T1ghh5iCzDujrnbgusKT/a7+2p+XV+8QYH6q7gapC9eiJy0BkB
 KEz6Vw2QeAalvL4mwkPG/Np0F07Ld4ChYyBH8AsCJQp8Onts8tdvFBkegynonE1/k+81
 e9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778643783; x=1779248583;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy+ToJ6n0jT+Y90zlSgrGRFufholfFQJCUMDaRqZ8T4=;
 b=FivNq6jSO80FQ47ND2PGoP1ItTJ3SXrefzheZuUKOZyaO4/ysl4EhaBxjsvQX9fRDd
 I4KdZYf6iV02V0Lf6NoTSBTNLKlh5PWXT0NVgbMABGT1CKPkCeBRLvsMmibIoyGKJmc1
 miQfV1l6AMg65a9+5XaNV1ukkz2lnx6wmIGr4Mfb5fCjaO5hlQ3HHkxsGQbJSvmWV31z
 mDeImZAmHzAI15rBnkOrIUumbtJk+Y02dNzSAondMk+7QjXpVl1wTEK0BzpKZB5vOBwG
 PdSTzFuzKQffgMERhn0WrqwbCwoPkv1tb+iSrwfbmXJiPdcGKa3Yl0xNOsipJZXWT6od
 CD3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wkMC+K9CYOnlk2ojq5qi3t8V+2+UGcRRnFm92ZrFVvvQ4Jf3bDD84pO/feSBPqFQT7LKLe+NAxEfVFXMUDaS7@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxj+wxVHsx3+CSXy3jiJclqBhXj1qqEiC+YudYrfZ6hJXLOIoXj
 8f1SRoyoDTB/xRgDsU6cTKq556D5BwsIosdqeK/uRZOp2ZPof+Ek3BHCWFaQmmpvYklxS/va2pO
 rJqlKf9Xqm/k9l9y33QLqqxgdDw==
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:c82:7df9:8c21])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3950:b0:3a2:d989:2b3a with SMTP id
 adf61e73a8af0-3af7f875047mr1492585637.20.1778642451747; 
 Tue, 12 May 2026 20:20:51 -0700 (PDT)
Date: Wed, 13 May 2026 03:20:09 +0000
In-Reply-To: <20260513032009.2300435-1-joannechien@google.com>
Mime-Version: 1.0
References: <20260513032009.2300435-1-joannechien@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513032009.2300435-2-joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
X-Headers-End: 1wN0V1-0007Y9-Nz
Subject: [f2fs-dev] [PATCH v1 2/2] f2fs/021: Fix mount syntax for disabling
 jquota
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS has removed the trailing "=" in the mount options for disabling
user journaled quotas. Update f2fs/021 to try the new syntax first and
fall back to the legacy syntax if the initial mount attempt fails.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/021 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/021 b/tests/f2fs/021
index 0cacb138..70b10fa8 100755
--- a/tests/f2fs/021
+++ b/tests/f2fs/021
@@ -21,7 +21,9 @@ quotacheck -uc $SCRATCH_MNT
 _scratch_unmount
 
 _scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
-_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+if ! _try_scratch_mount "-o remount,usrjquota,jqfmt=vfsold" >> $seqres.full 2>&1; then
+	_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
+fi
 _scratch_unmount
 
 echo "Silence is golden"
-- 
2.54.0.563.g4f69b47b94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
