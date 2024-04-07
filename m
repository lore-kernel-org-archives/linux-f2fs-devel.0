Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C231C67861
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Apr 2024 03:20:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rtJ5N-0003cl-PA;
	Sun, 07 Apr 2024 03:20:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rtJ5M-0003cc-IA
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 03:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tncgXPmvioR71gmXKDoxZFMTUcRtnOT3mMxGsBbEpWY=; b=XW9Iu67hRahBzQ5G21j9xnC2pZ
 jKk9uUofRVlvLamNxSuq/ElsqF1KdSgCzpQR2AOm4Lf69unkPnbEiB6x8OjAlM9pSEojbw/TgtNuC
 rfKRAwk6V6mcSVK9AmNdDU3VZ3hdTgsq02opyM+zXij9FsyvWHly1DY8u0D4uZAbbNDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tncgXPmvioR71gmXKDoxZFMTUcRtnOT3mMxGsBbEpWY=; b=D6FEx54KPFvHtci8rMqlCYxLXO
 H294Kym4Wwr2m5gd7FZg8Ks6LKEsmrPwRf7NGHiaqVAGlNrOsyyFbo9wmvjyuCdPgIQGOZubnLPxj
 kh8p4Bo61+3m4Y/RKaqA/3QymBRP2T+/7lWgxlLt2XTlq7t5GDw9gWOo1Ir2pzgqzUXI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rtJ5L-0005Q2-SM for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 03:20:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D929BCE09F8;
 Sun,  7 Apr 2024 03:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE33C433C7;
 Sun,  7 Apr 2024 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712460034;
 bh=b9Tc4eovGDofZDA3f8IXjRzPGaiAXdbUqV5UzjNB+5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=huvBeV5QNo4hti68EKlCE7KbV8DE7YP93IjNmjsGEfLXk3KWeJg2OkAZG7MenXrSE
 BSwuUOvNwWZ0AlmYFkzA2iYDdyL37mARklEzx9jDlqgqaqA1Rq3GsDwjMy1rnrMOTv
 fD4L9MslPHsq+QnHRPlEuu3qTT4ulFsjU+dQCEf29k0lLkOFOQj4egIk5UtQ0JKfX1
 qgkwMYN4C7RtZ53YwBer52WU6b2Da0rxOn2odLic3VYwbMq25GwKrdbW1OxJqs/+wS
 ZpOnO1th1nTuh0ktGHMyrtFw7N9JIkDpz6FEFfqgxyGLH9u/1nbpKM/9FSd+09ihWS
 hZl1reuBKxucA==
Message-ID: <302e8f2c-74a2-4476-b71a-87f818fea919@kernel.org>
Date: Sun, 7 Apr 2024 11:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20240328072136.3023135-1-chao@kernel.org>
 <CACOAw_w0YgVtGGdb-2DQ6ROCc7YyXETWxWPiAB+D0qHt369fQQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_w0YgVtGGdb-2DQ6ROCc7YyXETWxWPiAB+D0qHt369fQQ@mail.gmail.com>
X-Headers-End: 1rtJ5L-0005Q2-SM
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: fix zoned block device information
 initialization
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
Cc: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC80LzUgMjoyMCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gVGh1LCBNYXIgMjgsIDIw
MjQgYXQgMTI6MjPigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBG
cm9tOiBXZW5qaWUgUWkgPHF3amh1c3RAZ21haWwuY29tPgo+Pgo+PiBJZiB0aGUgbWF4IG9wZW4g
em9uZXMgb2Ygem9uZWQgZGV2aWNlcyBhcmUgbGVzcyB0aGFuCj4+IHRoZSBhY3RpdmUgbG9ncyBv
ZiBGMkZTLCB0aGUgZGV2aWNlIG1heSBlcnJvciBkdWUgdG8KPj4gaW5zdWZmaWNpZW50IHpvbmUg
cmVzb3VyY2VzIHdoZW4gbXVsdGlwbGUgYWN0aXZlIGxvZ3MKPj4gYXJlIGJlaW5nIHdyaXR0ZW4g
YXQgdGhlIHNhbWUgdGltZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxd2podXN0
QGdtYWlsLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+
PiAtLS0KPj4gdjY6Cj4+IC0gYWRkIGNoZWNrIGNvbmRpdGlvbiB0byBhdm9pZCByZW1vdW50IGZh
aWx1cmUuCj4+ICAgZnMvZjJmcy9mMmZzLmggIHwgIDEgKwo+PiAgIGZzL2YyZnMvc3VwZXIuYyB8
IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9mcy9mMmZz
L2YyZnMuaAo+PiBpbmRleCAwNTUwOTI5ZGM2ZTUuLjY5NGY4YTUyY2I4NCAxMDA2NDQKPj4gLS0t
IGEvZnMvZjJmcy9mMmZzLmgKPj4gKysrIGIvZnMvZjJmcy9mMmZzLmgKPj4gQEAgLTE1NTksNiAr
MTU1OSw3IEBAIHN0cnVjdCBmMmZzX3NiX2luZm8gewo+Pgo+PiAgICNpZmRlZiBDT05GSUdfQkxL
X0RFVl9aT05FRAo+PiAgICAgICAgICB1bnNpZ25lZCBpbnQgYmxvY2tzX3Blcl9ibGt6OyAgICAg
ICAgICAgLyogRjJGUyBibG9ja3MgcGVyIHpvbmUgKi8KPj4gKyAgICAgICB1bnNpZ25lZCBpbnQg
bWF4X29wZW5fem9uZXM7ICAgICAgICAgICAgLyogbWF4IG9wZW4gem9uZSByZXNvdXJjZXMgb2Yg
dGhlIHpvbmVkIGRldmljZSAqLwo+PiAgICNlbmRpZgo+Pgo+PiAgICAgICAgICAvKiBmb3Igbm9k
ZS1yZWxhdGVkIG9wZXJhdGlvbnMgKi8KPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBi
L2ZzL2YyZnMvc3VwZXIuYwo+PiBpbmRleCA3YzQ1OTI5NjcxYWQuLjY0MjU0MDc4MjQ3MSAxMDA2
NDQKPj4gLS0tIGEvZnMvZjJmcy9zdXBlci5jCj4+ICsrKyBiL2ZzL2YyZnMvc3VwZXIuYwo+PiBA
QCAtMjMyNiw2ICsyMzI2LDE3IEBAIHN0YXRpYyBpbnQgZjJmc19yZW1vdW50KHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIGludCAqZmxhZ3MsIGNoYXIgKmRhdGEpCj4+ICAgICAgICAgIGlmIChlcnIp
Cj4+ICAgICAgICAgICAgICAgICAgZ290byByZXN0b3JlX29wdHM7Cj4+Cj4+ICsjaWZkZWYgQ09O
RklHX0JMS19ERVZfWk9ORUQKPj4gKyAgICAgICBpZiAoZjJmc19pc19tdWx0aV9kZXZpY2Uoc2Jp
KSAmJgo+IAo+IFdoeSBkbyB3ZSBjaGVjayBtdWx0aXBsZSBkZXZpY2VzJyBjb25kaXRpb24gaGVy
ZT8KCk9oLCBpdCBuZWVkcyB0byBjaGVjayBmMmZzX3NiX2hhc19ibGt6b25lZCgpLCByaWdodD8K
ClRoYW5rcywKCj4gCj4gVGhhbmtzLAo+IAo+PiArICAgICAgICAgICAgICAgc2JpLT5tYXhfb3Bl
bl96b25lcyA8IEYyRlNfT1BUSU9OKHNiaSkuYWN0aXZlX2xvZ3MpIHsKPj4gKyAgICAgICAgICAg
ICAgIGYyZnNfZXJyKHNiaSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgInpvbmVkOiBtYXgg
b3BlbiB6b25lcyAldSBpcyB0b28gc21hbGwsIG5lZWQgYXQgbGVhc3QgJXUgb3BlbiB6b25lcyIs
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNiaS0+bWF4X29wZW5fem9uZXMs
IEYyRlNfT1BUSU9OKHNiaSkuYWN0aXZlX2xvZ3MpOwo+PiArICAgICAgICAgICAgICAgZXJyID0g
LUVJTlZBTDsKPj4gKyAgICAgICAgICAgICAgIGdvdG8gcmVzdG9yZV9vcHRzOwo+PiArICAgICAg
IH0KPj4gKyNlbmRpZgo+PiArCj4+ICAgICAgICAgIC8qIGZsdXNoIG91dHN0YW5kaW5nIGVycm9y
cyBiZWZvcmUgY2hhbmdpbmcgZnMgc3RhdGUgKi8KPj4gICAgICAgICAgZmx1c2hfd29yaygmc2Jp
LT5zX2Vycm9yX3dvcmspOwo+Pgo+PiBAQCAtMzg2OCwxMSArMzg3OSwyNCBAQCBzdGF0aWMgaW50
IGluaXRfYmxrel9pbmZvKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgaW50IGRldmkpCj4+ICAg
ICAgICAgIHNlY3Rvcl90IG5yX3NlY3RvcnMgPSBiZGV2X25yX3NlY3RvcnMoYmRldik7Cj4+ICAg
ICAgICAgIHN0cnVjdCBmMmZzX3JlcG9ydF96b25lc19hcmdzIHJlcF96b25lX2FyZzsKPj4gICAg
ICAgICAgdTY0IHpvbmVfc2VjdG9yczsKPj4gKyAgICAgICB1bnNpZ25lZCBpbnQgbWF4X29wZW5f
em9uZXM7Cj4+ICAgICAgICAgIGludCByZXQ7Cj4+Cj4+ICAgICAgICAgIGlmICghZjJmc19zYl9o
YXNfYmxrem9uZWQoc2JpKSkKPj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4KPj4gKyAg
ICAgICBpZiAoYmRldl9pc196b25lZChGREVWKGRldmkpLmJkZXYpKSB7Cj4+ICsgICAgICAgICAg
ICAgICBtYXhfb3Blbl96b25lcyA9IGJkZXZfbWF4X29wZW5fem9uZXMoYmRldik7Cj4+ICsgICAg
ICAgICAgICAgICBpZiAobWF4X29wZW5fem9uZXMgJiYgKG1heF9vcGVuX3pvbmVzIDwgc2JpLT5t
YXhfb3Blbl96b25lcykpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHNiaS0+bWF4X29wZW5f
em9uZXMgPSBtYXhfb3Blbl96b25lczsKPj4gKyAgICAgICAgICAgICAgIGlmIChzYmktPm1heF9v
cGVuX3pvbmVzIDwgRjJGU19PUFRJT04oc2JpKS5hY3RpdmVfbG9ncykgewo+PiArICAgICAgICAg
ICAgICAgICAgICAgICBmMmZzX2VycihzYmksCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgInpvbmVkOiBtYXggb3BlbiB6b25lcyAldSBpcyB0b28gc21hbGwsIG5lZWQgYXQgbGVh
c3QgJXUgb3BlbiB6b25lcyIsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Jp
LT5tYXhfb3Blbl96b25lcywgRjJGU19PUFRJT04oc2JpKS5hY3RpdmVfbG9ncyk7Cj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiArICAgICAgICAgICAgICAgfQo+
PiArICAgICAgIH0KPj4gKwo+PiAgICAgICAgICB6b25lX3NlY3RvcnMgPSBiZGV2X3pvbmVfc2Vj
dG9ycyhiZGV2KTsKPj4gICAgICAgICAgaWYgKHNiaS0+YmxvY2tzX3Blcl9ibGt6ICYmIHNiaS0+
YmxvY2tzX3Blcl9ibGt6ICE9Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNF
Q1RPUl9UT19CTE9DSyh6b25lX3NlY3RvcnMpKQo+PiBAQCAtNDE4Niw2ICs0MjEwLDkgQEAgc3Rh
dGljIGludCBmMmZzX3NjYW5fZGV2aWNlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4+Cj4+
ICAgICAgICAgIGxvZ2ljYWxfYmxrc2l6ZSA9IGJkZXZfbG9naWNhbF9ibG9ja19zaXplKHNiaS0+
c2ItPnNfYmRldik7Cj4+ICAgICAgICAgIHNiaS0+YWxpZ25lZF9ibGtzaXplID0gdHJ1ZTsKPj4g
KyNpZmRlZiBDT05GSUdfQkxLX0RFVl9aT05FRAo+PiArICAgICAgIHNiaS0+bWF4X29wZW5fem9u
ZXMgPSBVSU5UX01BWDsKPj4gKyNlbmRpZgo+Pgo+PiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
bWF4X2RldmljZXM7IGkrKykgewo+PiAgICAgICAgICAgICAgICAgIGlmIChpID09IDApCj4+IC0t
Cj4+IDIuNDAuMQo+Pgo+Pgo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+PiBMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+PiBodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
