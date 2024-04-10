Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A3CD11C2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:19:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ruSFF-0005eC-3j;
	Wed, 10 Apr 2024 07:19:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1ruSFB-0005e1-NA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Apr 2024 07:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=; b=mSppE7yT4tSelS1DWCGZx7V9B6
 SYf2ZEoDlIUwYWY8GONFQApkggqdpZ8194upNB29UFkLiLXTyRVN1wK/k8Xguy5qrrUGtMDi0w1xL
 pHsd29hvq0hZiEWVGeD6XM3bLMoL4PFhl8O2qwgYU0bzigDUlWeKeF0EYVMkixW7PKrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=; b=CgzqtM41oAit+TZ+b41kiqXzEb
 A4zALnFvBxX6pNA7FJYId11MZPlpTwg1gImYIpUuukNFPzEr9TplbXLjTYYrGMjt4qOD0AydOkDw6
 b4pdbMdOX5dQPTnp6InRe+CeVUtsktKUVhpRhFH+9Br6cImZksEuhLOlEPrRfqngzKsk=;
Received: from mail-lf1-f54.google.com ([209.85.167.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ruSFB-0006ad-7I for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Apr 2024 07:19:41 +0000
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-516dbc36918so4961426e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 10 Apr 2024 00:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712733570; x=1713338370; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=;
 b=NAhmZwQ0xtGFgozCpk2wSMaO9od/o/qA/z2hu6B44rwV0JXK0kPATQnW4wOvcUnHo3
 MIaJq/JpC6O5GLiItvJQ6RfzDmd0+kvTa9sUCp5WgBeKR54Bm8O3LMTy12ucCR6an1bJ
 tlZXoq3Jwx0BsOlqmG2FkVGKdZmsrJVyp3lFXXlb8i0p+lvq+UL+XiXx+tiGhLz47fem
 ZDu8qpAVdQvunA8ptnCRfVS5n8OsFXgXPDND/ks5fFNo2CHxupQ8far8PP/1n6keIbi4
 VM4oPrI4CgnWWwLeoab9GQUyoM0nXmnhjerr82TTZX2zP/BNz7JR0slCWokXIPCDlnjp
 bNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712733570; x=1713338370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xk1Admx7MIzrGsfX8zRP0T7PyL0wgFiVGzBCYwXkw08=;
 b=lNupyYxCcF5nNuEqNB/4vpeFuxFhsfKvqUiBW4fAaxX85Nfi/ixS4BZE4pENt6A+KY
 67LLTlu7iVhbUgmkBfJvZNqcV0l27iMcI1RdWjqjBOyj9B377y7tcFVKs7h6GLuuidYt
 /CnOkX01vDAVgOud10QWbtdgPcvZgFVAFYIuk8dvMsJDIQz4w5ktVFZjFQRJWmsEEbB/
 /Jjb9eRyYIStQxsogisAV74OlZraT0UcxcOM83NO8Isstf2mcbsZklQdaq5d0bnTrMgR
 IOlOy2tRavzZikizdu1LyZILMHH+/OrvtUoeEv351k2h9At2QMwEPp0tlch+Qlm8pnn7
 5mJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa9jMnttnzEDG54E58SBPuR1TYpVHCLgtydpQnaZfsto4G5ybibMDmKKKxJJCN/YzHPxvQto7HCfzm0gHGd8XfuNNBcSH4SSbAGYgEOCTLWLbTHgmEVg==
X-Gm-Message-State: AOJu0YytOGm30/3n65k8stSuaTOh73VhNueoN/4/JVfS4UfAidEdUtak
 B1lUCOFc00Pcu++5txN8PZioQ3oTfhAONTy+PyvYTDzFhZfXKRZlvhjm8X44lsJF32Vd5zjg9/o
 D7QoZguR+p7/ZwZb9z53XLrtHZOM=
X-Google-Smtp-Source: AGHT+IFJkOM+c2FBQgti9Bl4CgLt73ULYBTLadRBlGSY4yEmzpllD4ijLFUz0kuwMwcVPps4VDyp3PRKDEGxaDdg4Us=
X-Received: by 2002:a05:6512:230d:b0:516:d27c:f6c6 with SMTP id
 o13-20020a056512230d00b00516d27cf6c6mr1250477lfu.35.1712733569630; Wed, 10
 Apr 2024 00:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
 <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
In-Reply-To: <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 10 Apr 2024 15:19:18 +0800
Message-ID: <CAHJ8P3KaQF8okMOyagH80+BmUUZ=ENSoAApz2H-p_1=Pu5ZTbw@mail.gmail.com>
To: jaegeuk@kernel.org
X-Headers-End: 1ruSFB-0006ad-7I
Subject: Re: [f2fs-dev] [PATCH V3] f2fs: add REQ_TIME time update for some
 user behaviors
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgSmFlZ2V1awpBbnkgY29tbWVudHMgYWJvdXQgdGhpcyBwYXRjaD8KdGhhbmtzIQoKT24gV2Vk
LCBNYXIgMjAsIDIwMjQgYXQgNTozM+KAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3Jv
dGU6Cj4KPiBPbiAyMDI0LzMvMjAgMTQ6MjIsIFpoaWd1byBOaXUgd3JvdGU6Cj4gPiBzb21lIHVz
ZXIgYmVoYXZpb3JzIHJlcXVlc3RlZCBmaWxlc3lzdGVtIG9wZXJhdGlvbnMsIHdoaWNoCj4gPiB3
aWxsIGNhdXNlIGZpbGVzeXN0ZW0gbm90IGlkbGUuCj4gPiBNZWFud2hpbGUgYWRqdXN0IHNvbWUg
ZjJmc191cGRhdGVfdGltZShSRVFfVElNRSkgcG9zaXRpb25zLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29jLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBD
aGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4KPiBUaGFua3MsCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
