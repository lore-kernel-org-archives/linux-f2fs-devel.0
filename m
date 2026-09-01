Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B659EC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rEBXzPFRBz05/36y/iFQPFM5OzznkM3ijdGnka33YEU=; b=HGB33ezYzp/gL5UbYGy/ScvoRn
	UnfEiV6v6ocokxdTbDxJFrPeKPDwMMS7rRD/ULPEFP5FuRIj4cE+IUm1cCe4NzCqxyog2KqwIVvqp
	NXirOmUfvEmzYqYQIhg+8MVuLHr2kJTmvqjAQvjSLGErA1ze854Eymtg4nvjUFM0mCj8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1QtE-0002bT-6p;
	Tue, 01 Sep 2026 15:59:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x1Qt2-0002b9-UX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gp77WiCpsBoo+b95ZlkEkXec8l5ClFwLZZnKIIf5o+k=; b=SukIaBjLj31B22mcQKoIKvl+Ov
 5ASR9O/SGGDcnZEDqWJOR9nnr+4DvVGC280YQEL9AWC/wqzisDZTMbhbsWN5EmHlFtyUAvhwcN8te
 icI2dBJ81vM6x2gNnma1HJ66Mgbez8XbMsbFve/UoHpcU0mhQO99C+7jIJr3JT96Mpdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gp77WiCpsBoo+b95ZlkEkXec8l5ClFwLZZnKIIf5o+k=; b=do3/1T1tv9MdvS4J5Ezm8FXFI5
 zmpagNCvQ6surEQq1sKiaf/V+3BaTp9TpSxh4q6J7kaN5hM7VC+nVN68wcCg408PxlysYS0PTk5SL
 4ShWXoGZbDlqRJqGl6/N9pVWhh7MJTyC9r/Xdmk6tZBr2K2EC/8zW54x4jq657JFMkmg=;
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Qt2-0004pY-It for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:59:00 +0000
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39c74c469e8so30286201fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 08:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788278334; cv=none;
 d=google.com; s=arc-20260327;
 b=FGQrBA/aBhYZTUxq+QHw2bE0Xct7KEGY3NHHigTzM9nfmYPkUVcUUZpPWEtJYzpo7o
 DZRF5Ku8TdhgWM9M77FhWdS3pvSlovjUE343lA6mgpicTH4LKge8AS5NHIIJTydPz0d4
 7XqRWKIyGG0qE3hIkJ16NpYUd0fRXBMSsI6jGeumMqkV6gwT8aGOTzZr5QOFYgK9sHf6
 Mc+Ik3KDLtOo1sDFCcS7um3Vy46TCD/NfO2UVojxX+tflQXNABVbPNWjM7WDxejxXd31
 8pDVAum+7HrMv+x/padLd+kR/sFyC0G7RfAJlIsQ3ke/Kvi3WXi5PJPvKPUlHG46nD3Q
 WZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gp77WiCpsBoo+b95ZlkEkXec8l5ClFwLZZnKIIf5o+k=;
 fh=c++xOB4ZphYlB+KGzHLL6fGGuTq4FEv10wfs1TSzn4k=;
 b=qCJ7J+WunDby2bshvn6riDnWdPyAslGwU189o9eFJoYMVrEtL2vPfFbRwBwKFh6vLs
 2kyPZxIqe72ffX2BnOrx2gaSPwkIZbEETihKDMOiq+NbTCwksbzfD4zNWFwCXG+VQ7P1
 bx6HpWY7T8vfuc9aNyno/5Rtw5pC9TDNzlA85NU8Hv/JR6FZOm1kvyHsW3nvZgXbXQXx
 7IgVWczWrAlCqNpbGgcs6rinGhNPfMaq5X1hdP7p6VfNWCfAooKv1HLszMKt57diNJqs
 tjsT2638ozoxrd3K8P8qi9uQ6j4hc/ksADHP6Q5a7I+GnV47pUhd+X+zidArAQdlH3Hb
 5SXg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788278334; x=1788883134; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gp77WiCpsBoo+b95ZlkEkXec8l5ClFwLZZnKIIf5o+k=;
 b=ErUdi1khh3G9q4AkVX9L6kL0RhdH3g9p1+6aBzVHrJPrU4a3NacZq2Hl2UNoqnwS9M
 nwxs1ZnOHj0dabPBz9zA98SHghCACDWeYVsyxvB9ntKMe8YjjAYDoUYVqTLn+oPdxxPu
 obpMBKKzfPGwlp2zrjN/ZNmBFosT7WiNDjU8nykan5e5dQltmPG+oQQ1H3BB5HsBB8px
 o61lxURAOXJc7jU0ZfzqfCTp3bB8dOKfihfFW6HveWEwD7TNqF5Ke7479xBWm/NKgA8x
 6YD5A86GEGmTY9WI9PacuIOkavp8I6FMtI0/UFg5sNCI6nHitxJ4UCt3s7Hcl8IeQkfc
 992w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278334; x=1788883134;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gp77WiCpsBoo+b95ZlkEkXec8l5ClFwLZZnKIIf5o+k=;
 b=hIaVowNJYoj19QncRHHmnS95//129mPXNWpYGUchAnbmyvpmwFizASEHUH+eAOxlEY
 fwfS4chR4EqqH+n5eWVRFm1klHXT7MjofPO79FAmgkS5RG1oJu94O32nk+EeS3S75eo5
 0xgQw5fGUR/0pQxkKffKbjpxF/x2Xgn5FggeLL2c2YgtsS983ndfipJPZm0Ag3Cda9dN
 HyB9K4Ur7CAuwvvLvozFnRgdFg1xjcf68kPqgVCosPzlfay2O4iXD2rt+5tZKEqWr6OE
 5JXEzUwWszzQdXGz4akVZusEb25cXvqjFfloEsAkLQE0BmoHubJM/TVtgp+DMBG1tF0m
 UWvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz4Ko8P36qDjq/h9WyMLOWAsi5CWPxfPmc5eUqcVoXgYVoaEGE78iwkfg4qJ8/+AbtmpaBS3ATKKioOrjk3UBA@lists.sourceforge.net
X-Gm-Message-State: AFuF++nSkzzdCjUgNR2Oadx46FY8cfx0Usky/N+p6jtsZ5X1zy0qM3V7
 E1v6SZaPwR0npUonurrNDlMtKQeNN0uLuC+wOmHIRlPhC428zcEqy5+ROuJAs1fK9K0hJnc/SSk
 5KOLGq/4I65o9HmpD8O+a8Bn7GNBJ3F4=
X-Gm-Gg: AYBFou3BcL1wS6VRndQsEGpo0ICtkIjS0yZ29RPYIt9J1QJTPl6yKMMXGORmZ0TZxDQ
 ksSDCdet3D36EUDGU6SfA8fYDb5uV0WLVAqyHCcDaYYgg2EdFMadAkrXKnZKL9frMRSshPsIzoV
 htH1A/aec554PKeX7R3ng0upTNt4XVsKBTfRCRLWzq2jiIVUKs9kK3KNQhMMYkMNtrR6tA9f4Z0
 wDdsiSRjYPPOGkGcjhJdXM8dV/8MxG0lej1ZSU49+yJFYR+vXPGBvI+T4MZJdagTrgm0xniOcjK
 9hS2bYrtZ3q8y/oyZ5OUc3g7B6oQ5STVBZ7lg4Nz2Z2cDN6oFPtH+GViYGp0NqsQx4Q/3rP5EhP
 rceCahsW3cJyz1j5MiitLQzX64JBF79g=
X-Received: by 2002:a05:651c:54b:b0:3a3:2959:a466 with SMTP id
 38308e7fff4ca-3a32959d0d7mr42050231fa.8.1788278332283; Tue, 01 Sep 2026
 08:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
 <20260829060524.2656620-2-qiwenjie@xiaomi.com>
 <20260829060524.2656620-3-qiwenjie@xiaomi.com>
 <CACOAw_z1UUG0e+LSGmer_mPv+YcYVcjFiMLZ6RwhmYtmrObKXA@mail.gmail.com>
 <20260901025344.3466776-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260901025344.3466776-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 1 Sep 2026 08:58:39 -0700
X-Gm-Features: AcwNN1UslrG6sgIPwtWDVRaPkOW7y2avsy5hDLrd5JTB-dY5Kdv2YguVdwukVO8
Message-ID: <CACOAw_wnDrd_iQ1GALuYx59Pc3-qJeZbNU1JajsHJ5zMSvabow@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1x1Qt2-0004pY-It
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: refresh pinned allocation
 boundary after resize
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBBdWcgMzEsIDIwMjYgYXQgNzo1M+KAr1BNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gSGkgRGFlaG8sCj4KPiBUaGUgc2Vjb25kIGNoZWNrIGlzIGludGVu
dGlvbmFsLiBUaGUgZmlyc3QgY2hlY2sgaXMgb25seSBhbiBlYXJseQo+IHZhbGlkYXRpb24gYmVm
b3JlIG1udF93YW50X3dyaXRlX2ZpbGUoKSwgYnV0IG1udF93YW50X3dyaXRlX2ZpbGUoKSBkb2Vz
Cj4gbm90IGhvbGQgc2ItPnNfdW1vdW50LiBBIGNvbmN1cnJlbnQgcmVtb3VudCBjYW4gdGhlcmVm
b3JlIGNoYW5nZQo+IHJlc2l6YWJsZV90YWlsX3NlY25vIGJlZm9yZSBmcmVlemVfc3VwZXIoKSBv
YnRhaW5zIHRoZSBleGNsdXNpdmUKPiBzdXBlcmJsb2NrIGxvY2suCj4KPiBBIHRlc3Qtb25seSBo
b29rIHBhdXNlcyByZXNpemUgYWZ0ZXIgdGhlIGVhcmx5IGNoZWNrIGFuZCBiZWZvcmUKPiBtbnRf
d2FudF93cml0ZV9maWxlKCksIGFsbG93aW5nIGEgY29uY3VycmVudCByZW1vdW50IHRvIGNoYW5n
ZQo+IHJlc2l6YWJsZV90YWlsX3NlY25vIGJlZm9yZSByZXNpemUgY29udGludWVzLiBTdGFydGlu
ZyB3aXRoIDUwNiBzZWN0aW9ucwo+IGFuZCB0YWlsPTEsIHRoZSBzaW5nbGUtY2hlY2sgdmVyc2lv
biBsZXQgYSByZW1vdW50IGNoYW5nZSB0aGUgdGFpbCB0bwo+IDEyOCBhbmQgaW5jb3JyZWN0bHkg
cmV0dXJuZWQgc3VjY2Vzcy4gV2l0aCB0aGUgc2Vjb25kIGNoZWNrLCByZXNpemUKPiByZXR1cm5l
ZCAtRUlOVkFMIGFuZCBwcmVzZXJ2ZWQgNTA2IHNlY3Rpb25zIHdpdGgKPiBwaW5uZWRfYXJlYV9t
YXhfc2Vjbm89Mzc4Lgo+Cj4gVGhlIGZpcnN0IGNoZWNrIGlzIHRoZSBmYXN0IHBhdGggZm9yIGlu
dmFsaWQgcmVxdWVzdHMsIHdoaWxlIHRoZSBzZWNvbmQKPiBjaGVjayB2YWxpZGF0ZXMgdGhlIGZp
bmFsIGdlb21ldHJ5IGFmdGVyIGZyZWV6aW5nIHRoZSBmaWxlc3lzdGVtIGFuZAo+IHRha2luZyB0
aGUgcmVzaXplIGxvY2tzLiBCb3RoIGNoZWNrcyBhcmUgbmVlZGVkLgo+Cj4gVGhhbmtzLAo+IFdl
bmppZQoKUmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+CgpU
aGFua3MsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo=
