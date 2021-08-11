Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60B9C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 12:57:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94036600CD;
	Wed, 11 Aug 2021 12:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94036600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDnnJ-0002AO-GU; Wed, 11 Aug 2021 12:57:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mDnnJ-0002AG-3A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 12:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UI5FD1vAZoKgXdn7akXLwDlSZhMDxA4xttFxPLlV7U4=; b=DBroLMGfRbBgb2vAZzCAdXZ9+3
 tl78b5E8o8labnAmKKiJ0IS7vmINhFFwjseFaPjtWzmZv5JtdKbLgKbfIxR4f1BXGml4L7im9pu+T
 z1lbjJkrVcx2F0JIoRPLtsgkiSKNkZ35ahN9s5ykCMNRl/zV3lGBhr5l3WIeIcCKuCFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UI5FD1vAZoKgXdn7akXLwDlSZhMDxA4xttFxPLlV7U4=; b=L51UfKYdq82viumRUjqG5FeCnr
 fc+4loAWKAZWbSFbqyVsfYRRpWUUAvoNmPC4FMsex83OFKkYyLFC5hOWtL5IdmhjVK6Pk8VzxEgrE
 kwgVoLKHIsD5ukjQsWvTQFZ+5CDuhW9UsQG/1YVnrEQX0Yd0eFdT74LGaZZAq6AaiFiY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDnnH-00038R-GR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 12:57:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71D10601FF;
 Wed, 11 Aug 2021 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628686630;
 bh=+CFOKZhQCvP4jIpuALDJ47zPNHlom+tWJ/IiTz1zLDg=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=haVrEXIhoaiy0l5SlTb7FLEhBK6jGOgnxOdZnm/+fKjkcyYBOs8jl4WD8C8KUVgho
 NXx/FwkBYzlxAkzoUA/SGV/Le0ReEPtlOJqShaBRDO5C0tj3/4CEMzyRTHX4JqCES5
 zF2isEQQBixBmnlnF4KQclDre3GehRcx20N4H6KHRMHjHC5QK9i5LCQml27i8z0hEO
 Y9RG4zzpWv5LW09tb/P8xqd63Zbw8Dsx8H6Cg7/sys2uRE8+TEiilSVnwgpoF+I01Q
 dhLfiXcawQnlMd0j6lU6U6m8g7oiZ7gqw7BA2kfmnz9SsFup8mgBcjiJr5oGy57FNs
 p4szhztvNNWmA==
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
 <6519b8b7-1eb0-f286-7593-5c5ebbfb5554@kernel.org>
 <86e53ee7-13b5-5e8e-7c81-acb1736ebc8b@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <aa5f3225-6409-bc62-1021-107a18040384@kernel.org>
Date: Wed, 11 Aug 2021 20:57:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <86e53ee7-13b5-5e8e-7c81-acb1736ebc8b@vivo.com>
Content-Language: en-US
X-Headers-End: 1mDnnH-00038R-GR
Subject: Re: [f2fs-dev] f2fs do DIO write make file corruption
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS84LzExIDExOjI4LCBXdSBCbyB3cm90ZToKPiAKPiDlnKggMjAyMS84LzExIDExOjAz
LCBDaGFvIFl1IOWGmemBkzoKPj4gT24gMjAyMS84LzExIDEwOjQ4LCBXdSBCbyB3cm90ZToKPj4+
IEkgdXNlIHRoZSBmb2xsb3dpbmcgY29tbWFuZCB0byBjcmVhdGUgYSBmaWxlLCB0aGUgZmlsZSBt
YXkgZ290Cj4+PiBjb3JydXB0aW9uOgo+Pj4gIMKgwqDCoMKgZjJmc19pbyB3cml0ZSAyIDAgNTEy
IGluY19udW0gZGlvICRwYXRoCj4+Pgo+Pj4gQW5kIHdoZW4gSSB1c2UgYmlvIG9yIHRvIHNldCB0
aGUgY2h1bmsgc2l6ZSB0byAxIGJsb2NrLCB0aGUgZmlsZSBpcwo+Pj4gbm9ybWFsLiBUaGUgY29t
bWFuZHMgYXMgZm9sbG93aW5nOgo+Pj4gIMKgwqDCoMKgZjJmc19pbyB3cml0ZSAyIDAgNTEyIGlu
Y19udW0gYnVmZmVyZWQgJHBhdGgKPj4+ICDCoMKgwqDCoGYyZnNfaW8gd3JpdGUgMSAwIDUxMiBp
bmNfbnVtIGRpbyAkcGF0aAo+Pj4KPj4+IEkgZmluZCB0aGlzIGJ1ZyBvbiBvbGQga2VybmVsIHZl
cnNpb24gNC4xNC4xMTcsIGFuZCBub3QgZmluZCBvbiB2ZXJzaW9uCj4+PiA0LjE5LjE1Mi4gU28g
dGhpcyBidWcgaXMgZml4ZWQuIENhbiBhbnlvbmUgY2FuIHRlbGwgbWUgd2hpY2ggcGF0Y2ggZml4
ZWQKPj4+IHRoaXMgYnVnPwo+Pgo+PiBOb3Qgc3VyZSwKPj4KPj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9
bGludXgtNC4xOS55JmlkPTdiYWU4YjZiNzNlNDZjMzA3ZmEzNTVjZTA4NjgwMGI3YWQ2NjEwZjgK
CkkgZGlkbid0IHNlZSB0aGlzIHBhdGNoIGluIDQuMTQgc3RhYmxlIGtlcm5lbCBvZiBtYWlsaW5l
LCBzbyBkbyB5b3UgbWVhbiA0LjE0IGtlcm5lbAptYWludGFpbmVkIGJ5IEFuZHJvaWQ/CgpJZiBz
bywgZjJmcyBjb2RlcyBpbiBiZXR3ZWVuIDQuMTQgYW5kIDQuMTkgQW5kcm9pZCBrZXJuZWwgYXJl
IGFsbW9zdCB0aGUgc2FtZSwKc2VlIGJlbG93IGxpbms6CgpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qYWVnZXVrL2YyZnMtc3RhYmxlLmdpdC8KClRoYW5r
cywKCj4+Cj4gCj4gVGhpcyBwYXRjaCBpcyBhcHBsaWVkLiBUaGUgaXNzdWUgb2NjdXJzIHdoZW4g
ZjJmcyBkaW8gdHJ5IHRvIHByZWFsbG9jYXRlCj4gbXVsdGlwbGUgYmxvY2tzIGFuZCBnb3Qgc2Nh
dHRlcmVkIGRpc2sgYmxvY2tzLiBUaGUgbG9nIGFzIGZvbGxvd2luZzoKPiAgICAgICAgIG15X2Yy
ZnNfaW8tMTM0MjUgWzAwMl0gLi4uLiAgIDM5NS41ODM2Mzc6IGVsMF9pcnFfbmFrZWQ6Cj4gMTp0
eXBlOjEsaW5vOjQwMTMyLG9mZjo3Njgsb2xkX2JsazowLG5ld19ibGs6MTg1NzY0Cj4gICAgICAg
ICBteV9mMmZzX2lvLTEzNDI1IFswMDJdIC4uLi4gICAzOTUuNTgzNzEwOiBlbDBfaXJxX25ha2Vk
Ogo+IDE6dHlwZToxLGlubzo0MDEzMixvZmY6NzY5LG9sZF9ibGs6MCxuZXdfYmxrOjIwNTgyNAo+
ICAgICAgICAgbXlfZjJmc19pby0xMzQyNSBbMDAyXSAuLi4uICAgMzk1LjU4MzcyMTogZjJmc19t
YXBfYmxvY2tzOiBkZXYgPQo+ICgyNTksMjMpLCBpbm8gPSA0MDEzMiwgZmlsZSBvZmZzZXQgPSA3
NjgsIHN0YXJ0IGJsa2FkZHIgPSAweDJkNWE0LCBsZW4gPQo+IDB4MiwgZXJyID0gMAo+ICAgICAg
ICAgbXlfZjJmc19pby0xMzQyNSBbMDAyXSAuLi4uICAgMzk1LjU4MzczNTogZjJmc19tYXBfYmxv
Y2tzOiBkZXYgPQo+ICgyNTksMjMpLCBpbm8gPSA0MDEzMiwgZmlsZSBvZmZzZXQgPSA3NjgsIHN0
YXJ0IGJsa2FkZHIgPSAweDJkNWE0LCBsZW4gPQo+IDB4MSwgZXJyID0gMAo+ICAgICAgICAgbXlf
ZjJmc19pby0xMzQyNSBbMDAyXSAuLi4uICAgMzk1LjU4Mzc0MTogZjJmc19tYXBfYmxvY2tzOiBk
ZXYgPQo+ICgyNTksMjMpLCBpbm8gPSA0MDEzMiwgZmlsZSBvZmZzZXQgPSA3NjksIHN0YXJ0IGJs
a2FkZHIgPSAweDMyNDAwLCBsZW4gPQo+IDB4MSwgZXJyID0gMAo+IAo+IEFuZCBpZiB0aGUgYmxv
Y2tzIGFyZSBjb250aW51b3VzbHksIHRoZSBmaWxlIGRhdGEgaXMgbm9ybWFsOgo+IAkgIG15X2Yy
ZnNfaW8tMTM0MjUgWzAwMl0gLi4uLiAgIDM5NS41ODQwMzc6IGVsMF9pcnFfbmFrZWQ6Cj4gMTp0
eXBlOjEsaW5vOjQwMTMyLG9mZjo3NzAsb2xkX2JsazowLG5ld19ibGs6MjA1ODI1Cj4gICAgICAg
ICBteV9mMmZzX2lvLTEzNDI1IFswMDJdIC4uLi4gICAzOTUuNTg0MDY2OiBlbDBfaXJxX25ha2Vk
Ogo+IDE6dHlwZToxLGlubzo0MDEzMixvZmY6NzcxLG9sZF9ibGs6MCxuZXdfYmxrOjIwNTgyNgo+
ICAgICAgICAgbXlfZjJmc19pby0xMzQyNSBbMDAyXSAuLi4uICAgMzk1LjU4NDA3NzogZjJmc19t
YXBfYmxvY2tzOiBkZXYgPQo+ICgyNTksMjMpLCBpbm8gPSA0MDEzMiwgZmlsZSBvZmZzZXQgPSA3
NzAsIHN0YXJ0IGJsa2FkZHIgPSAweDMyNDAxLCBsZW4gPQo+IDB4MiwgZXJyID0gMAo+ICAgICAg
ICAgbXlfZjJmc19pby0xMzQyNSBbMDAyXSAuLi4uICAgMzk1LjU4NDA5MTogZjJmc19tYXBfYmxv
Y2tzOiBkZXYgPQo+ICgyNTksMjMpLCBpbm8gPSA0MDEzMiwgZmlsZSBvZmZzZXQgPSA3NzAsIHN0
YXJ0IGJsa2FkZHIgPSAweDMyNDAxLCBsZW4gPQo+IDB4MiwgZXJyID0gMAo+IAo+Pgo+PiBUaGFu
a3MsCj4+Cj4+Pgo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+PiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+Pj4gTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPj4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKPj4+Cj4+Cj4gCj4gCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
