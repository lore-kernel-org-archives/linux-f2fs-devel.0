Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F380C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVhigH4g3yQr9l6tge3eVwbULOYkbH8cwPHHMkBDUu8=; b=J6mDZ5dfKD8s8EG5oFBTQsNrYS
	1XdbSRl9S70lm4y6QwAzyTuBWywf4gUGfm3zkc/6sNFLMvkwOL3C6UhoQfnRerryK9dGCgHLUprCf
	9YQ5aYzeANbrSHhmzocez2QAxLTTTYBk2nthhM1nuoARx8PkHbJItqpgtuWvTzZy5nvo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RV7-00036r-7L;
	Tue, 01 Sep 2026 16:38:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RV4-00036g-LP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TWx81FEISW6Uris/X1cZjWXSFqgewjwM0j3D6tSdUPI=; b=jNE3BVT2nu5GM/np7ZdT5l74q+
 7FYdY2LdJYnZwB14x+AJHIAVcXx5tJyPxh/pnu2TWeji5aOwPJs1wz3Mwt7r1GAmuS7Ozh8TEov1I
 rAJS4PQ2MbPeNyb/jD2jmt+s2T3whxdgLr0ZML2U/hTDWwBBdT6bzV72Q44I9LYLBAFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TWx81FEISW6Uris/X1cZjWXSFqgewjwM0j3D6tSdUPI=; b=W16CjsyNJrKFY3msifiFiY550x
 Ez66IJEwaF0jG/PSwmbnOOYNDV818iZlSfDfQMIlSKIytbnWC0U+UDmR+4GJfK9r8Ca1CdJYY5foJ
 4xcYsBgYVt01YREoRlzH1z5DMxEf54cgZduomDXfhbWwqntFb3rsmEQveynTd9fQ1KI0=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RV2-00062c-NH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:19 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so12515a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280690; cv=none;
 d=google.com; s=arc-20260327;
 b=Jy7XMFaXhJgKRho+pQzG8AE7ESqeWhz8VFeW2CqB2GJAzCeuRGQQbcoZ+U21E+dLY7
 2eBun446xJxpU5dDF5QxkUnqDq+/vfLtmkGvThHW9B+r+qXeSbo6AulKTIRYYsXRa38k
 uttXMZnsihcdcCsZenHaK/UQc9SBhL//vUJ0ds5LiRZwhYo0g8TVC04aeInXf2+eLVI6
 ZGKqT1UC0Lmj4LEinDBs9wS0tfZp2gWQLs71w2o7WFE/0Ud9tKa4CIo1ZXK/8dRhWlfM
 KNgDNqgbY671usan48pvHXMkWqXgHUZ6+BSlBCzcz4mWyvPYOaeaGbmH5tarmAZ4odhn
 /QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=TWx81FEISW6Uris/X1cZjWXSFqgewjwM0j3D6tSdUPI=;
 fh=w0lGcVAd3wuv9FxXlgcv1MnA8D4Oef4oW42s9zTOLrc=;
 b=Eig4JMc6TCHjBe4NApwGbsCakNaWcj+8Xzykxa6TWs1byTZ2J51DZ4sSVzz9KjEQtP
 U13e8QrNjKwhiQ5LAAohlAU3L6UZHPfjOPxUuKHknbyV+NaNfux0DrF9iF/IwmzsENcz
 bS2483S0oL4mWjiO5jOC0Gb2SqaFO/wnMFNSClazrtZaXXllGToBbuIg1O8BCs/buiyU
 fziW8R8r11+p2yCogSKmiVuk5tzf2cvEZ/k/l7zQrXDgaoYwU727u585Bzpmvbn5ewya
 DRS2CBmKpQwgL19aXPTYDW7kQXQbRSLyu9IiCzMjSnsgdNmRz+4B9VO7wrL+z5Ym52h7
 ET2Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280690; x=1788885490; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TWx81FEISW6Uris/X1cZjWXSFqgewjwM0j3D6tSdUPI=;
 b=LuPY1uq3G/mMWucaPPqaXl3sc/ioD6bLOyww1j6bFSFJuGWjB6vSplRslTdP3LWrLg
 anoCCo1P2QT+Qaj8Sq4WS2MDYp8koSeOBTnn5ncLHTrdPnXuvwu/GK2ICUwozZBNLGLA
 zOI45CNzFJ5Gr2wLl1CcDNv/Vw8e7JnalhZpgG98amTnai3k2s59SqLsT82ih/3UXUPS
 T4Lfw7LScr7Z6IjQ+deIafr9Y8bOUspAxcIAe5s2QNzeTo/+4XL5gLxNiiSrbuZY/toz
 E4VzbQIrwPTJhA3neJ6vKV87yKwv8zfaYp9zUF7jGiFcFtRQDxfub3vYcb1bvrB7Ru/3
 gc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280690; x=1788885490;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TWx81FEISW6Uris/X1cZjWXSFqgewjwM0j3D6tSdUPI=;
 b=d4drA3B/uA576qYAUtAGfLZHKzHhISb1JCp5bTm+2FQYUNyL1t7bCzo/DeInc7pOpw
 TBgrPv3Yemrp6l1QAa0eZOQ9TS1Q9EO6J0nE6EVG1W1Etb08o/inVkwDewcqGkD3KyKz
 3ZArdLnT0W3OEL0rMaGftq9alWxPb5yawZs6Nf95KU1lXnrqQlLkRa5p/dIbq7mN7i/z
 0LyNi0YyG/EuSiVF0UCCufShALRzDvovuYiS6PD4p+sQWm074SjKT9ijAbaMkEb3YYcL
 6tvrttTHiPNbZZAsPndGFODxOs2+OLze1tpX5jYyhjlFpZPWYLJS8ncinZrwqw9wxe78
 4/BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5dA1Q7EFaI/6asLtWh2lBQelr8a00Oo0tcjg+SktMdKQ/K9dWZ3MtoiA6b+8I70CpeDOTr/G+SlHPUQR5Yn9Q@lists.sourceforge.net
X-Gm-Message-State: AFuF++mk0hGHCmmX+gUyTLlQQ+p/MXfRtDiaFjnR1zKMTcKyurWIkJ4W
 8+ehVSckQLCyeDutD9fHcmF28PnobJVle3RUJqXA3WNfDPYGhk9HfMgJAajnLDHM1NYIb/pjYEU
 iYytOeNDWAcIcidDA6GAuqT+xnRdONyY=
X-Gm-Gg: AYBFou2Kxj0qmVx89DFKZDVJ6nJkOO2Mz27PiHN1PN1ygElWTBn/ccknQ/rE1pY8Dco
 YFpfwKSVO4oFJd/bcEqPBIoOMS/iCRsJtBJAM7E0dymZFXFhStoMD56+GlqpA32TUGoBjQnyd41
 vkxEqi+YYMeHNtX/rTB0ecpvTUlOYEttxEZYa8KLlfTZq+CYKSysOYyVI0Xl3L4sI9l4zVoHn1V
 iZ1kxrVe0eZKBc42/kRuvlJUD+53/OBxm0v/vxbdwC7tH+a6jQ56nBz4gfD7vsOFPvP4HSxVp4r
 Yo0r2gCYvWCQ16u9Apxxgc1hlbMxP3QGvsab72U8WoD5G+M5X6AUwiFZNzaamWoudykC9YU9kL1
 Q/kk=
X-Received: by 2002:a05:6402:52d4:b0:6a6:32fa:54f6 with SMTP id
 4fb4d7f45d1cf-6a632fa558fmr14172160a12.21.1788280689891; Tue, 01 Sep 2026
 09:38:09 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:08 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:08 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <47f696a1-1efc-4e8e-90fe-22e1ea2feaea@kernel.org>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <f05b57691fdc4c186b08010314f8085aeb868e04.1788213716.git.zhangxp1998@gmail.com>
 <47f696a1-1efc-4e8e-90fe-22e1ea2feaea@kernel.org>
Date: Tue, 1 Sep 2026 11:38:08 -0500
X-Gm-Features: AcwNN1XV11VopDCShECHorlGvzGYofNHlqZjoVBGv2kQODpr1LJkuM4JJCcVpS0
Message-ID: <CAH=xXfGWsm--F9zS-zfqSKy+7_aWFou++2+-uCB5_m4cF9=hEQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x1RV2-00062c-NH
Subject: Re: [f2fs-dev] [PATCH v7 04/11] f2fs: describe orphan block layout
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks, this is cleaner and keeps the on-disk layout consistent with
the NAT and SIT blocks. I have restored struct f2fs_orphan_block with
DECLARE_FLEX_ARRAY(__le32, ino); the footer is still located by the
block-size-aware helper.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
