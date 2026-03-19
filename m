Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799311088E70
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jreKSGeezyGN2TwGKLPshLLwifgFxIs1lgCzACP8X0E=; b=QMhwVX9gyA1YqWaMfS6qcw6ilA
	PjGtC3A25a08MtxGbYFwcnELsCCm6F3n3eZdHDmKhGDOEwPOtCxPQk7/pSztR9BjatqZ580XtF5HK
	8q4ujTMBZ0rLyGwc7cWshtuUG/vMyWX19l7+pcowb6IZ8BWYDK1mutG8qRxcGwwnqk9A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w340d-000175-Tk;
	Thu, 19 Mar 2026 03:25:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1w340c-00016x-JN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 03:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=; b=YGJ1uLa8HMN6zeUlmSze7gJmXw
 SkdP2pNaPbwrs5/lHUUQpsQ7+mGu7mQy6MP/gHoYabcBFE9OQIjdmq+6GqRlAiBqFElQAXRnRXmtg
 2zOKOLDUS3tzSDWU4PJWMIoSpV5LTFl5q9WYZEizO1zXuXlJ/Zx4GEwcfdfbA7L6oCfo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=; b=VhwwIGNQDdaq3kzsHYCTDTmA6G
 tfOFxSOWysXMVgGTkFy0cO/LswcAYEZETtd48p2dqJSMF//dYXv6qYoBkLkpLt2KxzbolXRI9dNcM
 tNohB+tHmuAXTCiM+g2h3gjWODo26G2Kbpl1PSpVlyxi7nOy760Arr0Hm+IW35sHclOM=;
Received: from mail-yw1-f178.google.com ([209.85.128.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w340c-0001HZ-8i for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 03:25:18 +0000
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-79a3e2e64f4so4393617b3.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Mar 2026 20:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890707; cv=none;
 d=google.com; s=arc-20240605;
 b=OMs+MdZg+8Pyh8yAW4f6HKaNam+xt+rtrOvqJqDfyZGX4panozIZ1tsSN44YVIiE/c
 Smi28HHegoUCyBRpDNM103P3TEqvgvC/f98sUDGrV+QM3mkduvMy14yLjdvvsBtf8Aus
 XrOTuGFU2k7u+bO1x6DjcpNjb4cprBFMoQ7wQKYP5qvtGjyzwfBdQ2Mx0gLI/Hkzk8Yf
 kic64hKd+goLlm8SUfravjUjChmwPIiVYI401z2n2sz/SYMtAWhJqOfL32hr12t91kjr
 5hQMlaAC82XKJqxUyitZXQ0toF86x8TKUX4t3VssVDQ9ViefKzCTfdU3w8eEp3xCdyJe
 Ns8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
 fh=+z4rllPllkx2V/aeNUn3agmDzuCKGKMj8pLsQ2Ny9DQ=;
 b=AZgrf5k4u7miCSTqzgBLORlRGPpl1XGKUYJotyURWjh9OedL2qTLzq/UnHlPCC9Hzx
 uNrKRUPffdccbBNtVCeJTivViF2ccpi6Jd3GlDvVYlD7eE+wDvaD2OsJujwttAdhh37J
 spSdhiU/weUPlAGoZyZtIx4y/cUNm16DSsxWxQ+VfGwE49LB2M/mFFqZqEpgYTv4Dvq0
 8So1Fh0860hMeLEw+ejIKJ+v7Gm5kp4U67ZGNKwKwEPDi+9Ka7hW94qZvAV8xt9bAQvp
 L/dWI/w7fqnIlYAmefoc+6LubE7Iqq2iSo0w63maqKLzklzl7yEcf8AuHrDeMEcQK87T
 i8yw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773890707; x=1774495507; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
 b=GeMZIvDXMIWnqOR5r9IXuLHHVZNF0yIYj9FTKuoMuDbD+NxexA033bDLgHcBBUumzW
 Re0aycfEclkHVSeYfydZYXxIvZtRM0PzwuQ0UbWnX1SYqdG9zGfpWI/m7hkQnE/Uk0y2
 t5Bj42HrVrARPj16Dpik2+f0R31E2Hg6bCHRlpDfVPEcSnwfyQYao1rQy8YVxmnuV1JF
 2ZWiy5VDF5ut8OAuF3xlEtSLQzMluW7Z3JqaSwf/bmaz3EEkVBv3av5xCxdk4zX5euug
 jDxmXh+dSBF/aOg6LrrhsB6aloz4VSsH3eziri6/v2iADD/Rls7zBjlAIyeI9snmBYO1
 S7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773890707; x=1774495507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
 b=UR1sp+UWjAMy1SfmloulEckEyXfeVPuPIOYvDW9DtCsV79ttkzNwD7ao9hRPaNbJ4T
 AAieOd+uPrduT73XfH5Gfmz0IKT7tyhKJ3CFPa9xw7fP/AW+GdGaqzwuM18LsKS0qprU
 JSLUDMDxm8P0LifQEZi9I1ZBknQJO/4XKrZA1T/IoPSI2PIWH9FdeItI8BztZedjeO9r
 J0GXALXGNV8hGt4STZTWfaf9rZPQ8CQnIPKXRYwl6aXvdg6gDZN///ciqqzQFpJeflJx
 rzKpXLeQJylOMh4IOE0rQIMLotOFC+V8LKYt+SJKi/9V5OhIPWYJioQ92g4HA44ko7Tk
 z9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg3D+MXkz6Nd6iLBW1ps5cyxT3sh+IYsMsCYkV0MraOOfs/cX9iU1fM4GCbzngp0xdPdABepGR+PCqVqSkC5z2@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzE+/WoHIDqBo+gYjUbrr6J2PELvZ7b3TFevEjslfTEeCwEOQ2r
 /QYXnavTK/ORWmg4eTdn4CNf/hZKsBJxghq7THH3jHykLJuYn6krXcGbewTntAkImbVm8Aw5jNb
 oisN5H7+3yntC4e+l246dN50mr5DQjMg=
X-Gm-Gg: ATEYQzw8OkwhnkH98rjPtOfFfsMEbAS6KN4YXzYUucXVn1GPl5hyZ/Jl4sTB7L1KJqi
 XO+MMRMjlsDrhx4XsRNAMqZIrMaWkHEuq1yxIDDhZvYOq/5HUD5OUr3mDYDZu9cOMDZj9kk9YXh
 a2PqfXYMNLx2H+oRTsMR+b8tnC0PFcvIhm8Yxq3fb0t4vdwztYjgSBUlKf86be9Fc0vkzOtvCif
 H1pTv6/vYoeZM77zE2etaWz9O4k44KRDwrv9pkNkcZ9VfX3bMz33hUcUtQpySINDq/18/ft1HUq
 GB+bjL8=
X-Received: by 2002:a05:690c:ec9:b0:79a:6e1a:3f2f with SMTP id
 00721157ae682-79a71834809mr67186207b3.13.1773890707339; Wed, 18 Mar 2026
 20:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260319022335.3213311-1-zzzccc427@gmail.com>
 <20260319025710.GA357817@sol>
In-Reply-To: <20260319025710.GA357817@sol>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 19 Mar 2026 11:24:56 +0800
X-Gm-Features: AaiRm52go2qevgYqXTn06GleSzroBKX_LMCPd09ZGdoi0s8xlATO5QEwKpO4fM8
Message-ID: <CAFRLqsUSiS=azce_Q8AB1J=eZGsknorSaVJW7qtSTd2czY22ZA@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1w340c-0001HZ-8i
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate data races around fi->i_flags
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric,

> Is that really the correct Fixes commit?  I don't see what it has to do
> with this issue.

You're right, commit 360985573b55 only remapped the flag values and is
not related to the race.

The race is between the lockless read of fi->i_flags in
f2fs_update_inode() (from the writeback path) and the writes from the
ioctl paths.

The read side goes back to:

19f99cee206c ("f2fs: add core inode operations")

which added:

ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);

I'll fix the Fixes tag in v2. Please let me know if my understanding is
correct.

Thanks,
Cen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
