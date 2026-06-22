Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D69CD98F2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QuNaJA8/Pz1laNHoQb8VFQcr6fisznAdISfAxUecT+g=; b=gzhS5OSeEg26nuAT7WinoP6eQp
	JDw4/m2MO7njKb263rrK08qCjODnNYdz1vVvLYNsy9hMRsblzHPegqLz2l2nOY4UpftX5vHpW7QiU
	iaSyhMPx60ZwNJyZqC08+UbeeZ6EGBEEbL3N3ufuUFDgRZsSkayO7NObYDaQc+b6X7jo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbkh0-0003F0-JN;
	Mon, 22 Jun 2026 19:52:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wbkgz-0003Eu-Gu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 19:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A5CPMd/xpnKIzj5zdrxz7lPo5mrrWBvT5DkNNKpntEo=; b=fi1MoAspDe+klKt3g0IYkQJzbT
 9snMjaYjtDl3IKF7Xtv0EWPTEFrfzStHgqticaIjnFeOAeg5QjwvtNNp77zjSlGBeSzq8aTHkVZuP
 MftfPqEkpVAmq45hag04mqL1os6MZzioAjVU9MM+G73qEtYs9J8h5Y0lQzeWJHbKnfRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A5CPMd/xpnKIzj5zdrxz7lPo5mrrWBvT5DkNNKpntEo=; b=DSMdXemLiAaKK7hhiSyTFBs/yJ
 UDfDrInMr9zeZda8Xc5DrtZPI7c3cn9t9b8PEek9Uic0pVZmUFjYjS/fVDBb2MyFw+vdc4/U78S05
 IrB/XqYDSQXwM3ZY7+gaIB9riGSkDRlVpmdZlDCWfhqdJyfRrPh7QcUQgH4MC1UUdvuo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbkgx-0003lB-5z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 19:52:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB451601F3;
 Mon, 22 Jun 2026 19:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE901F000E9;
 Mon, 22 Jun 2026 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782157937;
 bh=A5CPMd/xpnKIzj5zdrxz7lPo5mrrWBvT5DkNNKpntEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aLH1zyEe/nBHecxIh4UM7KQXJ/DFPF/r9jyWSgFoxcKir1j8jH4xuwNmD92B/mwBU
 BE/lbTLqjFiaThgPdFyx8m6LjrAd2ECW719NLUN1NwiDTewX63XMSfVhXPVbTj1DZ6
 SRy/KbJn0BwAzae8JctDkUd1TCNnDrnsevyZeUkLazhqVzJG0yInDIF4FtwgxeFqL0
 eTIslkousKrMNWayFh4qvi2jdskublFEhW350AUtAHug7g+EhI6FnLLWO1EvybZpRI
 eltJhHiHwRiVP4kuSO6OPJ9PPyafG46yT+PBRWciiscXTHEcjiHb3kyilAtkycYr7a
 3NP4DIqC+wlBA==
Date: Mon, 22 Jun 2026 19:52:15 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ajmSbyFVH3ZRl1_e@google.com>
References: <20260510042336.94751-1-kartikey406@gmail.com>
 <CADhLXY57Oi+5+1PNb3ywnfVFV3iCHd-OFmpBS0=ooq0nFuKxiA@mail.gmail.com>
 <f8f1d255-3f45-43c8-bf7d-e9b12401e8b3@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8f1d255-3f45-43c8-bf7d-e9b12401e8b3@kernel.org>
X-Headers-End: 1wbkgx-0003lB-5z
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: initialize ino_entry_info before
 checkpoint load
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
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, stable@kernel.org,
 syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDYvMjIsIENoYW8gWXUgd3JvdGU6Cj4gT24gNi8yMS8yNiAxNjoxOCwgRGVlcGFuc2h1IEth
cnRpa2V5IHdyb3RlOgo+ID4gT24gU3VuLCBNYXkgMTAsIDIwMjYgYXQgOTo1M+KAr0FNIERlZXBh
bnNodSBLYXJ0aWtleQo+ID4gPGthcnRpa2V5NDA2QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+IAo+
ID4gPiBXaGVuIGYyZnNfZ2V0X3ZhbGlkX2NoZWNrcG9pbnQoKSBmYWlscyBkdXJpbmcgbW91bnQg
KGUuZy4gZHVlIHRvIGFuCj4gPiA+IGludmFsaWQgY2hlY2twb2ludCBDUkMgb24gYSBtYWxmb3Jt
ZWQgaW1hZ2UpLCBmMmZzX2ZpbGxfc3VwZXIoKSB0YWtlcwo+ID4gPiBhbiBlcnJvciBwYXRoIHRo
YXQgZXZlbnR1YWxseSBjYWxscyBpcHV0KCkgb24gdGhlIHJvb3QgaW5vZGUuIFRoaXMKPiA+ID4g
aW52b2tlcyBmMmZzX2Ryb3BfaW5vZGUoKSAtPiBmMmZzX2V4aXN0X3dyaXR0ZW5fZGF0YSgpLCB3
aGljaCBhY3F1aXJlcwo+ID4gPiBzYmktPmltW10tPmlub19sb2NrLiBIb3dldmVyLCBmMmZzX2lu
aXRfaW5vX2VudHJ5X2luZm8oKSBoYXMgbm90IHJ1bgo+ID4gPiB5ZXQgYXQgdGhpcyBwb2ludCwg
c28gdGhlIHNwaW5sb2NrIGlzIHVuaW5pdGlhbGl6ZWQgYW5kIGxvY2tkZXAKPiA+ID4gY29tcGxh
aW5zOgo+ID4gPiAKPiA+ID4gICAgRjJGUy1mcyAobG9vcDApOiBpbnZhbGlkIGNyYyB2YWx1ZQo+
ID4gPiAgICBGMkZTLWZzIChsb29wMCk6IEZhaWxlZCB0byBnZXQgdmFsaWQgRjJGUyBjaGVja3Bv
aW50Cj4gPiA+ICAgIElORk86IHRyeWluZyB0byByZWdpc3RlciBub24tc3RhdGljIGtleS4KPiA+
ID4gICAgVGhlIGNvZGUgaXMgZmluZSBidXQgbmVlZHMgbG9ja2RlcCBhbm5vdGF0aW9uLCBvciBt
YXliZQo+ID4gPiAgICB5b3UgZGlkbid0IGluaXRpYWxpemUgdGhpcyBvYmplY3QgYmVmb3JlIHVz
ZT8KPiA+ID4gICAgLi4uCj4gPiA+ICAgICBmMmZzX2V4aXN0X3dyaXR0ZW5fZGF0YSsweDUzLzB4
OTAgZnMvZjJmcy9jaGVja3BvaW50LmM6Nzg3Cj4gPiA+ICAgICBmMmZzX2Ryb3BfaW5vZGUrMHhk
YS8weGJmMCBmcy9mMmZzL3N1cGVyLmM6MTg1Mgo+ID4gPiAgICAgaXB1dCsweDY1MS8weGU4MCBm
cy9pbm9kZS5jOjIwMDkKPiA+ID4gICAgIGYyZnNfZmlsbF9zdXBlcisweDYwNDcvMHg3ODUwIGZz
L2YyZnMvc3VwZXIuYzo1NDYxCj4gPiA+IAo+ID4gPiBNb3ZlIGYyZnNfaW5pdF9pbm9fZW50cnlf
aW5mbygpIHRvIGJlZm9yZSBmMmZzX2dldF92YWxpZF9jaGVja3BvaW50KCkKPiA+ID4gc28gdGhh
dCBzYmktPmltW10gaXMgYWx3YXlzIGZ1bGx5IGluaXRpYWxpemVkIGJlZm9yZSBhbnkgZXJyb3Ig
cGF0aAo+ID4gPiBjYW4gdHJpZ2dlciBpcHV0KCkgLT4gZjJmc19kcm9wX2lub2RlKCkuIFRoZSBp
bml0IGZ1bmN0aW9uIG9ubHkKPiA+ID4gZGVwZW5kcyBvbiByYXcgc3VwZXJibG9jayBmaWVsZHMg
KEJMS1NfUEVSX1NFRywgRjJGU19DUF9QQUNLUywKPiA+ID4gTlJfQ1VSU0VHX1BFUlNJU1RfVFlQ
RSwgX19jcF9wYXlsb2FkKSwgd2hpY2ggYXJlIHBvcHVsYXRlZCB3ZWxsCj4gPiA+IGJlZm9yZSBj
aGVja3BvaW50IGxvYWQsIHNvIHRoZSBtb3ZlIGlzIHNhZmUuCj4gPiA+IAo+ID4gPiBGaXhlczog
MzA2M2M4MDc3NmUzICgiZjJmczogYW5vdGhlciB3YXkgdG8gc2V0IGxhcmdlIGZvbGlvIGJ5IHJl
bWVtYmVyaW5nIGlub2RlIG51bWJlciIpCj4gPiA+IENjOiBzdGFibGVAa2VybmVsLm9yZwo+ID4g
PiBSZXBvcnRlZC1ieTogc3l6Ym90K2VlYzhmMjY5M2Q3MTM4NmJkNjAwQHN5emthbGxlci5hcHBz
cG90bWFpbC5jb20KPiA+ID4gQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9i
dWc/ZXh0aWQ9ZWVjOGYyNjkzZDcxMzg2YmQ2MDAKPiA+ID4gVGVzdGVkLWJ5OiBzeXpib3QrZWVj
OGYyNjkzZDcxMzg2YmQ2MDBAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBEZWVwYW5zaHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdtYWlsLmNvbT4KPiA+ID4g
LS0tCj4gPiA+IENoYW5nZXMgaW4gdjI6Cj4gPiA+ICAgLSBBZGQgRml4ZXM6IHRhZyAoc3VnZ2Vz
dGVkIGJ5IENoYW8gWXUpCj4gPiA+ICAgLSBBZGQgQ2M6IHN0YWJsZUBrZXJuZWwub3JnCj4gPiA+
IC0tLQo+ID4gPiAgIGZzL2YyZnMvc3VwZXIuYyB8IDkgKysrKysrKy0tCj4gPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRp
ZmYgLS1naXQgYS9mcy9mMmZzL3N1cGVyLmMgYi9mcy9mMmZzL3N1cGVyLmMKPiA+ID4gaW5kZXgg
YzZhZmRiZDZlMWNkLi42YTIzMWE1YjBkNjIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL2YyZnMvc3Vw
ZXIuYwo+ID4gPiArKysgYi9mcy9mMmZzL3N1cGVyLmMKPiA+ID4gQEAgLTUxNDAsNiArNTE0MCwx
MyBAQCBzdGF0aWMgaW50IGYyZnNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBz
dHJ1Y3QgZnNfY29udGV4dCAqZmMpCj4gPiA+ICAgICAgICAgICAgICAgICAgZ290byBmcmVlX3Bh
Z2VfYXJyYXlfY2FjaGU7Cj4gPiA+ICAgICAgICAgIH0KPiA+ID4gCj4gPiA+ICsgICAgICAgLyoK
PiA+ID4gKyAgICAgICAgKiBJbml0aWFsaXplIGlubyBlbnRyeSBpbmZvIGVhcmx5IHNvIGYyZnNf
ZHJvcF9pbm9kZSAtPgo+ID4gPiArICAgICAgICAqIGYyZnNfZXhpc3Rfd3JpdHRlbl9kYXRhIGNh
biBzYWZlbHkgdGFrZSBpbS0+aW5vX2xvY2sgaWYgbW91bnQKPiA+ID4gKyAgICAgICAgKiBmYWls
cyBhZnRlciB0aGlzIHBvaW50IGFuZCB0cmlnZ2VycyBpcHV0IG9uIGNsZWFudXAuCj4gPiA+ICsg
ICAgICAgICovCj4gPiA+ICsgICAgICAgZjJmc19pbml0X2lub19lbnRyeV9pbmZvKHNiaSk7Cj4g
PiA+ICsKPiA+ID4gICAgICAgICAgZXJyID0gZjJmc19nZXRfdmFsaWRfY2hlY2twb2ludChzYmkp
Owo+ID4gPiAgICAgICAgICBpZiAoZXJyKSB7Cj4gPiA+ICAgICAgICAgICAgICAgICAgZjJmc19l
cnIoc2JpLCAiRmFpbGVkIHRvIGdldCB2YWxpZCBGMkZTIGNoZWNrcG9pbnQiKTsKPiA+ID4gQEAg
LTUxODQsOCArNTE5MSw2IEBAIHN0YXRpYyBpbnQgZjJmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykKPiA+ID4gCj4gPiA+ICAgICAgICAg
IGYyZnNfaW5pdF9leHRlbnRfY2FjaGVfaW5mbyhzYmkpOwo+ID4gPiAKPiA+ID4gLSAgICAgICBm
MmZzX2luaXRfaW5vX2VudHJ5X2luZm8oc2JpKTsKPiA+ID4gLQo+ID4gPiAgICAgICAgICBmMmZz
X2luaXRfZnN5bmNfbm9kZV9pbmZvKHNiaSk7Cj4gPiA+IAo+ID4gPiAgICAgICAgICAvKiBzZXR1
cCBjaGVja3BvaW50IHJlcXVlc3QgY29udHJvbCBhbmQgc3RhcnQgY2hlY2twb2ludCBpc3N1ZSB0
aHJlYWQgKi8KPiA+ID4gLS0KPiA+ID4gMi40My4wCj4gPiA+IAo+ID4gCj4gPiBIaSBDaGFvLAo+
ID4gCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoLiBUaGlz
IGlzIGFscmVhZHkgIlJldmlld2VkLWJ5OiIgeW91Lgo+IAo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phZWdldWsvZjJmcy5naXQvY29tbWl0Lz9oPWRl
di10ZXN0JmlkPTA2NWE2ZjhjZDIzYTkyOTdiNTQzZGNlYzkxM2ZlYjNjYjc4N2EyNWUKPiAKPiBJ
dCB3YXMgbWVyZ2VkLCBob3dldmVyLCBJIHRoaW5rIGl0IHNob3VsZCBiZSByZXZlcnRlZCBiZWNh
dXNlIGNvbW1pdCAzMDYzYzgwNzc2ZTMKPiAoImYyZnM6IGFub3RoZXIgd2F5IHRvIHNldCBsYXJn
ZSBmb2xpbyBieSByZW1lbWJlcmluZyBpbm9kZSBudW1iZXIiKSB3YXMgcmVtb3ZlZAo+IGZyb20g
ZGV2IGJyYW5jaCwgd2Ugd29uJ3QgY2FsbCBmMmZzX2V4aXN0X3dyaXR0ZW5fZGF0YSgpIGZyb20g
ZjJmc19kcm9wX2lub2RlKCkuCgpUaGFua3MgZm9yIGhlYWRzLXVwLiBMZXQgbWUgZHJvcCB0aGlz
IGZyb20gLWRldiBhcyBlbWVyZ2VuY3kgY2FsbCwgc2luY2UgdGhlCnByb2JsZW1ldGljIHBhdGNo
IHdhcyBub3QgbGFuZGVkIGF0IGFsbC4KCj4gCj4gVGhhbmtzLAo+IAo+ID4gCj4gPiBQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgYW55dGhpbmcgbmVlZGVkIGZyb20gbXkgc2lkZS4KPiA+IAo+ID4gVGhh
bmtzCj4gPiAKPiA+IERlZXBhbnNodSBLYXJ0aWtleQo+IAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0
CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
