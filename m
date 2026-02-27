Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0288DFEFB7F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+ASqHMDLnnDWnV8ymV+bS4QUZDeplFCCb7Cz7x7j90=; b=DwiN3NbhegRNFtbKAYAoN5PW4H
	9Uzm/AMMHbk5j2wHtttqSwBeDrtc6p/+4Wdx8z7H7hfzSIT+kE4eOCyL1YBxKPz3hYq+ZqLuA0zPI
	YTNJu2RpIMhVGB5TRGkQOHABUnDYZ4325mWIcdg4p1o00ZeDSEcJz8zEH0qZP3i2DieI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vw3Qk-0003oY-KQ;
	Fri, 27 Feb 2026 19:23:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1vw3Qi-0003oS-QW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Feb 2026 19:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHdqdmvCHx5nZfbBe78WXiPSSZr8iRHc+qqUm/nYZHQ=; b=TYyjytfF+Aqu53oYhoQHzwoMzh
 wvgDUFaQS77CdI1mFlY3z5jAZ+DmdnzzzCFtPG9CPtd5umvFQADR27jfPlJmRH+hyc21p3Aq4kR2/
 /fQWY/NWXLx0A2vCs+qNpZIbKGKulrUokqQQ1rSn6smOtXSasltdGTRYzE0uPTGe8hhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HHdqdmvCHx5nZfbBe78WXiPSSZr8iRHc+qqUm/nYZHQ=; b=gxgan4GLSbNviGAjaS2JT0t95r
 PoMrIBKqhPAOiJZPnq9kYD+udGn0juUxywaO1Asf6ieoDYKCAMwe8CxyBL5MVpi77oKj8vmGIQymW
 BuSnh8hjvIn0nN3gKwZCPRpWSrXBcrQUcgviUSAFmrw2r1Q4/YtHh7UMojOPwZ2V66Sw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vw3Qh-0007PC-Ou for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Feb 2026 19:23:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12A186013E;
 Fri, 27 Feb 2026 19:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F2AC19421;
 Fri, 27 Feb 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772220184;
 bh=K3lFIBm1i6SY6zVpJNBCqy97EFlnmv9cZvxdd/ZVO0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VcudyG4hIi+Mzr99pbOYr8tKNQdtQ3J2OBYhPzsEuo8Bd7wurDLpVVxwdsGJeQV68
 JYrR8r598eAeiMNbDs70beqHMCkq6uE2oQA2lN4oHghPPssMbpivtglIUk4aR2Slwt
 zHuhRdpT0j/QjDe07OEEklty6C16kQcoUT5wJxigNdMB0gfrnPd7hd/Iz+lqovagfp
 baA7D4PwFJEmdDM8sH/6fLKQTAyvqNynbPXZLiKNDC/HnpvT0oaiDDrdSMMWN8JUIV
 9kuslcGXc9prH4duQlfh5mSAnUaBTdgdIqh25fzQiUVqxLTvcauuKJkykiQtvSB0rA
 ojPWfwsiQatgA==
Date: Fri, 27 Feb 2026 19:23:02 +0000
To: Yongpeng Yang <monty_pavel@sina.com>
Message-ID: <aaHvFu7NRb00Px05@google.com>
References: <20260203133635.3942502-2-monty_pavel@sina.com>
 <20260203133635.3942502-5-monty_pavel@sina.com>
 <aZ0rNWT8kvhVlID5@google.com>
 <d6fbea59-1212-4426-898e-e9f436bd5972@sina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6fbea59-1212-4426-898e-e9f436bd5972@sina.com>
X-Headers-End: 1vw3Qh-0007PC-Ou
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: fix fiemap boundary handling when
 read extent cache is incomplete
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDIvMjcsIFlvbmdwZW5nIFlhbmcgd3JvdGU6Cj4gT24gMi8yNC8yNiAxMjozOCwgSmFlZ2V1
ayBLaW0gdmlhIExpbnV4LWYyZnMtZGV2ZWwgd3JvdGU6Cj4gPiBPbiAwMi8wMywgWW9uZ3Blbmcg
WWFuZyB3cm90ZToKPiA+PiBGcm9tOiBZb25ncGVuZyBZYW5nIDx5YW5neW9uZ3BlbmdAeGlhb21p
LmNvbT4KPiA+Pgo+ID4+IGYyZnNfZmllbWFwKCkgY2FsbHMgZjJmc19tYXBfYmxvY2tzKCkgdG8g
b2J0YWluIHRoZSBibG9jayBtYXBwaW5nIGEKPiA+PiBmaWxlLCBhbmQgdGhlbiBtZXJnZXMgY29u
dGlndW91cyBtYXBwaW5ncyBpbnRvIGV4dGVudHMuIElmIHRoZSBtYXBwaW5nCj4gPj4gaXMgZm91
bmQgaW4gdGhlIHJlYWQgZXh0ZW50IGNhY2hlLCBub2RlIGJsb2NrcyBkbyBub3QgbmVlZCB0byBi
ZSByZWFkLgo+ID4+IEhvd2V2ZXIsIGluIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8sIGEgY29udGln
dW91cyBleHRlbnQgY2FuIGJlIHNwbGl0Cj4gPj4gaW50byB0d28gZXh0ZW50czoKPiA+Pgo+ID4+
IHJvb3RAdm06L21udC9mMmZzIyBkZCBpZj0vZGV2L3plcm8gb2Y9ZGF0YS40TSBicz0xTSBjb3Vu
dD00ICYmIHN5bmMKPiA+PiByb290QHZtOi9tbnQvZjJmcyMgZGQgaWY9L2Rldi96ZXJvIG9mPWRh
dGEuNE0gYnM9MU0gY291bnQ9MiBzZWVrPTIgY29udj1ub3RydW5jICYmIHN5bmMKPiA+PiByb290
QHZtOi9tbnQvZjJmcyMgZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzICMgZHJvcCAy
TX40TSBleHRlbnQgY2FjaGUKPiA+PiByb290QHZtOi9tbnQvZjJmcyMgZGQgaWY9L2Rldi96ZXJv
IG9mPWRhdGEuNE0gYnM9MU0gY291bnQ9MiBzZWVrPTAgY29udj1ub3RydW5jICYmIHN5bmMKPiA+
PiByb290QHZtOi9tbnQvZjJmcyMgZjJmc19pbyBmaWVtYXAgMCAxMDI0IGRhdGEuNE0KPiA+PiBG
aWVtYXA6IG9mZnNldCA9IDAgbGVuID0gMTAyNAo+ID4+IGxvZ2ljYWwgYWRkci4gICAgcGh5c2lj
YWwgYWRkci4gICBsZW5ndGggICAgICAgICAgIGZsYWdzCj4gPj4gMAkwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDAwMDY0MDAwMDAgMDAwMDAwMDAwMDIwMDAwMCAwMDAwMTAwMAo+ID4+IDEJMDAwMDAw
MDAwMDIwMDAwMCAwMDAwMDAwMDA2NjAwMDAwIDAwMDAwMDAwMDAyMDAwMDAgMDAwMDEwMDEKPiA+
Pgo+ID4+IEFsdGhvdWdoIHRoZSBwaHlzaWNhbCBhZGRyZXNzZXMgb2YgdGhlIHJhbmdlcyAw772e
Mk1CIGFuZCAyTe+9njRNQiBhcmUKPiA+PiBjb250aWd1b3VzLCB0aGUgbWFwcGluZyBmb3IgdGhl
IDJN772eNE1CIHJhbmdlIGlzIG5vdCBwcmVzZW50IGluIG1lbW9yeS4KPiA+PiBXaGVuIHRoZSBw
aHlzaWNhbCBhZGRyZXNzZXMgZm9yIHRoZSAw772eMk1CIHJhbmdlIGFyZSB1cGRhdGVkLCBubyBt
ZXJnZQo+ID4+IGhhcHBlbnMgYmVjYXVzZSB0aGUgYWRqYWNlbnQgbWFwcGluZyBpcyBtaXNzaW5n
IGZyb20gdGhlIGluLW1lbW9yeQo+ID4+IGNhY2hlLiBBcyBhIHJlc3VsdCwgZmllbWFwIHJlcG9y
dHMgdHdvIHNlcGFyYXRlIGV4dGVudHMgaW5zdGVhZCBvZiBhCj4gPj4gc2luZ2xlIGNvbnRpZ3Vv
dXMgb25lLgo+ID4+Cj4gPj4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0aGUgcmVhZCBleHRlbnQg
Y2FjaGUgZG9lcyBub3QgZ3VhcmFudGVlIHRoYXQgYWxsCj4gPj4gYmxvY2tzIG9mIGFuIGV4dGVu
dCBhcmUgcHJlc2VudCBpbiBtZW1vcnkuIFRoZXJlZm9yZSwgd2hlbiB0aGUgZXh0ZW50Cj4gPj4g
bGVuZ3RoIHJldHVybmVkIGJ5IGYyZnNfbWFwX2Jsb2Nrc19jYWNoZWQoKSBpcyBzbWFsbGVyIHRo
YW4gbWF4YmxvY2tzLAo+ID4+IHRoZSByZW1haW5pbmcgbWFwcGluZ3MgYXJlIHJldHJpZXZlZCB2
aWEgZjJmc19nZXRfZG5vZGVfb2ZfZGF0YSgpIHRvCj4gPj4gZW5zdXJlIGNvcnJlY3QgZmllbWFw
IGV4dGVudCBib3VuZGFyeSBoYW5kbGluZy4KPiA+Pgo+ID4+IEZpeGVzOiBjZDhmYzUyMjZiZWYg
KCJmMmZzOiByZW1vdmUgdGhlIGNyZWF0ZSBhcmd1bWVudCB0byBmMmZzX21hcF9ibG9ja3MiKQo+
ID4+IFNpZ25lZC1vZmYtYnk6IFlvbmdwZW5nIFlhbmcgPHlhbmd5b25ncGVuZ0B4aWFvbWkuY29t
Pgo+ID4+IC0tLQo+ID4+ICBmcy9mMmZzL2RhdGEuYyB8IDE0ICsrKysrKysrKysrKy0tCj4gPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4+Cj4g
Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPiA+PiBpbmRl
eCA0MmYxNWZkOWM2OGUuLmVlZGFkY2NmODZiYiAxMDA2NDQKPiA+PiAtLS0gYS9mcy9mMmZzL2Rh
dGEuYwo+ID4+ICsrKyBiL2ZzL2YyZnMvZGF0YS5jCj4gPj4gQEAgLTE2MjMsOCArMTYyMywxOCBA
QCBpbnQgZjJmc19tYXBfYmxvY2tzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmMmZzX21h
cF9ibG9ja3MgKm1hcCwgaW50IGZsYWcpCj4gPj4gIAlsZnNfZGlvX3dyaXRlID0gKGZsYWcgPT0g
RjJGU19HRVRfQkxPQ0tfRElPICYmIGYyZnNfbGZzX21vZGUoc2JpKSAmJgo+ID4+ICAJCQkJbWFw
LT5tX21heV9jcmVhdGUpOwo+ID4+ICAKPiA+PiAtCWlmICghbWFwLT5tX21heV9jcmVhdGUgJiYg
ZjJmc19tYXBfYmxvY2tzX2NhY2hlZChpbm9kZSwgbWFwLCBmbGFnKSkKPiA+PiAtCQlnb3RvIG91
dDsKPiA+PiArCWlmICghbWFwLT5tX21heV9jcmVhdGUpIHsKPiA+PiArCQlpZiAoZjJmc19tYXBf
YmxvY2tzX2NhY2hlZChpbm9kZSwgbWFwLCBmbGFnKSkgewo+ID4+ICsJCQlpZiAobWFwLT5tX2xl
biA9PSBtYXhibG9ja3MpCj4gPj4gKwkJCQlnb3RvIG91dDsKPiA+PiArCQkJZWxzZSB7Cj4gPj4g
KwkJCQlwZ29mcyA9CShwZ29mZl90KW1hcC0+bV9sYmxrICsgbWFwLT5tX2xlbjsKPiA+PiArCQkJ
CWVuZCA9IG1hcC0+bV9sYmxrICsgbWF4YmxvY2tzOwo+ID4+ICsJCQkJb2ZzID0gbWFwLT5tX2xl
bjsKPiA+PiArCQkJCWdvdG8gbmV4dF9kbm9kZTsKPiA+PiArCQkJfQo+ID4+ICsJCX0KPiA+PiAr
CX0KPiA+IAo+ID4gVGhpcyBwYXRjaCBtYWtlcyBhIHN5c3RlbSBwYW5pYy4KPiAKPiBJIGhhdmUg
ZG9uZSBzb21lIHRlc3RpbmcgYW5kIG9ubHkgb2JzZXJ2ZWQgdGhlIHBhbmljIGluIHRoZQo+IGYy
ZnNfd3JpdGVfZW5kX2lvKCkgcGF0aC4gU3l6Ym90IGhhcyBhbHNvIHJlcG9ydGVkIGl0Ogo+IGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD02ZTRjYjFjYWM1ZWZjOTZlYTBj
YQo+IE15IHByb3Bvc2VkIGZpeCBpcyBoZXJlOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDIyNzA3MzA1Mi4zOTQwOTU4LTItbW9udHlfcGF2ZWxAc2luYS5jb20vCj4gCj4gSXMg
dGhpcyB0aGUgc2FtZSBpc3N1ZT8KClllYWgsIEkgdGhpbmsgc28uCgo+IAo+IFRoYW5rcwo+IFlv
bmdwZW5nLAo+IAo+ID4gCj4gPj4gIAo+ID4+ICAJbWFwLT5tX2JkZXYgPSBpbm9kZS0+aV9zYi0+
c19iZGV2Owo+ID4+ICAJbWFwLT5tX211bHRpZGV2X2RpbyA9Cj4gPj4gLS0gCj4gPj4gMi40My4w
Cj4gPiAKPiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiA+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gPiBMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+ID4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0
CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
