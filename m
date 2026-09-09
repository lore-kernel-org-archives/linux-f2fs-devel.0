Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED7AC79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VtiNkZmfQNobTRo/nxLqKwaBVegF6ZuTQ7Y12kzkf0o=; b=KZvgquhrRr1qX/xN9G4eZJA74k
	Ow//ZqpP6I44GNrqtmi2QVV0HyclE6VAWIDg/npitbCQyMc/evr/FaRrGVRZL4EzIBROO8KinxskC
	NKI4SYuNdylQRrynncAb/cAKruPJnuC0c2+5vcwxVJWjlxQ4RWY7/opsqhkP4MHW9ROc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4GlI-0003Pi-Ug;
	Wed, 09 Sep 2026 11:46:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jnhuang95@gmail.com>) id 1x4GlH-0003PZ-Co
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3di0iRlJ3KBrWFtySNtqCBIHfTnI7j7b8HqWFSCqTiA=; b=i1wWXn8fR31k5zSxopJ0EqmPsK
 9JKH9kyM3iM809oS74fcZOzSQdRAR8TYOPQdUyBLjo6IqDHWb6NT+KYP+IuzdTEeINa2VW9Gja8PX
 MwZHWFO4aPkogOuHUHkM9hWRh6mg9ro+fImiDE9/C9/vqT0vJ9LM55ACjIbcU94trlvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3di0iRlJ3KBrWFtySNtqCBIHfTnI7j7b8HqWFSCqTiA=; b=EJjX5YcjzdJmIoR39cKxspSe3A
 taCSgG2Y1KUq7GB960jNMDfd3WnC+6sntGKEa2Uoj1f3BoVLn+VxSunqJS/bm0zIcryleTAQ7ocTU
 6/Rum6pJhPKy4YtL1jwZuao29SzUV6dkh1jmKoKsdjsjU3rR1cIly8NI/JZsh+t3NdgQ=;
Received: from mail-oi2-f12.google.com ([74.125.231.204])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4GlG-0007oG-1g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:46:42 +0000
Received: by mail-oi2-f12.google.com with SMTP id
 5614622812f47-4b37a39a42dso621590b6e.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788954396; cv=none;
 d=google.com; s=arc-20260327;
 b=QxiBR1EnoTm4KbguySEa56qTU9soL+bMPf8QOdmzSI3VubBozfGzBwf/iTqq3Z1Jqu
 RkhvvZwaXjESpfBs7tmMeDXEC7moFgNq4oPrAj6Yxh/jtuMra3mrF/4P/rodrn8iKA4b
 YNzKWMC52IgGVBLI4t78n0yVlg+nN0SbPTkk2soBwA54cklmGfXXN6tpzXVlNXUetHc6
 UUX0rgd7Ae3+CZqKBGUe3NkabxDrln86uTUIrsy6zGT6srhsqr1vixqzjXn06P5wMMTz
 rJ+NHg9PkJaipIQHFu+09zR/zTgJIOeOuFWCxGLJKkaLR699j2z8zylkU24AXL0nkUke
 uqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3di0iRlJ3KBrWFtySNtqCBIHfTnI7j7b8HqWFSCqTiA=;
 fh=HCooI6u6mh38PmARIKt7KDkV0snsb/o0VmO1BSBuTrA=;
 b=OIh506qzfUFyqxl4yqIwvuv3QQoBxvCvFk6De6kivNiEp5tosLK/0SJgCseKoeaq/o
 2mqg/E4UD1srrFXTNFvQgO3oIzQvcDnpVuOyDJeKgjb70VWov35CJeMokdZqS3bZ22RV
 cxzYv+CP3/NyBiH/Yjfp11juPIBjxVujwZMoD3uVBhSmZNeQofMVuProQVlDS9Q1yEwf
 JgjvYS0Tf9WH9eyQc5Iw1miALkuFd+dNVjBrcXPX56+oX/9/Qif59Um3/ppoCLbMlGk+
 SkK1O14Kj+rYL6etqOoGJYe/WzsPZQ9lhjnl/hMhAQb33ff3SV8Tozpy/W+oaNkKnLVB
 kyJA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788954396; x=1789559196; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3di0iRlJ3KBrWFtySNtqCBIHfTnI7j7b8HqWFSCqTiA=;
 b=e1ymMG75Km54TWUNDSFO1NwSxsjvv5P7N/kgroB0KvlLVwHTQ8kLIX6qfuR1xQPH0e
 dSb6THtxeoVph5Ni29+yQsDfhdW9Etfg2tXHCZsc1vt+uVLW5BQopP3XK8OfkmyyNMct
 +L72FxZ3rVZ0oXQ3nuSFwhKdq+3+HUUszBKqJtiYlIDPmYMPL7cy5zT4mUU+fL0fSDz3
 LirXMgot8OydnQ9RfGXTSz994cNzmbNxKOy8UIDs/x0Tp+9tDKN9n/VsqQoeI/4YmMGH
 Rfcz7Ubk7OUdHcZ2uQPARhbI319MstywDBjECQninIZ7Dj4WexZPWM0z5U0We2G8rJ+e
 WqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954396; x=1789559196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3di0iRlJ3KBrWFtySNtqCBIHfTnI7j7b8HqWFSCqTiA=;
 b=lO2KlmBePcj5u3sqNz9jaOqxLXtcZT3AFcyqRfRIyDWPYQ0d/ftkb2NP04PSriiD+4
 RFljP0G4ClAo5fIiU9OqnlxuNalojJ5kknreVT6youYFjvWXwGD2GQx5arHHgNleV1sM
 oeB4reQnjH46YtBEEdExNmIoi8/OLByipXwGNIpybolPKwsVUK9PYqDoS09kflN+hdVo
 IYYTJ8r9ezFml0ifM3pI6npdNAaCKN+9PtcaqmPpTbhGHdtWDMA4Agn9QCN/DMgjJwQ+
 +wnmMbsg+4FzwAJ8kqrA173b1jCql4fnly/USi0Bm/SI7lqxBW9EKeoHy575mhddtxF0
 ne+g==
X-Gm-Message-State: AFuF++lQhB33JppqsEIxXe4TnOqbc/6jAaKIRrCzo66fU+FFfcw2BVCU
 yS9DYa9XcOb1p9VzQQL4xte0e+AWthZ6b8LWHeRL6xHoJX884pT9+KcTn8H4yDHnEHDj7Bzsrri
 pvkF8ciXHLi/O5pQ96ApF0kE8kVEE/mEEMP2MNyI=
X-Gm-Gg: AYBFou34qU+02QV+xqQzLTKw87n8F5RSwBDEmavuDal3aNDRxOF8YGnu00xPvBeEn2U
 ghbhWVJQXABq5h4l33sJQBVAGVC2LFXZn8VJzq2j+/8xWWbazw+AeKeFsajZn1AKw7ugbC+lWHi
 u3UmBZHgFxmXiXH/dvzM9r7jiQfKBaBn+siVCqDkP/dA7Oki+i57aHi77RASrEtIh+elaPlm8Iy
 M7robTc6rGC7Bj66BQ6jS3vVu40jJe0FcbfvQulBLgx2fgsTfxiGolmmWjptMBuOBkqUUjuEO+t
 cRUwEiTNnP/pcfoiryRVqIwLSe12iak74D2fmJUkCrjiOyYxSpNij1A=
X-Received: by 2002:a05:6820:c93:b0:6b5:ec3f:497d with SMTP id
 006d021491bc7-6bc26d619b9mr4409908eaf.24.1788954396383; Wed, 09 Sep 2026
 04:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260908034630.615415-1-jnhuang95@gmail.com>
 <9c971fe8-1f78-44a6-94a2-786555da6a05@kernel.org>
In-Reply-To: <9c971fe8-1f78-44a6-94a2-786555da6a05@kernel.org>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Wed, 9 Sep 2026 19:46:24 +0800
X-Gm-Features: AcwNN1UT3aURJK3NC__UD6nDrUafwpFMKII_6FKmtQTDRb12NKsH1naBWmT4V08
Message-ID: <CAJfKizojb0VAboo8v=ouzOVNRqy=xGm4Nt3suDZwu0E698G8XA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x4GlG-0007oG-1g
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix stale lock holder on
 remount failure
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiDkuo4yMDI25bm0OeaciDnml6XlkajkuIkgMTk6MTXl
hpnpgZPvvJoKPgo+IE9uIDkvOC8yNiAxMTo0NiwgSmlhbmFuIEh1YW5nIHdyb3RlOgo+ID4gRjJG
UyByZW1vdW50IGNhbiBmYWlsIHdoaWxlIGR1cGxpY2F0aW5nIGEgam91cm5hbGxlZCBxdW90YSBm
aWxlIG5hbWUuCj4gPgo+ID4gZjJmc19yZW1vdW50KCkKPiA+IC0gc2JpLT51bW91bnRfbG9ja19o
b2xkZXIgPSBjdXJyZW50Cj4gPiAtIGtzdHJkdXAoRjJGU19PUFRJT04oc2JpKS5zX3FmX25hbWVz
W2ldKQo+ID4gICA6IGZhaWxzCj4gPiAtIGZyZWUgcHJldmlvdXNseSBkdXBsaWNhdGVkIG5hbWVz
Cj4gPiAtIHJldHVybiAtRU5PTUVNCj4gPgo+ID4gVGhlIGRpcmVjdCByZXR1cm4gbGVhdmVzIHVt
b3VudF9sb2NrX2hvbGRlciBwb2ludGluZyBhdCB0aGUgZmFpbGVkCj4gPiByZW1vdW50IGNvbnRl
eHQuICBBIGxhdGVyIGNoZWNrcG9pbnQgbWF5IHRoZW4gd3JvbmdseSB0cmVhdCBhbm90aGVyCj4g
PiBjb250ZXh0IGFzIHRoZSBzX3Vtb3VudCBsb2NrIGhvbGRlci4KPiA+Cj4gPiBDbGVhciB1bW91
bnRfbG9ja19ob2xkZXIgYmVmb3JlIHJldHVybmluZyAtRU5PTUVNLgo+ID4KPiA+IEZpeGVzOiBl
Yjg1YzI0MTBkNmYgKCJmMmZzOiBxdW90YTogZml4IHRvIGF2b2lkIHdhcm5pbmcgaW4gZHF1b3Rf
d3JpdGViYWNrX2RxdW90cygpIikKPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5hbiBIdWFuZyA8am5o
dWFuZzk1QGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGZzL2YyZnMvc3VwZXIuYyB8IDEgKwo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9m
MmZzL3N1cGVyLmMgYi9mcy9mMmZzL3N1cGVyLmMKPiA+IGluZGV4IDEzMTRiNmNjY2VkOS4uZTI0
OWVhMTliZWFmIDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9zdXBlci5jCj4gPiArKysgYi9mcy9m
MmZzL3N1cGVyLmMKPiA+IEBAIC0yODY0LDYgKzI4NjQsNyBAQCBzdGF0aWMgaW50IF9fZjJmc19y
ZW1vdW50KHN0cnVjdCBmc19jb250ZXh0ICpmYywgc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKPiA+
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoIW9yZ19tb3VudF9vcHQuc19xZl9uYW1lc1tpXSkg
ewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IGk7IGor
KykKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUob3JnX21v
dW50X29wdC5zX3FmX25hbWVzW2pdKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNiaS0+dW1vdW50X2xvY2tfaG9sZGVyID0gTlVMTDsKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+Cj4gSG93IGFib3V0IGFkZGluZyByZXN0b3JlX2hv
bGRlciBsYWJlbCwgY2FsbCBnb3RvIHJlc3RvcmVfaG9sZGVyIGhlcmU/Cj4KPiBUaGFua3MsCgpV
cGRhdGVkIGluIHYyLAoKVGhhbmtzLAoKPgo+ID4gICAgICAgICAgICAgICAgICAgICAgIH0KPiA+
ICAgICAgICAgICAgICAgfSBlbHNlIHsKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
