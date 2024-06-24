Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E15C27C4F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2024 01:58:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sLYyb-0004O3-8i;
	Mon, 24 Jun 2024 01:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sLYyZ-0004Nx-TZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 01:58:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IRgn63ahMFQlYmSlaFDBmIEYBi1bk5q0CCobWZfVsmk=; b=f5afdRA8hHMog6p0hC79wV0ZWb
 RtjtfAfhHitUakNbPcAVzqC+LQmYhEBF3uSZg2fsJnhSN69RfJAmallcBU6UFh8fSM73XxC61y1Ja
 90gehBm4myUmhqc1xPYcI5vij0FF8FRnc3FPyeNpe4Grr2aVIONyZfIVHIYgg0jbX5u8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IRgn63ahMFQlYmSlaFDBmIEYBi1bk5q0CCobWZfVsmk=; b=ZoXcd4wB3oewYV5g7Z3sii9bJC
 hvKLEG4JMDOooE9VkD2Y1eqV8LiZBp+BI2H+pp+rrdg4H5SUSMrxjMbyc8ehv5AjfI0+NXboYZ15d
 4VaSQU00NhLFEAbS73eyQJlo2YsuS87UcxzA9aUVNatIS3OfdOMDfPrNV7gw1JV1uBUI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sLYya-0002vj-Sh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 01:58:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 721EBCE1067;
 Mon, 24 Jun 2024 01:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F0AC2BD10;
 Mon, 24 Jun 2024 01:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719194308;
 bh=GpDfdTZNP+dYTbdjDBrpbsC4ckNum2kz7o64tgKOqCM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FBjsfufSyYuou00Gv45QP2AF7Njr1JLe479GgOcWyKeV2O4xqgBcGOxAuyQ34LIaR
 I5E8lAayBhkBxlIgzB7J0fjwdSjb09kXp1a/+qtg3tdmG5FkpKB0AajFvGZC0IamQX
 YSxiNIaSZ2It396SPsJy6w3IeePaW5TazKMNvcNnpTBhSWMIQ3e0/aJ3gCrTRUVtkO
 Q3+y+u33qj4tUc9fU9SeNBMMHNip9M1GsT6R7AoBNGkbqlu3cNKJszH2nuCxtwrtx9
 +fcU90iM3xb0JTZ0aPTo26+cKHi1kcEpJ7QZ3x9gnmC8KgzESc5hvIi5lLVtCz+CvP
 jUgwydwy3WiFg==
Message-ID: <dfc4a115-9778-49b0-8a11-fd1cfd2272e9@kernel.org>
Date: Mon, 24 Jun 2024 09:58:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jaegeuk@kernel.org, Daeho Jeong <daeho43@gmail.com>
References: <20240606095213.4087668-1-chao@kernel.org>
 <d38a2712-f7cc-4aea-a343-00335a5215a0@kernel.org>
 <CACOAw_x3s2m70-cBhA0X0h5AetCQgDzVh7hRM00OVm=0Od5FUA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_x3s2m70-cBhA0X0h5AetCQgDzVh7hRM00OVm=0Od5FUA@mail.gmail.com>
X-Headers-End: 1sLYya-0002vj-Sh
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to add missing sb_{start,
 end}_intwrite() for ckpt thread
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgYWxsLAoKUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCBiZWNhdXNlIGR1cmluZyBmcmVlemVf
c3VwZXIoKSwgaXQgd2lsbCBjYWxsCnN5bmNfZnMoKSB0byBjbGVhciBhbGwgZGlydHkgZGF0YSwg
dGhlcmUgc2hvdWxkIGJlIG5vIHJhY2UgY2FzZSBhZnRlcgp0aGF0LgoKVGhhbmtzLAoKT24gMjAy
NC82LzEwIDIzOjEwLCBEYWVobyBKZW9uZyB3cm90ZToKPiBPbiBTYXQsIEp1biA4LCAyMDI0IGF0
IDU6MzbigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBPbiAyMDI0
LzYvNiAxNzo1MiwgQ2hhbyBZdSB3cm90ZToKPj4+IEFmdGVyIGNvbW1pdCAyNjFlZWI5YzE1ODUg
KCJmMmZzOiBpbnRyb2R1Y2UgY2hlY2twb2ludF9tZXJnZSBtb3VudAo+Pj4gb3B0aW9uIiksIGNo
ZWNrcG9pbnQgY2FuIGJlIHRyaWdnZXJlZCBpbiBiYWNrZ3JvdW5kIHRocmVhZCwgaXQgbWlzc2Vk
Cj4+PiB0byBjb3ZlciBmMmZzIGlubmVyIGNoZWNrcG9pbnQgb3BlcmF0aW9uIHcvIHNiX3tzdGFy
dCxlbmR9X2ludHdyaXRlKCksCj4+PiBmaXggaXQuCj4+Cj4+IEl0IG5lZWRzIHRvIHVzZSBzYl9z
dGFydF9pbnR3cml0ZV90cnlsb2NrKCksIG90aGVyd2lzZSwgaXQgd2lsbCBjYXVzZQo+PiBkZWFk
bG9jayBhcyBiZWxvdzoKPj4KPj4gLSBmcmVlemVfc3VwZXIKPj4gICAgLSBzYl93YWl0X3dyaXRl
KFNCX0ZSRUVaRV9XUklURSkKPj4gICAgLSBzYl93YWl0X3dyaXRlKFNCX0ZSRUVaRV9QQUdFRkFV
TFQpCj4+ICAgIC0gc2Jfd2FpdF93cml0ZShTQl9GUkVFWkVfRlMpCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBzeW5jCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC0gaXRlcmF0ZV9zdXBlcnMKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gc3VwZXJfbG9ja19zaGFyZWQKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGRvd25fcmVhZCgmc2ItPnNf
dW1vdW50KQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0g
c3luY19mc19vbmVfc2IKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLSBmMmZzX3N5bmNfZnMKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0gZjJmc19pc3N1ZV9jaGVja3BvaW50Cj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSB3YWl0X2Zvcl9jb21wbGV0aW9uCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtIGlzc3VlX2NoZWNrcG9pbnRfdGhyZWFkCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLSBzYl9zdGFydF9pbnR3cml0ZShzYmktPnNiKTsKPj4KPj4gLSB0aGF3X3N1cGVyCj4+ICAg
IC0gc3VwZXJfbG9ja19leGNsCj4+ICAgICAtIGRvd25fd3JpdGUoJnNiLT5zX3Vtb3VudCkKPj4K
Pj4gVGhhbmtzLAo+Pgo+Pj4KPj4+IEZpeGVzOiAyNjFlZWI5YzE1ODUgKCJmMmZzOiBpbnRyb2R1
Y2UgY2hlY2twb2ludF9tZXJnZSBtb3VudCBvcHRpb24iKQo+Pj4gQ2M6IERhZWhvIEplb25nIDxk
YWVob2plb25nQGdvb2dsZS5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvQGtl
cm5lbC5vcmc+Cj4+PiAtLS0KPj4+ICAgIGZzL2YyZnMvY2hlY2twb2ludC5jIHwgNSArKysrLQo+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2NoZWNrcG9pbnQuYyBiL2ZzL2YyZnMvY2hlY2twb2lu
dC5jCj4+PiBpbmRleCA1NWQ0NDRiZWM1YzAuLjY2ZWFhZDU5MWI2MCAxMDA2NDQKPj4+IC0tLSBh
L2ZzL2YyZnMvY2hlY2twb2ludC5jCj4+PiArKysgYi9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+Pj4g
QEAgLTE4MjgsOCArMTgyOCwxMSBAQCBzdGF0aWMgaW50IGlzc3VlX2NoZWNrcG9pbnRfdGhyZWFk
KHZvaWQgKmRhdGEpCj4+PiAgICAgICAgaWYgKGt0aHJlYWRfc2hvdWxkX3N0b3AoKSkKPj4+ICAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4KPj4+IC0gICAgIGlmICghbGxpc3RfZW1wdHkoJmNw
cmMtPmlzc3VlX2xpc3QpKQo+Pj4gKyAgICAgaWYgKCFsbGlzdF9lbXB0eSgmY3ByYy0+aXNzdWVf
bGlzdCkpIHsKPj4+ICsgICAgICAgICAgICAgc2Jfc3RhcnRfaW50d3JpdGUoc2JpLT5zYik7Cj4+
PiAgICAgICAgICAgICAgICBfX2NoZWNrcG9pbnRfYW5kX2NvbXBsZXRlX3JlcXMoc2JpKTsKPj4+
ICsgICAgICAgICAgICAgc2JfZW5kX2ludHdyaXRlKHNiaS0+c2IpOwo+Pj4gKyAgICAgfQo+Pj4K
Pj4+ICAgICAgICB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoKnEsCj4+PiAgICAgICAgICAgICAg
ICBrdGhyZWFkX3Nob3VsZF9zdG9wKCkgfHwgIWxsaXN0X2VtcHR5KCZjcHJjLT5pc3N1ZV9saXN0
KSk7Cj4+Cj4+Cj4gCj4gUmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2ds
ZS5jb20+Cj4gCj4gVGhhbmtzLgo+IAo+IAo+IAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+
PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+PiBodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAo=
