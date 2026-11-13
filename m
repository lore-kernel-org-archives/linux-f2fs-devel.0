Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9805606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yw+JaO13;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAqd1WXS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NxD4ydWV;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pFUcPtET
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=PEsTP1AECXKzcKa/MlkXfKKsKsZxz88bFwcjPIjywQs=; b=Yw+JaO13JVsy9z9UP7ftDU1cim
	pWotkfjg59azbByUBv1bk78DVmAGj5+BuY6R7JdvbcToMMHgWUK6iExr9NMuW33qlpnTKOOLsDj2w
	ElINgYKUni1tmn//Xe559U2q/C98TgUwT79Wj9FfEL7c0+jxQCi60nLcWc04e0hhn92s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRob6-000000002R5-460U;
	Fri, 13 Nov 2026 10:33:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jsjlee1020@gmail.com>) id 1xRob5-000000002Qx-2Gqa
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=foZcSwJ0fjwSH4rQkSaNmR4YpsPCYlns+MYnDU2PM1Q=; b=CAqd1WXSVC/rfWzGLrkZGmnCPm
 xtr8+m1hEYvJJaNje+rNdO77UOjXF+a/FvvZBAOqoDZ+sxs3Ep4UYXFKE5RKT62ES+dSdsB8TJRMw
 O0iDI81pRQJrWwTchMb0wU4nIGdMvTq2wZtKzYFIVj3Zl9ZS1GQ1jI9PpJeZOhRe1ShM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=foZcSwJ0fjwSH4rQkSaNmR4YpsPCYlns+MYnDU2PM1Q=; b=NxD4ydWVkxp2Wz36G0979j+jiq
 wCtQVCkKSubDtUBMLY+XJKWyXn/xuBlw19kjtx8Q5nTljFpRJhpOHy8lhbHjLeXt1YJYsOR9JjnOm
 qorSQiNksBktuE3DOA/R1We0lp8o7h5PHwdEqiMpgV3B0aC5XyjRPgpVFtpJ1jzQlCIE=;
Received: from mail-yw1-f180.google.com ([209.85.128.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRob2-000000001Ef-3QAl
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 10:33:31 +0000
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-8b31261e8a9so5672757b3.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 02:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794566003; cv=none;
 d=google.com; s=arc-20260327;
 b=RrLVR0RVbUAslnG4R81AUJ8yVvx5ALNB/YV9BOAU85jS1E3Y6qvpI43hptaccw38mJ
 t7kUAvnTioTnPunIxyWvikorpxZlIUMOEt8w+3ra7QQGgqJlrS0hy+cHRy9VFgGKjwv3
 rU4Wx407BCu7Lg8YRUEG2GANdJMOg/0o3NMgTz9KWqO5rorutNwqmGqacKrVv7AmQ5uL
 gRvTQLIaLLDB820Er8GEtMth8HNFNv80hO+vzHtzdISQw4iiEkubZNQwgbtlwWEc3igl
 fP2S1yNsocCKjx0X0eRdx/qnmD3118EVPgLDasguvfX3k0Sge/3LSAQ0jclVjFfPUMvl
 fsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=foZcSwJ0fjwSH4rQkSaNmR4YpsPCYlns+MYnDU2PM1Q=;
 fh=Jwnq2HKCvn0TpKSATiw9wC2eE7DEP2OV+iiwZ8ktJHw=;
 b=fDI9hDlLQdEy79PGfVmGYBZLnha/7lkTj+yrlgKVK8awEkJTzbelIggB2Fd5Ti8ce+
 0siVYVwqUW3Kz66OskLQWWkU3jL/SSKyywKlEeOOL2Z1RikAIvhT8CfNmhAdU5CSeScf
 ujyf5JSl85WQeyKI1NJGQemZHxJLluwOOvIK+ROltmNl/jwvDg/n0yaW9/tb2kVwz5U5
 H2XTxnbuDszUM4Yutqai9K6SUmmP8Y+TvFihMqEcdrpkzxBGuQl/Sc6bITF3+t0ox+8Z
 RsWzgbEPIC/4GuQOVxpHpbe/n91JN3sO90RW0lmUVl3dEgBR7muBC3HMsPOzvJ6ob3bB
 WXNQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794566003; x=1795170803; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=foZcSwJ0fjwSH4rQkSaNmR4YpsPCYlns+MYnDU2PM1Q=;
 b=pFUcPtET14x7I55WTrYuFw5RSg+3xVS7Ed/YclLe50i6fduRsgc7EKthgHa3PrLRKl
 CGbs69FwcV7/4eIWDfO5v+B/rDBxLOtEVtv+1ylWlQjciQhbwYk3hqQVKoymjJDa6HpT
 2L70N5m3hZqEGzUnq3U/7/4QLptU0X+7bMy/Jmdn86THHL2weoU1y/MTzW+PPai3/sGl
 ItY7LS68DJfchOaXKLr6tMzNu0WS5nJkekt2KI3BoZn6DN+BLp1mBOWJDVPsQH5EhD+V
 vYL9PHDeWTHFvrNLwh4Z4Q0mG8MzbpKc3Mu6tR2ekZRW79nlHLUGDA+yp9yaOYpIs1H2
 AfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794566003; x=1795170803;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=foZcSwJ0fjwSH4rQkSaNmR4YpsPCYlns+MYnDU2PM1Q=;
 b=VB742ycNO+Ih9BMWB63uNr1/VMRyywX1/BA9VEPPrCYAR/OZVEU37CwY00+HffSkRn
 2i213EVpPQtq6X6RAX5QYfFsHl4gLqY8hNEeq1QYoKtvonJlVMzzcgBco3MqLsQ6L3fm
 cRKb5GR66Zf1fU3d+kbHwkQ87bAW0iJpOW6AC/wIoDFdgIQ2I2VZmE2ERBqmUt5OXtGr
 pVBxQXZPrqPwpynmfXpFz+rRPhTOYVATAeO06gR03Q2EMpOdiWqs64WkZoQkVSsf23J2
 hOLc6r/SiceUiz1O4B04ArWzo0uA64ecI8Ne0uDxe/UMa0AXeo4j+jTYVW5hHDlSrWtb
 glDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGvZYhT0baSS0Yc6FXQ0JZ21BIEgEBsk/aLKDPI0zTjx6Ja4CsOyuJdPyzHvanWE4mYbYQ5V3RwT3cgMbdghdHj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8PE64x28RE3uxp4rFm2AnBGbUaICx8iAjdW//Mq55EFaaIiuGf
 igyq4w7MGRUR3dGUibhaD4h7Gd9IgsmxSlV9eMFFDJG+jatcOqepCei+WDRNozC4NVPBaHK7SD+
 EqmkRsXjlQd0mHGERGjDBFdDopH4rK3Y=
X-Gm-Gg: AYBFou1FHrVdmXWmSgdp4hikdAcSFYZ9aXnrH03Eo5WMTDDhAbsym1dDHLWTwTs3Tav
 uZXVl4pad85F1wnsAApQaSR9U204pS4O9OD8AkQHlQTtUk8XegMbpZvqqfxipbuorRNWjRGfdod
 NgRW8bpOKucv+bs6GTtfjXxtNHb2Anm4BOYFCX9+uGDjan04aCKh0T7Vl81fTL+vk/KF7b4DKkD
 krlEwXdAJB0p9nNv0RQZXp9b1Qo+qaaLefh6EJNmqS4VKX0ijZ775R07cTmozrC9Y6begBIY3ji
 DQPNP5cUbHX2zWp+CYj5A/aMnQ864sf4wiFzK7wDEwzpIftey8fpn39sTHNGIeDgibgj7ew/dO6
 ufC8UXjmCEpT5uYjXpAljDY55+QJPXM/g6lJSWN8=
X-Received: by 2002:a05:690e:1502:b0:67c:1e14:4fbc with SMTP id
 956f58d0204a3-67d893e4247mr1437064d50.11.1794566002787; Fri, 13 Nov 2026
 02:33:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
 <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
 <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
 <0e156b8a-2876-4bbe-b16c-55c70b3201b3@kernel.org>
 <CAPHXVrxHvXChxiBxCcHWLaFwvatnDVhSu7wdvPWiBDYaUSOQJg@mail.gmail.com>
 <86627f3f-cdda-4165-8ca2-0c8dd4e321a9@kernel.org>
In-Reply-To: <86627f3f-cdda-4165-8ca2-0c8dd4e321a9@kernel.org>
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Fri, 13 Nov 2026 19:33:10 +0900
X-Gm-Features: AclHuK-dU3XYmKguHiDmDg32EXFrUNZI_2N5QmJS8pOdbdk2kDR0zG0qrZyD1GY
Message-ID: <CAPHXVrx8AESeQdo+nsnHZsBaJ4=_t00cqaT6G1TGh-JLN_pHog@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRob2-000000001Ef-3QAl
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chao,

> Previously, we will trigger f2fs_bug_on() and there is no further error handling
> at that point, so that we will update SIT_I(sbi)->written_valid_blocks as well
> incorrectly, so I don't think this is a bug of a66cdd985532.

Understood, thanks for the clarification.
Please keep only the original Fixes tag for 81ffbd224e5f.

Thanks,
Seongjae


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
