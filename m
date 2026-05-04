Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFBAFF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 May 2026 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLGAfspoLTykr+D4p9hypLug4oqi+iO1m03p992Upvc=; b=aDIEUXa/7QbUIrjyZ59ZCv/TAz
	ZAjPbwEXQFsEmNfsTqxplMGAhU6z2vi0fXGGrCLm+LbqRSVTG93vGCnK0EsUJfkI4PyvEfEuDEOVu
	nEtJGY5vHvuHvvQdrmVDBeLYw7B+Ukh0tOCUrOmzKz/Rgz7EWfTegvmi3Z2gDtdD8XMI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJtDd-0005Lk-4J;
	Mon, 04 May 2026 13:20:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1wJtDc-0005La-32
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 13:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U2qtTlsoKwyo7bVCINT7mqcJokLylay0BKnY4TP7Yrc=; b=P7jegZndZifSD0YB90cAU/j8C5
 N8TTa5U+F/hf2ufHamRtJjlC4R8UKEMhrrdEdcs1GpIAfmWETBoMvYJlYltEs0qJqUUibakq65TJp
 eFcKANTw4o9te/1lIMJQdGjLrwxJ+/8WRSsm3lHScenjiDxU+WSodi39pbFqQWZik8uU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U2qtTlsoKwyo7bVCINT7mqcJokLylay0BKnY4TP7Yrc=; b=AgSAav8ucqoVtwEVvUaX/xcj/y
 olHbqq/AEGalQBJyOz24rbso7sgO4Epx9mDrclgNBZYmfQvY0ic2VxdtgvjR0LBwC+M8VfSe5EACp
 L6+EBlIJSOgrYS0DmfeJJFQcN1dAcG3o2meQoWiPx9Yw4Len4dTuPHZYGvgYBDXbeNG0=;
Received: from mail-yw1-f170.google.com ([209.85.128.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wJtDa-0002tK-P7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 13:20:16 +0000
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-79ea87af213so71817957b3.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 May 2026 06:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777900809; cv=none;
 d=google.com; s=arc-20240605;
 b=NAFYOB8qZCh/qkBFttAW3kA8mxxrWS2hVj0vXHFNZWQeCdAUv6eZ8uSV+dLVG+TFX9
 pd3xAMrSZ288BP4e9Atn6psfKDxFNJi2VKmthtDta+yzA4htTS6inTku+MXVTYC0gDHD
 KPyKjk8bIpwnXnw7wCkXVrgwaFIutW1Te9Kf6YOaowIvBqJGi2wc3ODghYItInoFdn3z
 dT5VRQ3cikTXssyu6cn3MdaJKs1EFWi3IBIGZPHvasWZovLzAmbmPgT3uQJTj5AorI9I
 jUmtSWQEFQey35QDuV7nqWYti0h0vPkseIlg3QPdv5ZGbjBnlzTfE359wwi3irTLyT19
 S+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U2qtTlsoKwyo7bVCINT7mqcJokLylay0BKnY4TP7Yrc=;
 fh=ELY+6SQM1X8cYrT0fHA+igVj0G7c5qgTspgoPM76YaI=;
 b=jqIABWfRaYlAILB4UUa2ZolLF1bTd3kKNKdhe8ji2spsHg0cgLPlctxTU+jEmtSjns
 42dZHYue43vTMKVdxnZXfDQqyB7nU5FzBsvCWk93TR3alLdepphTWn1wagx8FRsHPBWj
 2dyfWdESFSeExQs9hFdo/QstI5GLDmRty64mNmMqnH0vSSIwNTndGqiq2+kEGiaWAjF9
 jRGTdOq9fEQQWYn5NzE4cKP6F6Tt4cSkkjyyeEaIGxVW2Ey/2wJgc27PkbMTurLLBWCH
 TuPvYigyrGo4C6Ua/y4iqMxKyRPV1g7/ykWc2bi++NGQ7M7Ll7rQoCMsHlkrPMaOrCFe
 SBkg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777900809; x=1778505609; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2qtTlsoKwyo7bVCINT7mqcJokLylay0BKnY4TP7Yrc=;
 b=Na37CN2AS4I3qKMCoS9XVq78Gdayi0hGSC/NJ+lg1fygpKVlLJAG4+oM3/x74HFvrx
 oDI45bO92XXVBjXI1i/jQoFt0Eh51rgLTeXMrE/lkZucIjkhXxsH2uKKYYDmyLxqcBWH
 CXGJFYtWw3V0+ldrfnf4jwNnmIxNZllH+HSd+awwonUMTgGUMr8ck69YOgyWsC4ZylSD
 2orrALUZgIwRQ8qFRhHV4p2jF3Wd1hJuJpP2lJHduwZEBriflk/+eElkajxoVIX2GnQR
 JcsCKNzZUZ50HipkxDUQRj4WMuRD4yS4qa3PmK0UlKcHyXMjrhKqo7Bz9XCuAq7fOKvP
 xAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777900809; x=1778505609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2qtTlsoKwyo7bVCINT7mqcJokLylay0BKnY4TP7Yrc=;
 b=E4v7SV3gEcYIa06M6MnFwWeXFz03h/HG5VVsVfN6BioWMihbL33gj+inUfSb4HWRhx
 1BU4uTCmX0yVYrJswMFp+fNF8C8J3itiGdQ7HxFXUc9DcJfYXLaRpoe0zl56DuMCGvWL
 X2GhH/2hdgqmePTRBusLd6Lnqa2AE+LdeiBhGEWtZXsod5LKdDep2B8W7SOXIm5Bzmkx
 vMq50dk/y3AJmv2fS/FyiWynvS+/txY7O7kRB8bRPTIcL+xmeKJ6oUvzrnhUDiS7mW8G
 pjC7rYlc72H2thTDj7pMTlsfmzFxC8HP8gbI8f/uK2xiHKLwvKjE3FMaKFMcCVKEeFZt
 KqYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YLemQqkHUjbTn8cTkB+SvRQh5nvH/i9zwcTpkonDQ0bJsC+TGgFMijkdg7e7IdRHQXNGlrhUG6TqtXQNOoU+k@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx/LrjQ/jvIuBz+yQ1qJAxa1QEmaqylWq7Y2sBJ/v4Aa4/4uc/2
 MIDSW18YHvDa62hZ0pcpIFYLC0x8MKfUL7jGdHvPq9sbc956xhPVKBHE+9lZUf063rKkb8Zp7i+
 +aPXoK5QV6b7KxGUqi7CzJQQ+dXcekQ5zKEXnWdVhn98v
X-Gm-Gg: AeBDietepQaiA80eEik3KjNdYLOLja2uyIqlckrgiKvFjHyuUD7ytYDqWaWtJzCoDJ5
 nXU2Fva4b05H6a71WTskgqyFV1fP+wQd4H9f1xghfyqgpiyMhUxsY5+ky0lFls/tXEq1/HwI4+/
 hnfH77e14QF/9xbmQtFF4gSI4cjF8/bBC6i6CZ/EdVuzUp91snGovc4t0/2B7544l8K+xU+u4ii
 fcek2o6xNQQvO/0toCnIuOGEiW1QB7AjtcFD6nXWvAAwglqh6uzv10ZEdiXP1XkwgoUkdMctJNp
 RUelk7zzDqJ5Q6xbPMg=
X-Received: by 2002:a05:690c:f15:b0:7a2:46b8:3858 with SMTP id
 00721157ae682-7bd566a191dmr130166797b3.24.1777900808871; Mon, 04 May 2026
 06:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260503045820.973718-1-zzzccc427@gmail.com>
 <2ba0b3ad-615e-43c8-a165-af631607a4c3@kernel.org>
 <CAFRLqsUirEtA4+xxVkB9B71+eaqHa+nk78HxT-eAHEW2erJBBA@mail.gmail.com>
 <87bdc398-9387-49bf-ace1-7e7101661767@kernel.org>
In-Reply-To: <87bdc398-9387-49bf-ace1-7e7101661767@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 4 May 2026 21:19:56 +0800
X-Gm-Features: AVHnY4LCvXma5aOr4psZM4luCoAu32z4biIE_ISm_1vzZuq9n7_zyQpHhW5UHrE
Message-ID: <CAFRLqsVujW9h27JdFy5fEC+Qa_-a4jzcPbsa76Bq559oRDN==g@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wJtDa-0002tK-P7
Subject: Re: [f2fs-dev] [PATCH] f2fs: start discard thread after mount
 recovery
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
Cc: baijiaju1990@gmail.com, jaegeuk@kernel.org, quic_stummala@quicinc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Dear Chao. Yu

> Cen,
>
> I see, thanks for the explanation.
>
> Can you please update commit message w/ the explanation? That will be helpful
> for reviewer and git blame.
>
> Thanks,

I will send v2 shortly.

Best regards,
Cen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
