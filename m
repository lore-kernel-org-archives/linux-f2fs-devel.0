Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA0CCCF2C1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Oct 2026 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+mJwGTEvD8FfFJB5WtQ6tTPhmKe0+NbgLjliz5eKXY=; b=m8D1P+/sFe3hCpYfkmeoHRFCu8
	OZLtgKToqCOGg+mAOqct7lei8m4JIRCEUX3wPqSmwFNi2Tj6QFlm1ONuCyBKkoFyVw1FU6FJkb3m0
	EaEZVC9QBOTOKAyLCUkzpE7otSSgkJVsqi8AKoxEd6/yIOgoFBMMysHTRGoiVXMFfdcE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xI1EG-0005Rr-3f;
	Sat, 17 Oct 2026 10:01:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xI1EF-0005Rj-2K
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 10:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YbawAVaqfEsj2FEViDCMZVjK5TKuFAvjwsulFA3xoQ0=; b=g2HH5Einc7DU5TvMr/GYeiyurD
 E6mJW7Aujqpk7KWpdl15MvUCKyRBIoS64WirullJIa2q8yVHkgHnVPEhzMO+RPARQwPlrHBEqErJf
 8igv34XhZ2oOUON3pbG6sEqG+bMlnkJ8McyN1Y7d6JJjfDapJ5sI91TqNWMwT1xtKF8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YbawAVaqfEsj2FEViDCMZVjK5TKuFAvjwsulFA3xoQ0=; b=cLu0fI67guT5aOEhEohDtPn+gC
 64pO7jJdXO/9WLdMQMf8cL0nDEe+DLvUrSkIj2ZhO45XfVJYffpE6bKQyZ1PtnZdlrbu9pUm4+kbF
 caly5zah5kjCmq2g37SECSOeaKenJrhBpTPeOqx0vT1ywPNzfS5JWFTGYgWNgkAMWrIM=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xI1EB-0006Up-MN for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 10:01:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=YbawAVaqfEsj2FEViDCMZVjK5TKuFAvjwsulFA3xoQ0=; b=h
 zWDSTaaL7Cmk3RjO85542uQkwpa3SrBx1rbDwQGFGXvCfnWr9i1iTw79WtMW52w/
 xF8F8et0Wn/i35GUgHO8NELAsvINR9ft7hxlH4q8LwncSDzFvCTusCq/XNGMo8gx
 pSidfkU9z7/uqIJXPE6NlBE4sjh5H87i3IdtdqC9jw=
Date: Sat, 17 Oct 2026 18:00:47 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <atFFXafuVyyimmUk@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
 <atD9Csw1-lj5_SR_@google.com> <atFFXafuVyyimmUk@google.com>
X-NTES-SC: AL_Qu2SAP6Yvkov4SGaY+kdmEoVj+o8Xsaxs/8g2YJSc8gOtgfUwzsQWHZeElbTwO69ABq9sQGSYCZS08NTWLJTHKNy3WMTlzx+bywRu/+17A==
MIME-Version: 1.0
Message-ID: <15373a26.1e3d.1a1494e8d1a.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cSkvCgD3V6tPR9NqOWVRAA--.41986W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQ90RGrTR0+9fgAA38
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1xI1EB-0006Up-MN
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgoKSGkgSmFlZ3VrLArCoMKgCsKgIEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVjZSB0aGUgZmFpbHVy
ZSBpbiB5b3VyIGxvZzogc2QgMDowOjA6NDogUmV0cnlpbmcgdW5hbGlnbmVkIHdyaXRlIGZvciB6
b25lIDI2Mzkg4oaSIGNyaXRpY2FsIHRhcmdldCBlcnJvciDihpIgc2RlOgrCoCB6b25lIDI2Mzk6
IEFib3J0aW5nIHBsdWdnZWQgQklPcyDihpIgZjJmc19zdG9wX2NoZWNrcG9pbnQgKGtlcm5lbCA2
LjEyLjgxLWFuZHJvaWQxNi02KSBhbmQgZ290IHR3byB0d28gcXVlc3Rpb25zLgrCoMKgCsKgIDEu
IEtlcm5lbCBiYXNlbGluZS4gQ291bGQgeW91IGNvbmZpcm0gdGhhdCB0aGUga2VybmVsIHlvdSB0
ZXN0ZWQgaGFzIEJhcnQgVmFuIEFzc2NoZSdzIHpvbmVkIHdyaXRlIHBpcGVsaW5pbmcsIGkuZS4g
bXVsdGlwbGUgaW4tZmxpZ2h0CsKgIHNlcXVlbnRpYWwgd3JpdGVzIHBlciB6b25lLCB3aXRoIHRo
ZSBvcmRlciBrZXB0IGJ5IEJMS19GRUFUX09SREVSRURfSFdRIGFuZCB0aGUgcGVyLXpvbmUgZnJv
bV9jcHUgaW4gYmxvY2svYmxrLXpvbmVkLmM/IEFuZCB0aGF0IGl0CsKgIGRvZXMgbm90IGluY2x1
ZGUgdGhlc2UgdGhyZWUgZm9sbG93LXVwIGZpeGVzOgrCoMKgCsKgIC0gIkFORFJPSUQ6IGJsb2Nr
OiBQcmVzZXJ2ZSB0aGUgc3VibWlzc2lvbiBvcmRlciBvZiB6b25lZCB3cml0ZXMiCsKgIC0gIkFO
RFJPSUQ6IGJsb2NrOiBQcmVzZXJ2ZSB0aGUgb3JkZXIgb2Ygem9uZWQgUkVRX0ZVQSB3cml0ZXMi
CsKgIC0gIkFORFJPSUQ6IGJsb2NrOiBSZXN0b3JlIHRoZSB3cml0ZSBwb2ludGVyIG9mZnNldCBj
aGVjayIKwqDCoArCoCBJbiBBT1NQIHRoZXkgYXJlIDA1MGRlNTcwZiwgYzYxNmY3YzFhLCBkNTA2
MDFkMGYgb24gYW5kcm9pZDE2LTYuMTIsIGFuZCA2MDY4ZWQ5ZjAsIGQ3ODZmODYwOSwgZjA4NDMw
ZjgwIG9uIGFuZHJvaWQxNy02LjE4LiBUaGUKwqAgc2ltcGxlc3QgY2hlY2sgaXMgd2hldGhlciBS
RVFfWk9ORV9TRVJJQUxJWkVEIGFuZCB3b3JrX2J1c3koJnp3cGx1Zy0+YmlvX3dvcmspIGFwcGVh
ciBpbiB5b3VyIGJsb2NrL2Jsay16b25lZC5jLiBUaGUgb3V0cHV0IG9mIGdpdCBsb2cKwqAgLS1v
bmVsaW5lIC0tIGJsb2NrL2Jsay16b25lZC5jIHdvdWxkIGFsc28gZG8uCsKgwqAKwqAgMi4gVGVz
dCB3b3JrbG9hZC4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgY291bGQgeW91IHNoYXJlIHRoZSB0ZXN0
IHdvcmtsb2FkIHRoYXQgdHJpZ2dlcnMgaXQ/wqAgU28gZmFyIEkgaGF2ZSBub3QgYmVlbiBhYmxl
IHRvIHJlcHJvZHVjZSBpdCB1c2luZyBudWxsX2JsayB0byBzaW11bGF0ZcKgCnpvbmUgZGV2aWNl
cyB3aXRoIHFlbXUgYW5kIGFuZHJvaWQxNy02LjE4IGdraSBrZXJuZWwuIEFueSBzdWdnZXN0aW9u
cyB3b3VsZCBiZSBtdWNoIGFwcHJlY2lhdGVkLgpUaGFua3MsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0
CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
