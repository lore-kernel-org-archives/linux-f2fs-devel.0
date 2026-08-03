Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171E5C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0Ax4QNdnlLwtSRzHBd8UGvoTN36ESsimP2PjWbGL4I=; b=AvuxOawS9X6efx94Dii6AZ4ShW
	f4WDjD/OyZ/trcf++Kj6rL1vAPz3UlyfuFfm9xuZe4mr0N3hG5wmtnpDp7HGp/w/ieOOYrDQrtEap
	pio5JNd3dHtuDBFR2BJ83G9q7CkLVpeaTCbHLOzzeCGEjfsDXMArRmzRZ6T/4wvrE9+s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqogW-00029R-AN;
	Mon, 03 Aug 2026 09:10:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqogV-00029K-2z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2oqzU058dzalitvaU7FmatWsZJscz5TxwjziifaQTk=; b=i+KSQuvCr6iQi+nbW9uq9PWdOE
 tmzVfMMeprkzL+VUbp8jRNHbddkZKFL0acFoevIy+BUQqJjY6dy/rL03t6mWZRajaWS5s8e5V8hIc
 BuR7rqGICXEmqoLl5cBiSRBOGho0oNRdDPsu4WOs/HWFONajbjmspqcf2DaYmYANyx5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x2oqzU058dzalitvaU7FmatWsZJscz5TxwjziifaQTk=; b=b7nYaKjd0Hj2LHtsFFpy+mwtyq
 7zQqJHch7H9B+KDjdMK8YV+Q1efmPySKSeUSf2vliNofducY/ZvMPFj/uuElKqw1gk9VO8Yzt5vpt
 /cvZmb/y3WQIyiGxaxpXyfA5U04v2U+FdvCqRXygDqfx+7V+CKZ/eEDHWUZl7lwMkgBI=;
Received: from mail-lj1-f171.google.com ([209.85.208.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqogU-0002yd-W9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:10:11 +0000
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39f75e1e9d9so21987001fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 02:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785748204; cv=none;
 d=google.com; s=arc-20260327;
 b=Z8tf+sn6AoFsCjWaEeEx+aFmfiEZnjSHhCgWRz20YV27SxH1/87F24YXagoL+fgLWR
 aYI7uFTKwS1GVhSEmnkyqJz5EdTbttRPl4O5eZxH3oEJvT4mY6ysRUTCZoIGX4usEAbl
 nriN8N70Tg0NfDcI3lhG5aHCmntfnbyGzI+8qhkptdRN1SZCU5Y5zUhrpVMPtafP9aSo
 9Ufu7u44ZCsbelW/V9K0uT2otjfadtboHhtZiU0u2pzgvYTPKbMDqKs4cOZC0ObL3G5q
 uIBfBOghTyDPNNuvwj+xqE5PseqkznaO+M7a8zHD82NAe6GQwwb5rkXc4VJY4qxer69z
 ZpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x2oqzU058dzalitvaU7FmatWsZJscz5TxwjziifaQTk=;
 fh=0DnoCi5/qgr4uWnmpcLKsoPkhe/vJELEE/VBy8Zw4xI=;
 b=f/TuAco/0HemWU3DZZS6dfreIZGz6Zo4qosqCGAi2N0ufGq7NP8UTHKKZeYKgMG14G
 +gFM4T6IZ3gvqJVs5XPiVyJqO8aozgGG6h7U2Re/Li/jWwnTBqkR1K59vpu/s2ajWin1
 4004pDHWV165AxD9GH9syyNi1Jwg9Opm8a7itN7nOxEbzCBMKEpaU8G4g5y83ktl/Ci3
 +bJxYrfbRRjqqAl73xrqUIbabKMLhLKPS1SFrjLMyoRhzibQBEKHul4VannC3f+LV/RC
 PP0WEGR4RZa8vtnFEe20GD3EPiJv4zOdjd6fWEDtL5Ph+/OK/xYBIVllVfl0HPMP3Df1
 r5DQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785748204; x=1786353004; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x2oqzU058dzalitvaU7FmatWsZJscz5TxwjziifaQTk=;
 b=g0yj1QtrgjkFn91WR996rL2l/N++ywCcD/3KoGNoS6Ffswc41A/DUubD2YpUB6Bd3+
 qSaLpBJgofajWjGafRVUREPODfbH/jXP70hvzXtP9rMpN8wN5/65TN/058jHK8P3GFz6
 BqNCBRk9xL1FBPFmO3SINBrRsre2MHCf4gzgRbCF0xm2n7sYBMbA8TxIC1x6aLbmToA9
 nvzmtchUM+M8Q25SJ6K+Vk2ExF9UW75+VHH/UjpCfsL2Ya5hN2ioaW8S7jSq9c/jIyBt
 S01O0P5v2K7we9NezJiL1t7xl89BWJF93k8TPzvPWsYbZI66lffjFitgj1ors2YkLk/y
 2FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785748204; x=1786353004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x2oqzU058dzalitvaU7FmatWsZJscz5TxwjziifaQTk=;
 b=ovZbWawjBCpZajDdsnh/VOHG3rycvmukHOuteS8gGGjrXTVxxZ6erflLAkTYlNCT07
 K6tG6CKXuAuH/6XVZY99Lak/+1QqcUEpK9pU8mXUxUELknOeh3Y+eZlG6cmO8Fzs0lFy
 1Z+3wYNcKiGZT2M8bh2J928E+jePJ2fQhNvk26jOmnW8EH/NkAu3ay8I7aq0UfeDPw8M
 ANdz+6lu1fYKr4RwrBw5u9GE7RPgjghZDm70VJT3LIea5pybfi8R7G/fNQ+ora3w9L+s
 4saGZqD4iXK7p5Pg6cVnWNjyxU8OHxeTpqzDnoUEuaAzgaPGS8ABgb/0QVc5ETVFkRLX
 n/Hg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3Cs6XGZ20HqBzBGvtYITNpYmXMCorMntuk2bjxAIEeO+25Gy4uaczPhFMF6+ndv5JShE69JtM+Kg20U9f1Yca@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwsJV4vvO5JzUZy+No5w8slKKbkLjBf9hVpRcmG/zflJv7CryDg
 98kR+dkLJwzOwq2FROV/MAn1Az/MFbxrdj+QAs0nPF3DenD/eBVAVZXqWb9QlEg6ntnVGupz2He
 JOqdbWRRte1RDUyt3sS0qmcVTLGk20us=
X-Gm-Gg: AR+sD11lvUG04yaWSLalxZFfdaIWUbSd12o8cF2RVV1Sug1IXqyn90wjldLU3hOx+f0
 kXqr3ZGcMlVS8Qq4VoBOu5Tawb16QPJBZ8JZkpM0hI8x7do/5xShcmpwGp7jIOBi/+jAkfPBnGs
 4ja43pVcbiiQbOLdHzr5BWc5/5dhC/GDoWa5sYa94dsyq9L/mqqOOFRnp8BKAxe8wqhx66I0tnR
 os9tmMHJrEV0X8jUgS2c5voyt9AfE6OVIFH86WJK162s/+rcIJ86a/b8FxkfP/cN6DnrITTsecv
 X8J5iu1F+OXfthN7sC8L8Gs/HQkra+HH3NLDQrVY1ZRG17r9pTZgQeNCiA==
X-Received: by 2002:a05:6512:2395:b0:5b0:197b:9811 with SMTP id
 2adb3069b0e04-5b2e4f882femr2082192e87.53.1785748204175; Mon, 03 Aug 2026
 02:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260724090532.351989-1-qiwenjie@xiaomi.com>
 <c235897c-bec7-45f2-aed9-1efa7e0646ed@kernel.org>
In-Reply-To: <c235897c-bec7-45f2-aed9-1efa7e0646ed@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 3 Aug 2026 17:09:53 +0800
X-Gm-Features: AUfX_my2RRSx7rlcae-vhYCh-9rY7UwWTNOfOcgKLpJgSFDJ-Wqx_bfiZcw8hto
Message-ID: <CAGFpFsREpUdgZ_JwaE2c1uhUQAq8peY99UvDN5ug0_vn_9NOxA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqogU-0002yd-W9
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid NULL checkpoint thread access in
 sysfs
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBZZXMuIFRoaXMgcGF0Y2ggYWxzbyBleHRlbmRzIHRoZSBleGlzdGluZyBzX3Vtb3VudCBwcm90
ZWN0aW9uIHRvCiAgY2twdF90aHJlYWRfaW9wcmlvIGFuZCBjcml0aWNhbF90YXNrX3ByaW9yaXR5
LCB3aGljaCBpcyBhIHNlcGFyYXRlCiAgcmVtb3VudC12cy1zeXNmcyByYWNlIGlzc3VlLgoKICBJ
J2xsIHNwbGl0IGl0OgogIC0ga2VlcCBvbmx5IHRoZSBOVUxMIGYyZnNfaXNzdWVfY2twdCBmaXgg
aW4gdGhpcyBwYXRjaAogIC0gc2VuZCB0aGUgc191bW91bnQgcHJvdGVjdGlvbiBmb3IgY2twdF90
aHJlYWRfaW9wcmlvIGFuZAogICAgY3JpdGljYWxfdGFza19wcmlvcml0eSBhcyBhIHNlcGFyYXRl
IHBhdGNoCgpPbiBNb24sIEF1ZyAzLCAyMDI2IGF0IDM6NTPigK9QTSBDaGFvIFl1IDxjaGFvQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gNy8yNC8yNiAxNzowNSwgV2VuamllIFFpIHdyb3RlOgo+
ID4gY2hlY2twb2ludF9tZXJnZSBpcyBzZXQgYnkgZGVmYXVsdCwgYnV0IHRoZSBjaGVja3BvaW50
IG1lcmdlIHRocmVhZCBpcyBub3QKPiA+IGNyZWF0ZWQgZm9yIHJlYWQtb25seSBtb3VudHMuIFRo
ZSBja3B0X3RocmVhZF9pb3ByaW8gc3lzZnMgc3RvcmUgcGF0aCB1c2VzCj4gPiB0aGUgbW91bnQg
b3B0aW9uIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHVwZGF0ZSB0aGUgdGFzayBpb3ByaW8uIE9uIHN1
Y2gKPiA+IG1vdW50cywgd3JpdGluZyB0aGUgbm9kZSBwYXNzZXMgYSBOVUxMIHRhc2sgdG8gc2V0
X3Rhc2tfaW9wcmlvKCkuCj4gPgo+ID4gS2VlcCBzdG9yaW5nIHRoZSByZXF1ZXN0ZWQgaW9wcmlv
LCBidXQgYXBwbHkgaXQgb25seSB3aGVuIHRoZSBjaGVja3BvaW50Cj4gPiB0aHJlYWQgZXhpc3Rz
LiBUYWtlIHNfdW1vdW50IGZvciBja3B0X3RocmVhZF9pb3ByaW8gYW5kCj4gPiBjcml0aWNhbF90
YXNrX3ByaW9yaXR5IHRvbywgbWF0Y2hpbmcgdGhlIGV4aXN0aW5nIHByb3RlY3Rpb24gZm9yIEdD
IHRocmVhZAo+ID4gZW50cmllcy4KPiA+Cj4gPiBGaXhlczogZTY1OTIwNjYxNzA4ICgiZjJmczog
YWRkIGNrcHRfdGhyZWFkX2lvcHJpbyBzeXNmcyBub2RlIikKPiA+IENjOiBzdGFibGVAa2VybmVs
Lm9yZwo+ID4gU2lnbmVkLW9mZi1ieTogV2VuamllIFFpIDxxaXdlbmppZUB4aWFvbWkuY29tPgo+
ID4gLS0tCj4gPiBSZXByb2R1Y2VyOgo+ID4gICAgbW91bnQgLW8gcm8gLXQgZjJmcyAvZGV2L3Zk
YiAvbW50L2YyZnMKPiA+ICAgIGVjaG8gYmUsNCA+IC9zeXMvZnMvZjJmcy92ZGIvY2twdF90aHJl
YWRfaW9wcmlvCj4gPgo+ID4gQmFzZWxpbmUgZG1lc2c6Cj4gPiAgICBPb3BzOiBnZW5lcmFsIHBy
b3RlY3Rpb24gZmF1bHQKPiA+ICAgIEtBU0FOOiBudWxsLXB0ci1kZXJlZiBpbiByYW5nZSBbMHgw
MDAwMDAwMDAwMDAwN2IwLTB4MDAwMDAwMDAwMDAwMDdiN10KPiA+ICAgIFJJUDogc2V0X3Rhc2tf
aW9wcmlvKzB4OGIvMHgzNjAKPiA+ICAgIENhbGwgVHJhY2U6Cj4gPiAgICAgZjJmc19zYmlfc3Rv
cmUrMHgyYWYvMHgyNTgwCj4gPiAgICAga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MzYwLzB4NjIw
Cj4gPiAgICAgdmZzX3dyaXRlKzB4NWY4LzB4ZjUwCj4gPiAgICAga3N5c193cml0ZSsweGY5LzB4
MWQwCj4gPiAgICAgZG9fc3lzY2FsbF82NCsweDVmLzB4NTUwCj4gPgo+ID4gICBmcy9mMmZzL3N5
c2ZzLmMgfCA5ICsrKysrKy0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3N5c2ZzLmMgYi9m
cy9mMmZzL3N5c2ZzLmMKPiA+IGluZGV4IGJlOTJjMDVhNTQyMC4uMDI5NDU0NGQzZDM0IDEwMDY0
NAo+ID4gLS0tIGEvZnMvZjJmcy9zeXNmcy5jCj4gPiArKysgYi9mcy9mMmZzL3N5c2ZzLmMKPiA+
IEBAIC01NTcsNyArNTU3LDcgQEAgc3RhdGljIHNzaXplX3QgX19zYmlfc3RvcmUoc3RydWN0IGYy
ZnNfYXR0ciAqYSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+
Cj4gPiAgICAgICAgICAgICAgIGNwcmMtPmNrcHRfdGhyZWFkX2lvcHJpbyA9IElPUFJJT19QUklP
X1ZBTFVFKGNsYXNzLCBsZXZlbCk7Cj4gPiAtICAgICAgICAgICAgIGlmICh0ZXN0X29wdChzYmks
IE1FUkdFX0NIRUNLUE9JTlQpKSB7Cj4gPiArICAgICAgICAgICAgIGlmIChjcHJjLT5mMmZzX2lz
c3VlX2NrcHQpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzZXRfdGFza19pb3By
aW8oY3ByYy0+ZjJmc19pc3N1ZV9ja3B0LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjcHJjLT5ja3B0X3RocmVhZF9pb3ByaW8pOwo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIGlmIChyZXQpCj4gPiBAQCAtMTAwNywxMyArMTAwNywxNiBAQCBzdGF0aWMgc3NpemVf
dCBmMmZzX3NiaV9zdG9yZShzdHJ1Y3QgZjJmc19hdHRyICphLAo+ID4gICAgICAgc3NpemVfdCBy
ZXQ7Cj4gPiAgICAgICBib29sIGdjX2VudHJ5ID0gKCFzdHJjbXAoYS0+YXR0ci5uYW1lLCAiZ2Nf
dXJnZW50IikgfHwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYS0+
c3RydWN0X3R5cGUgPT0gR0NfVEhSRUFEKTsKPiA+ICsgICAgIGJvb2wgdGhyZWFkX2VudHJ5ID0g
Z2NfZW50cnkgfHwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAhc3RyY21wKGEtPmF0dHIubmFt
ZSwgImNrcHRfdGhyZWFkX2lvcHJpbyIpIHx8Cj4gPiArICAgICAgICAgICAgICAgICAgICAgIXN0
cmNtcChhLT5hdHRyLm5hbWUsICJjcml0aWNhbF90YXNrX3ByaW9yaXR5Iik7Cj4KPiBPaCwgc2Vl
bXMgeW91IGZpeGVkIGFub3RoZXIgcmFjZSBpc3N1ZSBpbiB0aGlzIHBhdGNoIGFzIHdlbGw/Cj4K
PiAibW91bnQgLW8gcmVtb3VudCxybyIgdnMgImVjaG8geHggPiBjcml0aWNhbF90YXNrX3ByaW9y
aXR5Igo+Cj4gQ2FuIHlvdSBmaXggdGhpcyBpbiBhIHNlcGFyYXRlZCBwYXRjaD8KPgo+ID4KPiA+
IC0gICAgIGlmIChnY19lbnRyeSkgewo+ID4gKyAgICAgaWYgKHRocmVhZF9lbnRyeSkgewo+Cj4g
Ym9vbCB0aHJlYWRfZW50cnkgPSAhc3RyY21wKGEtPmF0dHIubmFtZSwgImNrcHRfdGhyZWFkX2lv
cHJpbyIpIHx8Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIXN0cmNtcChhLT5hdHRyLm5hbWUs
ICJjcml0aWNhbF90YXNrX3ByaW9yaXR5Iik7Cj4KPiBpZiAoZ2NfZW50cnkgfHwgdGhyZWFkX2Vu
dHJ5KQo+Cj4gPiAgICAgICAgICAgICAgIGlmICghZG93bl9yZWFkX3RyeWxvY2soJnNiaS0+c2It
PnNfdW1vdW50KSkKPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVBR0FJTjsKPiA+
ICAgICAgIH0KPiA+ICAgICAgIHJldCA9IF9fc2JpX3N0b3JlKGEsIHNiaSwgYnVmLCBjb3VudCk7
Cj4gPiAtICAgICBpZiAoZ2NfZW50cnkpCj4gPiArICAgICBpZiAodGhyZWFkX2VudHJ5KQo+Cj4g
aWYgKGdjX2VudHJ5IHx8IHRocmVhZF9lbnRyeSkKPgo+IFRoYW5rcywKPgo+ID4gICAgICAgICAg
ICAgICB1cF9yZWFkKCZzYmktPnNiLT5zX3Vtb3VudCk7Cj4gPgo+ID4gICAgICAgcmV0dXJuIHJl
dDsKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
