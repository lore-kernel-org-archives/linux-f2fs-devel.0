Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2784DC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UaM/kA69pKIYRWmplPfOAnIEGguueGFs1P3up0AWqOM=; b=caRZOyaLEcJO4AYzwZXpLV+dG4
	yx6cpN//hYfC7MPswB+oOBq1lfdYCUKSX6ANR9rvk0b8fx94Dr1eWSyxT8Nk9WRMaDtcjueBX9bDC
	3IF97NI6uzK5AtBlUmOCidOHHasUealo7ICcBol5coLUU1AuTYdujT9LvG57jVjDr1Nk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weWFC-0007ZP-Md;
	Tue, 30 Jun 2026 11:03:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weWEr-0007Yo-4b
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WMJgU7k3s4TM2At+hKoin8UaWXfonWN6mqvCqCeU92Y=; b=TwBfjHcfcVXFdsjjqyCpxVHMWn
 HAdMEtz+jNCDQSAuhOfAA6AS41Zeg2ngnIsf4H30VPmnzWvaOXlYOFtavkuFG0jc2XUzCk7S6Yg4f
 ZpxSgUlbYvxI0LXMZRtAw16EcwuLyB0H0VAH4Zis6FbF4VIQ9XPpGbHdH7zH4mheyE7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WMJgU7k3s4TM2At+hKoin8UaWXfonWN6mqvCqCeU92Y=; b=maFnuQin6+m45s7xvilT0H8VPx
 N+aVi0nNhEVF7spC3L/RfcPRaUQIuWDOwy7D6OWmF/aZ/rAf7/Q+dJR5zUfCNhP14FuYwiVHu9vcA
 w9JMeTMl601sXKg9WmNPcIy6kc/H6yi9mpHGxI1dzjZ8JN4KhyESLIrKnHEIJE+Wpp10=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weWEl-0000cy-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:02:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 596BE600FF;
 Tue, 30 Jun 2026 11:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921AE1F000E9;
 Tue, 30 Jun 2026 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782817358;
 bh=WMJgU7k3s4TM2At+hKoin8UaWXfonWN6mqvCqCeU92Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZoSlMyGSHyoiDOQ3D6rPo2K7Yd2B4u61PcS3/N8AZ60xZsRbhT473TwqQPTH9xmXL
 dVGeJ6JbrY3j/K30qV0SwSBS1MF0sye4/wXsIkfan3kjYgteB+6WOftMkOWrKvCfkY
 wQ0FC2ZBjslO6biu9jIuQ5iamqDiZxN8KSUrJAEqCrUcq0mbFkpm7HGotTRlYspvDj
 8fmTxwDRx9/25XeMeSH2bW5zd5VP1cosLKBJ8w0wL6mBLdrrYrM9aOJ49eadXTIdCs
 CP/Baqua0HoWUPCVrssYupRO4+f4XApJWe92Ty7wr+UtzfuJBc9ayZB69zUo20HQOn
 mgmxPpIrCo0dA==
Message-ID: <5ad89199-f5e8-43a7-971a-575ff27c1d40@kernel.org>
Date: Tue, 30 Jun 2026 19:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260629114918.224537-1-chao@kernel.org>
 <CAHJ8P3LOBs0gWHM7rT-G51tQ7Q+utn_xupnp2BuBir+cAC-Xiw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3LOBs0gWHM7rT-G51tQ7Q+utn_xupnp2BuBir+cAC-Xiw@mail.gmail.com>
X-Headers-End: 1weWEl-0000cy-Fd
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential
 section-unaligned pinfile
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNi8zMC8yNiAxNjo1MCwgWmhpZ3VvIE5pdSB3cm90ZToKPiBDaGFvIFl1IHZpYSBMaW51eC1m
MmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiDkuo4y
MDI25bm0NuaciDI55pel5ZGo5LiAIDE5OjUy5YaZ6YGT77yaCj4+Cj4+IEJsb2NrcyBvZiBwaW5m
aWxlIG1heSBub3QgYWxpZ25lZCB0byBzZWN0aW9uIHNpemUgZHVlIHRvIHdyb25nIHVzZQo+PiBv
biBwaW5maWxlLCByZXN1bHQgaW4gaGVhdnkgb3ZlcmhlYWQgb2YgR0MsIGxldCBhdm9pZCB0aGlz
IGJ5Cj4+IGFkZGluZyBhZGRpdGlvbmFsIGNoZWNrIGNvbmRpdGlvbiBpbiBmMmZzX3NldGF0dHIo
KS4KPj4KPj4gLSB0cnVuY2F0ZSAtcyA4bWIgcGluZmlsZQo+PiA6IHJhbmRvbSBjaGVja3BvaW50
IG1heSBwZXJzaXN0IGZpbGVzaXplIHcvIGlub2RlCj4+IC0gZmFsbG9jYXRlIC1vIDAgLWwgOG1i
IHBpbmZpbGUKPj4gIC0gZjJmc19mYWxsb2NhdGUKPj4gICAtIGYyZnNfZXhwYW5kX2lub2RlX2Rh
dGEKPj4gICAgLSBmMmZzX2FsbG9jYXRlX3Bpbm5pbmdfc2VjdGlvbgo+PiAgICAtIGYyZnNfbWFw
X2Jsb2Nrcwo+PiAgICAgLSBmMmZzX21hcF9sb2NrCj4+ICAgICAtIF9fYWxsb2NhdGVfZGF0YV9i
bG9jawo+PiAgICAgLSBmaWxlX25lZWRfdHJ1bmNhdGUKPj4gICAgIDogdy8gRkFEVklTRV9UUlVO
Q19CSVQsIHdlIGNhbiBleHBlY3QgdW5hbGlnbmVkIG1hcHBpbmcgY2FuIGJlCj4+ICAgICAgIHRy
dW5jYXRlZCB3aGlsZSBvcGVuKCkgaWYgZjJmcyBpcyBub3QgdW1vdW50IGFibm9ybWFsbHkKPj4g
ICAgIC0gZjJmc19tYXBfdW5sb2NrCj4+ICAgICA6IGZvbGxvd2luZyBmMmZzIGNoZWNrcG9pbnQg
YW5kIHN1ZGRlbiBwb3dlci1jdXQKPj4KPj4gLSBtb3VudAo+PiAtIG9wZW4gcGluZmlsZQo+PiAg
LSBmMmZzX2ZpbGVfb3Blbgo+PiAgIC0gZmluaXNoX3ByZWFsbG9jYXRlX2Jsb2Nrcwo+PiAgICAt
IHRydW5jYXRlX3NldHNpemUKPj4gICAgOiBmaWxlc2l6ZSBpcyA4bWIKPj4gICAgLSBmMmZzX3Ry
dW5jYXRlCj4+ICAgIDogY2FuIG9ubHkgdHJ1bmNhdGUgYmxvY2sgb3V0c2lkZSBmaWxlc2l6ZSwg
cmF0aGVyIHRoYW4gdHJ1bmNhdGluZwo+PiAgICAgIHVuYWxpZ25lZCBibG9ja3MgaW5zaWRlIGZp
bGVzaXplCj4gSGkgQ2hhbywKPiA4TUIgaXMgc2VjdGlvbiBhbGluZ2VkIHdoZW4gZmFsbG9jYXRl
ZCBieSBmMmZzX2FsbG9jYXRlX3Bpbm5pbmdfc2VjdGlvbj8/Cj4gc28gSG93IGNvdWxkIHRoZXJl
IGFyZSB1bmFsaWduZWQgYmxvY2tzIGluc2lkZSBmaWxlc2l6ZT8KClpoaWd1bywKCkFzIHBhcnRp
YWwgYmxrYWRkcnMgd2VyZSBwZXJzaXN0ZWQgYW5kIHJlY292ZXJlZCwgc2VlIGNvbW1lbnRzIGFy
b3VuZApmMmZzX21hcF91bmxvY2soKS4KCj4+Cj4+IEZpeGVzOiBmNWE1M2VkY2YwMWUgKCJmMmZz
OiBzdXBwb3J0IGFsaWduZWQgcGlubmVkIGZpbGUiKQo+PiBDYzogc3RhYmxlQGtlcm5lbC5vcmcK
Pj4gQ2M6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPj4gLS0tCj4+ICBmcy9mMmZzL2ZpbGUuYyB8
IDI4ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMv
ZmlsZS5jIGIvZnMvZjJmcy9maWxlLmMKPj4gaW5kZXggZjRmYWNkNDA5ZDliLi4xMWNjOGQ3OWMy
MzUgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4+ICsrKyBiL2ZzL2YyZnMvZmlsZS5j
Cj4+IEBAIC0xMTA3LDE3ICsxMTA3LDIzIEBAIGludCBmMmZzX3NldGF0dHIoc3RydWN0IG1udF9p
ZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIUlTX0FMSUdORUQoYXR0ci0+aWFfc2l6ZSwKPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgRjJGU19CTEtfVE9fQllURVMoZmktPmlfY2x1c3Rlcl9zaXplKSkpCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiAtICAgICAgICAgICAgICAgLyoKPj4gLSAg
ICAgICAgICAgICAgICAqIFRvIHByZXZlbnQgc2NhdHRlcmVkIHBpbiBibG9jayBnZW5lcmF0aW9u
LCB3ZSBkb24ndCBhbGxvdwo+PiAtICAgICAgICAgICAgICAgICogc21hbGxlci9lcXVhbCBzaXpl
IHVuYWxpZ25lZCB0cnVuY2F0aW9uIGZvciBwaW5uZWQgZmlsZS4KPj4gLSAgICAgICAgICAgICAg
ICAqIFdlIG9ubHkgc3VwcG9ydCBvdmVyd3JpdGUgSU8gdG8gcGlubmVkIGZpbGUsIHNvIGRvbid0
Cj4+IC0gICAgICAgICAgICAgICAgKiBjYXJlIGFib3V0IGxhcmdlciBzaXplIHRydW5jYXRpb24u
Cj4+IC0gICAgICAgICAgICAgICAgKi8KPj4gLSAgICAgICAgICAgICAgIGlmIChmMmZzX2lzX3Bp
bm5lZF9maWxlKGlub2RlKSAmJgo+PiAtICAgICAgICAgICAgICAgICAgICAgICBhdHRyLT5pYV9z
aXplIDw9IGlfc2l6ZV9yZWFkKGlub2RlKSAmJgo+PiAtICAgICAgICAgICAgICAgICAgICAgICAh
SVNfQUxJR05FRChhdHRyLT5pYV9zaXplLAo+PiAtICAgICAgICAgICAgICAgICAgICAgICBGMkZT
X0JMS19UT19CWVRFUyhDQVBfQkxLU19QRVJfU0VDKHNiaSkpKSkKPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gKyAgICAgICAgICAgICAgIGlmIChmMmZz
X2lzX3Bpbm5lZF9maWxlKGlub2RlKSkgewo+PiArICAgICAgICAgICAgICAgICAgICAgICAvKgo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgKiBJdCBtYXkgYnJlYWsgc2VjdGlvbi1hbGlnbmVk
IGZhbGxvY2F0ZSByZWNvdmVyeQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgKiBtZWNoYW5p
c20sIHNvIGRvIG5vdCBhbGxvdyBsYXJnZXIgc2l6ZSB0cnVuY2F0aW9uLgo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgKi8KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGF0dHItPmlh
X3NpemUgPiBpX3NpemVfcmVhZChpbm9kZSkpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gSXMgaXQgb2sgaWYgd2UgYWxsb3cgbGFyZ2VyIHNpemUg
dHJ1bmNhdGlvbiBhbmQgYWxzbyAgbGltaXQgaXQgdG8KPiBhbGlnbmVkICJGMkZTX0JMS19UT19C
WVRFUyhDQVBfQkxLU19QRVJfU0VDKHNiaSkiPwoKTm8sIEkgdGhpbmsgYWJvdmUgZXhhbXBsZSB3
aWxsIHN0aWxsIHN1ZmZlciBzZWN0aW9uLXVuYWxpZ25lZCBpc3N1ZS4KClRoYW5rcywKCj4gdGhh
bmtzIQo+PiArICAgICAgICAgICAgICAgICAgICAgICAvKgo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgKiBUbyBwcmV2ZW50IHNjYXR0ZXJlZCBwaW4gYmxvY2sgZ2VuZXJhdGlvbiwgd2UgZG9u
J3QKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogYWxsb3cgc21hbGxlci9lcXVhbCBzaXpl
IHVuYWxpZ25lZCB0cnVuY2F0aW9uIGZvcgo+PiArICAgICAgICAgICAgICAgICAgICAgICAgKiBw
aW5uZWQgZmlsZS4KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICovCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGVsc2UgaWYgKCFJU19BTElHTkVEKGF0dHItPmlhX3NpemUsCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRjJGU19CTEtfVE9fQllURVMoQ0FQX0JMS1NfUEVS
X1NFQyhzYmkpKSkpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4+ICsgICAgICAgICAgICAgICB9Cj4+ICAgICAgICAgfQo+Pgo+PiAgICAgICAgIGlm
IChpc19xdW90YV9tb2RpZmljYXRpb24oaWRtYXAsIGlub2RlLCBhdHRyKSkgewo+PiAtLQo+PiAy
LjQ5LjAKPj4KPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
