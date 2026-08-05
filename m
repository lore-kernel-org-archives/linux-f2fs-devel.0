Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F9DC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=clwdC2MGMLhhIhrFmomUghU+xD4xIJS5jZ3P87cC1Vo=; b=ayNN3eDuYoRBjtvnAtmccdS6FZ
	nxyFH52XB3oyVbUlPwmEgQ1oJC8CqR79N6WJKf/UITJy5tXMLPzD8RrFK+L7I2dH78r0g3LAO+y1P
	h40Z0/8yeBkquSjhiNmDaPm0/O1a0LFjwRs2lqC78U64wwZ5+mgMY3IRfo00RYZQAsfM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrQrn-0000wu-4u;
	Wed, 05 Aug 2026 01:56:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrQrl-0000wn-Lg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmzKqbfPb1H9Kqqi+KhKqEPKX52mImv9cGOoNpcsaSM=; b=BtaBOMKiCq2GYYK7Z4z9jzxaiH
 6V0gagbVxExRXdy5s1MxJ4Q2W2LVkX6Cd2gRvxZLPZwGZTugXvp3LadMqq2EESR91qiSOjD6RN+3E
 nxFmDAcZTsEDaEWuhTmBEPlBGPFT9hwbkVI+MwyIVV8WYvh+PR41hiZjb5XSD3urO4qA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nmzKqbfPb1H9Kqqi+KhKqEPKX52mImv9cGOoNpcsaSM=; b=SgMTY9TJ5dfnxeQMyL7G5P3UZ7
 dUfXcLpXXYRMNYL0xoEHQ9t1V5CZjPh82COdHH2ddMydoNqblvrMKAVTkN5LcfG1ybnm4A/invvzp
 IPtPyrgTpbeRUWrpCh0TDyTmFL5qE++1eLAZzEhQiCiJ3rLbANUqYidnZzehlzkt3OfQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrQri-00009G-NO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 01:56:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC13F600B1;
 Wed,  5 Aug 2026 01:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099131F000E9;
 Wed,  5 Aug 2026 01:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785894972;
 bh=nmzKqbfPb1H9Kqqi+KhKqEPKX52mImv9cGOoNpcsaSM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=F59aVum9Q/Op+ViIDTOgsHDSZEvlGUnhtwksQ4cosb+uaxO1auWhbU2hDKBxfpkBl
 esUW0ghqLX7K4uvTTqC5KD1YexSCtZSehFolVK8+8dZuy55inVuf6IpFsOU2Fw7q95
 CEST2O6lBFNuy7ORkcKh7877W9972TAGAwm+E+lTG8DxOW1n8raX8FrPuk/GBi+0A5
 qHKo3cj7ntxKUc/UiVUF2KH7yWQdXm/uUDWkM+pGfoxs2QEvrrK3SAlAmQCb0MRTYh
 thaPBjoOIn2B5534upTTq+jyS7ryYTI0LKDG08llTEGkxP4Ws/xseJJkysln7uTg2n
 ONtYxCSS50QRA==
Message-ID: <5874c3fb-f697-4894-b5a1-da3c0d1dcd35@kernel.org>
Date: Wed, 5 Aug 2026 09:56:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Garli=C5=84ski=2C_Krystian?= <krystian.garlinski@cgi.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <YQBP288MB009831270521BF40A51BF32C99D42@YQBP288MB0098.CANP288.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <YQBP288MB009831270521BF40A51BF32C99D42@YQBP288MB0098.CANP288.PROD.OUTLOOK.COM>
X-Headers-End: 1wrQri-00009G-NO
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: fix parent dentry for lost+found
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC80LzI2IDE1OjA0LCBHYXJsacWEc2tpLCBLcnlzdGlhbiB2aWEgTGludXgtZjJmcy1kZXZl
bCB3cm90ZToKPiBUaGUgIi4uIiBlbnRyeSBvZiBsb3N0K2ZvdW5kIGN1cnJlbnRseSBwb2ludHMg
dG8gbG9zdCtmb3VuZCBpdHNlbGYsCj4gd2hpbGUgdGhlIGlub2RlJ3MgaV9waW5vIGZpZWxkIGNv
cnJlY3RseSBwb2ludHMgdG8gdGhlIHJvb3QgaW5vZGUuCj4gCj4gQXMgYSByZXN1bHQsIGEgZmls
ZXN5c3RlbSBmcmVzaGx5IGNyZWF0ZWQgYnkgbWtmcy5mMmZzIGlzIGltbWVkaWF0ZWx5Cj4gcmVw
b3J0ZWQgYXMgY29ycnVwdGVkIGJ5IGZzY2suZjJmcywgd2hpY2ggdmFsaWRhdGVzIHRoZSAiLi4i
IGVudHJ5Cj4gYWdhaW5zdCBpX3Bpbm8uCj4gCj4gU2V0IHRoZSAiLi4iIGVudHJ5IHRvIHRoZSBy
b290IGlub2RlIGluc3RlYWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogS3J5c3RpYW4gR2FybGnFhHNr
aSA8a3J5c3RpYW4uZ2FybGluc2tpQGNnaS5jb20+ClJldmlld2VkLWJ5OiBDaGFvIFl1IDxjaGFv
QGtlcm5lbC5vcmc+CgpUaGFua3MsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
