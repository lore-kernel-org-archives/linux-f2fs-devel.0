Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1106CA9EBB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 01:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ps288q2L7SUkip/3tXHGwYu6yCKpA2dgPqxjJeZBEU=; b=Ua72TW2HXG7PTDze+kP0OkdlTM
	sh7eYxlzKFvEX4j+fwvpwIP32rfd+ibRTi5m5VksV6Grr6897pgKGVJHIpEoTgnkp3Btu38JSiUO6
	2WhVsPBXQucJTSMmfMlhpmHXyxLdSYxxowrqWVtbWOB3i+lf+gLrt3HY0LeKoWmMXYDs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFM4y-0004cL-0v;
	Sat, 10 Oct 2026 01:40:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFM4u-0004U2-HL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 01:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SZl4SnArjiyXWWZ9ZgVuzgd9w33IJ6HXnd3SOcZyUFA=; b=gAmP6UNVYI0odxAU9gxwm5T0Yn
 MoT+E+GpKGzH7nRM4SvUiKgLR654leYgKGmRjKXhc/jor/P7rAdOM7uiyJBEx9ULBQDPczo6AJ2Xo
 BB/EfGDGT2x6fkCKGbrwCBqIfLq9X+9qZuu1zrEubopPXpPGntT57jAyD4ZFr9ZGls6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SZl4SnArjiyXWWZ9ZgVuzgd9w33IJ6HXnd3SOcZyUFA=; b=VrnQ/dd2QKz3DHqXimmex53xde
 5QNJHFxJHnpspJhfDndPlyilvY2b4rSUkbn5xrQyzChZsBjN4uiwbazJG9ndED2PnUiRAdFUAz74u
 XaApW2YQxgAfz7jl66esP0l+4458aC9OYFt8osM6RumK02ykF3qhMB608yrbag+H0g4M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFM4r-0006sg-FD for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 01:40:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 230C3409CE;
 Sat, 10 Oct 2026 01:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191661F000FF;
 Sat, 10 Oct 2026 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791596440;
 bh=SZl4SnArjiyXWWZ9ZgVuzgd9w33IJ6HXnd3SOcZyUFA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TuVtSeFNT/gJffAaYNL/Ilcpd6AwMuOY2Tzzt4aGBSYcT9twshC03XF6yybQW+thv
 s0pm/3syuVqdqGksDn19C6GRsWeoPSBF1HfEt8gIoehF82IgP32y+TrVUV31s9jS52
 hhvB/Pz8vXqLnk9pcyJ3DStlltNIWwYjUrrGGctTtKyl+joR1kUqHb4RSLB7n/zXa6
 oRBI44N8mDgRowL0l0k9vRYTlEyNcWd99afSL0aJstyDT5MiZtpNwkW0EmfpFZE0M+
 sp0+duEbKdv22K9suEL8dhPka4hvBwQ1UShuisU6W23Sje5Rq6iQPhQf1zaGh8EJk7
 yGTiTIFrYU/fg==
Message-ID: <bc41a1a3-773f-4c6b-8c47-9eb622127373@kernel.org>
Date: Sat, 10 Oct 2026 09:40:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20261002171704.3652570-1-daeho43@gmail.com>
 <63812000-4677-4af6-a3e1-4e87e39f0d88@kernel.org>
 <CACOAw_w5uXiYqGObti+uiWwJSeaNCZc6+t3j2yopL-PLf226=A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_w5uXiYqGObti+uiWwJSeaNCZc6+t3j2yopL-PLf226=A@mail.gmail.com>
X-Headers-End: 1xFM4r-0006sg-FD
Subject: Re: [f2fs-dev] [PATCH] f2fs: disallow mmap write and data-modifying
 fallocate on atomic files
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgpPbiAxMC85LzI2IDIzOjA1LCBEYWVobyBKZW9uZyB3cm90ZToKPiBPbiBGcmksIE9jdCA5LCAy
MDI2IGF0IDE6MzXigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBP
biAxMC8zLzI2IDAxOjE3LCBEYWVobyBKZW9uZyB3cm90ZToKPj4+IEZyb206IERhZWhvIEplb25n
IDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4+Pgo+Pj4gU3RvcmVzIHRocm91Z2ggYSBzaGFyZWQg
d3JpdGFibGUgbWFwcGluZyBhbmQgZmFsbG9jYXRlIHdpdGgKPj4+IEZBTExPQ19GTF9QVU5DSF9I
T0xFLCBGQUxMT0NfRkxfWkVST19SQU5HRSwgRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIG9yCj4+
PiBGQUxMT0NfRkxfSU5TRVJUX1JBTkdFIGRvIG5vdCBnbyB0aHJvdWdoIC0+d3JpdGVfYmVnaW4s
IHNvIHRoZXkgYnlwYXNzCj4+PiB0aGUgQ09XIGlub2RlIGFuZCBtb2RpZnkgdGhlIG9yaWdpbmFs
IGlub2RlIGRpcmVjdGx5LiBSZWplY3QgdGhlbSB3aGlsZQo+Pj4gdGhlIGZpbGUgaXMgaW4gYXRv
bWljIHdyaXRlIG1vZGUsIGFzIGZhbGxvY2F0ZSBhbHJlYWR5IGRvZXMgZm9yIHBpbm5lZAo+Pj4g
YW5kIGNvbXByZXNzZWQgZmlsZXMuIEEgd3JpdGUgZmF1bHQgZ2V0cyBTSUdCVVMgYW5kIGZhbGxv
Y2F0ZSBnZXRzCj4+PiAtRU9QTk9UU1VQUC4KPj4+Cj4+PiBmYWxsb2NhdGUgd2l0aG91dCB0aGVz
ZSBmbGFncyBvbmx5IHByZWFsbG9jYXRlcyBibG9ja3MgYW5kIHN0YXlzCj4+PiBhbGxvd2VkLgo+
Pj4KPj4+IEZpeGVzOiAzZGIxZGUwZTU4MmMgKCJmMmZzOiBjaGFuZ2UgdGhlIGN1cnJlbnQgYXRv
bWljIHdyaXRlIHdheSIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9u
Z0Bnb29nbGUuY29tPgo+Pj4gLS0tCj4+PiAgZnMvZjJmcy9maWxlLmMgfCAxMCArKysrKysrKy0t
Cj4+PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+Pj4gaW5k
ZXggZWY0ZDIxOGU2OTQuLjU2YzY4NmI4NTgwIDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9maWxl
LmMKPj4+ICsrKyBiL2ZzL2YyZnMvZmlsZS5jCj4+PiBAQCAtMTQwLDYgKzE0MCwxMCBAQCBzdGF0
aWMgdm1fZmF1bHRfdCBmMmZzX3ZtX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikK
Pj4+ICAgICAgICAgICAgICAgcmV0dXJuIFZNX0ZBVUxUX1NJR0JVUzsKPj4+ICAgICAgIH0KPj4+
Cj4+PiArICAgICAvKiBtbWFwIHN0b3JlcyBieXBhc3MgdGhlIENPVyBpbm9kZSBhbmQgd291bGQg
YnJlYWsgYXRvbWljaXR5ICovCj4+PiArICAgICBpZiAoZjJmc19pc19hdG9taWNfZmlsZShpbm9k
ZSkpCj4+PiArICAgICAgICAgICAgIHJldHVybiBWTV9GQVVMVF9TSUdCVVM7Cj4+Cj4+IFdpbGwg
d2Ugc3VmZmVyIHJhY2UgaXNzdWUgZHVlIHRvIHRoZSBjaGVjayB3L28gbG9jaz8KPj4KPj4gVGhh
bmtzLAo+IAo+IEhpIENoYW8sCj4gCj4gWWVzLCB0aGVyZSBpcyBhIHJhY2Ugd2l0aCBmMmZzX2lv
Y19zdGFydF9hdG9taWNfd3JpdGUoKS4KPiAKPiBwYWdlX21rd3JpdGUgY2Fubm90IHRha2UgaW5v
ZGVfbG9jaywgYmVjYXVzZSB0aGUgbG9jayBvcmRlciBpcyBpX3J3c2VtCj4gLT4gbW1hcF9sb2Nr
IChlLmcuIGZpZW1hcCBjb3BpZXMgdG8gdXNlciB1bmRlciBpbm9kZV9sb2NrKS4gU28gdjIgd2ls
bAo+IHVzZSBpbnZhbGlkYXRlX2xvY2sgaW5zdGVhZDoKPiAKPiBmMmZzX2lvY19zdGFydF9hdG9t
aWNfd3JpdGUoKSBob2xkcyBmaWxlbWFwX2ludmFsaWRhdGVfbG9jaygpIGZyb20gdGhlCj4gZmx1
c2ggdW50aWwgRklfQVRPTUlDX0ZJTEUgaXMgc2V0Lgo+IGYyZnNfdm1fcGFnZV9ta3dyaXRlKCkg
cmVjaGVja3MgdGhlIGZsYWcgYWZ0ZXIKPiBmaWxlbWFwX2ludmFsaWRhdGVfbG9ja19zaGFyZWQo
KSwgd2hpY2ggaXQgaG9sZHMgdW50aWwgdGhlIGZvbGlvIGlzCj4gZGlydGllZC4KPiAKPiBJZiB5
b3UgYXJlIG9rYXkgd2l0aCB0aGlzLCBJJ2xsIHNlbmQgdjIuCgpEYWVobywgbG9va3MgZmluZSB0
byBtZSwgcGxlYXNlIGdvIGFoZWFkLiA6KQoKVGhhbmtzLAoKPiAKPiBUaGFua3MsCj4gCj4+Cj4+
PiArCj4+PiAgICAgICBpZiAoaXNfaW5vZGVfZmxhZ19zZXQoaW5vZGUsIEZJX0NPTVBSRVNTX1JF
TEVBU0VEKSkgewo+Pj4gICAgICAgICAgICAgICBlcnIgPSAtRUlPOwo+Pj4gICAgICAgICAgICAg
ICBnb3RvIG91dDsKPj4+IEBAIC0yMTEzLDkgKzIxMTcsMTEgQEAgc3RhdGljIGxvbmcgZjJmc19m
YWxsb2NhdGUoc3RydWN0IGZpbGUgKmZpbGUsIGludCBtb2RlLAo+Pj4KPj4+ICAgICAgIC8qCj4+
PiAgICAgICAgKiBQaW5uZWQgZmlsZSBzaG91bGQgbm90IHN1cHBvcnQgcGFydGlhbCB0cnVuY2F0
aW9uIHNpbmNlIHRoZSBibG9jawo+Pj4gLSAgICAgICogY2FuIGJlIHVzZWQgYnkgYXBwbGljYXRp
b25zLgo+Pj4gKyAgICAgICogY2FuIGJlIHVzZWQgYnkgYXBwbGljYXRpb25zLiBBdG9taWMgZmls
ZXMgc2hvdWxkIG5vdCBlaXRoZXIsIHNpbmNlCj4+PiArICAgICAgKiB0aGVzZSBtb2RpZnkgdGhl
IG9yaWdpbmFsIGlub2RlIGRpcmVjdGx5IGFuZCBicmVhayBhdG9taWNpdHkuCj4+PiAgICAgICAg
Ki8KPj4+IC0gICAgIGlmICgoZjJmc19jb21wcmVzc2VkX2ZpbGUoaW5vZGUpIHx8IGYyZnNfaXNf
cGlubmVkX2ZpbGUoaW5vZGUpKSAmJgo+Pj4gKyAgICAgaWYgKChmMmZzX2NvbXByZXNzZWRfZmls
ZShpbm9kZSkgfHwgZjJmc19pc19waW5uZWRfZmlsZShpbm9kZSkgfHwKPj4+ICsgICAgICAgICAg
ZjJmc19pc19hdG9taWNfZmlsZShpbm9kZSkpICYmCj4+PiAgICAgICAgICAgICAgIChtb2RlICYg
KEZBTExPQ19GTF9QVU5DSF9IT0xFIHwgRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIHwKPj4+ICAg
ICAgICAgICAgICAgICAgICAgICBGQUxMT0NfRkxfWkVST19SQU5HRSB8IEZBTExPQ19GTF9JTlNF
UlRfUkFOR0UpKSkgewo+Pj4gICAgICAgICAgICAgICByZXQgPSAtRU9QTk9UU1VQUDsKPj4KCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
