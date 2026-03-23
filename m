Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187A6EC01DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHkNnCqQhAY8a9IHC2jwq33ynMBF59zvGEOyVFmTuUQ=; b=ajbKJC0OnPOZcerHWHcwJeftVK
	vJBahJp6q+rrgE/ThimWL2cQTzg/ArJBLyZrxzL6D8B1YgFohJZTpSk0w/KLzPFolPH6U1TH1v9rd
	B5NThMzp4jKBvHsVjOvjtREcB6yDRRLDyTXPbyqF50uYyugDaM/0/NjXGW2J7cWKfgII=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w4ePh-0004DJ-Ss;
	Mon, 23 Mar 2026 12:29:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w4ePh-0004D8-4I
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 12:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NxxbDas/ioTG9LjidlJmuEMOm4QWrt1ZA/Vu572ddR8=; b=XnJb5u02HIMhzrykZJ+GboJEs3
 TC858MRENHybXAq+A0xm6LMP40bdLvypJbWoHW4R+E/wrOwueVXCP7npF8/uMO+qodo1HOol0EiQo
 OYXU6lLt7/0TH9m0rJI9jtxzc+S2YMEjNVH9TORhLj856PkPVuacMO/fQXuuUq/keMro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NxxbDas/ioTG9LjidlJmuEMOm4QWrt1ZA/Vu572ddR8=; b=SpR7rQ74yzVcphPGiPfQQL19ot
 XVyJC5SmxWVoKivjcI6sFwx9Z0oCwgqRtSMM/jTQD0Get/7Gc+vtK/A9iujxBJcP5RBnXJVOR0a65
 MtDvJ+shrGcV6f+E+Y9BOkmOHtwmL1CfpjuCrMipDX3xUNV4FsieTc6xseLJBZEZXo6Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w4ePh-0004rN-9u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Mar 2026 12:29:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 091EF42A4C;
 Mon, 23 Mar 2026 12:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E2C4CEF7;
 Mon, 23 Mar 2026 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774268974;
 bh=aVuhB7vvScImTIF5fYAY9I7af9+wp23fh9Y+NGg9Ejo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=lVB1ued8fYJmjkwcSLnUxqMeHJo41UfrEPzFIQLI/2ZUeWc70PAPVrmx+a0Vfd3Qd
 dJMbMRxi2DiPCvvwTVurSPkN0nsShjmZkqAWEpOCgle4wMsY7nfB+yo5rMTmYE62Vh
 ICKwKpCqI9dGcgYrXTCSkM4eO2LMV3LQnzzc+U/LdGa5wuTX3ky4cJbmO27+Qq/oGW
 0OUcOo1A53+pbljsK+4QgkLkdYa9awHw4fB76GMEoze3IcUAHneSRMABt4VkmYogZ5
 /ItmWRWS/R/fw4gnESKxFOoKsw73N2tUsvcYdEDwlvD+RQGyrKNXgP/61z34BKeJLJ
 5b+BURz8xsPiw==
Message-ID: <6ed7d4d6-379b-4df1-9041-c433951018b2@kernel.org>
Date: Mon, 23 Mar 2026 20:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260323120622.3351920-2-monty_pavel@sina.com>
 <20260323120622.3351920-4-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260323120622.3351920-4-monty_pavel@sina.com>
X-Headers-End: 1w4ePh-0004rN-9u
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix fiemap boundary handling
 when read extent cache is incomplete
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
Cc: stable@kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMy8yMy8yNiAyMDowNiwgWW9uZ3BlbmcgWWFuZyB3cm90ZToKPiBGcm9tOiBZb25ncGVuZyBZ
YW5nIDx5YW5neW9uZ3BlbmdAeGlhb21pLmNvbT4KPiAKPiBmMmZzX2ZpZW1hcCgpIGNhbGxzIGYy
ZnNfbWFwX2Jsb2NrcygpIHRvIG9idGFpbiB0aGUgYmxvY2sgbWFwcGluZyBhCj4gZmlsZSwgYW5k
IHRoZW4gbWVyZ2VzIGNvbnRpZ3VvdXMgbWFwcGluZ3MgaW50byBleHRlbnRzLiBJZiB0aGUgbWFw
cGluZwo+IGlzIGZvdW5kIGluIHRoZSByZWFkIGV4dGVudCBjYWNoZSwgbm9kZSBibG9ja3MgZG8g
bm90IG5lZWQgdG8gYmUgcmVhZC4KPiBIb3dldmVyLCBpbiB0aGUgZm9sbG93aW5nIHNjZW5hcmlv
LCBhIGNvbnRpZ3VvdXMgZXh0ZW50IGNhbiBiZSBzcGxpdAo+IGludG8gdHdvIGV4dGVudHM6Cj4g
Cj4gJCBkZCBpZj0vZGV2L3plcm8gb2Y9ZGF0YS4xMjhNIGJzPTFNIGNvdW50PTEyOAo+ICQgbG9z
ZXR1cCAtZiBkYXRhLjEyOE0KPiAkIG1rZnMuZjJmcyAvZGV2L2xvb3AwIC1mCj4gJCBtb3VudCAt
byBtb2RlPWxmcyAvZGV2L2xvb3AwIC9tbnQvZjJmcy8KPiAkIGNkIC9tbnQvZjJmcy8KPiAkIGRk
IGlmPS9kZXYvemVybyBvZj1kYXRhLjcyTSBicz0xTSBjb3VudD03MiAmJiBzeW5jCj4gJCBkZCBp
Zj0vZGV2L3plcm8gb2Y9ZGF0YS40TSBicz0xTSBjb3VudD00ICYmIHN5bmMKPiAkIGRkIGlmPS9k
ZXYvemVybyBvZj1kYXRhLjRNIGJzPTFNIGNvdW50PTIgc2Vlaz0yIGNvbnY9bm90cnVuYyAmJiBz
eW5jCj4gJCBlY2hvIDMgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMKPiAkIGRkIGlmPS9kZXYv
emVybyBvZj1kYXRhLjRNIGJzPTFNIGNvdW50PTIgc2Vlaz0wIGNvbnY9bm90cnVuYyAmJiBzeW5j
Cj4gJCBkZCBpZj0vZGV2L3plcm8gb2Y9ZGF0YS40TSBicz0xTSBjb3VudD0yIHNlZWs9MCBjb252
PW5vdHJ1bmMgJiYgc3luYwo+ICQgZjJmc19pbyBmaWVtYXAgMCAxMDI0IGRhdGEuNE0KPiBGaWVt
YXA6IG9mZnNldCA9IDAgbGVuID0gMTAyNAo+IGxvZ2ljYWwgYWRkci4gICAgcGh5c2ljYWwgYWRk
ci4gICBsZW5ndGggICAgICAgICAgIGZsYWdzCj4gMAkwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAw
MDY0MDAwMDAgMDAwMDAwMDAwMDIwMDAwMCAwMDAwMTAwMAo+IDEJMDAwMDAwMDAwMDIwMDAwMCAw
MDAwMDAwMDA2NjAwMDAwIDAwMDAwMDAwMDAyMDAwMDAgMDAwMDEwMDEKPiAKPiBBbHRob3VnaCB0
aGUgcGh5c2ljYWwgYWRkcmVzc2VzIG9mIHRoZSByYW5nZXMgMO+9njJNQiBhbmQgMk3vvZ40TUIg
YXJlCj4gY29udGlndW91cywgdGhlIG1hcHBpbmcgZm9yIHRoZSAyTe+9njRNQiByYW5nZSBpcyBu
b3QgcHJlc2VudCBpbiBtZW1vcnkuCj4gV2hlbiB0aGUgcGh5c2ljYWwgYWRkcmVzc2VzIGZvciB0
aGUgMO+9njJNQiByYW5nZSBhcmUgdXBkYXRlZCwgbm8gbWVyZ2UKPiBoYXBwZW5zIGJlY2F1c2Ug
dGhlIGFkamFjZW50IG1hcHBpbmcgaXMgbWlzc2luZyBmcm9tIHRoZSBpbi1tZW1vcnkKPiBjYWNo
ZS4gQXMgYSByZXN1bHQsIGZpZW1hcCByZXBvcnRzIHR3byBzZXBhcmF0ZSBleHRlbnRzIGluc3Rl
YWQgb2YgYQo+IHNpbmdsZSBjb250aWd1b3VzIG9uZS4KPiAKPiBUaGUgcm9vdCBjYXVzZSBpcyB0
aGF0IHRoZSByZWFkIGV4dGVudCBjYWNoZSBkb2VzIG5vdCBndWFyYW50ZWUgdGhhdCBhbGwKPiBi
bG9ja3Mgb2YgYW4gZXh0ZW50IGFyZSBwcmVzZW50IGluIG1lbW9yeS4gVGhlcmVmb3JlLCB3aGVu
IHRoZSBleHRlbnQKPiBsZW5ndGggcmV0dXJuZWQgYnkgZjJmc19tYXBfYmxvY2tzX2NhY2hlZCgp
IGlzIHNtYWxsZXIgdGhhbiBtYXhibG9ja3MsCj4gdGhlIHJlbWFpbmluZyBtYXBwaW5ncyBhcmUg
cmV0cmlldmVkIHZpYSBmMmZzX2dldF9kbm9kZV9vZl9kYXRhKCkgdG8KPiBlbnN1cmUgY29ycmVj
dCBmaWVtYXAgZXh0ZW50IGJvdW5kYXJ5IGhhbmRsaW5nLgo+IAo+IENjOiBzdGFibGVAa2VybmVs
Lm9yZwo+IEZpeGVzOiBjZDhmYzUyMjZiZWYgKCJmMmZzOiByZW1vdmUgdGhlIGNyZWF0ZSBhcmd1
bWVudCB0byBmMmZzX21hcF9ibG9ja3MiKQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdwZW5nIFlhbmcg
PHlhbmd5b25ncGVuZ0B4aWFvbWkuY29tPgoKUmV2aWV3ZWQtYnk6IENoYW8gWXUgPGNoYW9Aa2Vy
bmVsLm9yZz4KClRoYW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
