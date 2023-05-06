Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8529C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  6 May 2023 14:17:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pvIjG-0006L2-5w;
	Sat, 06 May 2023 14:17:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1pvIjE-0006Kv-Ut
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 May 2023 14:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9YVwjWo5/vDdysTKQ2ElKQ8F4j2GH4XEIOM2THe87YU=; b=H+cLEPZVszR55cXjSkEdsJjyeB
 /o0CDNy5ChIbZ4aLMW779IExdWDIHuljWMT5CkxhSK+c4YAIuwIODx7lo25+F4zRjPthiXnw09lsI
 9NQWdj1Y7UkovEv13ilT1yFXruUDHOGjRWMzm5c9DZwKmjg7jcvgN2885hG9LLfUxmN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9YVwjWo5/vDdysTKQ2ElKQ8F4j2GH4XEIOM2THe87YU=; b=GyZk6fBgScNGOBHz2S6sslXob0
 mcORobvV483jWU3OyqrewbiI9Qs6YVNG1MEEuc5WCSwUG6vY+mRh/J5hft5mMqC0IzL/xpVa3/Ia+
 HBXrAH5NyYgjTIQHmH9DkI+BdosuNSOP0ubw2qjyBWlyRwdKfyZmULIZm9+6qItFkgVs=;
Received: from smtp-26.smtpout.orange.fr ([80.12.242.26]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pvIjE-0002X8-JP for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 May 2023 14:17:41 +0000
Received: from [192.168.1.18] ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id vIj6pu3sYpwRIvIj6pSGog; Sat, 06 May 2023 16:17:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1683382654;
 bh=9YVwjWo5/vDdysTKQ2ElKQ8F4j2GH4XEIOM2THe87YU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Zm5kU3ok+O8Rx6LXy5OXsz5nPyFjuTjcuALaOEsZl2uuXu8QgnNTrkWmTWnvQtDqt
 Tewts/IjOl3WJ+bYase2oGW3dOvGEjEZOldfelWH8Q4npMjd61gOFEWq6UgbWHeQX7
 zURhUvSVLhm2U47kP5udiqE+n2SgU5XF5Zj2vNtisF0huNXXCYCC/ozMSvUJJ94tkf
 lkrQAh1x44hEBlN0DG0eoMxn5x3QuEP6hzQRONZQtiyCCy7BSc2mHFRIy8JwYPWkPI
 ZX3sHNfEDDJtYxNg5vrYKCYMPW/KflB8Sie7LkT/+iOuS+UFt0Y+TG5MOOdcLv83r6
 YYsJoDR8Lja3A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 16:17:34 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7ab5fb52-8d5b-4de5-78d7-da32254d8d25@wanadoo.fr>
Date: Sat, 6 May 2023 16:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: fr, en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
References: <20230506114033.23908-1-frank.li@vivo.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230506114033.23908-1-frank.li@vivo.com>
X-Headers-End: 1pvIjE-0002X8-JP
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: move the conditional statement
 after holding the inode lock in f2fs_fallocate()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TGUgMDYvMDUvMjAyMyDDoCAxMzo0MCwgWWFuZ3RhbyBMaSBhIMOpY3JpdMKgOgo+IEZvciBqdWRn
aW5nIHRoZSBpbm9kZSBmbGFnIHN0YXRlLCB0aGUgaW5vZGUgbG9jayBtdXN0IGJlIGhlbGQuCj4g
Cj4gRml4ZXM6IGZjYzg1YTRkODZiNSAoImYyZnMgY3J5cHRvOiBhY3RpdmF0ZSBlbmNyeXB0aW9u
IHN1cHBvcnQgZm9yIGZzIEFQSXMiKQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPGZyYW5r
LmxpQHZpdm8uY29tPgo+IC0tLQo+ICAgZnMvZjJmcy9maWxlLmMgfCAxNCArKysrKysrLS0tLS0t
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+IGluZGV4IDg1
MGU3NDVlY2Y4OC4uMDgzN2M1MDBiOTkwIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4g
KysrIGIvZnMvZjJmcy9maWxlLmMKPiBAQCAtMTgwMSw2ICsxODAxLDEzIEBAIHN0YXRpYyBsb25n
IGYyZnNfZmFsbG9jYXRlKHN0cnVjdCBmaWxlICpmaWxlLCBpbnQgbW9kZSwKPiAgIAlpZiAoIVNf
SVNSRUcoaW5vZGUtPmlfbW9kZSkpCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gKwlpZiAo
bW9kZSAmIH4oRkFMTE9DX0ZMX0tFRVBfU0laRSB8IEZBTExPQ19GTF9QVU5DSF9IT0xFIHwKPiAr
CQkJRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIHwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UgfAo+ICsJ
CQlGQUxMT0NfRkxfSU5TRVJUX1JBTkdFKSkKPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwo+
ICsJaW5vZGVfbG9jayhpbm9kZSk7Cj4gKwo+ICAgCWlmIChJU19FTkNSWVBURUQoaW5vZGUpICYm
Cj4gICAJCShtb2RlICYgKEZBTExPQ19GTF9DT0xMQVBTRV9SQU5HRSB8IEZBTExPQ19GTF9JTlNF
UlRfUkFOR0UpKSkKPiAgIAkJcmV0dXJuIC1FT1BOT1RTVVBQOwoKcmV0ID0gLUVPUE5PVFNVUFA7
CmdvdG8gb3V0OwoKaGVyZSBhbmQgaW4gc29tZSBvdGhlciBwbGFjZXMgYmVsb3cuCgpNYXliZSB0
aGUgY29kZSBzaG91bGQgZGUgcmVhcnJhbmdlZCBhbm90aGVyIHdheSBpZiAKdHJhY2VfZjJmc19m
YWxsb2NhdGUoKSBzaG91bGQgbm90IGJlIGNhbGxlZCBpbiBzdWNoIGNhc2VzLgoKQ0oKCj4gQEAg
LTE4MTQsMTMgKzE4MjEsNiBAQCBzdGF0aWMgbG9uZyBmMmZzX2ZhbGxvY2F0ZShzdHJ1Y3QgZmls
ZSAqZmlsZSwgaW50IG1vZGUsCj4gICAJCQlGQUxMT0NfRkxfWkVST19SQU5HRSB8IEZBTExPQ19G
TF9JTlNFUlRfUkFOR0UpKSkKPiAgIAkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICAgCj4gLQlpZiAo
bW9kZSAmIH4oRkFMTE9DX0ZMX0tFRVBfU0laRSB8IEZBTExPQ19GTF9QVU5DSF9IT0xFIHwKPiAt
CQkJRkFMTE9DX0ZMX0NPTExBUFNFX1JBTkdFIHwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UgfAo+IC0J
CQlGQUxMT0NfRkxfSU5TRVJUX1JBTkdFKSkKPiAtCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gLQo+
IC0JaW5vZGVfbG9jayhpbm9kZSk7Cj4gLQo+ICAgCXJldCA9IGZpbGVfbW9kaWZpZWQoZmlsZSk7
Cj4gICAJaWYgKHJldCkKPiAgIAkJZ290byBvdXQ7CgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
