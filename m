Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B798FED2FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhPHG8+sDcfAWJj4oUOMmrtwQ+hecE943lST3KjzGvA=; b=PxhB3LKfgHuKFkIhVoQNVDk4p4
	fbIHuNi2FN3MFi6RIaOs62Jq7XNxDXLMou6gKgozimyD8wUH4YwKE6Jvd8BdOhPbTk9JY+k09+M0h
	H3wOLkwgnBFLc+x/3Cg8MMnbI8B8FbmprXrSVi+9mD+xDfaAotO41SX91hgsybmk2avU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0dUb-0004Qi-IC;
	Thu, 12 Mar 2026 10:42:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w0dUa-0004Qa-EH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 10:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OhBU19yxwMk5sdtE2Ar6FI2MNjCzn7jU+R0RWkLQ38g=; b=Nx0enB6xExK12k4jvUBc6d32TD
 8Ij0FsyNn4ML5Ws8cECxWLNiRXiv3XXT+kRyByeGLtrQMDVN6w2lXPk1G3rEkMmxUPcMvduN7d9VJ
 SI7PIfCZSYqXqN4basOi4k2mqjyv+zXIROUrDb6aUQKmueYy26VDgK1HycL2iMUwA/dE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OhBU19yxwMk5sdtE2Ar6FI2MNjCzn7jU+R0RWkLQ38g=; b=Xs+pH8hyA7KleTqn4jQXiQEywi
 nU2Row+JB17ckcWwDZJWtDjTwjbDFQxmNYhVaynQW5lng1WSKQVF3yBcgdAtpcBVUeS98CTBHaVY+
 lBwb9sxdY331+xQ/wgEaNJy5WlVjVY+Ij3i3c5Rgd5r885e3KlNFl5Tet58rV/7k/z2Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w0dUZ-0006Xv-Uz for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Mar 2026 10:42:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CE7543EE5;
 Thu, 12 Mar 2026 10:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1ECC116C6;
 Thu, 12 Mar 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773312121;
 bh=FVC4nXLPw3YlQt6R6WthbAg6byUAm+B6gVgdJvAqIJ8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=EbIx6Lo2sQjMuz8t9Ftb1XDafN9exz6e1iKD15SrTAl0QtrWm6m42NgsVw2CRC0Si
 BKPZsqALlffhnj3rpKzex17n7EPcpmiqUc5YIHhSIj9saiqaBpiC4Va8PGBffODidc
 dUjEBklFZfai+3xWz4XGFVQG2EEBWbE4NMPqVQWULpzywmzsL28x4UcB0Ze4l+pU1S
 WWccuZXSgLyM8+BC4dnmw5apQvxND0NjxH2nKTOiBwC7QQQqR8HzEtXNpD9N9HU3XV
 Tv7IN1rxiw3z+d2Vt3DrNwcV3BrpytiM3s51WkWCXpyyUXHO8mZvMV1VwHNTBFUSYV
 jJS/TOH3RB+BA==
Message-ID: <9dc584cd-d2fb-4a85-b1d0-ded944064603@kernel.org>
Date: Thu, 12 Mar 2026 18:41:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260216112737.67408-1-monty_pavel@sina.com>
 <f331751b-08ad-42d2-ad23-37d21e1364f8@kernel.org>
 <c7bdf38f-4cf5-490b-8e0f-35f4574f4b81@sina.com>
Content-Language: en-US
In-Reply-To: <c7bdf38f-4cf5-490b-8e0f-35f4574f4b81@sina.com>
X-Headers-End: 1w0dUZ-0006Xv-Uz
Subject: Re: [f2fs-dev] [PATCH] f2fs: invalidate block device page cache on
 umount
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNi8zLzEyIDExOjU2LCBZb25ncGVuZyBZYW5nIHdyb3RlOgo+IAo+IE9uIDMvMTIvMjYg
MDg6NDksIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4+IE9uIDIwMjYvMi8x
NiAxOToyNywgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPj4+IEZyb206IFlvbmdwZW5nIFlhbmcgPHlh
bmd5b25ncGVuZ0B4aWFvbWkuY29tPgo+Pj4KPj4+IE5laXRoZXIgRjJGUyBub3IgVkZTIGludmFs
aWRhdGVzIHRoZSBibG9jayBkZXZpY2UgcGFnZSBjYWNoZSwgd2hpY2gKPj4+IHJlc3VsdHMgaW4g
cmVhZGluZyBzdGFsZSBtZXRhZGF0YS4gQW4gZXhhbXBsZSBzY2VuYXJpbyBpcyBzaG93biBiZWxv
dzoKPj4+Cj4+PiBUZXJtaW5hbCBBwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBU
ZXJtaW5hbCBCCj4+PiBtb3VudCAvZGV2L3ZkYiAvbW50L2YyZnMKPj4+IHRvdWNoIG14IC8vIGlu
byA9IDQKPj4+IHN5bmMKPj4+IGR1bXAuZjJmcyAtaSA0IC9kZXYvdmRiLy8gYmxvY2sgb24gIltZ
L05dIgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHRvdWNoIG14MiAvLyBpbm8gPSA1Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3luYwo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVtb3VudCAvbW50
L2YyZnMKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkdW1wLmYyZnMgLWkgNSAvZGV2L3ZkYiAvLyBibG9jayBhZGRyIGlzIDAKPj4+
Cj4+PiBBZnRlciB1bW91bnQsIHRoZSBibG9jayBkZXZpY2UgcGFnZSBjYWNoZSBpcyBub3QgcHVy
Z2VkLCBjYXVzaW5nCj4+PiBgZHVtcC5mMmZzIC1pIDUgL2Rldi92ZGJgIHRvIHJlYWQgc3RhbGUg
bWV0YWRhdGEgYW5kIHNlZSBpbm9kZSA1IHdpdGgKPj4+IGJsb2NrIGFkZHJlc3MgMC4KPj4+Cj4+
PiBUaGlzIHBhdGNoIGNhbGxzIGludmFsaWRhdGVfYmRldiBkdXJpbmcgdW1vdW50IHRvIGludmFs
aWRhdGUgdGhlIGJsb2NrCj4+PiBkZXZpY2UgcGFnZSBjYWNoZSwgcHJldmVudGluZyBzdGFsZSBt
ZXRhZGF0YSBmcm9tIGJlaW5nIHJlYWQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWW9uZ3Blbmcg
WWFuZyA8eWFuZ3lvbmdwZW5nQHhpYW9taS5jb20+Cj4+PiAtLS0KPj4+ICDCoCBmcy9mMmZzL3N1
cGVyLmMgfCA2ICsrKysrKwo+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5jIGIvZnMvZjJmcy9zdXBlci5jCj4+
PiBpbmRleCAxYTc1NTk5N2FmZjUuLjM5ZDNiNTJjZWFjMSAxMDA2NDQKPj4+IC0tLSBhL2ZzL2Yy
ZnMvc3VwZXIuYwo+Pj4gKysrIGIvZnMvZjJmcy9zdXBlci5jCj4+PiBAQCAtMjA5MSw2ICsyMDkx
LDEyIEBAIHN0YXRpYyB2b2lkIGYyZnNfcHV0X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Ip
Cj4+PiAgwqAgI2lmIElTX0VOQUJMRUQoQ09ORklHX1VOSUNPREUpCj4+PiAgwqDCoMKgwqDCoCB1
dGY4X3VubG9hZChzYi0+c19lbmNvZGluZyk7Cj4+PiAgwqAgI2VuZGlmCj4+PiArwqDCoMKgIHN5
bmNfYmxvY2tkZXYoc2ItPnNfYmRldik7Cj4+Cj4+IFdlIHdpbGwgY2FsbCBzeW5jX2Jsb2NrZGV2
IGluIGJlbG93IHBhdGg/Cj4+Cj4+IC0ga2lsbF9mMmZzX3N1cGVyCj4+ICDCoC0ga2lsbF9ibG9j
a19zdXBlcgo+PiAgwqAgLSBnZW5lcmljX3NodXRkb3duX3N1cGVyCj4+ICDCoMKgIC0gcHV0X3N1
cGVyCj4+ICDCoCAtIHN5bmNfYmxvY2tkZXYKPj4KPj4gMTcyMSB2b2lkIGtpbGxfYmxvY2tfc3Vw
ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKPj4gMTcyMiB7Cj4+IDE3MjPCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYgPSBzYi0+c19iZGV2Owo+PiAxNzI0Cj4+IDE3
MjXCoMKgwqDCoMKgwqDCoMKgIGdlbmVyaWNfc2h1dGRvd25fc3VwZXIoc2IpOwo+PiAxNzI2wqDC
oMKgwqDCoMKgwqDCoCBpZiAoYmRldikgewo+PiAxNzI3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3luY19ibG9ja2RldihiZGV2KTsKPj4gMTcyOMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJkZXZfZnB1dChzYi0+c19iZGV2X2ZpbGUpOwo+PiAxNzI5wqDCoMKgwqDC
oMKgwqDCoCB9Cj4+IDE3MzAgfQo+Pgo+Pj4gK8KgwqDCoCBpbnZhbGlkYXRlX2JkZXYoc2ItPnNf
YmRldik7Cj4gCj4gVGhpcyB3b3JrcyBmb3IgYW4gZjJmcyBpbnN0YW5jZSBtb3VudGVkIG9uIGEg
c2luZ2xlIGRldmljZSwgYnV0IGl0IGRvZXMKPiBub3Qgd29yayBmb3IgbXVsdGktZGV2aWNlIGNv
bmZpZ3VyYXRpb25zLCBiZWNhdXNlIHRoZSB2ZnMgY2Fubm90IGJlCj4gYXdhcmUgb2YgRkRFVigx
KS4KClllYWgsIEkgbWVhbnQgd2UgY2FuIGF2b2lkIGR1cGxpY2F0ZWQgc3luY19ibG9ja2Rldigp
IGZvciBtYWluIGRldmljZSBpbgpmMmZzX3B1dF9zdXBlcigpLgoKPiAKPj4KPj4gSSBndWVzcyB3
ZSBjYW4gbGVhdmUgdGhlIGRldmljZSB3LyB1cHRvZGF0ZSBjYWNoZSwgaW4gY2FzZSBpZiB0aGVy
ZSBhcmUKPj4gbXVsdGlwbGUgdXNlciBvbiB0aGUgZGV2aWNlPwo+IAo+IFRoZSBwYWdlIGNhY2hl
IG9mIHRoZSBibG9jayBkZXZpY2UgZmlsZSBtYXkgY29udGFpbiBkYXRhIHRoYXQgaXMgbm90Cj4g
dXB0b2RhdGUuIEZvciBleGFtcGxlLCBkYXRhIG1heSBmaXJzdCBiZSByZWFkIGRpcmVjdGx5IHRo
cm91Z2ggdGhlIGJsb2NrCiA+IGRldmljZSBmaWxlLCBhbmQgdGhlbiB0aGUgc2FtZSBibG9ja3Mg
bWF5IGJlIHdyaXR0ZW4gdGhyb3VnaCBmMmZzLiBTaW5jZT4gZjJmcyB3cml0ZXMgdG8gdGhlIGJs
b2NrIGRldmljZSB2aWEgdGhlIHN1Ym1pdF9iaW8gcGF0aCwgaXQgZG9lcyBub3QKPiB1cGRhdGUg
dGhlIHBhZ2UgY2FjaGUgb2YgdGhlIGJsb2NrIGRldmljZSBmaWxlLiBBcyBhIHJlc3VsdCwgdGhl
IGRhdGEgaW4KPiB0aGUgYmxvY2sgZGV2aWNlIGZpbGXigJlzIHBhZ2UgY2FjaGUgbWF5IGJlY29t
ZSBzdGFsZS4gVGhlcmVmb3JlLCB0aGUgcGFnZQo+IGNhY2hlIG11c3QgYmUgaW52YWxpZGF0ZWQg
ZHVyaW5nIHVubW91bnQuCgpXZWxsLCBjYW4gd2UgY2FsbCBpb2N0bChmZCwgQkxLRkxTQlVGKSBm
b3IgYWxsIGRldmljZXMgYmVsb25nIHRvIGYyZnMgaW1nIGxpa2UKeW91IGRpZCBpbiAoImYyZnMt
dG9vbHM6IGludmFsaWRhdGUgYmxvY2sgZGV2aWNlIHBhZ2UgY2FjaGUgYmVmb3JlIHJlYWRpbmcK
bWV0YWRhdGEiKSwgZG9lcyB0aGF0IGZpeCB0aGUgaXNzdWU/CgpUaGFua3MsCgo+IAo+IFRoYW5r
cwo+IFlvbmdwZW5nLAo+IAo+Pgo+PiBUaGFua3MsCj4+Cj4+PiArwqDCoMKgIGZvciAoaSA9IDE7
IGkgPCBzYmktPnNfbmRldnM7IGkrKykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHN5bmNfYmxvY2tk
ZXYoRkRFVihpKS5iZGV2KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpbnZhbGlkYXRlX2JkZXYoRkRF
VihpKS5iZGV2KTsKPj4+ICvCoMKgwqAgfQo+Pj4gIMKgIH0KPj4+ICDCoCDCoCBpbnQgZjJmc19z
eW5jX2ZzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGludCBzeW5jKQo+Pgo+Pgo+Pgo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdAo+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldAo+PiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
