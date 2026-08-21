Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F2C5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBVarttc+C89tDYePnYzZ9W9859XQ1MGma5KwbZXSh8=; b=UsFY7jZ59jzdd8IpcRiVo9UFLI
	b1T1qtUijZxW7nu7YNsRV+knmf8YnX774BfkKV6ZRqCpsA3ii8GiGmKAQg5GIyTvi4XupnMwFx9Uz
	unDpl2Oo7FbhUegAjmjPOLffq8MrCFagP2LUQyCcEg2k0XsB6fOsCeEmkUSYkNtWe2AE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxKWR-0003ps-6A;
	Fri, 21 Aug 2026 08:22:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1wxKVU-0003ZO-DH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 08:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jvL9ik0khXWRl5coP2HL9T/t7eY9GXA67WUTdNRw3u8=; b=RX7g7E+6sxVGPhy1is8BV2fBQn
 Lyx3bJ18iWuNeqP9bSSRbpaaXKjwWKj0hwNvlpwJvcNbvxxO/QqN58wOjiBDZQwC70qpBCVfkh3qX
 ScxScLJ4xFe+nZyFFT7C8fghGfECiCyL2QXlwaqx+nF+A05Z39cv+YwQoEXmnsqPgUbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jvL9ik0khXWRl5coP2HL9T/t7eY9GXA67WUTdNRw3u8=; b=UhJx9IHeVJVBlq//PAUld/0OSG
 kUWty6tnbWQzp41E7OM8KN4Hb+Onl57A9FnLC609+kv6OGULyCw/7kTpp6H3U5gtKzA4G+9bEKkYg
 RKwnrLI3Z/pjqJmKJjRYEOFEFnOmZlAjLdVyMkn4djN9UoN2auV0kRaCSBCjHhb5pJ40=;
Received: from smtp-81.smtpout.orange.fr ([80.12.242.81]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxKVQ-0002pK-0s for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 08:21:41 +0000
Received: from [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
 ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
 by smtp.orange.fr with ESMTPSA
 id xKVIwiv66xjiyxKVIw2ix2; Fri, 21 Aug 2026 10:21:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1787300493;
 bh=jvL9ik0khXWRl5coP2HL9T/t7eY9GXA67WUTdNRw3u8=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=KKJF430ipWHOJxMpmwJ1qqY6jliuuHDkXkkAHKshjUxBvdz7Q5Mgmr0+0nOmLmrNM
 kbJecVgFmaKsQ0Dfr7sXw+C2ZgMc+wckIDhSxu1FMHzFqqBNDrVpB/fpjEPvXu9WDZ
 oJH38qcnfRbHXvLR1uRYc7XHhWLJ0jDF/ilI1KOpmjpcE/njGF9CBf7QrTcyii+I5F
 h5ITHYn2ZxGsWa7tnGgXUxZWjf665P6TwrW6twSqj0KDcZl2APMuccxQFtUbc1zUoC
 dlThk3+4W4E9J95T0lDC5pIO7bABunw8sX0mcuUoXk4P+Gs/s4myxqepqkhdRnLy2I
 ZEhLgbEK6s0Pg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:6128:9b8c:c203:905]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Aug 2026 10:21:33 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
Message-ID: <0fc4eebe-68a1-472f-9dee-fecd5dd85f06@wanadoo.fr>
Date: Fri, 21 Aug 2026 10:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260821011812.2938998-1-daeho43@gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <20260821011812.2938998-1-daeho43@gmail.com>
X-Headers-End: 1wxKVQ-0002pK-0s
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
From: Christophe JAILLET via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Daeho Jeong <daehojeong@google.com>, stable@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TGUgMjEvMDgvMjAyNiDDoCAwMzoxOCwgRGFlaG8gSmVvbmcgYSDDqWNyaXTCoDoKPiBGcm9tOiBE
YWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+IAo+IEluIGYyZnNfcmVuYW1lKCkg
YW5kIGYyZnNfdW5saW5rKCksIGRpcmVjdGx5IHJldHVybmluZyAtRVBFUk0gd2hlbgo+IGVuY291
bnRlcmluZyBhIGRldmljZSBhbGlhc2luZyBmaWxlIGJ5cGFzc2VzIHRoZSBjbGVhbnVwIHBhdGgu
Cj4gCj4gRml4IHRoaXMgYnkgc2V0dGluZyBlcnIgdG8gLUVQRVJNIGFuZCBqdW1waW5nIHRvIHRo
ZSBwcm9wZXIgY2xlYW51cAo+IGxhYmVscyAob3V0X2RpciBhbmQgb3V0KSBpbnN0ZWFkIG9mIHJl
dHVybmluZyBpbW1lZGlhdGVseS4KPiAKPiBGaXhlczogYTczN2U0MDlhM2Q2ICgiZjJmczogc3Vw
cG9ydCBkeW5hbWljIHJlc2VydmUvcmVsZWFzZSBmb3IgZGV2aWNlIGFsaWFzaW5nIikKPiBDYzog
c3RhYmxlQGtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9u
Z0Bnb29nbGUuY29tPgoKSGksCmlmIHBvc3NpYmxlLCBhCgpSZXBvcnRlZC1ieTogQ2hyaXN0b3Bo
ZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4KCndvdWxkIGJlIGFwcHJl
Y2lhdGVkLgoKQ0o+IC0tLQo+ICAgZnMvZjJmcy9uYW1laS5jIHwgMTIgKysrKysrKystLS0tCj4g
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9mcy9mMmZzL25hbWVpLmMgYi9mcy9mMmZzL25hbWVpLmMKPiBpbmRleCA3ODRm
NjM2MjQ0ZTEuLmI5YjE1YzVkMjhkZSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL25hbWVpLmMKPiAr
KysgYi9mcy9mMmZzL25hbWVpLmMKPiBAQCAtNTcxLDggKzU3MSwxMCBAQCBzdGF0aWMgaW50IGYy
ZnNfdW5saW5rKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpCj4gICAK
PiAgIAl0cmFjZV9mMmZzX3VubGlua19lbnRlcihkaXIsIGRlbnRyeSk7Cj4gICAKPiAtCWlmIChJ
U19ERVZJQ0VfQUxJQVNJTkcoaW5vZGUpKQo+IC0JCXJldHVybiAtRVBFUk07Cj4gKwlpZiAoSVNf
REVWSUNFX0FMSUFTSU5HKGlub2RlKSkgewo+ICsJCWVyciA9IC1FUEVSTTsKPiArCQlnb3RvIG91
dDsKPiArCX0KPiAgIAo+ICAgCWlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKHNiaSkpKSB7Cj4g
ICAJCWVyciA9IC1FSU87Cj4gQEAgLTEwMjUsOCArMTAyNywxMCBAQCBzdGF0aWMgaW50IGYyZnNf
cmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKm9sZF9kaXIsCj4g
ICAJfQo+ICAgCj4gICAJaWYgKG5ld19pbm9kZSkgewo+IC0JCWlmIChJU19ERVZJQ0VfQUxJQVNJ
TkcobmV3X2lub2RlKSkKPiAtCQkJcmV0dXJuIC1FUEVSTTsKPiArCQlpZiAoSVNfREVWSUNFX0FM
SUFTSU5HKG5ld19pbm9kZSkpIHsKPiArCQkJZXJyID0gLUVQRVJNOwo+ICsJCQlnb3RvIG91dF9k
aXI7Cj4gKwkJfQo+ICAgCj4gICAJCWVyciA9IC1FTk9URU1QVFk7Cj4gICAJCWlmIChvbGRfaXNf
ZGlyICYmICFmMmZzX2VtcHR5X2RpcihuZXdfaW5vZGUpKQoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
