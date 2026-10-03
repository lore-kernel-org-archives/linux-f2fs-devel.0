Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83217CA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsccpV9+SwYFZ7S0j1v7g9+TVG+lUJOvr3UsxyDcA6s=; b=W2huBWn6mBiKqRjc4/wTSRIXrE
	gXIdPAKJ/gvwja4i4wVfXuDGdpP5WJyMiwYmMcrjxxpmtN7rLTuoOxlbg47z/uahRKeG2/hThFhN3
	ZXhq1d+8N+ViRxUQGWlaL++U2ram557DySNCReEq7j6SRqHkholJOxZEVJuTLn6jueEg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodv-00067O-QJ;
	Sat, 03 Oct 2026 01:34:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodu-000675-Bb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SySqUGBtZUkxe/IcZwklkIQ9/BMIZLRIdk8geHpfU08=; b=dCu3lZ3Ojw95TyTlIJwgfQhYD7
 AicZGF8YMFUVoD54bczQyGGylqRaYch8RDMjbKw1UsNj2F8Pbpuvlgq6SBSzPF5fpVUybd34C7Iwx
 ya8PF2Buvgk9AR14ybDDq1eJN+NV0qzvtUPTQN9x+acTH3EBT855et6qG+nGdc69ACI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SySqUGBtZUkxe/IcZwklkIQ9/BMIZLRIdk8geHpfU08=; b=aSQwkgnyTX7TZTAWx5vMCpWcQU
 17hjarHFYXPwH06tus2OuIHwOXKasAs8lWtRJBk/VnDKnfrGlstqVCj5sTLUPqlg01RXcVDNqDGQj
 GVjYi48yOnlR7sD0znCBAZ0h1uXX0fndGG+qWkEmimhcVoAlN4ewfAWk6oyL+S38FeY0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodu-00071V-J4 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48CFA4482A;
 Sat,  3 Oct 2026 01:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED4D1F000FF;
 Sat,  3 Oct 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991261;
 bh=SySqUGBtZUkxe/IcZwklkIQ9/BMIZLRIdk8geHpfU08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OovaZvHYApS21HzUT1ObshpQBYaY5A8CUrmekMEXuidw5zyfu/PRj44303DTwfxcx
 aAaHGQ49G+G/c3X451kuW6DfIYtsFVGQiqByh8c9Gc7tMZ9S4uRbbQx4WdnlI2gwPq
 p/PSlIbLfnw+GYC5umsaLg/cMtan8EvDeeLNXj+SgGA2MAzSWbnfBqg0hrDq7AJIXo
 m4lQ9ulXWrlH6KWJDzugKSuzy7RwTEppL3kJ/FlKnPY6RCmihcKuTileUwOQIyLK3k
 P1UDgVtkFEwypjv+DE1CWDVxsMUMGNRVVOfEiRL9zaWLTLXVOCfqAdj7eTpquXXOIy
 VisLY3UcDiEbQ==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-12-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-12-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:20 +0000
Message-Id: <20261003013420.DED4D1F000FF@smtp.kernel.org>
X-Headers-End: 1xCodu-00071V-J4
Subject: Re: [f2fs-dev] [PATCH v17 11/21] xfs: handle fsverity I/O in
 write/read path
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
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MiBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW0hpZ2hdIHhmczogdW5jb25kaXRp
b25hbCBJT01BUF9GX0ZTVkVSSVRZIGluIHhmc19tYXBfYmxvY2tzIHRyaWdnZXJzIFdBUk5fT05f
T05DRQotIFtNZWRpdW1dIHhmczogSU9NQVBfRl9TSEFSRUQgc3RhdGUgbGVhayBpbiB4ZnNfem9u
ZWRfYnVmZmVyZWRfd3JpdGVfaW9tYXBfYmVnaW4KLS0KCmNvbW1pdCAyZmM2ODI1NjdhODhiNWE2
YTI2MGFmNjBkYTMzNTM2N2EzNDYzNTNiCkF1dGhvcjogQW5kcmV5IEFsYmVyc2h0ZXluIHZpYSBM
aW51eC1mMmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4K
CnhmczogaGFuZGxlIGZzdmVyaXR5IEkvTyBpbiB3cml0ZS9yZWFkIHBhdGgKClRoaXMgY29tbWl0
IGFkZHMgZnN2ZXJpdHkgaGFuZGxpbmcgdG8gdGhlIFhGUyByZWFkIGFuZCB3cml0ZSBwYXRocy4g
SXQKaW50cm9kdWNlcyBhIG5ldyBpbm9kZSBmbGFnIGZvciBNZXJrbGUgdHJlZSBjb25zdHJ1Y3Rp
b24gYW5kIHBhc3NlcyB0aGUKSU9NQVBfRl9GU1ZFUklUWSBmbGFnIHRvIGlvbWFwIHNvIGl0IHBy
b2Nlc3NlcyBmc3Zlcml0eSBtZXRhZGF0YSBwcm9wZXJseQpiZXlvbmQgRU9GLgoKPiBkaWZmIC0t
Z2l0IGEvZnMveGZzL3hmc19hb3BzLmMgYi9mcy94ZnMveGZzX2FvcHMuYwo+IGluZGV4IGMzMGU2
ODhjZmM5ZjYuLjE5NjQwZTRlM2VkMTIgMTAwNjQ0Cj4gLS0tIGEvZnMveGZzL3hmc19hb3BzLmMK
PiArKysgYi9mcy94ZnMveGZzX2FvcHMuYwo+IEBAIC0xNzIsMTIgKzE3MywxNiBAQCB4ZnNfbWFw
X2Jsb2NrcygKPiAgCWludAkJCXJldHJpZXMgPSAwOwo+ICAJaW50CQkJZXJyb3IgPSAwOwo+ICAJ
dW5zaWduZWQgaW50CQkqc2VxOwo+ICsJdW5zaWduZWQgaW50CQlpb21hcF9mbGFncyA9IDA7Cj4g
IAo+ICAJaWYgKHhmc19pc19zaHV0ZG93bihtcCkpCj4gIAkJcmV0dXJuIC1FSU87Cj4gIAo+ICAJ
WEZTX0VSUk9SVEFHX0RFTEFZKG1wLCBYRlNfRVJSVEFHX1dCX0RFTEFZX01TKTsKPiAgCj4gKwlp
ZiAoeGZzX2lmbGFnc190ZXN0KGlwLCBYRlNfVkVSSVRZX0NPTlNUUlVDVElPTikpCj4gKwkJaW9t
YXBfZmxhZ3MgfD0gSU9NQVBfRl9GU1ZFUklUWTsKCltTZXZlcml0eTogSGlnaF0KRG9lcyB0aGlz
IHVuY29uZGl0aW9uYWxseSBzZXQgSU9NQVBfRl9GU1ZFUklUWSBmb3IgYW55IHdyaXRlYmFjayB3
aGVuIHRoZQpjb25zdHJ1Y3Rpb24gZmxhZyBpcyBzZXQ/CgpJZiBhIHVzZXIgbW1hcHMgYSBmaWxl
IHdpdGggUFJPVF9XUklURSwgY2FsbHMgRlNfSU9DX0VOQUJMRV9WRVJJVFksIGFuZApkaXJ0aWVz
IGEgZm9saW8gYmVsb3cgaXNpemUgZHVyaW5nIE1lcmtsZSB0cmVlIGNvbnN0cnVjdGlvbiwgdGhl
IHdyaXRlYmFjawp3aWxsIGhpdCB0aGlzIHBhdGggYW5kIGFwcGx5IElPTUFQX0ZfRlNWRVJJVFku
IFRoaXMgYXBwZWFycyB0byBsYWNrIHRoZQpvZmZzZXQgPj0geGZzX2ZzdmVyaXR5X21ldGFkYXRh
X29mZnNldChpcCkgcmVzdHJpY3Rpb24gdXNlZCBlbHNld2hlcmUKKHN1Y2ggYXMgaW4geGZzX2Jt
YXBpX2NvbnZlcnRfb25lX2RlbGFsbG9jKCkpLCB3aGljaCBjb3VsZCB0cmlnZ2VyIGEKV0FSTl9P
Tl9PTkNFKGZvbGlvX3Bvcyhmb2xpbykgPCBpc2l6ZSkgaW4gaW9tYXBfd3JpdGVwYWdlX2hhbmRs
ZV9lb2YoKQpmb3IgZm9saW9zIGJlZm9yZSBFT0YuCgpbIC4uLiBdCgo+IGRpZmYgLS1naXQgYS9m
cy94ZnMveGZzX2lvbWFwLmMgYi9mcy94ZnMveGZzX2lvbWFwLmMKPiBpbmRleCA3YzYyMzhmZWQ2
MWU0Li5jY2M4YjhmYWJhYjNmIDEwMDY0NAo+IC0tLSBhL2ZzL3hmcy94ZnNfaW9tYXAuYwo+ICsr
KyBiL2ZzL3hmcy94ZnNfaW9tYXAuYwpbIC4uLiBdCj4gQEAgLTE2NjgsNyArMTY3NCw4IEBAIHhm
c196b25lZF9idWZmZXJlZF93cml0ZV9pb21hcF9iZWdpbigKPiAgCQkJCXNtYXAuYnJfc3RhcnRv
ZmYgKyBzbWFwLmJyX2Jsb2NrY291bnQpOwo+ICAJCQl4ZnNfdHJpbV9leHRlbnQoJnNtYXAsIG9m
ZnNldF9mc2IsCj4gIAkJCQkJZW5kX2ZzYiAtIG9mZnNldF9mc2IpOwo+IC0JCQllcnJvciA9IHhm
c19ibWJ0X3RvX2lvbWFwKGlwLCBzcmNtYXAsICZzbWFwLCBmbGFncywgMCwKPiArCQkJZXJyb3Ig
PSB4ZnNfYm1idF90b19pb21hcChpcCwgc3JjbWFwLCAmc21hcCwgZmxhZ3MsCj4gKwkJCQkJaW9t
YXBfZmxhZ3MsCj4gIAkJCQkJeGZzX2lvbWFwX2lub2RlX3NlcXVlbmNlKGlwLCAwKSk7Cj4gIAkJ
CWlmIChlcnJvcikKPiAgCQkJCWdvdG8gb3V0X3VubG9jazsKPiBAQCAtMTY3OCw2ICsxNjg1LDgg
QEAgeGZzX3pvbmVkX2J1ZmZlcmVkX3dyaXRlX2lvbWFwX2JlZ2luKAo+ICAJaWYgKCFpcC0+aV9j
b3dmcCkKPiAgCQl4ZnNfaWZvcmtfaW5pdF9jb3coaXApOwo+ICAKPiArCWlvbWFwX2ZsYWdzIHw9
IElPTUFQX0ZfU0hBUkVEOwo+ICsKCltTZXZlcml0eTogTWVkaXVtXQpDYW4gdGhpcyBJT01BUF9G
X1NIQVJFRCBzdGF0ZSBsZWFrIGFjcm9zcyBpdGVyYXRpb25zPwoKQnkgbW9kaWZ5aW5nIHRoZSBs
b2NhbCBpb21hcF9mbGFncyB2YXJpYWJsZSBoZXJlLCBpdCBzZWVtcyBJT01BUF9GX1NIQVJFRApp
cyByZXRhaW5lZCBpZiB0aGUgY29kZSBsYXRlciB0YWtlcyB0aGUgZ290byByZXN0YXJ0IHBhdGgu
Cgp4ZnNfem9uZWRfYnVmZmVyZWRfd3JpdGVfaW9tYXBfYmVnaW4oKSB7CnJlc3RhcnQ6CiAgICAu
Li4KICAgIGVycm9yID0geGZzX2JtYnRfdG9faW9tYXAoLi4uLCBpb21hcF9mbGFncywgLi4uKTsK
ICAgIC4uLgogICAgaW9tYXBfZmxhZ3MgfD0gSU9NQVBfRl9TSEFSRUQ7CiAgICAuLi4KICAgIGlm
ICgoZmxhZ3MgJiBJT01BUF9aRVJPKSAmJiBzcmNtYXAtPnR5cGUgPT0gSU9NQVBfSE9MRSkgewog
ICAgICAgIGlmIChmaWxlbWFwX3JhbmdlX25lZWRzX3dyaXRlYmFjayguLi4pKSB7CiAgICAgICAg
ICAgIC4uLgogICAgICAgICAgICBnb3RvIHJlc3RhcnQ7CiAgICAgICAgfQogICAgfQp9CgpUaGlz
IHdvdWxkIHBvbGx1dGUgdGhlIHNvdXJjZSBtYXAgc3RhdGUgd2l0aCBDT1ctc3BlY2lmaWMgZmxh
Z3Mgb24gdGhlCnN1YnNlcXVlbnQgaXRlcmF0aW9uLgoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3
IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAwMjIyMzcwNS4yMTc1NTQyLTEt
YWFsYmVyc2hAa2VybmVsLm9yZz9wYXJ0PTExCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
