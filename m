Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA2C88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QZefsERTaftsrIRXChMeWCqoC5BfnooiZi+TnMNS+I=; b=Y6R6M8Rejdu0R0o+AxSPFY7rqD
	psS8DWevItlKbfet75nzdpokRd7XoneE8eaFPom5f9yU3FZt/S2i2ycBVx6H2hr41AQdBjXuMQMxz
	4ZgAef2bvqWTkpUejXWG42/nZ5/Ljyca+KLFuSAm2DcjtplW+0ihDR/DYLw4l+DitgMw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6Ili-0004jp-2f;
	Tue, 15 Sep 2026 02:19:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6IlO-0004jQ-Fc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wsJFM5lGSqVqpj1Wvq3qwMzbcNrTLZ77Ch6iAAxQYx0=; b=kAIWU7hzJrcxQY+31W8ubu+bkP
 BmaMWJJh4zEtwV8l/nOLWD+e8GHZOlmVW1vRwUxYx6AoPFbgbiYJvw/4a9IBIqeknKThlTcw9vVQ2
 HJwNjkW5j1Mx0u4AzCy8fPbD28o+P005ndvMmxSFIXatqJthwxhnvqzodrZKdK2qxf2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wsJFM5lGSqVqpj1Wvq3qwMzbcNrTLZ77Ch6iAAxQYx0=; b=dkWKC5c3afV60yVGuCV0AQKmKv
 QEz13jv1RIkZN6riTd7dFAPPyBfQt3Kv5DWel5IqTj8uLn/fa+H2NKpi/bZQoXL/ErLbqKeI67sxc
 JPnTj62bVUwJixpEP06EGk+UJEcOwdU9t7pRTcD6iD7Rlr2/i7PXJXdbQUW9g8IR1G1k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6IlK-0002MS-Gj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:19:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDA6840767;
 Tue, 15 Sep 2026 02:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30501F000FF;
 Tue, 15 Sep 2026 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789438744;
 bh=wsJFM5lGSqVqpj1Wvq3qwMzbcNrTLZ77Ch6iAAxQYx0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=mjmRrfykLaJqFWHGfmyF3bNk0Jt+l4DbdShBkEmeHjO09IJigf0Zq3GrUJIrdMVbt
 C2CJgPYSsry9LQ05Ezyd0yqAaOUYFqeL2cKMks6WXkc96cBV4jLjfOZ1uhdCFKuH7B
 xxkwsFQEk/cKywCygQAUxo6eQBijx49c/BquP2hDPt1OEbP0acvaq5ouISNdcepqK+
 eMbNwDnPSpjoPMWYnNZytHHE89prgXX/Fe2vLQNcByfZ1tX5jRV+DAAXEIsUCv/2id
 3x5TJa7Xp3JGW2hCRiedTRV+0kG4jHTnrhwXLdhU6eVsBOVmfBzx00953SWLE6A/ox
 h/val+8IW84sw==
Message-ID: <c79a8f13-7ef4-425a-a046-831b024f7a76@kernel.org>
Date: Tue, 15 Sep 2026 10:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260911232405.1815804-1-chao@kernel.org>
 <20260911232405.1815804-3-chao@kernel.org>
 <CAHJ8P3JSW+y4PK+Zb6HvpnDgYt7uPko5kOVsbn3zRPefd5o98Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3JSW+y4PK+Zb6HvpnDgYt7uPko5kOVsbn3zRPefd5o98Q@mail.gmail.com>
X-Headers-End: 1x6IlK-0002MS-Gj
Subject: Re: [f2fs-dev] [PATCH v7 02/12] f2fs: cache: initialize meta cache
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

T24gOS8xNC8yNiAxNzoyMSwgWmhpZ3VvIE5pdSB3cm90ZToKPiBDaGFvIFl1IHZpYSBMaW51eC1m
MmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiDkuo4y
MDI25bm0OeaciDEy5pel5ZGo5YWtIDA3OjI45YaZ6YGT77yaCj4+Cj4+IEZyb206IENoYW8gWXUg
PGNoYW9Aa2VybmVsLm9yZz4KPj4KPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIG1ldGFfYmxvY2tz
IGluIGYyZnNfc2JfaW5mbyBzdHJ1Y3R1cmUsIGluaXRpYWxpemVzCj4+IGFuZCBkZXN0cm95cyB0
aGUgbWV0YSBjYWNoZSBkdXJpbmcgZmlsZXN5c3RlbSBtb3VudCBhbmQgdW5tb3VudC4KPj4KPj4g
SXQgYWxzbyBpbnRyb2R1Y2VzIGhlbHBlciB3cmFwcGVycyBmb3IgbWV0YSBjYWNoZSBvcGVyYXRp
b24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPj4gLS0t
Cj4+ICAgZnMvZjJmcy9jYWNoZS5oIHwgMTIgKysrKysrKysrKysrCj4+ICAgZnMvZjJmcy9kYXRh
LmMgIHwgIDMgKysrCj4+ICAgZnMvZjJmcy9mMmZzLmggIHwgIDMgKysrCj4+ICAgZnMvZjJmcy9z
dXBlci5jIHwgMTAgKysrKysrKysrLQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9jYWNoZS5oIGIv
ZnMvZjJmcy9jYWNoZS5oCj4+IGluZGV4IDcyZGJmMjZhYjI2ZS4uZDVlZTUxNjkxZmFjIDEwMDY0
NAo+PiAtLS0gYS9mcy9mMmZzL2NhY2hlLmgKPj4gKysrIGIvZnMvZjJmcy9jYWNoZS5oCj4+IEBA
IC0xOTQsNCArMTk0LDE2IEBAIHZvaWQgZjJmc190cnVuY2F0ZV9jYWNoZShzdHJ1Y3QgZjJmc19j
YWNoZWRfYmxvY2sgKmVudHJ5LCBib29sIGRyb3BfZGlydHkpOwo+PiAgIHZvaWQgZjJmc19kcm9w
X2NhY2hlX3JhbmdlKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9ja19saXN0ICpjYWNoZSwKPj4gICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGxlbiwgYm9v
bCBkcm9wX2RpcnR5KTsKPj4KPj4gK2ludCBmMmZzX3N0YXJ0X2NhY2hlX3diX3RocmVhZChzdHJ1
Y3QgZjJmc19zYl9pbmZvICpzYmkpOwo+PiArdm9pZCBmMmZzX3N0b3BfY2FjaGVfd2JfdGhyZWFk
KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSk7Cj4+ICsKPj4gKyNkZWZpbmUgTUVUQV9DQUNIRShz
YmkpICAgICAgICAgICAgICAgICgmKHNiaSktPm1ldGFfYmxvY2tzKQo+PiArCj4+ICsjZGVmaW5l
IGYyZnNfZmluZF9tZXRhX2NhY2hlKHNiaSwgYmxrYWRkcikgICAgICAgICAgICAgXAo+PiArICAg
ICAgIGYyZnNfZmluZF9jYWNoZShNRVRBX0NBQ0hFKHNiaSksIGJsa2FkZHIpCj4+ICsjZGVmaW5l
IGYyZnNfaW52YWxpZGF0ZV9tZXRhX2NhY2hlcyhzYmksIHN0YXJ0LCBsZW4pICAgXAo+PiArICAg
ICAgIGYyZnNfZHJvcF9jYWNoZV9yYW5nZShNRVRBX0NBQ0hFKHNiaSksIHN0YXJ0LCBsZW4sIGZh
bHNlKQo+PiArI2RlZmluZSBmMmZzX3RydW5jYXRlX21ldGFfY2FjaGVzKHNiaSwgc3RhcnQsIGxl
bikgICAgIFwKPj4gKyAgICAgICBmMmZzX2Ryb3BfY2FjaGVfcmFuZ2UoTUVUQV9DQUNIRShzYmkp
LCBzdGFydCwgbGVuLCB0cnVlKQo+PiArCj4+ICAgI2VuZGlmIC8qIF9MSU5VWF9GMkZTX0NBQ0hF
X0ggKi8KPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPj4g
aW5kZXggZDg2OGI5MzljYWVlLi41OWZlZjIxMzIxNzcgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMv
ZGF0YS5jCj4+ICsrKyBiL2ZzL2YyZnMvZGF0YS5jCj4+IEBAIC02NzAsNiArNjcwLDkgQEAgc3Rh
dGljIGJvb2wgX19oYXNfbWVyZ2VkX3BhZ2Uoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1
Y3QgYmlvICpiaW8sCj4+ICAgICAgICAgIGlmICghaW5vZGUgJiYgIWZvbGlvICYmICFpbm8pCj4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4+Cj4+ICsgICAgICAgaWYgKGYyZnNfaXNf
Y2FjaGVfYmlvKGJpbykpCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+ICsKPj4g
ICAgICAgICAgYmlvX2Zvcl9lYWNoX2ZvbGlvX2FsbChmaSwgYmlvKSB7Cj4+ICAgICAgICAgICAg
ICAgICAgc3RydWN0IGZvbGlvICp0YXJnZXQgPSBmaS5mb2xpbzsKPj4KPj4gZGlmZiAtLWdpdCBh
L2ZzL2YyZnMvZjJmcy5oIGIvZnMvZjJmcy9mMmZzLmgKPj4gaW5kZXggYzBjN2Q1MWM4MzBmLi44
NWM0YmY0MGI0YWEgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMvZjJmcy5oCj4+ICsrKyBiL2ZzL2Yy
ZnMvZjJmcy5oCj4+IEBAIC0yMTA3LDYgKzIxMDcsOSBAQCBzdHJ1Y3QgZjJmc19zYl9pbmZvIHsK
Pj4gICAjaWZkZWYgQ09ORklHX0RFQlVHX0xPQ0tfQUxMT0MKPj4gICAgICAgICAgc3RydWN0IGxv
Y2tfY2xhc3Nfa2V5IGNwX2dsb2JhbF9zZW1fa2V5Owo+PiAgICNlbmRpZgo+PiArCj4+ICsgICAg
ICAgLyogZjJmcyBpbnRlcm5hbCBjYWNoZSAqLwo+PiArICAgICAgIHN0cnVjdCBmMmZzX2NhY2hl
ZF9ibG9ja19saXN0IG1ldGFfYmxvY2tzOwo+PiAgIH07Cj4+Cj4+ICAgLyogRGVmaW5pdGlvbnMg
dG8gYWNjZXNzIGYyZnNfc2JfaW5mbyAqLwo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5j
IGIvZnMvZjJmcy9zdXBlci5jCj4+IGluZGV4IDZhMmYwOWM2MWRjZC4uYjczMWI5YmI3YjU0IDEw
MDY0NAo+PiAtLS0gYS9mcy9mMmZzL3N1cGVyLmMKPj4gKysrIGIvZnMvZjJmcy9zdXBlci5jCj4+
IEBAIC0yMDk0LDYgKzIwOTQsOCBAQCBzdGF0aWMgdm9pZCBmMmZzX3B1dF9zdXBlcihzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiKQo+PiAgICAgICAgICBpcHV0KHNiaS0+bWV0YV9pbm9kZSk7Cj4+ICAg
ICAgICAgIHNiaS0+bWV0YV9pbm9kZSA9IE5VTEw7Cj4+Cj4+ICsgICAgICAgZjJmc19kZXN0cm95
X2NhY2hlKE1FVEFfQ0FDSEUoc2JpKSk7Cj4+ICsKPj4gICAgICAgICAgLyogU2hvdWxkIGNoZWNr
IHRoZSBwYWdlIGNvdW50cyBhZnRlciBkcm9wcGluZyBhbGwgbm9kZS9tZXRhIHBhZ2VzICovCj4+
ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBOUl9DT1VOVF9UWVBFOyBpKyspIHsKPj4gICAgICAg
ICAgICAgICAgICBpZiAoIWdldF9wYWdlcyhzYmksIGkpKQo+PiBAQCAtNTI2MywxMiArNTI2NSwx
NiBAQCBzdGF0aWMgaW50IGYyZnNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZnNfY29udGV4dCAqZmMpCj4+ICAgICAgICAgIGlmIChlcnIpCj4+ICAgICAgICAgICAg
ICAgICAgZ290byBmcmVlX3BlcmNwdTsKPj4KPj4gKyAgICAgICBlcnIgPSBmMmZzX2luaXRfY2Fj
aGUoc2JpLCBNRVRBX0NBQ0hFKHNiaSksIEYyRlNfTUVUQV9DQUNIRSk7Cj4gbmV2ZXIgZmFpbCBu
b3c/CgpZZXMsIHdpbGwgY2xlYW4gdXAuCgpUaGFua3MsCgo+PiArICAgICAgIGlmIChlcnIpCj4+
ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfcGFnZV9hcnJheV9jYWNoZTsKPj4gKwo+PiAgICAg
ICAgICAvKiBnZXQgYW4gaW5vZGUgZm9yIG1ldGEgc3BhY2UgKi8KPj4gICAgICAgICAgc2JpLT5t
ZXRhX2lub2RlID0gZjJmc19pZ2V0KHNiLCBGMkZTX01FVEFfSU5PKHNiaSkpOwo+PiAgICAgICAg
ICBpZiAoSVNfRVJSKHNiaS0+bWV0YV9pbm9kZSkpIHsKPj4gICAgICAgICAgICAgICAgICBmMmZz
X2VycihzYmksICJGYWlsZWQgdG8gcmVhZCBGMkZTIG1ldGEgZGF0YSBpbm9kZSIpOwo+PiAgICAg
ICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIoc2JpLT5tZXRhX2lub2RlKTsKPj4gLSAgICAgICAg
ICAgICAgIGdvdG8gZnJlZV9wYWdlX2FycmF5X2NhY2hlOwo+PiArICAgICAgICAgICAgICAgZ290
byBmcmVlX21ldGFfY2FjaGU7Cj4+ICAgICAgICAgIH0KPj4KPj4gICAgICAgICAgZXJyID0gZjJm
c19nZXRfdmFsaWRfY2hlY2twb2ludChzYmkpOwo+PiBAQCAtNTU5Niw2ICs1NjAyLDggQEAgc3Rh
dGljIGludCBmMmZzX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZz
X2NvbnRleHQgKmZjKQo+PiAgICAgICAgICBtYWtlX2JhZF9pbm9kZShzYmktPm1ldGFfaW5vZGUp
Owo+PiAgICAgICAgICBpcHV0KHNiaS0+bWV0YV9pbm9kZSk7Cj4+ICAgICAgICAgIHNiaS0+bWV0
YV9pbm9kZSA9IE5VTEw7Cj4+ICtmcmVlX21ldGFfY2FjaGU6Cj4+ICsgICAgICAgZjJmc19kZXN0
cm95X2NhY2hlKE1FVEFfQ0FDSEUoc2JpKSk7Cj4+ICAgZnJlZV9wYWdlX2FycmF5X2NhY2hlOgo+
PiAgICAgICAgICBmMmZzX2Rlc3Ryb3lfcGFnZV9hcnJheV9jYWNoZShzYmkpOwo+PiAgIGZyZWVf
cGVyY3B1Ogo+PiAtLQo+PiAyLjQ5LjAKPj4KPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKPj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4gaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
