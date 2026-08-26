Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD4C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CyMOUkeu6mmC7wWoOwhn4HKFiosb4HaK/lOY+/9l9k=; b=SsUC16hqTWbdMKqn/Xjt6sW2Lm
	P3DpnD3SEonTNIMGCMT2tgTINEGt+tk77fi15yIMLyQIVNZzzJ+L1MGX28NoGNavfciMeBNu7WjHR
	ur68hnf72mc3ZsOdhPOIwW06VUPnwdvk+6LtEQFGFUOfCoCG+iSHAjBZXzTgRd+6SLH4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz3KT-0002PR-Qc;
	Wed, 26 Aug 2026 02:25:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wz3KL-0002PD-DO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yDfUXef/4iZh8Ovy/VyzOPnY/ckIY5+tTqfm+hPiNm8=; b=TcQ9RC5E1fZP+gltP052rIsMUF
 t1XxNLQIn3y91mVbtMptAE0EOLPWTFHPuGo5D0kkgrs3ebobYnp0N4+eDoxSot8AssP/2/IytBaXk
 +hzXavbog/4UUU29oCAyGdXcwsVvTxA8fnefGdAM1acjrJt/hnmsq8zcya6yXf3GGmnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yDfUXef/4iZh8Ovy/VyzOPnY/ckIY5+tTqfm+hPiNm8=; b=LujVONwH242UZ+6DYB1TA/6a76
 OtJCzFX+f4uSiZi5xWRoA2gNq7crYLktEiQy3u2QMY/bWy00I3EBu19VhE2NoC9eTSPxqUKqGsI+u
 FpCu9FPQ0pgAbMMc9SCNqiGLoXKOfbZaNPKXr5cMIHhzRRFQYXE4ARvNPMfFz77x/Tng=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz3KL-0001fX-Bu for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:25:22 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so4935125ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787711116; x=1788315916; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yDfUXef/4iZh8Ovy/VyzOPnY/ckIY5+tTqfm+hPiNm8=;
 b=q7043jAuqmKUoyATzZb5pdMQal6Ycd4k7bsXOWNInY36dQDZMdbueLE7U7NFzvjhqZ
 77SYYp9B3XsjIqCa0wHDfATnSQ5q6AQNSR6RP3wu6d4eqcELPVoK4VEb9FZ1dacRZg9P
 qKKEm/K09Br8r5a3Vr+LMtR5ljmbbUdujwCFWiAJ6RTJgzO4hY+cZkatbDxEnDNrSV02
 u5uZl7grNesCMm+ix3u6AdCdTF+cpj87tEC6FPwp0W97E6odWomnDicL9LVjPC0mzdWm
 W2GfjNaHkU0P1dxhPAP2DZXFi3LCTxjlNpkTe8BVjlOKmtqz/OJnW0T6E3O7Tvs/Fm41
 thOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787711116; x=1788315916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yDfUXef/4iZh8Ovy/VyzOPnY/ckIY5+tTqfm+hPiNm8=;
 b=FFB417wgrfbZjlZmL2doCNUNw3uqSjGe6n9h1ixjMT8vBM7xT4lgt4F4K/5OMNjM5h
 6NkBxvzrNRtIckLzE4//RUgHm5mCzJImJSfAzfq3KqC8pwi8XdGzmua7SKzEWrPXKtVD
 HjH232/ozQtXfCT22Z0sAMzjC2/zJVbhaQgtvWCSffVNi1hFV2pRp+4oPc+6kozwNmBh
 pcrDKvLYD/qv+ASrUIa1BXvQGV9t0lO6s4vP+ammpxOV0Qx2VDyBHcwcIlPR30czA1ZJ
 JroJR7jYwDyCZ2o9r1wR5yUBR6TxqsG/BlSHaVcu5gq2AdjLm+OMAh585WHk0y2tsr5C
 jwyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1PQwQcRbO5Ls/f17enyyNKOAs6rceIR2mf3T+6B3MivlYSfXw/Ve42YVFoGbSvVoqyv7FsLcymV+L9z5RkRLr@lists.sourceforge.net
X-Gm-Message-State: AFuF++kcjDlFxRYaMv3Vq9y2PpoUHq9+xP9n43gAaG81pXn2Hb1dBQkG
 lT8LpaeDX1yMZPv1gwZuCxoi0p3gZ/JUvJsEB98kNg/ZCMy+nzxoShAt
X-Gm-Gg: AR+sD13BZ791ZSwebsso6TQaeKusAWm+uv6bKvbqMG4Ea098QLwHYUme8EDcmq26Jat
 V65voj7IhcSLWkp+8lqmelsy3WUu9dRTBklHgttoy/kx5Od4PdQiCqiKPt7gBskVlCwcT+fi7ms
 E1+TSkcHpZULmNpqxxxhMRsgN8BBkrJQnB8iJS0hLoO7vlCLFIUEuBmS6/5KajIfy6yf1lE9zBj
 rOrcRmpvrXuCX6Fdnj03m9ILxwoQZcwSaSmXXgd79LTDhDj4WGj5jU7g8geMv1rpqm0R3AsYokL
 kPDDwl8vIrBpnCQIUoAIVM19rmCRKYUD0UG7v7kLGQFqK5CSaOhbIFYSP13Gs43wsVWgWvQCoTP
 nwmHIdN7AocLcFG7Qsvsuv+JoVuH7Q6v21sQWMdQZzi/AkgCncxHAhCjVr2GdhFvPQFjxdHbfmg
 /J7M29lu0+o1g6ho8IrJaT2+nnjJlKkPCx+WKTfzwlDC/B0ALph7VyQFlhvutELEqXLxqTo7cMu
 etXfLgz0EbamVguTV8sajAO
X-Received: by 2002:a17:902:cf0f:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d707ac86ccmr50573835ad.7.1787711115649; 
 Tue, 25 Aug 2026 19:25:15 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d704c4bea8sm2899655ad.82.2026.08.25.19.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:25:15 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Wed, 26 Aug 2026 10:25:09 +0800
Message-ID: <20260826022509.2506420-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824191404.2558269-1-daeho43@gmail.com>
References: <20260824191404.2558269-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wz3KL-0001fX-Bu
Subject: Re: [f2fs-dev] [PATCH] f2fs: support resizable tail section and
 unify pinned allocation
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

It looks like resizable_tail_secno is parsed into F2FS_CTX_INFO(ctx),
but is not propagated to F2FS_OPTION(sbi), so the mount option has no
effect.

Regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
