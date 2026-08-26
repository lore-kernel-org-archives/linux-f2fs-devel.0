Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF313C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1adwINPN8uweNtg4jte9AwfprWguhlmpXPyP2mVoNY=; b=dRSEXGBsl3YWdvUYv7cMvN84Rt
	7sUoYC3kf7refyzhhS+jAI7JJtW/C05T+5IGfBnCifVAse3JrMVohHUwRD397DUJAuqPNx7nIl2uE
	NRqNPtDaX9lZKzMA4vNrKy3gGzWS1PUJ3p9rS3SWszsfp+aeGF4a1TQ/JXagps+21AQg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzLLc-0002Yy-OV;
	Wed, 26 Aug 2026 21:39:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1wzLLa-0002Yq-RS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPS8H8k9KpvigDORStPsZkpmZ1Nd6hAKRPDeRw+tD5M=; b=U/0sAjzodywrYWBl3WW593/D4E
 TPNtbxiBHwvYrb2dgPVYPvlO2Zxr/j2GM7Rbknmcp5K4PDWGvaOUNy074/aHVqheW2MR7ddK7P5aJ
 /r0ZttYMNVzrHDLnBudZPAArcdH4taDR31KxiTBMWS9kY/jOMJxczUmIj88Be7wNzaHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kPS8H8k9KpvigDORStPsZkpmZ1Nd6hAKRPDeRw+tD5M=; b=fgiza49lj01ALC06DX4swd0+Es
 PQJMCrxTMRrezfjI7jPa6C+85azX37xlUKOD7O58Y1q3/WSn3rqnXVm0nz5FpmMgLq1tWSH4mQONG
 gqEdMHK2ImTP0mGCqSs2Q9iMXhtNgyKL4Xg3L+7o1djx9AXIg4xtXOeaAuDuneReoR6g=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzLLZ-0002rY-5N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:39:50 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so1637224a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780383; cv=none;
 d=google.com; s=arc-20260327;
 b=snimoB6VzsauP0eL006lPRrW5UATuxEPGw1TURer3WBSRQqKqY5o3WEoXHEArffPAP
 edlO6dlhDjZOX7hbjQeFQEp7VjHN6wV2/6oWaeCmS0ND2/rmv9y9Ng5CqztnNQaOwyfw
 VxuDQ+eSZHU2dJr2IvBr3PZEGHnApZwg3AWd8c3WfV2PruoIQw1SrnryN27DwBHYS1k3
 c/JWpY74iR8UyVOA0J+F/nC8TMZANjofy3gl70et+fisip9SctdEZTftL75kQcbX0GJu
 QlmRbIjdSTIizz1hQcOr3SdVM7JITgPkQajOhuRtnjdw45ysZP16rkTaQucHDr3YZFaJ
 6w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=kPS8H8k9KpvigDORStPsZkpmZ1Nd6hAKRPDeRw+tD5M=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=ViV17qC4xqMFYBDd51swdxRyQRsyPCz6fNFnuqtAi/Xu7G9oT1Y5RnPvn0lXBxc0+M
 RUGMsAQCMSnZ1wCxgxGk8AzzjxDCL4HgXKeSMExo4H3OH10wYGijFgr5n2DcXLuAL+cB
 LnjWipxY8sI+HkFJGoMegkZyVq9gK1YCg4ODUheSOJhXn0I7qE2ugc2BYdMwSTdFlBSy
 DRLLHJMKaKdpIBUoaPpk8mUTj4D9Lkb65P9LPl0ZGxxicrMiEg0iWLUl48xh54dIJQ0w
 MsmcSQ0SCQtkcK3N6i+oFf9nNSUvBBOcwSW57oFhyLbsZGnE7RIBSDWvh1SY8poD3uea
 LMqQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787780383; x=1788385183; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kPS8H8k9KpvigDORStPsZkpmZ1Nd6hAKRPDeRw+tD5M=;
 b=hyR8MXGcCCI5UG9jbMvQ/im6MJHC0b9IARBapwYIVE+ETcw7w572GPtAMwJlXl4xx8
 YuZ5I5shZDMU/Oo9Rd8aA+hjzzQ9xGgrJdOdGRm8S089I8hdDOzfdoNqxIfaq++8jT3t
 Tb5K8jNAr3clCxuxtCZBu8jjGy9Iuk8wrU5AAE8eOXxdteoxPfYrB7UfHhmb3V4DDYgj
 JpCWJA6c43kOSBFeonqL3oyZ2PI4kJbqQPKdx02iTNHGalcgdAiannWPhMU0laej+W8u
 C02wBw3oJwP7kfqrJnHEmk5Qdc0T5+MSvfx1WHC+BjDcG975QqVn7Pksd/MMcY0njgvX
 lHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780383; x=1788385183;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kPS8H8k9KpvigDORStPsZkpmZ1Nd6hAKRPDeRw+tD5M=;
 b=tUpe4PWXMOFUjxs3F55maRq0yA3Z+PXCuG6P1U1LbnhUJ0csgSrqBneTiJ8STq+0he
 zE6vGCp9XbrfF/HxH5rFGD2ebgFYCTkNvxYXKLvalnSNLsGTLMmHwaA95NaGdggsgKuC
 e4Hi1uEv4XHRvG/gwvvIAK8v0VN3jqn9ZiIs1Dxc83eqrzGYPGQ44g6divMUEY+D6brv
 8E4HNKOFtct6UdlL6y8Ko1TYBKyqHAa28tlJR04453MqYX17gzZdpiYEtFwlvQEoZ0uN
 WZEyEs6b/uca2ZPh8sZWmJMZqWT641n/+drGV37+J+1autRNh2uLKfmNfer9p3hM8kkR
 hQwg==
X-Gm-Message-State: AFuF++kZtirgju0q8mztgNNMHOsnk6Aw1JAiNXOYOIIE/yd753hY1+V4
 vQlioR9yUkSgj5L1he9VUbawsW/51pMAvd8Lb6HlAg3XbaLINz+4tXPxxVAkpEuy8JYVLy7fHJt
 5nS8nQtaFPmpSXRKPFyT1FuWNXrEHL7+XDHVIfZo=
X-Gm-Gg: AR+sD11GSUoODF85q5171nJVVwURIIrP3yVKaDAo2vYf6ZgmI2msmWMtMEXTMh6/rAR
 sd4cTqWZliP2+A9rxjgP16Y81Kv/ZxWqw554eKacRX7i++QmHyYAs5fu1SpbXrHsAou+lU2u2lL
 s8g7blBgThNzsitMzkA9uRPjAHGmwky+evU6t1/ICvJxBjwhJs1d+CPqGa8hnLCTL6s4FunLb8s
 WaWFGgojo6mt6UGn5If1NssLjRgdK7CR9SIF3nvcPycFhzDXVvqWGuZZwbIwh/TZYiUjMwZHAsZ
 2+Ti7P9PZI7/CjtpMoFyYfWaQF3+Nh811fLAdWoEknUuLVvr7qsz41GinS7bbsfhm0gFBmuZt8r
 5
X-Received: by 2002:a05:6402:304c:b0:69e:9213:11b with SMTP id
 4fb4d7f45d1cf-6a5df63b59fmr10367592a12.13.1787780382483; Wed, 26 Aug 2026
 14:39:42 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:42 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:42 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
Date: Wed, 26 Aug 2026 16:39:42 -0500
X-Gm-Features: AcwNN1U2BbM36RbhmFCQr1E1D2roqKDYtg9A4YU1Yd15gl2_fxg9UZPTYYUjKjw
Message-ID: <CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzLLZ-0002rY-5N
Subject: [f2fs-dev] [PATCH 1/5] f2fs: avoid underflow when counting free NIDs
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

__count_free_nids() subtracts the retention threshold before checking
whether the cached count exceeds it. The operands are unsigned, so a
smaller cache wraps before the result is assigned to long.

The PAGE_SIZE-derived threshold happens to make this an unsigned long
subtraction, whose wrapped result becomes negative when converted to
long by supported toolchains. Do not rely on operand width or
unsigned-to-signed conversion. Compare values before subtracting.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/shrinker.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 4f6bf5926de4..1fd0ee4f89a9 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -23,9 +23,10 @@ static unsigned long __count_nat_entries(struct
f2fs_sb_info *sbi)

 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
+	unsigned long count = NM_I(sbi)->nid_cnt[FREE_NID];
+	unsigned long max = MAX_FREE_NIDS;

-	return count > 0 ? count : 0;
+	return count > max ? count - max : 0;
 }

 static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
