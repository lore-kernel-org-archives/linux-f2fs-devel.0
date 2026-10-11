Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB04CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6WX5dUBKpBow5YTrS8Iw6apFySw5Ft0UFQ/d1O+QekM=; b=dbqCCkvaUmV2QtnevmmgsEViRO
	9vqEqIImis98mQvFZ8apauuGR6fopWPn6Mf6NIFKQ+opITot+FoFRMaqJYq7R/HaFUt9TGrMXy0Df
	qA0iXL/tWcRwmc2pEhaImqUKgPqX+DBnG+j5WfWp8EhOpIoatf1EfjLEDqnwXrNuMges=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFi71-0002lD-2b;
	Sun, 11 Oct 2026 01:12:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFi6s-0002l2-VO
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:12:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A4gRj7W6tjsE/rOXWq4wmshAzwenDKIWX7pteMKX3AA=; b=U2qzgdKGYtWQvNnVPaAwcy92fp
 1VFKD9EJFEnbutrl4/vbDOMjCnudww6kyre/aMUNlFey+1yW/aOMqmZxNT314c5Tbf0zSr9XBpg/z
 S5Tb43sJ6vIKmV5t3IOmvuyfV9xMJrgqr5CONyvLigmL1XjXFm3D4BL+YPheQHId81sI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A4gRj7W6tjsE/rOXWq4wmshAzwenDKIWX7pteMKX3AA=; b=Rh4UUJQEK+TMseu5BT3Wvw6Rz+
 nE1Qq+/tAUzHbbX3m0VwLcI7XHWoHCgfwYOerekpINU3khdBYCcjhZ3aq/qJjm1ZCOEbKnkhL1gW+
 DZsPZBHX7TRKh+fRD802NbAHaMJYbvpI0j0kb8a1G+82pn7Mfmkjw53vqMK37tBu9NWA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFi6p-0005e9-V0 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:12:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54D9860018;
 Sun, 11 Oct 2026 01:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3198F1F000FF;
 Sun, 11 Oct 2026 01:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791681130;
 bh=A4gRj7W6tjsE/rOXWq4wmshAzwenDKIWX7pteMKX3AA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FjWUO7GfaYTs2Tm3zqxM/z8j0UkP7ubBXnElYMKHPiMqpc5gJyE5+gMw3vnPohMgy
 xe6MLQbg592xpnHa/nvS4apI6duelob1F/4FwN+n6fjmGi69nGwOoIjtROpQlanZ3z
 Z/vI7hQY27eXK87TZT6yiFcnxyaFLLJ42ZRR4oqrySXv7fl5BYoyz9u4ZxkMunp+zk
 fxsSdpR8FNYByDdqD90K3vKFuyNGYnylpp7R5I9BN9Z5fziSN4iGt0HkkPSaEO2FNf
 OCliqEgHFnaxg94jfIn1jTtIYsEyjuRwthvdsOD4WaQqaiSXqa/8heYAYjOcxREZUG
 6lE5CNWCiHLig==
Message-ID: <4de81087-6b2a-4f0b-9867-e6fc84198239@kernel.org>
Date: Sun, 11 Oct 2026 09:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Juhyung Park <qkrwngud825@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 kernel-team@android.com
References: <20261005201711.699080-1-qkrwngud825@gmail.com>
Content-Language: en-US
In-Reply-To: <20261005201711.699080-1-qkrwngud825@gmail.com>
X-Headers-End: 1xFi6p-0005e9-V0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix casefolded dentry hash for
 names that fold beyond F2FS_NAME_LEN
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAvNi8yNiAwNDoxNywgSnVoeXVuZyBQYXJrIHdyb3RlOgo+IFNpbmNlIGtlcm5lbCBjb21t
aXQgNDNjNzgwYmEyNjI0ICgiZjJmczogcmV3b3JrIGZpbGVuYW1lIGhhbmRsaW5nIiwKPiB2NS44
KSwgdGhlIGtlcm5lbCBjYXNlZm9sZHMgYSBuYW1lIGludG8gYW4gRjJGU19OQU1FX0xFTiBidWZm
ZXIsIGFuZCBpZgo+IHRoZSBmb2xkZWQgbmFtZSBkb2Vzbid0IGZpdCwgaXQgZmFsbHMgYmFjayB0
byBoYXNoaW5nIHRoZSByYXcgb24tZGlzawo+IG5hbWUgKGYyZnNfaW5pdF9jYXNlZm9sZGVkX25h
bWUoKSkuCj4gCj4gZjJmc19kZW50cnlfaGFzaCgpIHN0aWxsIGZvbGRzIGludG8gYSBQQVRIX01B
WCBidWZmZXIsIGFzIHRoZSBvcmlnaW5hbAo+IGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBkaWQsIHNv
IGl0IGhhc2hlcyB0aGUgZm9sZGVkIG5hbWUgaW5zdGVhZC4gTkZECj4gZGVjb21wb3NpdGlvbiBj
YW4gZ3JvdyBhIG5hbWUgY29uc2lkZXJhYmx5IChlYWNoIDMtYnl0ZSBIYW5ndWwgc3lsbGFibGUK
PiBiZWNvbWVzIDYtOSBieXRlcyksIHNvIGEgdmFsaWQgPD0gMjU1LWJ5dGUgbmFtZSBjYW4gZm9s
ZCB0byBtb3JlIHRoYW4KPiAyNTUgYnl0ZXMuIEZvciBzdWNoIGEgbmFtZSwgZnNjay5mMmZzIGNv
bXB1dGVzIGEgZGlmZmVyZW50IGhhc2ggdGhhbiB0aGUKPiBrZXJuZWwuIEl0IHRoZW4gImZpeGVz
IiB0aGUga2VybmVsLXdyaXR0ZW4gaGFzaF9jb2RlIHRvIGEgd3JvbmcgdmFsdWUsCj4gYW5kIHRo
ZSBmaWxlIGJlY29tZXMgdW5yZWFjaGFibGUgdmlhIGxvb2t1cCAoRU5PRU5UKSB1bmxlc3MgdGhl
IGtlcm5lbAo+IGZhbGxzIGJhY2sgdG8gbGluZWFyIGxvb2t1cCAoZS5nLiBsb29rdXBfbW9kZT1j
b21wYXQpLiBMYXRlciBmc2NrIHJ1bnMKPiBjb25zaWRlciB0aGUgYnJva2VuIGhhc2ggY29ycmVj
dCBhbmQgcmVwb3J0IG5vdGhpbmcuCj4gCj4gVGhpcyBzaWxlbnRseSBtYWtlcyB1c2VyIGZpbGVz
IHVucmVhY2hhYmxlIG9uIEFuZHJvaWQsIHdoZXJlIC9kYXRhL21lZGlhCj4gaXMgY2FzZWZvbGRl
ZCBhbmQgZnNjayBpcyB0cmlnZ2VyZWQgb24gYSBmdWxsIE9UQSBhbmQgYSBrZXJuZWwgdmVyc2lv
bgo+IGNoYW5nZS4gVGhpcyBwZXJzb25hbGx5IGhhcHBlbmVkIHRvIG1lIG9uIG15IGRhaWx5IGRy
aXZlciB1bml0LiBTaW5jZQo+IHRoZSBidWdneSBmc2NrIGNvbnNpZGVycyBpdHMgb3duIGhhc2gg
Y29ycmVjdCBhZnRlcndhcmRzLCB0aGUgZGFtYWdlIGlzCj4gbmV2ZXIgcmVwb3J0ZWQsIGFuZCBp
dCByZXBlYXRzIGZvciBldmVyeSBuZXcgc3VjaCBmaWxlIHRoZSBrZXJuZWwKPiBjcmVhdGVzLgo+
IAo+IE1pbmltYWwgcmVwcm9kdWNlcjoKPiAKPiAgICBOQU1FPSQocHJpbnRmICfqsIAlLjBzJyAk
KHNlcSA0MykpICAjIDEyOSBieXRlcyByYXcsIDI1OCBieXRlcyBmb2xkZWQKPiAgICB0cnVuY2F0
ZSAtcyAxMjhNIGNmLmltZwo+ICAgIG1rZnMuZjJmcyAtcSAtTyBleHRyYV9hdHRyLGNhc2Vmb2xk
IC1DIHV0ZjggY2YuaW1nCj4gICAgbW91bnQgLW8gbG9vcCBjZi5pbWcgbW50Cj4gICAgbWtkaXIg
bW50L2QgJiYgY2hhdHRyICtGIG1udC9kICYmIHRvdWNoICJtbnQvZC8kTkFNRSIKPiAgICB1bW91
bnQgbW50Cj4gICAgZnNjay5mMmZzIC1mIC15IGNmLmltZwo+ICAgIG1vdW50IC1vIGxvb3Ascm8g
Y2YuaW1nIG1udAo+ICAgIHN0YXQgIm1udC9kLyROQU1FIgo+IAo+IEJlZm9yZSB0aGlzIHBhdGNo
LCBmc2NrLmYyZnMgd3JvbmdmdWxseSBtb2RpZmllcyB0aGUgaGFzaCBhbmQgYnJlYWtzCj4ga2Vy
bmVsIGxvb2t1cDoKPiAKPiAgICBzdGF0OiBjYW5ub3Qgc3RhdHggJ21udC9kL+qwgOqwgOqwgOqw
gOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqw
gOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqw
gOqwgCc6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKPiAKPiBVc2UgYW4gRjJGU19OQU1FX0xF
TiBidWZmZXIsIGFzIHRoZSBrZXJuZWwgZG9lcy4gdXRmOF9jYXNlZm9sZCgpIGFscmVhZHkKPiBy
ZXR1cm5zIC1FTkFNRVRPT0xPTkcgb24gb3ZlcmZsb3csIHdoaWNoIGZhbGxzIGJhY2sgdG8gdGhl
IHJhdy1uYW1lIGhhc2guCj4gV2l0aCB0aGlzLCBmc2NrLmYyZnMgbGVhdmVzIHRoZSByZXByb2R1
Y2VyIGltYWdlIHVudG91Y2hlZCwgYW5kIGl0IGFsc28KPiByZXBhaXJzIHRoZSBoYXNoZXMgdGhh
dCB0aGUgYnVnZ3kgdmVyc2lvbiBwcmV2aW91c2x5IHJld3JvdGUuCj4gCj4gRml4ZXM6IGNlNjRl
YTA4MTViZiAoImYyZnMtdG9vbHM6IEFkZCBzdXBwb3J0IGZvciBDYXNlZm9sZGluZyIpCj4gU2ln
bmVkLW9mZi1ieTogSnVoeXVuZyBQYXJrIDxxa3J3bmd1ZDgyNUBnbWFpbC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgoKVGhhbmtzLAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
