Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AFCA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLr0z0t2dvWyy1LjsqGSZk9srk9cTdLZkoR9Cw57QPM=; b=k6MzH/tdYDLpzhxtOEcRlKxM2X
	ytzKUTOXme3QOzcWw38IWzeXjhurXWVyKPS2P7aPkqaUAtJTpWPUAFGJQ3vJYhfsv1xMMXuhOGAuJ
	+JkMtj26jNAn3OfCRbaG1lBI0saylzExeWd3NKjZCeKYHYeOPqDaBAL0q3SH6b50BY4w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCoe3-00069H-5S;
	Sat, 03 Oct 2026 01:34:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodw-00067n-PV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x7vMuR5AcU1jSWw2WHJu8galDlc8EMn6cPwWJMVwloQ=; b=bAtSMjqBVd808dBeYsTktQcDtd
 2mxL7WAy7gy9K1XSxI2cweVqc2YQA8QNqF7fvBtvn4dyIjnAgVQ/hbS7y9oCvR74CcEjMnsRY58hL
 wUU4PvmnDhDZKUB03xD+UwnElintAiHEunG0JRB5qe/L8dQvBP9ZaNXRvaDmVEYCNgc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x7vMuR5AcU1jSWw2WHJu8galDlc8EMn6cPwWJMVwloQ=; b=ZxR2qkhkp9vmUdExZ6MFmcrOEX
 BecKQz4Kh23mBInSUrtPRUzjCsi8aYqDkfM1sTQ2BYRFZbKoDCXHGydJgpwSDG3lTIeMeu78PCr7f
 eskrDGiTfT1wShPH5+4ial3owL7g4IqSTZVllAWs4+2Mz+nw87tqbvwXPXIhmCpW3gZw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodw-0001jx-HL for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F274460DAA;
 Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708321F00893;
 Sat,  3 Oct 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991262;
 bh=x7vMuR5AcU1jSWw2WHJu8galDlc8EMn6cPwWJMVwloQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TerrwNGhhOKb/DzepP3rjV7a+qOKU43MvTZX9Q+MjD+YoejT73hEehDCxvF/GJkUR
 X0Iy4Yl1GQ3dhAHKKxrH1Z/tY48bNoIU8l4nwCU9McJCFX7pMnkadvJH3sdgqALZ8Z
 YBUzxy45QG4KGDiP/F8inLxwaT7GsZX589XnwMHmQSwlL8LzN3ANYF2mU1xICl4ocL
 Jj4ZiZJWHUaJySuHLwCGSI10kXC2+XgsxHHV7O+4pAEeEFFgvmSTCqv1JfK0D8PW8d
 dGH3LmKSjaV/1OyJX9C9rzwDiR922GQB20Mq4tUSVszbISxeMdKmwL4iaITnhf2dCC
 jLrytqSumL4bg==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-16-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-16-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:22 +0000
Message-Id: <20261003013422.708321F00893@smtp.kernel.org>
X-Headers-End: 1xCodw-0001jx-HL
Subject: Re: [f2fs-dev] [PATCH v17 15/21] xfs: add fs-verity support
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
MyBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW0hpZ2hdIHhmczogQUItQkEgbG9j
ayBpbnZlcnNpb24gZGVhZGxvY2sgaW4geGZzX2ZzdmVyaXR5X2RlbGV0ZV9tZXRhZGF0YQotIFtI
aWdoXSB4ZnM6IGluY29uc2lzdGVudCBvbi1kaXNrIHN0YXRlIGFmdGVyIGZzLXZlcml0eSBlbmFi
bGVtZW50IG9wdGltaXphdGlvbiBmYWlsdXJlCi0gW01lZGl1bV0geGZzOiByZXNvdXJjZSBsZWFr
IHdoZW4gZnMtdmVyaXR5IGVuYWJsZW1lbnQgaXMgYWJvcnRlZAotLQoKY29tbWl0IGUyMTQwZjU0
NjgxMTViZmE2Y2Y0Yjc0ZjM2ZjUxZWUyNzgwZjFjMjMKQXV0aG9yOiBBbmRyZXkgQWxiZXJzaHRl
eW4gdmlhIExpbnV4LWYyZnMtZGV2ZWwgPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0PgoKeGZzOiBhZGQgZnMtdmVyaXR5IHN1cHBvcnQKClRoaXMgY29tbWl0IGFkZHMgaW50
ZWdyYXRpb24gd2l0aCBmcy12ZXJpdHkgZm9yIFhGUy4gSXQgaW50cm9kdWNlcyByZWFkaW5nCmFu
ZCB3cml0aW5nIHRoZSBNZXJrbGUgdHJlZSB0aHJvdWdoIHRoZSBpb21hcCBpbnRlcmZhY2UgYW5k
IHN0b3JlcyB0aGUKdmVyaXR5IGRlc2NyaXB0b3IgaW4gdGhlIGlub2RlIGRhdGEgZm9yayBwYXN0
IEVPRi4KCj4gZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfZnN2ZXJpdHkuYyBiL2ZzL3hmcy94ZnNf
ZnN2ZXJpdHkuYwo+IGluZGV4IDk3NmUwNTI1N2JmOTAuLjhjZmZjYWZjMTlhYTAgMTAwNjQ0Cj4g
LS0tIGEvZnMveGZzL3hmc19mc3Zlcml0eS5jCj4gKysrIGIvZnMveGZzL3hmc19mc3Zlcml0eS5j
CgpbIC4uLiBdCgo+ICtzdGF0aWMgaW50Cj4gK3hmc19mc3Zlcml0eV9kZWxldGVfbWV0YWRhdGEo
Cj4gKwlzdHJ1Y3QgeGZzX2lub2RlCSppcCkKPiArewo+ICsJc3RydWN0IHhmc190cmFucwkqdHA7
Cj4gKwlzdHJ1Y3QgeGZzX21vdW50CSptcCA9IGlwLT5pX21vdW50Owo+ICsJaW50CQkJZXJyb3I7
Cj4gKwo+ICsJeGZzX2lsb2NrKGlwLCBYRlNfTU1BUExPQ0tfRVhDTCk7Cj4gKwllcnJvciA9IHhm
c190cmFuc19hbGxvYyhtcCwgJk1fUkVTKG1wKS0+dHJfaXRydW5jYXRlLCAwLCAwLCAwLCAmdHAp
Owo+ICsJaWYgKGVycm9yKSB7Cj4gKwkJeGZzX2l1bmxvY2soaXAsIFhGU19NTUFQTE9DS19FWENM
KTsKPiArCQlyZXR1cm4gZXJyb3I7Cj4gKwl9Cj4gKwo+ICsJdHJ1bmNhdGVfaW5vZGVfcGFnZXMo
VkZTX0koaXApLT5pX21hcHBpbmcsIFhGU19JU0laRShpcCkpOwoKW1NldmVyaXR5OiBIaWdoXQpD
b3VsZCB0aGlzIGxvY2sgb3JkZXJpbmcgbGVhZCB0byBhbiBBQi1CQSBkZWFkbG9jaz8KCkluIFhG
UywgZm9saW8gbG9ja3MgbXVzdCBnZW5lcmFsbHkgYmUgYWNxdWlyZWQgYmVmb3JlIHRyYW5zYWN0
aW9uIGFsbG9jYXRpb24KdG8gcHJldmVudCBkZWFkbG9ja3Mgd2l0aCBtZW1vcnkgcmVjbGFpbSBv
ciB3cml0ZWJhY2sgdGhyZWFkcyB0aGF0IG1heSBob2xkCnRoZSBmb2xpbyBsb2NrIHdoaWxlIHdh
aXRpbmcgZm9yIHRyYW5zYWN0aW9uIGxvZyBzcGFjZS4KCkhlcmUsIHhmc190cmFuc19hbGxvYygp
IGlzIGNhbGxlZCBiZWZvcmUgdHJ1bmNhdGVfaW5vZGVfcGFnZXMoKSwgd2hpY2gKYWNxdWlyZXMg
dGhlIGZvbGlvIGxvY2tzLgoKWyAuLi4gXQoKPiArc3RhdGljIGludAo+ICt4ZnNfZnN2ZXJpdHlf
ZW5kX2VuYWJsZSgKPiArCXN0cnVjdCBmaWxlCQkqZmlsZSwKPiArCWNvbnN0IHZvaWQJCSpkZXNj
LAo+ICsJc2l6ZV90CQkJZGVzY19zaXplLAo+ICsJdTY0CQkJbWVya2xlX3RyZWVfc2l6ZSkKPiAr
ewo+ICsJc3RydWN0IGlub2RlCQkqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOwo+ICsJc3RydWN0
IHhmc19pbm9kZQkqaXAgPSBYRlNfSShpbm9kZSk7Cj4gKwlzdHJ1Y3QgeGZzX21vdW50CSptcCA9
IGlwLT5pX21vdW50Owo+ICsJc3RydWN0IHhmc190cmFucwkqdHA7Cj4gKwlpbnQJCQllcnJvciA9
IDA7Cj4gKwlsb2ZmX3QJCQlyYW5nZV9zdGFydCA9IHhmc19mc3Zlcml0eV9tZXRhZGF0YV9vZmZz
ZXQoaXApOwo+ICsKPiArCXhmc19hc3NlcnRfaWxvY2tlZChpcCwgWEZTX0lPTE9DS19FWENMKTsK
PiArCj4gKwkvKiBmcy12ZXJpdHkgZmFpbGVkLCBqdXN0IGNsZWFudXAgKi8KPiArCWlmIChkZXNj
ID09IE5VTEwpCj4gKwkJZ290byBvdXQ7CgpbU2V2ZXJpdHk6IE1lZGl1bV0KRG9lcyB0aGlzIGFi
b3J0IHBhdGggbGVhayBibG9ja3MgYWxsb2NhdGVkIGZvciB0aGUgTWVya2xlIHRyZWUgcGFzdCBF
T0Y/CgpXaGVuIHRoZSBjb3JlIGNhbGxzIHhmc19mc3Zlcml0eV9lbmRfZW5hYmxlKCkgd2l0aCBk
ZXNjID09IE5VTEwgdG8gc2lnbmFsCmFuIGFib3J0LCB0aGlzIGNvZGUganVtcHMgdG8gdGhlIG91
dCBsYWJlbC4KCkJlY2F1c2UgZXJyb3IgaXMgaW5pdGlhbGl6ZWQgdG8gMCBhbmQgbm90IHVwZGF0
ZWQgaGVyZSwgdGhlIGNsZWFudXAgYmxvY2sKYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gKHdo
aWNoIGNoZWNrcyBpZiBlcnJvciBpcyBub24temVybykgaXMgc2tpcHBlZC4KClsgLi4uIF0KCj4g
KwkvKgo+ICsJICogRW5zdXJlIHRoYXQgd2UndmUgcGVyc2lzdGVkIHRoZSB2ZXJpdHkgaW5mb3Jt
YXRpb24gYmVmb3JlIHdlIGVuYWJsZQo+ICsJICogaXQgb24gdGhlIGlub2RlIGFuZCB0ZWxsIHRo
ZSBjYWxsZXIgd2UgaGF2ZSBzZWFsZWQgdGhlIGlub2RlLgo+ICsJICovCj4gKwlpcC0+aV9kaWZs
YWdzMiB8PSBYRlNfRElGTEFHMl9WRVJJVFk7Cj4gKwo+ICsJeGZzX3RyYW5zX2xvZ19pbm9kZSh0
cCwgaXAsIFhGU19JTE9HX0NPUkUpOwo+ICsJeGZzX3RyYW5zX3NldF9zeW5jKHRwKTsKPiArCj4g
KwllcnJvciA9IHhmc190cmFuc19jb21taXQodHApOwo+ICsJeGZzX2l1bmxvY2soaXAsIFhGU19J
TE9DS19FWENMKTsKPiArCWlmIChlcnJvcikKPiArCQlnb3RvIG91dDsKPiArCj4gKwlpbm9kZV9z
ZXRfZmxhZ3MoaW5vZGUsIFNfVkVSSVRZLCBTX1ZFUklUWSk7Cj4gKwo+ICsJLyoKPiArCSAqIFBy
b2FjdGl2ZWx5IHJlbW92ZSB1bndyaXR0ZW4gZXh0ZW50cyBsZWZ0IGJ5IENPVyBwcmVhbGxvY2F0
aW9ucyBhbmQKPiArCSAqIHdyaXRlIHByZWFsbG9jYXRpb24gaW4gdGhlIG1lcmtsZSB0cmVlIGhv
bGVzIGFuZCBwYXN0IGRlc2NyaXB0b3IsCj4gKwkgKiBhbmQgYW55IGRlbGF5ZWQgcHJlYWxsb2Nh
dGlvbnMKPiArCSAqLwo+ICsJZXJyb3IgPSB4ZnNfZnJlZV9lb2ZibG9ja3MoaXApOwo+ICtvdXQ6
Cj4gKwlpZiAoZXJyb3IpIHsKPiArCQlpbnQJZXJyb3IyOwo+ICsKPiArCQllcnJvcjIgPSB4ZnNf
ZnN2ZXJpdHlfcmVzZXRfaW5vZGUoaXApOwoKW1NldmVyaXR5OiBIaWdoXQpDYW4gdGhpcyBzZXF1
ZW5jZSByZXN1bHQgaW4gYW4gaW5jb25zaXN0ZW50IG9uLWRpc2sgc3RhdGU/CgpJZiB4ZnNfZnJl
ZV9lb2ZibG9ja3MoKSBmYWlscywgdGhlIFhGU19ESUZMQUcyX1ZFUklUWSBmbGFnIGhhcyBhbHJl
YWR5CmJlZW4gY29tbWl0dGVkIHRvIGRpc2sgaW4gdGhlIHByZXZpb3VzIHRyYW5zYWN0aW9uLiBU
aGUgY29kZSB0aGVuIGNhbGxzCnhmc19mc3Zlcml0eV9yZXNldF9pbm9kZSgpIHRvIHJldmVydCB0
aGUgZW5hYmxlbWVudCBpbiBhIG5ldyB0cmFuc2FjdGlvbi4KCklmIGEgc3lzdGVtIGNyYXNoIG9j
Y3VycyBiZXR3ZWVuIHRoZSB0d28gdHJhbnNhY3Rpb25zLCBvciBpZiBhbGxvY2F0aW5nCnRoZSBz
ZWNvbmQgdHJhbnNhY3Rpb24gZmFpbHMsIHRoZSBmaWxlIGNvdWxkIGJlIGxlZnQgcGVybWFuZW50
bHkgc2VhbGVkCm9uIGRpc2ssIGJ1dCB1bnNlYWxlZCBpbiBtZW1vcnkuCgotLSAKU2FzaGlrbyBB
SSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDAyMjIzNzA1
LjIxNzU1NDItMS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9MTUKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
