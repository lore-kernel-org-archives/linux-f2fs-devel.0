Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C34C79FB7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTJENHWrgt5E+KsRkcyfinzyAcNBGJovV8ul8tov2vE=; b=FSrnSouMnRyCXtkTfcJLusUCbv
	DYMXDeI8ZIE8rJUpXJGbH1EK8fIgTuqsk6eCYysEPCIDsbHI2E3tN8eN9VK20gqB0EMX6ErEv7B8X
	5oSwVn3WBul+7Ph2TV13zCH8JnctR1KEzFKi3CpNHn8Kr2PVo5TvXRjC1p3hXoJRBO1Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4O3f-0003Cc-2k;
	Wed, 09 Sep 2026 19:34:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4O3d-0003CU-KF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BVdtMSWxf7icB7wBjmlVHIP4GsX+nPXsq5J6fcR2a6o=; b=W2uHHPVL3c7DyT9jTKTi4N0e/1
 xA+B91t2kjrWpVnVIQnTNkY2K6GccW+nBCvp2ZEYff9kvQyr6cmNGZgppmwW8jWG1ot+4U4ccaWQ1
 spMvmTu0him8ZK3Gf8PsIm50pAKeVDHXoVQMObwpHhCqs1rQAQh4ncN1R/eGuDLhEJew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BVdtMSWxf7icB7wBjmlVHIP4GsX+nPXsq5J6fcR2a6o=; b=ArGO2YRClvnupeGPAXmgq/RAIo
 zPJbhtw0ramlabdWLhw66vrHdgBhGg0aesCbb9ZOO6EJMQ1f/14amU6pZbFnwb4vZ1Fg8SNYOCnpt
 MzuM9sKHfBURXHhSRZDhfmXkj9mDkt++XZv7WqkvPDoGr+kBLsNC7mgG05mtkSNCfQZA=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4O3c-0004VC-3F for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:34:09 +0000
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b89986bcecso487331e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 12:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788982441; cv=none;
 d=google.com; s=arc-20260327;
 b=pi/1em1CeR1ZyVb7CM0EHGLKcqRXYJoJxO7NsXHsPeiqWeZdyw3bx6oxI0JCWofPGp
 jbx5Psn34AYRBUfeOVTPPEbwRDks836POce4G+71vdM+YJUHMBOF0m0Eu8KN/Js+fPY7
 CMpgsrB4GNkTpAUAXh8xwaQ4yXt10hhQuhjEIHsyL++Ko4O+wYN60jEppGe3wpsFrRWd
 04yESCwECkR9s42uPRU6VqreaLRyWk9jQ77hxQbz0C13yJOxVEuhkCMCvc/1WwU3Vqt3
 1qGI4OrznuAN9G9NL8RmL2o7kMhmw0ZcKm1zGz0+1H7HNAUBgSGSbd/0kW1O3OkN457F
 LOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BVdtMSWxf7icB7wBjmlVHIP4GsX+nPXsq5J6fcR2a6o=;
 fh=w04EfBzkVxESR7oslHf9Ad4/ROH9wZ+4UuOc/8aWB10=;
 b=byhiB8n6wXzTVFRzaqssk6jzjRF+LlUp87ygjFcC0IVMbC1AeG/EZbrBf98PirMyBd
 1oRFnfYGPqto3i5gLlpDddn1c08jy8ROjrzDCMWwZoTiSTUYYc4xArv5CVR5IvEkQe60
 S3AeBas0hx4TbzvVHGaSe6PZSHrqF172pSgrQxYsh8YnYTBnHMQvlV65bO01MJsQGPd+
 X5dCxpb/4x3TnAkEO7Abo5ODQmofgoSm6Wyrz7lmXVTRTDZwArAJtqX8ug/ZSsswXhUV
 kV12yroGVzz0bwAGwynBPVuYC3vRbmA+0scnFXOnKl8PiMaihI0hkoanAhuPx07DLdyn
 PzGg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788982441; x=1789587241; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BVdtMSWxf7icB7wBjmlVHIP4GsX+nPXsq5J6fcR2a6o=;
 b=E6uDsE1P3OTFW8iGkNZMRIDHTH6Rn4KjxDhOKkMvmvhRrzFEMUHM1MoGORHIDYqPtZ
 I5ikkc2A6D7GYC9T+6Eb1JkPuEJerlaJSbNg2b+vL5q7hRjjXad8d8C/dK6f/8MVPPYU
 NNlVnyPPfj2XVAivR2PEn9uCK/zZGWidwc/ZbwcaiOY2mKtDsQ5xlyQaqKFTZKXXdtXO
 /KL3BWuLvcFbuEFgR1FZNz8ufCajG/4lSFt9uXYQRHdh/v/EBH/Mf1nE9MGNTnRaH5rW
 3ITdmmU5Za9sHQDmozF9H4uHpw6Xmzjxwm89p9P4ULIwIb1P5olVByRqpZImBm1Hkpyn
 3cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788982441; x=1789587241;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BVdtMSWxf7icB7wBjmlVHIP4GsX+nPXsq5J6fcR2a6o=;
 b=JjpR3HoBQh4Czdm3Z/9liV26e/8b52optkV2egOAZIN1rCO0+2ccR0/NR/mQ+fYgNW
 S7ffSqDrOmZPrlMI2WYpK8luILwFpz0fWql0Ut/FkS77FTwUfUeX7y1P/l3a9D7QTAvB
 EawiOxiGZkJ8Mx5B73mt8QHX6fYVSo6REVQT3tXaRVyhKIHnph0iSO8Ud+yW6aYDqvU0
 ZYGJHdamWmH2LcyMZW5xlQmy3D9wdmSW9jqNHBE9+yKbSQhdz1LXAY9BW3PoTBT6X4Nv
 3eo9nmblu8YjVzMI5guI1KkPffsBGBDeTUd31xJVjqTOuo4bwr9DKZS9QHEooYXagU4j
 D8Kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE1zfrmvgQkj9/VcEKIpUDsck41AUzhh5apAzftGlMcEBPj7exaWLZpcmWapdh8Fpktg+ahxQ2NyXaiBnNXNZM@lists.sourceforge.net
X-Gm-Message-State: AFuF++kM+XdZkuZCHCaZB+1yPEG6AzMPQIzdM6I6tN2YYFhb2QBt8V8w
 qDkrh4D2tzmfWrmwH1XL97q5XYmuth4rO9enroto/In4qn9kL3MOI39BUCEhYqD/BIcZIVFnRg6
 xcCM9VvrqeKdW0rV+lZ4ypFdd/G/zAzY=
X-Gm-Gg: AYBFou3mZOUz3MFEVHf6JvEZNag7BjStqmuOxUxURak2ifVNf4Rt5iB35zIKm9Ya0vX
 hAOc6WQKqIVg73Bt6/QaYcTM1jnCEXlH4WMPvtvDhs/S0Ug+AG9fMyYVYwBTQ5e+7PYxZqVx8H1
 koB6I8mELejvkwrnwLp9NGG9YcLjOifcdPh+zyr3hcfSFB1/0Vjtw09DiWVFdMfYUxFO+wIbph/
 NUhyuVZsRWHexSzyGhIl43jBqKlPqumcppQLp+po42e94Ao3tCQPe3Gux2o6bi2VjHuSLEWvMZo
 QlODgeiu5g/4whg4SfiAWqDHuUY/HmE3xYBDCf6Z+xif9dfTgkIFiles7LbznRQiPLrcYm0dnGG
 mjXSq8yZRsh7m/y6ltvdj6uwC+FVpd/sghsGeU/BZ61kOQM5Gj3G+x8A=
X-Received: by 2002:a05:6512:1093:b0:5b6:183c:5c91 with SMTP id
 2adb3069b0e04-5b6183c5e10mr6124641e87.47.1788982440939; Wed, 09 Sep 2026
 12:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_yO+CyS=xBDA1iRTfjZtm_40wLGwD6TZQLRN2nFmuw7xQ@mail.gmail.com>
 <20260907114553.2551964-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260907114553.2551964-1-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 12:33:48 -0700
X-Gm-Features: AcwNN1WUDSWydzjn3Er-hR5IhocfCQTX_w3kug0YfdBpl4DCR5cKCHHj57XQObQ
Message-ID: <CACOAw_wBMigWOu1cyZgsqd2EVH_mO_HN+y=g3ryBdMSFtX6cig@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Headers-End: 1x4O3c-0004VC-3F
Subject: Re: [f2fs-dev] [PATCH 07/14] f2fs: make GC migration large-folio
 aware
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgNywgMjAyNiBhdCA0OjQ24oCvQU0gTmFuemhlIFpoYW8gPG56emhhby5zaWdt
YUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCAyOCBBdWcgMjAyNiAxMDoyMDo0MCAtMDcw
MCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBVbmRlciBQYXRjaCAwOCwgYSBjbGVhbmx5IHJlYWQg
bGFyZ2UgZm9saW8gbWF5IE5PVCBoYXZlCj4gPiBmMmZzX2ZvbGlvX3N0YXRlIGFsbG9jYXRlZAo+
ID4gKGZvbGlvLT5wcml2YXRlID09IE5VTEwpLCByaWdodD8KPiA+Cj4gPiBXaGVuIGZvcmVncm91
bmQvYmFja2dyb3VuZCBHQyB0cmllcyB0byBtaWdyYXRlIGEgNEtCIGJsb2NrIGluIHN1Y2ggYSBm
b2xpbywKPiA+IGBmZnNgIGlzIE5VTEwsIGFuZCBgYXRvbWljX2luYygmZmZzLT53cml0ZV9wYWdl
c19wZW5kaW5nKWAgd2lsbCBpbnN0YW50bHkgY3Jhc2gKPiA+IHdpdGggYSBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UhCj4gPgo+ID4gRml4OiBDYWxsIGBmZnMgPSBmMmZzX2Zmc19maW5kX29yX2Fs
bG9jKGZvbGlvKTtgIGJlZm9yZSBhY2Nlc3NpbmcgYGZmc2AuCj4KPiBJbiBtb3ZlX2RhdGFfcGFn
ZSgpLCB0aGUgZm9saW8gaXMgb2J0YWluZWQgdmlhCj4gZjJmc19nZXRfcmVhZF9kYXRhX2ZvbGlv
KCkgLyBmMmZzX2dldF9sb2NrX2RhdGFfZm9saW8oKSwgd2hlcmUKPiBmMmZzX2ZvbGlvX3N0YXRl
IGlzIGFsbG9jYXRlZCB1bmNvbmRpdGlvbmFsbHkgZm9yIGxhcmdlIGZvbGlvcy4gU28KPiB0aGVy
ZSBzaG91bGRuJ3QgYmUgYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaGVyZSwgcmlnaHQ/Cj4K
PiBUaGFua3MsCj4gTmFuemhlCgpBaCwgSSB3YXMgY29uZnVzZWQuIFlvdSdyZSByaWdodC4KClRo
YW5rcyBmb3IgY2hlY2tpbmchCkRhZWhvCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
