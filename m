Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98165606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IG2zTM7I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QiLwgpcX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f6a4qmqx;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czAZilCI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ZEe3koUjRqFA5FlPibkJtd3MDYiNNCHqG53b9J1YNCk=; b=IG2zTM7IN0faXXl9V1rvmus2DZ
	uaoddj12WXOwh45SOylWxWVxiW/BwRa0pcfgm2308x5PK29keGtnaOyNYq6jlHBe/A0YQQ9o3bvvi
	eOqS73z3fikRuf4kIor0snYG6vkQ3IxiiT4hVC5kai9sofbCYhHTk8apeKCcU9FoCEE8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xXCGa-000000007zO-120U;
	Sat, 28 Nov 2026 06:50:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zangyangyang66@gmail.com>) id 1xXCGY-000000007zA-3doI
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 06:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2jze9JXd4rNY7tmBBsVI5WSvKbTzFIMPeKIA0VbZ/0=; b=QiLwgpcXFMGZS/kxXD91fB04Wd
 W1BdX9/KD34qN7zXYsGy52JJQLJP0dLRyd0UETnBuCrhi2yhu+uNsW4ilUkW+jdTymmR8BAMVuXa+
 W8aPhSLdpPO5ZfitfsybhcCc/nRFC1TVgRCgUNSTFgchCqyYf4Kl5diWC2FKVir3tvpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2jze9JXd4rNY7tmBBsVI5WSvKbTzFIMPeKIA0VbZ/0=; b=f6a4qmqxurcvsgbSGsEbru9+Dr
 45RY6jsoZuFG49K/1tx+BB+z/l6+ZMjTXzlLP3KvRfGA35BJIBvcANTOODJsy6/ButF5yCE/27Mub
 qu95UESgd11LuBzTiQS/ieDxihyTmnLlYcNQRqYIeVozePF57yoB/0+lMN0d3J7hOSKk=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXCGX-0000000042Y-28yZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 06:50:34 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b41e5a1719so3613274a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 22:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795848628; x=1796453428; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K2jze9JXd4rNY7tmBBsVI5WSvKbTzFIMPeKIA0VbZ/0=;
 b=czAZilCI7afwGcU6MfEf1MXzDzsNCjLu06NE4y4upCYHGu6SWJQu7WfOxUo2rlGYk3
 htnfYs1sCZVennbBVImXHIRTdzu19y69rue7s8Tz9ZVXMgtrF+Op7zSuKJy9U1CizYW8
 el3UMug6XTxOm/u70JASW3Kt+70Wi/XxWgRpDo1JFLz0Pxgzhi2z1tvSR8Z6NKj7RM4n
 9OuZNgnyVweO9weNxs2imq1YqtcG9EkTnJKXurdYIhc2ZE7QP6rn8ABif9aC+uwYCWSj
 Xc2DSFbshS6TeJV3/Q308K1V/9zP5R7xaafmpm2V7ORUbq3EmVU0Hr3jtBpXW/qU65s2
 WNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795848628; x=1796453428;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2jze9JXd4rNY7tmBBsVI5WSvKbTzFIMPeKIA0VbZ/0=;
 b=M6EvGut5SgH48YcBa5K5hv64D66/Xyipf+AoGneMFN6QCoIiu03mWrg88JyMCV4Bq0
 fzCd9Fy1tCUyo6hSvdyT9JVRSzhFx6cfqAPE/M2b5ocCIsWSV7tBH2c5Q1qKl6Wy8p7o
 dovFhffVMbn48eTfhf+5WQ+SXEssyEz/KS7cCy+tAy0J5cgMwTaNp+rpk6LdHAdCVlyG
 zAvjhAJrxeaH5JvJThvkX2u9araDR0hl+Dr940Ubl6Z7l93qt+SV04SISmnxWU4Hh9oz
 RM/sAVISZAlxi6zz4UKjgIqnktzYp8QoIFbRJgWU80h7LyqSE4uxhUXlYtxXcUpXqRf+
 uU1g==
X-Gm-Message-State: APuU4Z8928uXFEgMjFyzqHF10747cRLSw37X0cDZZ6X6wS818QakTWsL
 Nh2cq11N4Xuem8C4ys3E8AuUTIXK/h2I8N830KYxsNcDR71oNPwrVTjryxfUgQ==
X-Gm-Gg: AZFdTZfKHZymqAtdqEj7fvBtPSg/B0qMo2rFN1vrJSAJyBnXFkZkIhL0BufLn21z8v8
 CrHXQHp3MBaerwQk5Ze3rFUj5E4xSPpSUlXapfH1vBZTrtd+qSXu7pGz36QBdAjzTvY9UmBox4/
 bcw7k2gpWpOIxQzUcLng6iqlmi8Xr6gMIVNGNqnWkxgq9xT4Ry+plTfjBzzlrgWNSC5d2IUPwHN
 FMTanM/9h/uIWtUeC62S39V+qc7oVethIRiaXN4ruIg7XO9pmaGDIDkP4o1MJlljNlRxAl8VKOb
 /ZT8S9aWabIlIN3+PUYw3MnAuwEiyoAPhjgpu0EAfBgN/lwJM0lUm8UVHG8Z8fw6F3HCLZuy2cN
 hFOzGchk0inCjIAMU369LU/wI0NmtnoZ6dnLwA5OXV55TF4jZxmK0IQKyX8SCNKtoqPQ7QNrhit
 d1xWit4RukRa9LKpn9jR1mWpJ4WROhyRxqCcyB7Ep2tlX9JTuYC1/5mpHrrVPcG2R3I3jHgN1Vx
 Xvo22gMjUO/VuFH4Faeo7R7v+mBaSYGFrr31HKG7Md+W+c0QnpuYPQfeUWK7EVILia2hb4fjIvN
 T/Pm206kmaV7eLfzGDg/fIVoFyTM90isbg/WlZ5DgtiJf7OFmcY0U6esWLHPhWL77X8oG7De1cy
 ZPDo=
X-Received: by 2002:a17:90b:2792:b0:3a4:ca46:840f with SMTP id
 98e67ed59e1d1-3b41c8e172amr24912469a91.8.1795848627742; 
 Fri, 27 Nov 2026 22:50:27 -0800 (PST)
Received: from ?IPV6:2408:8607:1b00:8:f220:2b60:48d4:ddd3?
 ([2408:8607:1b00:8:f220:2b60:48d4:ddd3])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41aab4729sm41324583a91.0.2026.11.27.22.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 22:50:27 -0800 (PST)
Message-ID: <d5549455-2518-4446-8b5a-2e64aea0b7ef@gmail.com>
Date: Sat, 28 Nov 2026 14:50:19 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yangyang Zang <zangyangyang66@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
References: <20261022061352.2590882-1-zangyangyang1@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261022061352.2590882-1-zangyangyang1@xiaomi.com>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xXCGX-0000000042Y-28yZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unsigned underflow in
 has_enough_free_blks()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, Yangyang Zang <zangyangyang1@xiaomi.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

5ZyoIDIwMjYvMTAvMjIgMTQ6MTMsIFlhbmd5YW5nIFphbmcg5YaZ6YGTOgoKPiBoYXNfZW5vdWdo
X2ZyZWVfYmxrcygpIGNoZWNrcyB0aGUgZmlsZXN5c3RlbSBoYXMgZW5vdWdoIGZyZWUgYmxvY2tz
Cj4gYnkgY29tcHV0aW5nCj4KPiAgICAgIGF2YWlsX3VzZXJfYmxvY2tfY291bnQoc2JpKSAtIHZh
bGlkX3VzZXJfYmxvY2tzKHNiaSkKPgo+IEJvdGggb3BlcmFuZHMgYXJlIHVuc2lnbmVkLCBzbyB3
aGVuIGF2YWlsX3VzZXJfYmxvY2tfY291bnQgaXMgbGVzcwo+IHRoYW4gdmFsaWRfdXNlcl9ibG9j
a3MgdGhlIHN1YnRyYWN0aW9uIHdyYXBzIGFyb3VuZCB0byBhIGxhcmdlCj4gcG9zaXRpdmUgdmFs
dWUgYW5kIHRoZSBmdW5jdGlvbiBpbmNvcnJlY3RseSByZXBvcnRzIHRoYXQgZW5vdWdoIGZyZWUK
PiBibG9ja3MgYXJlIGF2YWlsYWJsZS4KPgo+IFJlcGxhY2UgdGhlIHN1YnRyYWN0aW9uIHdpdGgg
YSBkaXJlY3QgY29tcGFyaXNvbiBzbyB0aGUgY2hlY2sgc3RheXMKPiBjb3JyZWN0IHJlZ2FyZGxl
c3Mgb2Ygd2hpY2ggb3BlcmFuZCBpcyBsYXJnZXIuCj4KPiBGaXhlczogODRiNWJiOGJmMGY2IChm
MmZzOiBtb2RpZnkgZjJmc19pc19jaGVja3BvaW50X3JlYWR5IGxvZ2ljIHRvIGFsbG93IG1vcmUg
ZGF0YSB0byBiZSB3cml0dGVuIHdpdGggdGhlIENQIGRpc2FibGUpCj4gU2lnbmVkLW9mZi1ieTog
WWFuZ3lhbmcgWmFuZyA8emFuZ3lhbmd5YW5nMUB4aWFvbWkuY29tPgo+IC0tLQo+ICAgZnMvZjJm
cy9zZWdtZW50LmggfCA2ICsrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuaCBiL2Zz
L2YyZnMvc2VnbWVudC5oCj4gaW5kZXggNTI2NzY0YmEzMWFlLi5jNjk1NTAwODRiZWEgMTAwNjQ0
Cj4gLS0tIGEvZnMvZjJmcy9zZWdtZW50LmgKPiArKysgYi9mcy9mMmZzL3NlZ21lbnQuaAo+IEBA
IC03MDcsMTcgKzcwNywxNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaGFzX2Vub3VnaF9mcmVlX3Nl
Y3Moc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ICAgCj4gICBzdGF0aWMgaW5saW5lIGJvb2wg
aGFzX2Vub3VnaF9mcmVlX2Jsa3Moc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ICAgewo+IC0J
dW5zaWduZWQgaW50IHRvdGFsX2ZyZWVfYmxvY2tzID0gMDsKPiArCXVuc2lnbmVkIGludCB2YWxp
ZF91c2VyX2Jsb2NrX2NvdW50Owo+ICAgCXVuc2lnbmVkIGludCBhdmFpbF91c2VyX2Jsb2NrX2Nv
dW50Owo+ICAgCj4gICAJc3Bpbl9sb2NrKCZzYmktPnN0YXRfbG9jayk7Cj4gICAKPiAgIAlhdmFp
bF91c2VyX2Jsb2NrX2NvdW50ID0gZ2V0X2F2YWlsYWJsZV9ibG9ja19jb3VudChzYmksIE5VTEws
IHRydWUpOwo+IC0JdG90YWxfZnJlZV9ibG9ja3MgPSBhdmFpbF91c2VyX2Jsb2NrX2NvdW50IC0g
KHVuc2lnbmVkIGludCl2YWxpZF91c2VyX2Jsb2NrcyhzYmkpOwo+ICsJdmFsaWRfdXNlcl9ibG9j
a19jb3VudCA9ICh1bnNpZ25lZCBpbnQpdmFsaWRfdXNlcl9ibG9ja3Moc2JpKTsKPiAgIAo+ICAg
CXNwaW5fdW5sb2NrKCZzYmktPnN0YXRfbG9jayk7Cj4gICAKPiAtCXJldHVybiB0b3RhbF9mcmVl
X2Jsb2NrcyA+IDA7Cj4gKwlyZXR1cm4gYXZhaWxfdXNlcl9ibG9ja19jb3VudCA+IHZhbGlkX3Vz
ZXJfYmxvY2tfY291bnQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBmMmZzX2lz
X2NoZWNrcG9pbnRfcmVhZHkoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQoKcGluZwoKVGhhbmtz
LApZYW5neWFuZwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
