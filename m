Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E276CA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B869V9k+l0eupLbux7k70vJ4GLSxetnL9wC4uTKvIx4=; b=MLewguFIr4tkcvaAMRhuGOIl57
	2HwLQbPFSqs4JvIWo95+4GaKZmzpAcYQZ8BTGEqAIbsnEnJ07OyL3FV0vj9vajbL45LZ7CaleCSOy
	/rw2pqth863M6HYzBsDJrtn46CH6kXYQOkEz+gqvyzYk4BRUTCbFQXQeRZd3y1BOLJxA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCody-0007B2-A5;
	Sat, 03 Oct 2026 01:34:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodx-0007AY-A2
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iAc2SJPMx1kpAYE7t6Ztsj/T6PG+UB1BAqXGjjzUQiA=; b=OTeTdn2SivgDSWCuJ/Cu6eWLJU
 Ai4y0ehoWWZUCB708i6J6Q+f43r6aXA/21HU5nI/dwi+sfTF5CQmG9imd2t3lPdhP/WMjNfq6Ea7X
 9LoIzKTCPK729FG6e8RP6MhCh4/sQxY8hWHX7U/uBmGcXqUV9NyPknOZALYLc934IQ74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iAc2SJPMx1kpAYE7t6Ztsj/T6PG+UB1BAqXGjjzUQiA=; b=N7KkwyXSPIJyu96WnB7Ztkshkf
 MXkTT7d8WVZOqpFd3G3yAIsM4h6S/AzP80o4JfcwjqoUHiJX1GRn8HjG3volWFlRX/l68uh0ecPBT
 FL442l9dGN+ggRzzx4KHuQVDUdT7Ht+yOn2kll35gRyBFkDmZhwvFf38DjYYyVa38Rg8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodx-00071d-8s for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B433560DAB;
 Sat,  3 Oct 2026 01:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4E1F00899;
 Sat,  3 Oct 2026 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991263;
 bh=iAc2SJPMx1kpAYE7t6Ztsj/T6PG+UB1BAqXGjjzUQiA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZJA/EodFPHV96PyxnGvMoT0+G0GL8MCdeDz74QiGlgPH5u+ySh7qAJPGrTz7/W6zI
 h2LTA6NnN+KtutkD6OYry5tqOHFje16kC//D908PKPPjyAve+a9ljF2CueGUozX4pG
 dIOq/QIasq6GDZaRsxzqoZ+F2bPdRBs+I5b3DBFUj//vJbMuPMz5StTI48yBO0vkvb
 TGMhibjM2pu71/O9vpWkKuwe9oKHIgcM7u6vLQFVAlAIUaDqkS+dMB27JRSnFAGX2F
 F+BCUFf9N5X53sWBsiMXQ3vZxHlYswrxeU0Q7fcvORb7Ai3NFpMxkuV7CkJojqub4E
 GajwD2iwSPuOA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-13-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-13-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:22 +0000
Message-Id: <20261003013423.33F4E1F00899@smtp.kernel.org>
X-Headers-End: 1xCodx-00071d-8s
Subject: Re: [f2fs-dev] [PATCH v17 12/21] xfs: use read ioend for fsverity
 data verification
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
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW0hpZ2hdIHhmczogZGVhZGxvY2sg
aW4gcGVyLUNQVSBiaW8gY29tcGxldGlvbiBkdWUgdG8gbWVtcG9vbF9hbGxvYygpIHdpdGggR0ZQ
X05PRlMKLS0KCmNvbW1pdCBlYTFhMGIyMDIzYmYwNGI1NTZlMGY5ZDc5OGViOGQ2NzNmMGU3MmNh
CkF1dGhvcjogQW5kcmV5IEFsYmVyc2h0ZXluIHZpYSBMaW51eC1mMmZzLWRldmVsIDxsaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KCnhmczogdXNlIHJlYWQgaW9lbmQgZm9y
IGZzdmVyaXR5IGRhdGEgdmVyaWZpY2F0aW9uCgpUaGlzIGNvbW1pdCB1c2VzIHJlYWQgaW9lbmRz
IGZvciBmc3Zlcml0eSB2ZXJpZmljYXRpb24sIG1vdmluZyBmc3Zlcml0eQptZXRhZGF0YSBJL08g
dG8gYSBzZXBhcmF0ZSB3b3JrcXVldWUgdG8gYXZvaWQgZGVhZGxvY2tzLiBJdCBwYXNzZXMKZnN2
ZXJpdHlfaW5mbyBmcm9tIHRoZSBpb21hcCBjb250ZXh0IGRvd24gdG8gdGhlIGlvZW5kIGFuZCBh
ZGRzIGEgaGVscGVyIHRvCmNoZWNrIGZvciBmaWxlIGRhdGEuCgo+IGRpZmYgLS1naXQgYS9mcy94
ZnMveGZzX2FvcHMuYyBiL2ZzL3hmcy94ZnNfYW9wcy5jCj4gaW5kZXggMTk2NDBlNGUzZWQxMi4u
YTM2Zjg0MDg4NGI0OSAxMDA2NDQKPiAtLS0gYS9mcy94ZnMveGZzX2FvcHMuYwo+ICsrKyBiL2Zz
L3hmcy94ZnNfYW9wcy5jClsgLi4uIF0KPiBAQCAtNjIzLDExICs2MjQsMTMgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpb21hcF9yZWFkX29wcyB4ZnNfaW9tYXBfcmVhZF9vcHMgPSB7Cj4gIAo+ICBz
dGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBpb21hcF9yZWFkX29wcyAqCj4gIHhmc19nZXRfaW9t
YXBfcmVhZF9vcHMoCj4gLQljb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZQkqbWFwcGluZykKPiAr
CWNvbnN0IHN0cnVjdCBhZGRyZXNzX3NwYWNlCSptYXBwaW5nLAo+ICsJbG9mZl90CQkJCXBvcykK
PiAgewo+ICAJc3RydWN0IHhmc19pbm9kZQkJKmlwID0gWEZTX0kobWFwcGluZy0+aG9zdCk7Cj4g
IAo+IC0JaWYgKGJkZXZfaGFzX2ludGVncml0eV9jc3VtKHhmc19pbm9kZV9idWZ0YXJnKGlwKS0+
YnRfYmRldikpCj4gKwlpZiAoYmRldl9oYXNfaW50ZWdyaXR5X2NzdW0oeGZzX2lub2RlX2J1ZnRh
cmcoaXApLT5idF9iZGV2KSB8fAo+ICsJICAgIHhmc19mc3Zlcml0eV9pc19maWxlX2RhdGEoaXAs
IHBvcykpCj4gIAkJcmV0dXJuICZ4ZnNfaW9tYXBfcmVhZF9vcHM7CgpbU2V2ZXJpdHk6IEhpZ2hd
CkRvZXMgdGhpcyBsb2dpYyByb3V0ZSBmc3Zlcml0eSBtZXRhZGF0YSByZWFkcyB0aHJvdWdoIHhm
c19pb21hcF9yZWFkX29wcyBpZgp0aGUgYmxvY2sgZGV2aWNlIGhhcyBpbnRlZ3JpdHkgY2hlY2tz
dW1zPyAKClVzaW5nIHhmc19pb21hcF9yZWFkX29wcyBjYXVzZXMgeGZzX2Jpb19zdWJtaXRfcmVh
ZCgpIHRvIGNhbGwKeGZzX2lvZW5kX3N1Ym1pdF9yZWFkKCksIHdoaWNoIHNldHMgQklPX0NPTVBM
RVRFX0lOX1RBU0sgb24gdGhlIGJpby4gVGhpcwptZWFucyB0aGUgY29tcGxldGlvbnMgZm9yIHRo
ZXNlIG1ldGFkYXRhIHJlYWRzIHdpbGwgYmUgcXVldWVkIHRvIHRoZSBwZXItQ1BVCmJpbyBjb21w
bGV0aW9uIHdvcmtlci4KCj4gIAlyZXR1cm4gJmlvbWFwX2Jpb19yZWFkX29wczsKPiAgfQoKWyAu
Li4gXQo+IGRpZmYgLS1naXQgYS9mcy94ZnMveGZzX2lvZW5kLmMgYi9mcy94ZnMveGZzX2lvZW5k
LmMKPiBpbmRleCBlNzBiZTViODZmMGI3Li5mNGMxYmJjMDM3MTRmIDEwMDY0NAo+IC0tLSBhL2Zz
L3hmcy94ZnNfaW9lbmQuYwo+ICsrKyBiL2ZzL3hmcy94ZnNfaW9lbmQuYwpbIC4uLiBdCj4gQEAg
LTExNyw2ICsxMzgsMjQgQEAgeGZzX2VuZF9pb19yZWFkKAo+ICAJCX0KPiAgCX0KPiAgCj4gKwkv
Kgo+ICsJICogSWYgd2UgaGF2ZSBmc3Zlcml0eSBvbiB0aGlzIGJpbywgd2UgbmVlZCB0byBydW4g
ZnN2ZXJpdHkgdmVyaWZpY2F0aW9uCj4gKwkgKiBvZiBkYXRhIGZvbGlvcyBmcm9tIGEgc2VwYXJh
dGUgZnN2ZXJpdHkgd29ya3F1ZXVlLiBUaGlzIGlzIG5lY2Vzc2FyeQo+ICsJICogdG8gYXZvaWQg
ZGVhZGxvY2tpbmcgZHVlIHRvIGZzdmVyaXR5IGlzc3VpbmcgbW9yZSByZWFkcyBvZiBmc3Zlcml0
eQo+ICsJICogbWV0YWRhdGEgd2hpY2ggd291bGQgYmUgcHJvY2Vzc2VkIGJ5IHRoZSBzYW1lIHdv
cmtlciBpbiB0aGUgQklPCj4gKwkgKiBjb21wbGV0aW9uIHdvcmtxdWV1ZS4KPiArCSAqLwo+ICsJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX0ZTX1ZFUklUWSkgJiYgIWVycm9yICYmIGlvZW5kLT5pb192
aSAmJgo+ICsJCQl4ZnNfZnN2ZXJpdHlfaXNfZmlsZV9kYXRhKGlwLCBpb2VuZC0+aW9fb2Zmc2V0
KSkgewo+ICsJCWZzdl9pb2VuZCA9IG1lbXBvb2xfYWxsb2MoJnhmc19mc3Zlcml0eV9pb2VuZF9w
b29sLAo+ICsJCQkJR0ZQX05PRlMpOwoKW1NldmVyaXR5OiBIaWdoXQpDYW4gdGhpcyByZXN1bHQg
aW4gYW4gQUJCQSBkZWFkbG9jayB1bmRlciBtZW1vcnkgcHJlc3N1cmU/CgpJZiB0aGUgbWVtb3J5
IHBvb2wgaXMgZW1wdHksIG1lbXBvb2xfYWxsb2MoKSB3aXRoIEdGUF9OT0ZTIHdpbGwgc2xlZXAg
YW5kCmJsb2NrIHRoZSBwZXItQ1BVIGJpbyBjb21wbGV0aW9uIHdvcmtlciBpbiB4ZnNfZW5kX2lv
X3JlYWQoKS4KCkFzIG5vdGVkIGluIHhmc19nZXRfaW9tYXBfcmVhZF9vcHMoKSBhYm92ZSwgaWYg
dGhlIGJsb2NrIGRldmljZSBoYXMgaW50ZWdyaXR5CmNoZWNrc3VtcyBlbmFibGVkLCBmc3Zlcml0
eSBtZXRhZGF0YSByZWFkcyB3aWxsIHVzZSB4ZnNfaW9tYXBfcmVhZF9vcHMKYW5kIHRoZWlyIGNv
bXBsZXRpb25zIHdpbGwgYWxzbyBiZSBxdWV1ZWQgdG8gdGhpcyBzYW1lIHBlci1DUFUgYmlvIGNv
bXBsZXRpb24Kd29ya2VyLgoKU2luY2UgdGhpcyB3b3JrZXIgY291bGQgYmUgYmxvY2tlZCBpbiBt
ZW1wb29sX2FsbG9jKCkgd2FpdGluZyBmb3IgdGhlCmZzdmVyaXR5IHdvcmtxdWV1ZSB0byBmaW5p
c2ggdmVyaWZ5aW5nIGRhdGEsIGFuZCB0aGUgZnN2ZXJpdHkgd29ya3F1ZXVlCmNvdWxkIGNvbmN1
cnJlbnRseSBiZSB3YWl0aW5nIG9uIGEgbWV0YWRhdGEgcmVhZCBjb21wbGV0aW9uIHRoYXQgaXMg
cXVldWVkIG9uCnRoaXMgYmxvY2tlZCB3b3JrZXIsIGNhbiB0aGlzIGNhdXNlIGEgaGFuZz8KCj4g
KwkJZnN2X2lvZW5kLT5pb2VuZCA9IGlvZW5kOwo+ICsJCUlOSVRfV09SSygmZnN2X2lvZW5kLT53
b3JrLCB4ZnNfZW5kX2ZzdmVyaXR5X2lvX3JlYWQpOwo+ICsKPiArCQlmc3Zlcml0eV9lbnF1ZXVl
X3ZlcmlmeV93b3JrKCZmc3ZfaW9lbmQtPndvcmspOwo+ICsJCXJldHVybjsKPiArCX0KPiArCj4g
IAlpb21hcF9maW5pc2hfaW9lbmRzKGlvZW5kLCBlcnJvcik7Cj4gIH0KCi0tIApTYXNoaWtvIEFJ
IHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjEwMDIyMjM3MDUu
MjE3NTU0Mi0xLWFhbGJlcnNoQGtlcm5lbC5vcmc/cGFydD0xMgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
