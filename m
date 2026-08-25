Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD81C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hqDDvg6bCftOTRp26B/FJiJDCGdyBML0wPJUyzTHGDI=; b=hB622/6nkNC8TTYTPdOWNHqA6U
	wA8LuGziuRvIat2U6M2kMhHqICWw2xFYMw+pVD66Pcny2mOOiUxI9zx+b/lU53NMXU4mVQ9CMApGy
	3b3jPSBuEIof+yhjUAyrhasRRm/fRpQKdo3JIa/CMptUEH6scRYzJ0pFU5jv9Vf0dCT8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjxL-0001qC-2G;
	Tue, 25 Aug 2026 05:44:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjxJ-0001q0-Ca
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9SuLEqoCX5r7uIsyJAvA4LqSfPSBqPwMEMFXIkAMTbs=; b=T/KT3dziMxK/sKwUNLULaKxqpM
 qT+Y6O1tIbwoLiVHoZTVqvVJCw6koj8XvlBGlr5F62TwoWrMxsBtakxelz7ZohCpl9y8gYLMLQ0Vg
 uKu6svGboBeJNCB5abJ3oCkgI2hpxkASYttLIk1MUO72VeKLgcc3yEoPoQmjzeOdE7uM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9SuLEqoCX5r7uIsyJAvA4LqSfPSBqPwMEMFXIkAMTbs=; b=CmzRx2w7KDsD8w4vwROWJVWVjk
 b8E9CY63CtxTaoCGgm5+LPJ0CVKtYN0AGz42cD4+kymsmDPIxLrc16iA/BLqSVkmKS3IsrnHrS7Ru
 4HcYtn+V0hrgQzkIvKvcCU0UINY43zL6uQAFLk07WI+yMyA/sEUD3e+LTadaFymmhm08=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjxA-0004o4-Iv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:44:08 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so4185019a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636643; x=1788241443; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9SuLEqoCX5r7uIsyJAvA4LqSfPSBqPwMEMFXIkAMTbs=;
 b=OP3U97f4ICweZtjajanuKmyHpWJMNSNN2rrk2sMCGzBpVLviOA9Y2zUJhKrFk1sS0z
 5GCS/V2gYzMna4Zc7a1VUNbjjTeLEKF1G+JFsCDmxbwkn2wtQur4c0c4t3IXKhASneiF
 7q2iTkk/ZocozyZBpDpDt0kDANZFCH7bqZe9fbU0lGtL3I50uWUUybfjcFHpI7GEek8U
 KZJgwEQ6RNy68IWynnnTU8fBBwOtfp4+4sZRbq4G+BsCuTHPc8jQ2zcWIZijcFaxnSPo
 125jNsb6uZ92rvNx/tAqqfuV7bCyGgB+MbgMrku5ocTusav9WxDXzagTL1OzjwUL/m2t
 9c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636643; x=1788241443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9SuLEqoCX5r7uIsyJAvA4LqSfPSBqPwMEMFXIkAMTbs=;
 b=WcLC4PUc0xo0hTc9GAXmDj51dgeq9KQVWsAJ8kMW1asZAI3RANX2Q7QFktLdXhHX4b
 wme4J1H2ZrfV43Q01XuHdzeiIxzxPw8lT7l0ChUXT1NCueXwklrMdV3EWeKt86g6K1U0
 hrdD/cODj/NHt0ti6AGolgjOwRmawd+WtTpJsStjpjtzEvN0qgZ8EAEwCPgwaUhSXZKh
 Bx6w1yOvKvP06PaNz1OphIkrndZn0NY1oTgYFBYx2F/R+k0udk2K9JwRDltvlkSAPG0x
 nABf4p+3qb4fkxjhdp3lyaRqCO8FztIZNeIb/6l5W8hkNBUrMiT7Q3zQ6CjFpQrgulWU
 HOrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRHJHwKVJKJ8qw8nrQlU5PgNYuPpYohOQeiLciylNcZpbgH+Rd1Dl//CGifn9NYy1mO5RTC+kropnpMOpnxY04@lists.sourceforge.net
X-Gm-Message-State: AFuF++la5bHgA6RNSEU6Xk33ZRuX+8oqLqpXPFXTlstKr1qcf3KdUHFE
 Fj17vY7EfxxsOV3CG8XLumVU9jBBtP2x6NPsEWmOYJYepe0XQ4mg1vJdqF3nUKxZ
X-Gm-Gg: AR+sD13OCgYU024RcbDvMizd2FZpCb9Q6AJX1INBOGP+Iq8cjw/pfz85Jqv38vDAYXU
 u83AkAirr2R/3NFYzen6NGQh/UqjAxX50//W2v1sCF6CkMgop7nQqDG89mImWvy1gS4Rehh3YLm
 mTGpEQSUEuDLTar3/8mCueaXJ7khDyKVD8xxJfaEG0GwEKkc3/BvADWoBSxeXIVhLHdvE449S5F
 lInPPO4s6/acwZu7H3TpOksXh+3Uijf0BEJ5Mz4WVpxteKZZDEZGiP1siPEtXeZBfjJuNUvB8cx
 XVDcaDipQ3fYQJtoz2VfrLlhmVRv/stj55ppB51XGOHKqLStkIVVMxYm4InHgnIo9PE/o5NTsVg
 DDN6nh0ki4bmnRiSxU2VUD02g3fasl09lLw6ZJhvucI+yGwSvBeVSN7gTaTWGVd3QG8BpbDdaNP
 AbUveZT2xzZBaUe0aT95DfvWRe4KdJxlqgfrVI8tl3hzE11beU63z7gq49sRi6dZZ3h184KRWf/
 Ps/nXWMyHKttuWaQj5sNCw0w7mtjfgLimY=
X-Received: by 2002:a17:90b:390f:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-395c2f29705mr55413340a91.0.1787636642859; 
 Mon, 24 Aug 2026 22:44:02 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d31e8csm2288170a91.9.2026.08.24.22.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:44:02 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:43:56 +0800
Message-ID: <20260825054356.401106-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-10-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-10-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjxA-0004o4-Iv
Subject: Re: [f2fs-dev] [PATCH v2 09/12] f2fs: cache: use compress cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> entry = f2fs_grab_cache(COMPRESS_CACHE(sbi), blkaddr,
> 				F2FS_CACHE_LOCK_CREATE);
> if (IS_ERR(entry))
> 	return;
>
> entry->ino = ino;

and inode invalidation reads:

> if (IS_COMPRESS_CACHE(cache) && entry->ino != ino)
> 	continue;

A newly created entry is inserted into the radix tree before
`f2fs_grab_cache()` acquires its entry lock and returns.  Its initial `ino` is
zero, and inode invalidation reads `entry->ino` without taking that lock.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
