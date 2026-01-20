Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD1D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GI6wel3evTBdi5mgMT40JIn2k7CHYUpj9LsgIecdknc=; b=jj8gS8gbq7YdjNHl4xwGwfLiix
	m4WuJIoQV4OIsnG5xUy25bws5jNxn5XEVUYYiVgEhtcigKvtFc5UuYgnGNa3JZZEgzQo5Huk3Nuct
	OSLdZciZ2GM9HR3e7tZ0wLRzxNoi6NL4NezoG+nbWFHc1MQi7fgDzU3KOgh2dqfE9hEY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viBAj-0005x3-Af;
	Tue, 20 Jan 2026 12:49:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viBAi-0005ws-7I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=72Zqzg15JFpAai/joP7qs1t0ma4dZjZrqb4/CI4MT2c=; b=SmNwRzBji2CHYaYpAQX61UI2lK
 mqhw0AiWbDc53U0zvIjyodGC5UwCvRt88eja4vWrMhfA1ovbfWlNbb0IupSVhu3GufsliPLc74Hxb
 jd+hDFrpsU/UzoR26lxPsBc/fbW3uJlp/UiKbtCn12OGFUZr4VOTF6g1kfH8uDlNhrdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=72Zqzg15JFpAai/joP7qs1t0ma4dZjZrqb4/CI4MT2c=; b=HXPROQqzsgn4VrWdkKUmeqK7g1
 kAlDd0SD1syUn2lFD1Hp4rwecQicyks2tgdZZMaOIyRkpX7yDldaV4V9mhMGlD8AHdrjUilBxGkb7
 v1o7XwCUILCHsCsdfA44b099dtYpPHW3/JDKfQZbUKVOWFYo3G2N1x9EXtVI7pR9HD8k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viBAh-00039x-Qz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:49:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7726442B9D;
 Tue, 20 Jan 2026 12:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF59C16AAE;
 Tue, 20 Jan 2026 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768913353;
 bh=Y44ejQU4aMrfo1rZA+vU0Q9UQxBkm0QnXfJamSItof4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=gorMvPiehvSVl3t6egCUmqtYtRDPRFwUC91WghLg9mp2iDeHmRMnSHNGJegbV3DPw
 xVp3y0PCQcc8a9IxhkQ/w/z1vsglfsVSnHY22cc4S36TZCnzdRYep4wRHqk4l4r+oy
 yCRY7wfbeiNAFNb/Hf54UDS6eqPWTKw4c6Q6b8wCqmm8n6X3M1RC8nS33lyEgSt5nH
 1FBPb/SkrfNtOXBrgo4qPPkYKYh8pY6ZIseJUr/txE9eMHpYRvWVO1UYViUbInpy0e
 HJ9apYRsjMhqwCB/bm01qYJ9rTt6PU3fpz8xcO5ITnROhBJG3Ow5hFXOtpQGXEJNNn
 KfukkPW75Ed8w==
Message-ID: <643e61a6-3539-492d-89d0-6e0ad918eccf@kernel.org>
Date: Tue, 20 Jan 2026 20:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>
References: <20260112013320.8028-1-chao@kernel.org>
 <5e888451-228e-41e5-ada7-a22a61cb84dd@126.com>
 <32fa7311-0393-4e71-a927-3c502e40efd8@kernel.org>
 <6d6b3bad.5f72.19bd535bd6d.Coremail.nzzhao@126.com>
 <bf56a771-129b-4bf1-b5c7-05ecba6cda00@kernel.org>
 <7489ce81.333.19bd8ca5df6.Coremail.nzzhao@126.com>
Content-Language: en-US
In-Reply-To: <7489ce81.333.19bd8ca5df6.Coremail.nzzhao@126.com>
X-Headers-End: 1viBAh-00039x-Qz
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid f2fs_map_blocks() for
 consecutive holes in readpages
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TmFuemhlLAoKT24gMS8yMC8yMDI2IDg6MjQgQU0sIE5hbnpoZSBaaGFvIHdyb3RlOgo+IEhpIENo
YW86Cj4gQXQgMjAyNi0wMS0xOSAyMTo0NDo0OCwgIkNoYW8gWXUiIDxjaGFvQGtlcm5lbC5vcmc+
IHdyb3RlOgo+Pgo+PiBJIGd1ZXNzIGYyZnNfbWFwX25vX2Rub2RlKCkgd2lsbCB1cGRhdGUgbWFw
LT5tX25leHRfcGdvZnMgdG8gcGdvZnMgb2YgbmV4dAo+PiBwb3RlbnRpYWwgdmFsaWQgZG5vZGUu
Cj4+Cj4+IFRoYW5rcywKPj4KPiAKPiBJIGd1ZXNzIHdlIHdlcmUgZGlzY3Vzc2luZyB0aGUgY2Fz
ZXMgdGhhdCBmMmZzX2dldF9kbm9kZV9vZl9kYXRhIHdvbid0IHJldHVybgo+IC1FTk9FTlQgaW4g
ZjJmc19tYXBfYmxvY2tzIGJ1dCBkbi5ibGthZGRyIGlzIHN0aWxsIE5VTExfQUREUiBvciBORVdf
QUREUiA/CgpJIG1heSBtaXN1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24gYXQgZmlyc3QgcGxhY2Us
IHNvcnJ5IGFib3V0IHRoYXQuCgo+IAo+IEkgdGhpbmsgSSBtaWdodCB1bmRlcnN0YW5kIHRoZSBp
bnRlbnRpb24gYmVoaW5kIHlvdXIgcmVwZWF0ZWQgZW1waGFzaXMgb24gdGhlCj4gZjJmc19tYXBf
bm9fZG5vZGUgY2FzZT/CoCBBcmUgeW91IHNheWluZyB0aGF0LCBvbiBGMkZTLCB0aGUgdmFzdCBt
YWpvcml0eSBvZiBzcGFyc2UKPiBmaWxlcyBmYWxsIGludG8gaG9sZXMgd2hlcmUgdGhlIGRub2Rl
IGhhc24ndCBiZWVuIGFsbG9jYXRlZCBhdCBhbGwsIGFuZCB0aGF0IHdpdGhpbiB0aGUKPiBkbm9k
ZSB0aGUgYmxrYWRkciB2YWx1ZXMgTlVMTF9BRERSIGFuZCBORVdfQUREUuKAlGVzcGVjaWFsbHkg
dGhlIGxhdHRlciBvbiB0aGUgcmVhZCBwYXRoCj4g4oCUYXJlIHJlbGF0aXZlbHkgdW5jb21tb24/
CgpBY3R1YWxseSwgbm8sIHdlJ2QgYmV0dGVyIGludmVzdGlnYXRlIGludG8gZGV0YWlscyBvZiBo
b2xlIGRhdGEgcGF0dGVybiBpbiBkZXZpY2UKdG8gc2VlIHdoZXRoZXIgdGhlcmUgYXJlIDEpIG1v
cmUgc21hbGwgaG9sZXMgaW4gZG5vZGUgKE5VTExfQUREUi9ORVdfQUREUiBjYXNlKSBvcgoyKSB0
aGVyZSBhcmUgbW9yZSBsYXJnZSBob2xlIGluIHtkaSxpfWRub2RlLCBkbyB5b3UgaGF2ZSBmcmVl
IHNsb3QgdG8gY2hlY2sgdGhhdD8gOikKClRoYW5rcywKCj4gCj4gVGhhbmtzLAo+IE5hbnpoZSBa
aGFvCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
