Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BAC369AB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Apr 2025 02:52:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u89BK-0006vk-Gg;
	Fri, 25 Apr 2025 02:52:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u89BI-0006va-70
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Apr 2025 02:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1omHT6fh0YTM4sgYYXCweBSKfjD/CEhXZsn7YFWCdWs=; b=Q+PHHdxK9jtrBPeIXSy+qV3nqd
 nsvjuGAJHO5DLtlZ28/sP7LoKaPH63bJXUJjbqlOFb6vZkepnor0+Y+YHYoI3s1E8EeZd5nO0M/ZO
 3pbYz2bGSa9CmdWrggTDSklczVIAfXYRdzZZQkyb4KJKhsrzeAdPd5Q/NFGWHzOfBhF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1omHT6fh0YTM4sgYYXCweBSKfjD/CEhXZsn7YFWCdWs=; b=jRmWIURqyLVjpJ1IgwHTdu8V2p
 OrBzAHBiB3jUn4dpuFbzIlNhjNtFQsFXZw1D/Lg0w8VCEYVZouI9kyIl4Vi0tk6YRBFkLp5jIM6Ml
 lXDxDJnZb++JP+JURlvqgd1JqG9whNLkGGNsshYC9bNVUYIi0QOOqmY0CWXUTtVUGIH8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u89B3-0002Xg-Bt for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Apr 2025 02:52:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 84DF668464;
 Fri, 25 Apr 2025 02:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640CDC4CEE3;
 Fri, 25 Apr 2025 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745549542;
 bh=3pUZ2fojXMMC0aaYRUGjxCXTzjS/eJ2kqKQysZn/X+s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LaOO8ZsNaByvpsr11braxNzhLhgtNKwlfbMmnKmoqZsy2u6ttnkSDO/UvW64jAf3Q
 TFsJviMEtEw1ke4YkVVFyEXiJh89ljwMmTZa5jxGeckZa/xRFAnIEzlxhLj1ninl3m
 SAljvNbX5zhl5mga8E5uLEplSt4o1JLmofgN2joO/g/f7lgqgwIUjfch6Z4BmQukwO
 hlqqcCnxGP7mFJiZT09SeSn0ucmitOrtSW5uCqbIqj/fF0y7qlBpq892Pd/8AlBz82
 aSs/pnKT/4LXITSW2mZos04iZJnF7z5NDvhSfu44nVpMN/yRpk56KRDSBaEl2+I5M8
 XbYDO6bzVNGQw==
Message-ID: <45b3d1c8-cb94-43ac-a9af-e8389c74fbd5@kernel.org>
Date: Fri, 25 Apr 2025 10:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dmitry Antipov <dmantipov@yandex.ru>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250423161527.152834-1-dmantipov@yandex.ru>
 <cfbe6edc-fcc3-4351-9c3d-5c6c18178835@kernel.org>
 <579042fc-d8e6-4ce4-b3d5-72cfb4102d3c@yandex.ru>
Content-Language: en-US
In-Reply-To: <579042fc-d8e6-4ce4-b3d5-72cfb4102d3c@yandex.ru>
X-Headers-End: 1u89B3-0002Xg-Bt
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: end all corrupted fs writes with
 -EFSCORRUPTED
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
Cc: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNC8yNC8yNSAxODo0MywgRG1pdHJ5IEFudGlwb3Ygd3JvdGU6Cj4gT24gNC8yNC8yNSAxMTo1
OCBBTSwgQ2hhbyBZdSB3cm90ZToKPiAKPj4gSSBndWVzcyB3ZSBuZWVkIHRvIGZpZ3VyZSBvdXQg
d2h5IGYyZnNfYnVnX29uKCkgd2lsbCBiZSB0aWdnZXJyZWQ/Cj4+Cj4+IGYyZnNfd3JpdGVfZW5k
X2lvKCkKPj4gewo+PiAuLi4KPj4gwqDCoMKgwqDCoMKgwqAgZjJmc19idWdfb24oc2JpLCBmb2xp
by0+bWFwcGluZyA9PSBOT0RFX01BUFBJTkcoc2JpKSAmJgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZm9saW8tPmluZGV4ICE9IG5pZF9vZl9ub2RlKCZmb2xpby0+cGFnZSkpOwo+
IAo+IFdlbGwsIHN5emthbGxlciBpcyB2ZXJ5ICJjcmVhdGl2ZSIgaW4gZ2VuZXJhdGluZyB3ZWly
ZGx5IGRhbWFnZWQgZmlsZXN5c3RlbXMgOi0pLgoKWWVhaC4KCj4gCj4gQW4gb3ZlcmFsbCBpZGVh
IG9mIHRoZSBwYXRjaCBpcyB0aGF0IGFuIGF0dGVtcHQgdG8gY29tcGxldGUgSS9PIG9uIGEgZmls
ZXN5c3RlbQo+IHdoaWNoIGlzIGtub3duIHRvIGJlICJicm9rZW4gZW5vdWdoIHRvIHJ1biBmc2Nr
IiBtYXkgbWFrZSB0aGUgdGhpbmdzIGV2ZW4gd29yc2UKPiAoYnkgbWFraW5nIHRoZSBmaWxlc3lz
dGVtIGV2ZW4gbGVzcyBjb25zaXN0ZW50KS4gU28gaXQgbWF5IGJlIHNhZmVyIGp1c3QgdG8KPiBy
ZWZ1c2UgYWxsIGluLWZsaWdodCB3cml0ZSBhdHRlbXB0cyBhdCBsZWFzdC4KCldlIHdpbGwgaGFu
ZGxlIElPIG9uY2UgdGhlcmUgaXMgY3JpdGljYWwgZXJyb3IgKHRhZ2dlZCB3LyBDUF9FUlJPUl9G
TEFHKSwgeW91CmNhbiBjaGVjayB0aGUgZGV0YWlsZWQgYmVoYXZpb3JzIGFzIGJlbG93OgoKZXJy
b3JzPSVzICAgICAgICAgICAgICAgIFNwZWNpZnkgZjJmcyBiZWhhdmlvciBvbiBjcml0aWNhbCBl
cnJvcnMuIFRoaXMgc3VwcG9ydHMgbW9kZXM6CiAgICAgICAgICAgICAgICAgICAgICAgICAicGFu
aWMiLCAiY29udGludWUiIGFuZCAicmVtb3VudC1ybyIsIHJlc3BlY3RpdmVseSwgdHJpZ2dlcgog
ICAgICAgICAgICAgICAgICAgICAgICAgcGFuaWMgaW1tZWRpYXRlbHksIGNvbnRpbnVlIHdpdGhv
dXQgZG9pbmcgYW55dGhpbmcsIGFuZCByZW1vdW50CiAgICAgICAgICAgICAgICAgICAgICAgICB0
aGUgcGFydGl0aW9uIGluIHJlYWQtb25seSBtb2RlLiBCeSBkZWZhdWx0IGl0IHVzZXMgImNvbnRp
bnVlIgogICAgICAgICAgICAgICAgICAgICAgICAgbW9kZS4KICAgICAgICAgICAgICAgICAgICAg
ICAgID09PT09PT09PT09PT09PT09PT09PT0gPT09PT09PT09PT09PT09ID09PT09PT09PT09PT09
PSA9PT09PT09PQogICAgICAgICAgICAgICAgICAgICAgICAgbW9kZSAgICAgICAgICAgICAgICAg
ICBjb250aW51ZSAgICAgICAgcmVtb3VudC1ybyAgICAgIHBhbmljCiAgICAgICAgICAgICAgICAg
ICAgICAgICA9PT09PT09PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PSA9PT09PT09PT09
PT09PT0gPT09PT09PT0KICAgICAgICAgICAgICAgICAgICAgICAgIGFjY2VzcyBvcHMgICAgICAg
ICAgICAgbm9ybWFsICAgICAgICAgIG5vcm1hbCAgICAgICAgICBOL0EKICAgICAgICAgICAgICAg
ICAgICAgICAgIHN5c2NhbGwgZXJyb3JzICAgICAgICAgLUVJTyAgICAgICAgICAgIC1FUk9GUyAg
ICAgICAgICBOL0EKICAgICAgICAgICAgICAgICAgICAgICAgIG1vdW50IG9wdGlvbiAgICAgICAg
ICAgcncgICAgICAgICAgICAgIHJvICAgICAgICAgICAgICBOL0EKICAgICAgICAgICAgICAgICAg
ICAgICAgIHBlbmRpbmcgZGlyIHdyaXRlICAgICAga2VlcCAgICAgICAgICAgIGtlZXAgICAgICAg
ICAgICBOL0EKICAgICAgICAgICAgICAgICAgICAgICAgIHBlbmRpbmcgbm9uLWRpciB3cml0ZSAg
ZHJvcCAgICAgICAgICAgIGtlZXAgICAgICAgICAgICBOL0EKICAgICAgICAgICAgICAgICAgICAg
ICAgIHBlbmRpbmcgbm9kZSB3cml0ZSAgICAgZHJvcCAgICAgICAgICAgIGtlZXAgICAgICAgICAg
ICBOL0EKICAgICAgICAgICAgICAgICAgICAgICAgIHBlbmRpbmcgbWV0YSB3cml0ZSAgICAga2Vl
cCAgICAgICAgICAgIGtlZXAgICAgICAgICAgICBOL0EKICAgICAgICAgICAgICAgICAgICAgICAg
ID09PT09PT09PT09PT09PT09PT09PT0gPT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PSA9
PT09PT09PQoKQnV0IGZvciBTQklfTkVFRF9GU0NLIGNhc2UsIGlmIHRoZSBpbmNvbnNpc3RlbmN5
IGlzIGRldGVjdGVkIGluIHNwZWNpZmljIGlub2RlLCBjYW4gd2UganVzdApzdG9wIGZ1cnRoZXIg
dXBkYXRlcyBmb3IgdGhpcyBpbm9kZT8gUmF0aGVyIHRoYW4gYWxsIGlub2Rlcz8KClRoYW5rcywK
Cj4gCj4gRG1pdHJ5Cj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
