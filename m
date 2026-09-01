Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11885C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1o45n6J1EXfmlxfTnfTN1k+4DY2V17H3NlORhA9SMs=; b=eSn1C7pu0vB/NzdGAh8DUmfoeP
	B6ZyOmQmz5tXptlxW3bBYLo/RTTy+4h9Y/Btp03t2joXGYFyaqL2Yfq5hNAiP4RQe9CZ0ckMEnQTQ
	PX2bXWXSyQnxRW4714od/O/Wbn5x8CdlqBud+Ab2eU13DU25+6kXEPh3NNZhdRMjtVio=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RV3-0007kH-LV;
	Tue, 01 Sep 2026 16:38:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RV1-0007kB-Ti
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nlU4+bIAztJ6sx8wlI8snYU2Yuu311Zr2b171MA9MtE=; b=SWcrY+WoOoOCzGDDG3S0mA3XL1
 JvUQVDwc6ZDT/LKY8buA1IzDjcvjDxowskGb7d4lW1UOYfVip3d21avABWruPfkQ7zcJbQuUJ3vf2
 /sQ+ziuCrnqy+nMAVle+ztPPbHNwxRlrjavlvztG7LKPUqUDfJ2m87K8oXYVgpqS/0Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nlU4+bIAztJ6sx8wlI8snYU2Yuu311Zr2b171MA9MtE=; b=Mcrqnc9tD/q4u8OOmFa7tEB2V8
 MqnepkPkC2cv2ybRMq1G1TgDlYa+5Y6xIxXT12Dhrkbsf40+n2qrVr7jnjuRuT9cRSBkdjLG+np/e
 vtoqY8cNSRAawYftNReJDdz40AW9igtUmm1cF6kwdQfJpUMED+btDIR61XrO81s1v9s8=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RUz-00062O-3P for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:13 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a623987d32so20916a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280686; cv=none;
 d=google.com; s=arc-20260327;
 b=QEkm9sFYtDSgDMnwCI8liSH8BU/XXWTbURL9Hh/HExgkP7SdKz22kbls7To9E8USX6
 S3o7uyPqtRZO+cpWjJK67h/sg1D0kd0/+v6udZ10EpM8DuSIWsce2xWUeWTweHBhduz2
 I5dL+mph3NDVegOj7wWvf+X7bpYnqZVAdzzm1kUJw3ZDOkOWF4OxmlOclugRlXczQ4qG
 ivfJzfYLHyR+JMbVeDXoLvGkL5eBe+Li6eGfnT6dWvlganZxfaDEwiI1w6rl+uSPLHM5
 TmDLGaUSvdi1IKFlPilybMOiCFzMI8Bim4/tGfpRuXyWAH5hvKbMapSpxAGjB7Qd0EXQ
 Qi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=nlU4+bIAztJ6sx8wlI8snYU2Yuu311Zr2b171MA9MtE=;
 fh=ZZyEDQQrpMGN+93C+nWCKA85F8NlBoZRGypE92/ZoLw=;
 b=bUV+71Bx3sFJd6gVzyjFfvxHIXeTIHQUFFPtG4RPOOrO7wvAl8+5UI4vrjb615Uz0B
 IRBE7YUuCRqvKPolaGit8Brw1PRZhkD50eT8c8TLUWQ4zm0qFz09s7bmMu15QPI8ASQ/
 883ACPqKhwIzjqSCth13h8V9cv+VDKNcm6quQWlszTcxNsAR68dsJy9GahRX0j03MXfY
 7OpQV3zc5R1A6W8R5k9msaBvhiBi3sV2pZPl9xipf78NoOo3EaMNcMKBuqilksDBeGIc
 FqBUfKQtWeK6sBWF9PyWsubO11RxbPc7DQMgeQK4B5lTbgNBO8rnnEWHFzz0rPrFgXTt
 499g==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280686; x=1788885486; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nlU4+bIAztJ6sx8wlI8snYU2Yuu311Zr2b171MA9MtE=;
 b=saoYniQB0pUTclqiOWDrSySL67HaGTOLcdRkMqSQdf6zdwPflAtbm6QQIgUOvP0K11
 VJicmAGivzv6ZOPXYh3LYcDycUMyVAY0j/E6i6GNGrJP+txu7/BbDnDGwSpCJB9CRIWE
 +S1Q5CIFdVILPWmPi2W65UqhUDG2lIz0BRT4WYE3zfnyp7K7isYl7ZoqguKIZivKllXe
 71V07c9gm4TqYALOMuxfMRIxnGk3wMjGFksmg7zHEpgIKXtXnhJfVtQE8gmJ9qNLVveE
 hS8sZrNMOLOdiUvEHJ/vgePYrg9byn4c24vH4a0BNrGEJ7oeWrlFpT8reR2GY6MDbH5m
 RKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280686; x=1788885486;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlU4+bIAztJ6sx8wlI8snYU2Yuu311Zr2b171MA9MtE=;
 b=r9UzyqW7189gopKt/o9+RgH0kJVezRoKaFqcWdsRdI6r/QfEVJNCsgvUSgsyhVG9eb
 oCpEJZFB9dDgQekLv1x0DWA19aiPw4THoa8P9C4dVxmPz+2dCEvQYGhZPbw5bPuwfYbX
 pTrLpXsuX8oLJDmCnxmWAyi6DvD9wO/V8oyxBcgb1eTXmE3qjoiUzvAW/pZOF8riJNO6
 6GyVr+cPjWllKGG1NblmYn3UH2MMNt0LbNf2w3BZXfRrjZz7NGgFaTl4NOkeYC01MI+U
 c0lSFmHSejMKQVnZGgMPiLBHXslzJu51U4MXm9GIy6fzJa1qLvEqi/Cvbo8sIMqepPbO
 3s8A==
X-Gm-Message-State: AFuF++kyCVOB3/OlQEvudnXJQoNl2wN9DrtygWTdPQ65OVhxfrtNS4j3
 mOBDe9hdz+YYrlRilrGc2UntUntlJh+2uA7jTSfYt4M3B3pWSsWWeauOn5kdb11gsZd/sgr261s
 /qbtSgGQmTHiFlO4Pl0v/uh1DEGRa6Fk=
X-Gm-Gg: AYBFou3Z1eIaWfbyBQ0066zIYL0KM09FgoZZqerXVt0xbZdfN2636qqS8JiybG/d2Bj
 KCj+2U5IQdC9DKKl15L451OxykUyP0YKrnH0SxEpzVmhl3Luwdc4Ytxx3vCzi5tf5bp6fxzchPZ
 /p2B9Zo70hrxRAvi/Va+9jTj7nvQOaLzopRSjeVUzTLRHtcKmTAaVZ4uBtbj3bpn6or9PnHw99h
 ndaK8MKMCapzxR8TXfydDAg8kt+U/ngcNyHor0HKBR9amLZLT+GT5nRrCiHQVzx6zwEKGNlxkc+
 M8r6w42c4x6m0mQfFRNI5+AHpxfflg8DB9FaEM3PD0C3cNqs9zoitzlb3l7X/PFLBb854EZCVLZ
 1bg==
X-Received: by 2002:a05:6402:24c9:b0:6a3:714e:f5b4 with SMTP id
 4fb4d7f45d1cf-6a60d3a5f5cmr18267643a12.9.1788280686015; Tue, 01 Sep 2026
 09:38:06 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:05 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:05 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACOAw_wNy_rFe9fC-+iHyEmsEDRtB_CWA2d+gTvV0DjhLAC9CQ@mail.gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <d6a28ec269f24e0ea20f125671ae0e2802d384dc.1788213716.git.zhangxp1998@gmail.com>
 <CACOAw_wNy_rFe9fC-+iHyEmsEDRtB_CWA2d+gTvV0DjhLAC9CQ@mail.gmail.com>
Date: Tue, 1 Sep 2026 09:38:05 -0700
X-Gm-Features: AcwNN1Vi5kjEyl9qyBD6MJJIlkPqFmttS6KIpCPnuqp0vSZXoHy4rSb08lG1KTg
Message-ID: <CAH=xXfEwscibuAp1nnibVZx0sPbtefQoj+zQHmBR9n4nT_SF-A@mail.gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x1RUz-00062O-3P
Subject: Re: [f2fs-dev] [PATCH v7 03/11] f2fs: describe NAT block layout
 dynamically
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks. START_NID() no longer has any callers after this change, so I
have removed it for v8.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
