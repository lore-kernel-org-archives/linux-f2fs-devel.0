Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDCEC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8EwZZBTVkuxLxr6ZLcaljHVTfAsB3CIcFdQCr8JerY=; b=bdrRIcox+TCjuQ1rgTu4Kb+Yeh
	2LNYmK3/qkTCBT5qTD3nYf/UJjG5x3QW+2kP9EHuq5gADP+sVBEYuUCmspz9Sj+qhBJFdboEZ8k2T
	HpgY5Vpj29iakrj2E9ChStmPStI90zjMW5tX8AR3xwPWoUTzsXTpU1mOwrp91l3rDoqU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyfqz-0005CS-5J;
	Tue, 25 Aug 2026 01:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wyfqx-0005CL-Cp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q3eNHOGdymoD0U1ubqtCEOT3WEKZ0IxuALPhKkv9Eh8=; b=Mwm9UEntPO+o2THU4cq0Ci9WSD
 3vngsRAil7dJMG5oxRLXZsAbEDdgYhFrlhFAH9uRAga4Jsnw3ZSHDsJxnhaPiL984uQ56B/ghTHDx
 YvEdGt2RENAxilhVBinA4SWZ0oqBAUqUkZ6UHOAFDft3GajoLIC2JoqEJjrPb+a6Nboc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q3eNHOGdymoD0U1ubqtCEOT3WEKZ0IxuALPhKkv9Eh8=; b=eCg/O1E/psm6Jb3kSpjtMFiVyP
 0Dq9ex4OzusrZJ9vd+/U4HUeSJnGgzJWVxBdcC728pgoa3BJh+BAsT6+H9mNbgtX0TJfQ7g5x5Fta
 YwvsSpU2jI7GYae3IU9X1JKGa2Y+L2c8Y2AaEBIAyyZnO/LI3+fnntSmyBO1ALQYVdks=;
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyfqv-0004bW-Q4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 01:21:27 +0000
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b457a0b4e5so3804210e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 18:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787620879; cv=none;
 d=google.com; s=arc-20260327;
 b=n8uWdsX0TVGEpBRsofzHKiAfFl4pwnaap3+NDCt1P6wihboW7uNFNsiLU1DjKmxcCK
 76Y4npq6E29qjZskah8mvptHgMb1CXMszk1Xx866ZZsCuQ4MY3WHglUU2faYMcebNN5X
 b7Jd+Deg6isZ9B4JHLrwiZZIu5VIyNNrgrWxnrVoJGcqGDOjjAtBbcceQ1Rcl/XDLfu2
 aaQW7UrZH6I7ttZNgc5irnGFB4GQMBTGkwcKqYMTU29XDqF4gV5bcO5FnrCaTTQjs7ej
 YGlwNtKIPvyMWykywfGotYPMziE0w50zUyYl2B4WJFcbOzg2Zb+DdB4J6kCvMO56WEz2
 +ZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q3eNHOGdymoD0U1ubqtCEOT3WEKZ0IxuALPhKkv9Eh8=;
 fh=oh8GcuTs5l6vtVv8jxKUVm8rcZMY+V3Oh6LDYEbY1AE=;
 b=RCme/yfVOK5EeffFUqTIaOpW10iUcfkyBBA6ZGpevlsyaS60eVnzS93J5DcC3LWCyQ
 CTWXwZoz1KZJoYAuB8k6RbdPzDcCd8xzxIBqN+kAl4PDp1nY0l8oNOPnONcpFi65A5ly
 XqyvFyOJf9vkYlJG0DnpjazRqjBeJ2NFKa/0ozg7/ED8bKGPeum29IrV0QbqUZt+fCLW
 c7gk9s5EqDJAJuu3vOU45FtK1RN2cL8wuOXZhAimbpZLgFYwaCThPpE3puErDeW5kP5i
 NsJOKjQ45hL5BtYYsPKT5A7aGpFMa4xfGXzDgIdA2Fkb0m+gb531LwUgIFwQ/Zoh31Il
 GNAQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787620879; x=1788225679; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q3eNHOGdymoD0U1ubqtCEOT3WEKZ0IxuALPhKkv9Eh8=;
 b=clUApE4M0eP/Zuh8Tv2uKqno0Ppq3EzbcCCrz7zo3tQergGyQqnwL4lfA+Ird5Eesd
 RK5LJbKxWKCRQh6nXwbFV4EIqPbdv10MZ89C+/4gzrrEuhBvaYe6sbaMOh1h3oyGE55q
 9FjNaraa58TbmVkRafWy0yaa0I5UsO1QRo65r44SqtDAyta4CYJGS79UYgjTxUsTogLt
 MWJVxFERvukQWwcN5r6Wup75Zbw3MBCZ387MXXYemzFxMKEwLKSNzlTAb2xfLKVt/OlY
 C75icgTaFBgDsaiaLMqDcQqGZJbbl48vGT+2A0vPViYPjHyvkX7m6ys54PyK9s6I3wfW
 f3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787620879; x=1788225679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q3eNHOGdymoD0U1ubqtCEOT3WEKZ0IxuALPhKkv9Eh8=;
 b=IAjUZ8EancVEzGSztGLf9c0M5ghUPk0vYq226ZKR+jJ46u6XjlNZRQ5y/hHfpYaghr
 wmNK11K5Ut27QxlcO3UHa5807lDDKdJIGInpCdxIxs9bxNHKVOT2U09kttndnXjptSIQ
 W1lc8FhSmfT1G9qazWoeW1odv3gW5MhvJAIKykiKdl78/EdQikFPmOd1ofGBsBkmIXo1
 yWm74FNJiKiHfMFPP3x7goQmCGINGawkBf1n0cpoJrF2geufTXxKp8QRUeY2hNS9pjHi
 Fzj6amVjzufL92RU3F8jaHIRElt+l2UQbERtf5s+w7pRwNpuNTQKJzEHgNNHOpJz+fQj
 H0lA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe9wityQxQ/BU3KRSeMyHWfKaNNZZmXg8sgwNZezTYbFrRrrwKVWuLzrQhW0whTCKllB+Fzuqyz9EH30yloG3t@lists.sourceforge.net
X-Gm-Message-State: AFuF++krSGNbmD7hk07qpUp42F/GseEvoAKgiiCmpVhW28c1oTVgnWh2
 JhLdchpFq+W2tHYADh9jY5SiiVKdVvuicNGI/bypgXPbQVvFgWenn73lsCX7ItPqmMFyXd5RXGE
 ovKSSTTBaA8GrR4MPV79AieqPXK36y5U=
X-Gm-Gg: AR+sD12YI0/Kvo8S8znAUdrJCRNJxLtdgqbY8ju1d0oTwRhTuGYVsiGLAm6srlJgrHZ
 8JwAngKk8hm+bCBmZ0lvPf4ClKPwykKvIOAVwPIhN4ZXJq9fC6Vk+dkCP3bu/9xqMQ5qMPxdxdI
 HKYJRIARBOnw59HyM2j3uj8c01F5dHSuT6pgdHKAyDPd6Ixrz8HWD9FPlhQ+XEx8kFHbjbq/fAP
 qxDMhQXHej0vHAzvU+77dqOuGXpdoMxH5lYZtnyaoy0FyLhJpyazmeqGxPvspp9OctpmgBgwJWr
 AHgQGhf76oBZ/nktNZEEtN3KMS7i6+eektq1QRu19dZldwprtktJ8v8nVlfJF51f5Qd0qs+Jx1k
 OxnbHlpVwmyFtZESGaQaJMteBHOW8q0GPKNICbl3DEq0=
X-Received: by 2002:a05:6512:12c8:b0:5b2:958f:8cdc with SMTP id
 2adb3069b0e04-5b484224628mr9836281e87.11.1787620878627; Mon, 24 Aug 2026
 18:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260818171412.3201082-1-daeho43@gmail.com>
 <2b2dc21a-a78d-416c-aa4f-7531c1b62321@kernel.org>
In-Reply-To: <2b2dc21a-a78d-416c-aa4f-7531c1b62321@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 24 Aug 2026 18:21:05 -0700
X-Gm-Features: AcwNN1Wm-g6pmgnMMTMbzH9BA78INBBP62ssi_HDkVAkCYweygLsSflTsqI8l-M
Message-ID: <CACOAw_wb_CPopSxjptn7MTheojQfZdtPAKh_n4OyFg9hSUbcTw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wyfqv-0004bW-Q4
Subject: Re: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBBdWcgMjQsIDIwMjYgYXQgNjowNeKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzE5LzI2IDAxOjE0LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEZy
b206IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPgo+ID4gSW4gZnJlZV9z
ZWdtZW50X3JhbmdlKCksIE1BSU5fU0VDUyhzYmkpIGlzIHRlbXBvcmFyaWx5IHJlZHVjZWQgYnkg
YHNlY3NgCj4gPiB3aGlsZSB2YWxpZCBibG9ja3MgaW4gdGhlIHRydW5jYXRlZCByYW5nZSBhcmUg
ZXZhY3VhdGVkIGJ5IEdDLgo+ID4KPiA+IEhvd2V2ZXIsIGlmIGFueSBzZWN0aW9ucyB3aXRoaW4g
dGhlIHRydW5jYXRlZCByYW5nZSB3ZXJlIGFscmVhZHkgZnJlZSwKPiA+IGZhaWxpbmcgdG8gZGVk
dWN0IHRoZW0gZnJvbSBGUkVFX0koc2JpKS0+ZnJlZV9zZWN0aW9ucyBsZWFkcyB0byBhbgo+ID4g
b3Zlci1lc3RpbWF0aW9uIG9mIGF2YWlsYWJsZSBzcGFjZSBpbiB0aGUgcmVkdWNlZCBtYWluIGFy
ZWEsIGNhdXNpbmcKPiA+IGluY29uc2lzdGVudCBmcmVlIHNlY3Rpb24gYWNjb3VudGluZy4KPiA+
Cj4gPiBGaXggdGhpcyBieSBjYWxjdWxhdGluZyB0aGUgbnVtYmVyIG9mIGFscmVhZHktZnJlZSBz
ZWN0aW9ucyBpbiB0aGUKPiA+IHRydW5jYXRlZCByYW5nZSB1bmRlciBzZWdtYXBfbG9jaywgZGVk
dWN0aW5nIHRoZW0gZnJvbSBmcmVlX3NlY3Rpb25zIHVwb24KPiA+IGVudGVyaW5nIGZyZWVfc2Vn
bWVudF9yYW5nZSgpLCBhbmQgcmVzdG9yaW5nIHRoZW0gdW5kZXIgc2VnbWFwX2xvY2sgb24gZXhp
dC4KPgo+IEkgdGhpbmsgd2UgbmVlZCB0byBjaGFuZ2UgY29tbWl0IG1lc3NhZ2UgYSBiaXQgdG8g
cmVmbGVjdCByZWFsIGlzc3Vlcz8KPgo+IEZpeGVzIGFuZCBDYyBzdGFibGUgbGluZSBoZXJlLgo+
Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNv
bT4KPiA+IFNpZ25lZC1vZmYtYnk6IFN1bm1pbiBKZW9uZyA8c19taW4uamVvbmdAc2Ftc3VuZy5j
b20+Cj4gPiAtLS0KPiA+ICAgZnMvZjJmcy9nYy5jIHwgMTUgKysrKysrKysrKysrKystCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZ2MuYyBiL2ZzL2YyZnMvZ2MuYwo+ID4gaW5kZXggNzg3MTMz
ZWUyZWIyLi5mM2E2ZmM2ZDA4YWUgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9mMmZzL2djLmMKPiA+ICsr
KyBiL2ZzL2YyZnMvZ2MuYwo+ID4gQEAgLTIyMDAsOCArMjIwMCw5IEBAIGludCBmMmZzX2djX3Jh
bmdlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPiA+ICAgc3RhdGljIGludCBmcmVlX3NlZ21l
bnRfcmFuZ2Uoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IHNlY3MsIGJvb2wgZHJ5X3J1bikKPiA+ICAgewo+ID4g
LSAgICAgdW5zaWduZWQgaW50IG5leHRfaW51c2UsIHN0YXJ0LCBlbmQ7Cj4gPiArICAgICB1bnNp
Z25lZCBpbnQgc2Vjbm8sIG5leHRfaW51c2UsIHN0YXJ0LCBlbmQsIGVuZF9zZWNubzsKPiA+ICAg
ICAgIHN0cnVjdCBjcF9jb250cm9sIGNwYyA9IHsgQ1BfUkVTSVpFLCAwLCAwLCAwIH07Cj4gPiAr
ICAgICB1bnNpZ25lZCBpbnQgZnJlZWRfc2VjcyA9IDA7Cj4gPiAgICAgICBpbnQgZ2NfbW9kZSwg
Z2NfdHlwZTsKPiA+ICAgICAgIGludCBlcnIgPSAwOwo+ID4gICAgICAgaW50IHR5cGU7Cj4gPiBA
QCAtMjIxMCw2ICsyMjExLDcgQEAgc3RhdGljIGludCBmcmVlX3NlZ21lbnRfcmFuZ2Uoc3RydWN0
IGYyZnNfc2JfaW5mbyAqc2JpLAo+ID4gICAgICAgTUFJTl9TRUNTKHNiaSkgLT0gc2VjczsKPiA+
ICAgICAgIHN0YXJ0ID0gTUFJTl9TRUNTKHNiaSkgKiBTRUdTX1BFUl9TRUMoc2JpKTsKPiA+ICAg
ICAgIGVuZCA9IE1BSU5fU0VHUyhzYmkpIC0gMTsKPiA+ICsgICAgIGVuZF9zZWNubyA9IEdFVF9T
RUNfRlJPTV9TRUcoc2JpLCBlbmQpOwo+ID4KPiA+ICAgICAgIG11dGV4X2xvY2soJkRJUlRZX0ko
c2JpKS0+c2VnbGlzdF9sb2NrKTsKPiA+ICAgICAgIGZvciAoZ2NfbW9kZSA9IDA7IGdjX21vZGUg
PCBNQVhfR0NfUE9MSUNZOyBnY19tb2RlKyspCj4gPiBAQCAtMjIyMSw2ICsyMjIzLDE0IEBAIHN0
YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPiA+
ICAgICAgICAgICAgICAgICAgICAgICBzYmktPm5leHRfdmljdGltX3NlZ1tnY190eXBlXSA9IE5V
TExfU0VHTk87Cj4gPiAgICAgICBtdXRleF91bmxvY2soJkRJUlRZX0koc2JpKS0+c2VnbGlzdF9s
b2NrKTsKPiA+Cj4gPiArICAgICBzcGluX2xvY2soJkZSRUVfSShzYmkpLT5zZWdtYXBfbG9jayk7
Cj4gPiArICAgICBmb3IgKHNlY25vID0gTUFJTl9TRUNTKHNiaSk7IHNlY25vIDw9IGVuZF9zZWNu
bzsgc2Vjbm8rKykgewo+ID4gKyAgICAgICAgICAgICBpZiAoIXRlc3RfYml0KHNlY25vLCBGUkVF
X0koc2JpKS0+ZnJlZV9zZWNtYXApKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGZyZWVkX3Nl
Y3MrKzsKPiA+ICsgICAgIH0KPiA+ICsgICAgIEZSRUVfSShzYmkpLT5mcmVlX3NlY3Rpb25zIC09
IGZyZWVkX3NlY3M7Cj4gPiArICAgICBzcGluX3VubG9jaygmRlJFRV9JKHNiaSktPnNlZ21hcF9s
b2NrKTsKPiA+ICsKPgo+IEJlZm9yZSBmMmZzX2djX3JhbmdlCj4gMC4uODkgaGF2ZSAxMCBkaXJ0
eS9mdWxsIHNlY3Rpb25zLCA4MCBmcmVlIHNlY3Rpb25zLgo+IDkwLi45OSBoYXZlIDUgZGlydHkg
c2VjdGlvbnMsIDUgZnJlZSBzZWN0aW9ucy4KPgo+IEZSRUVfSShzYmkpLT5mcmVlX3NlY3Rpb25z
IC09IGZyZWVkX3NlY3M7Cj4gZnJlZV9zZWN0aW9ucyA9IDg1IC0gNSA9IDgwCj4KPiBBZnRlciBm
MmZzX2djX3JhbmdlCj4gMC4uODkgaGF2ZSAxMyBkaXJ0eS9mdWxsIHNlY3Rpb25zLCA3NyBmcmVl
IHNlY3Rpb25zLgo+IDkwLi45OSBoYXZlIDEwIGZyZWUgc2VjdGlvbnMuCj4gZnJlZV9zZWN0aW9u
cyA9IDc3ICguZnJlZV9zZWN0aW9ucykgKyAxMCAoc2VjcykgPSA4Nwo+Cj4gPiAgICAgICAvKiBN
b3ZlIG91dCBjdXJzZWdzIGZyb20gdGhlIHRhcmdldCByYW5nZSAqLwo+ID4gICAgICAgZm9yICh0
eXBlID0gQ1VSU0VHX0hPVF9EQVRBOyB0eXBlIDwgTlJfQ1VSU0VHX1RZUEU7IHR5cGUrKykgewo+
ID4gICAgICAgICAgICAgICBlcnIgPSBmMmZzX2FsbG9jYXRlX3NlZ21lbnRfZm9yX3Jlc2l6ZShz
YmksIHR5cGUsIHN0YXJ0LCBlbmQpOwo+ID4gQEAgLTIyNDUsNiArMjI1NSw5IEBAIHN0YXRpYyBp
bnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPiA+ICAgICAg
ICAgICAgICAgZjJmc19idWdfb24oc2JpLCAxKTsKPiA+ICAgICAgIH0KPiA+ICAgb3V0Ogo+ID4g
KyAgICAgc3Bpbl9sb2NrKCZGUkVFX0koc2JpKS0+c2VnbWFwX2xvY2spOwo+ID4gKyAgICAgRlJF
RV9JKHNiaSktPmZyZWVfc2VjdGlvbnMgKz0gZnJlZWRfc2VjczsKPgo+IFNvLCBzaG91bGRuJ3Qg
YmU/Cj4gRlJFRV9JKHNiaSktPmZyZWVfc2VjdGlvbnMgKz0gc2VjczsKCkR1cmluZyBmMmZzX2dj
X3JhbmdlKCksIHdoZW4gdGhlIGRpcnR5IHNlY3Rpb25zIGluIDkwLi45OSBhcmUgY2xlYW5lZCBh
bmQKZnJlZWQsIGBfX3NldF90ZXN0X2FuZF9mcmVlKClgIGlzIGludm9rZWQgZm9yIHRob3NlIHNl
Y3Rpb25zLCB3aGljaAphdXRvbWF0aWNhbGx5IGluY3JlbWVudHMgYEZSRUVfSShzYmkpLT5mcmVl
X3NlY3Rpb25zYCBmb3IgZWFjaCBuZXdseQpmcmVlZCBzZWN0aW9uPwoKPgo+IFRoYW5rcywKPgo+
ID4gKyAgICAgc3Bpbl91bmxvY2soJkZSRUVfSShzYmkpLT5zZWdtYXBfbG9jayk7Cj4gPiAgICAg
ICBNQUlOX1NFQ1Moc2JpKSArPSBzZWNzOwo+ID4gICAgICAgcmV0dXJuIGVycjsKPiA+ICAgfQo+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
