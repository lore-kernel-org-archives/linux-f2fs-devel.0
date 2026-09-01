Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD2C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1y+40uwQeqrP/FOBK6SP8DuN5u4GglXigg634If07E8=; b=TsT620sezJsv7oDWaDQvHCU3Ug
	QeXoISF7jeyYaK/C0gfzGHdpHdH1UnfGC4u9FQpjOyn+/iBBzXay77+a5zLlffYzFMCYWKjy7zN8k
	5/Smtqt9Y5SWu+DzVsjLXK1zlndMd3Hw43C8CPgvgI7/l/XipV3dRjQiZ+ub47tNt70c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Edl-0001hi-LE;
	Tue, 01 Sep 2026 02:54:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1EdL-0001Nx-Mj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 02:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hnhudaSsoqw6ovaSVsUuE3pS2LqCa0PRcmc82+XnLus=; b=FUTh6hsJV/WRluLXl3uvQmkEer
 xo2ILGQ/rA+aiAE9h0F7GVfpND4VAEPKkPydgOYVyzFfdyKGVm8cOf+kMo9Scq9VV6q+EfZgoRf/f
 Ayzcg1hy6ej6hwOtSyoVCVWmJIfdGxKpocWXn3Q80sLhYE/3F7sDJVEJi3DUAW7eJbrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hnhudaSsoqw6ovaSVsUuE3pS2LqCa0PRcmc82+XnLus=; b=Wmpgpu6poOaMj0fAMWGU0BT6Pi
 P5SxTrP1lYFMMF/HuobOkStii7TDZj9DGiu9cfBSRCO/0cm/ohvFR+wkADLl/QGTyN2I8bHv1hhIr
 pxFxgs1SVC6BReLWBF+dKmxoWzuE1oURyyiq0ar4Q9QulYrDtusy5vZxAjG9Gti0JZDw=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1EdI-000190-PU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 02:53:57 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so4351590a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788231231; x=1788836031; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnhudaSsoqw6ovaSVsUuE3pS2LqCa0PRcmc82+XnLus=;
 b=MpSsdKFfbTuI+4hcqq7tDPVHAh9R3dO41B1Admzq9+mmzy25BN/hfxuHLg2EPdDSGR
 aN80JE61YclyCZlLN+6/2j058mAAxA8z5cMDIG02LIeigZPqD1VmA0GDe9H4JAbTpKlf
 zE11UsT35vFOkTGR8AH4smEVEscT/38n5QHBMOd0EHirfpNe73zq8mbK0Jkw+S8vmqxL
 Drbx5gQOZTjn65f9SuAhBzVL3OA4AdV4+IlkmiinFIZogLSTA5SBXd5LoFK48ki80YKD
 hOLGE7P+SwcZgnMiRl/mSOKZUhIc7Mx5HH1fG8e7hN7d6MR904T7VVrzOPAKZ4NDzkBm
 odUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788231231; x=1788836031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hnhudaSsoqw6ovaSVsUuE3pS2LqCa0PRcmc82+XnLus=;
 b=RbfCNG3byaqmgC/Pw6b4oW2/PbowOvHmeQrYZOs/+A6yKvQR8LVFNxVbR43coEbzAr
 38KdZn11CuJxb/uMwgjWXIc5eIeMnWVwWSRkB79C3YfrEQsFnTD6sv/e7toTqfw2kbLe
 dK2R/6OopzGxX5Vn+2dr/ANTWGddHNp8KLIo6fxKJyR43w+R9qUT/Dx90JUHSVyqqAI1
 BjpsCk5Pe+LEbMTyMxsoSTsjE8Mw/t3zSZfp5Qs3kTlwW/ZZ9AAQ2L4zd/8subWq7OJ1
 p/2KYnLbyaep+Of/HAeXzQr47anpEt5/SHH1Y6/Cy5A7qv9E4Q4/GpyyNNvl3yCpptej
 WK1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByQlf6sS3czGa8Eoc1RD0tbRyPj0DyxFyHhg1EPnfGHjmuHsxfLwyjC5fa+UD2+5Hdiw0Q5okampAmjVzcl8bn+@lists.sourceforge.net
X-Gm-Message-State: AFuF++m0AEMoaSawjTEvUoZddtfWJGfIirLCeUCDsF9kOitI1+V51uNH
 PJPvF0eCXphU28WiZ+U7PMffovHRmvHRFaOnyCT0l3iWV0cOTDP1bzol
X-Gm-Gg: AYBFou3aHXwjGVLEGGDrsly7n9Sl+qzMEEsim1IdfkczhF1WPPVvo8IbZ+AeXl6cU3x
 l+aZi+OziGik5v+sV3rSzWn4NqyyYQPVL2XIlulMe6SZguArhN4ZDyMw98CcsRqji0eakAiljqI
 Ce9mZ9lUJhYR0oP0C9t3oh+GALJtffKaeDh1A0eJH2XaYy0csdFNpr0nkW4xzrdH19CxLnQAy4Z
 LJHCUUCnq0RzTyhYGUMqCrlnQQ5fvb0ExX0kOGzGd1kqZlP84CWAeh4Ir37Ux28eXLwYnFfF/as
 JJnz2AysgXbwI2PTEeGaX9T73b1wPVl5MChJLY6AnbsRxb8nobW+HTThbkHQz7tplwcgNxzDJjh
 TagWNgVNYAxq0vxqURCRSQru5xh6J4ozlU0JhLyjVO54ZBPiAZNAF5R6w5jQstx5r48xKF3YogA
 NLguWnka8SeRqS44dtn4zeQROzt8zL9EbtVCVvX/UO33lRyOxNuHDpbkJn6cAeebKprMzxGvvLc
 v2v9Oj9O+4+jU9QvzQQb6jFCA==
X-Received: by 2002:a17:90b:33ca:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-396d0a36c74mr43300056a91.0.1788231231053; 
 Mon, 31 Aug 2026 19:53:51 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d4c2bf7sm3053009a91.12.2026.08.31.19.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 19:53:50 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Tue,  1 Sep 2026 10:53:44 +0800
Message-ID: <20260901025344.3466776-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_z1UUG0e+LSGmer_mPv+YcYVcjFiMLZ6RwhmYtmrObKXA@mail.gmail.com>
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
 <20260829060524.2656620-2-qiwenjie@xiaomi.com>
 <20260829060524.2656620-3-qiwenjie@xiaomi.com>
 <CACOAw_z1UUG0e+LSGmer_mPv+YcYVcjFiMLZ6RwhmYtmrObKXA@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x1EdI-000190-PU
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: refresh pinned allocation
 boundary after resize
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
 jaegeuk@kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

The second check is intentional. The first check is only an early
validation before mnt_want_write_file(), but mnt_want_write_file() does
not hold sb->s_umount. A concurrent remount can therefore change
resizable_tail_secno before freeze_super() obtains the exclusive
superblock lock.

A test-only hook pauses resize after the early check and before
mnt_want_write_file(), allowing a concurrent remount to change
resizable_tail_secno before resize continues. Starting with 506 sections
and tail=1, the single-check version let a remount change the tail to
128 and incorrectly returned success. With the second check, resize
returned -EINVAL and preserved 506 sections with
pinned_area_max_secno=378.

The first check is the fast path for invalid requests, while the second
check validates the final geometry after freezing the filesystem and
taking the resize locks. Both checks are needed.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
