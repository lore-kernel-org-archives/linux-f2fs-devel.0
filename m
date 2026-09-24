Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D82C98310
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q41j9J1wGazUmHkM7cu9xLhhqRMER4K+tqhYChtWVFw=; b=X/DrlWePRbgrxn+Vv3rImlNx8/
	K7XJOPgY4CIEnQZfdbXFuwUWQTODUmun3POdt5b5QYe2h4+gSHP06byj5cg0Np1+wAybH3CKYMsny
	1ygPkhAkHjtEeSpb2qWUTB8ZstOIKl4r5kjtdpCxykQA4lrp+AxIdhY29uMCVtBTj0wQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9eek-0007Xi-VH;
	Thu, 24 Sep 2026 08:18:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x9eeW-0007WQ-15
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 08:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RJu/AuLG41tv3IGJK1rwhcStlwPDE3jmlfjcNPoALb4=; b=Uh4+HOMIYKmwY+7/+/LH0rC6eU
 qOz2yNc4nKSZl+gdIWiqXlst18t3ouPspkIcV9TuldU2Ey6lsOveEyoLsKlOnuvpbhGFnJvQg/pPv
 gtL6N/8cnEMG+Tlw4WXTLeOLu4SjTTwdRMMM4MriDDPJFNOb8jhi70+wDNj72773gr5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RJu/AuLG41tv3IGJK1rwhcStlwPDE3jmlfjcNPoALb4=; b=UGIiE1VnA3edIbpmj11Et3smWe
 qweG5Gkk6sfrWLS1sabrTEJHrNe3piY3VlXW2xXWH1VJGepAKXLG5DAcEa+zEQ2p152qZ/zXk/tV5
 THOIyT7FC6z3xAfIFgzhNDYZz2juSCSOQ9PGUu/62FPaIxXrUW0LtXo+yZnKH7+Voa0g=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9eeW-0008Q7-Dd for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 08:18:00 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4843971bdd0so34406f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 01:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790237874; cv=none;
 d=google.com; s=arc-20260327;
 b=U7kzgL07ogHD1KthM8UxDyJreb3CSxHWTgrHER/5L/3qsxyk/hXmduz4RBy957G6/F
 1U8+FeAKruccklSst8GIzAgPQzOpQh6MgGYZCgmM4O5Jqlw7Xq4EtTeJ5t6KZSJYC3dv
 gCqNcCUEFs6AVmBuQox1a6J8qibqZ92h1wK5UYG9Oa+LflkD1kP8//jW0vllhFffqAvU
 211Ew1J6ANJLx0pvFfVO4Xn1j0/zUm35qXxmue44Lk94IAeLf7mOkOXVjXN+hOiJdP5z
 5zjsol7ukWb9ynNqFutpHiaRghjCdQOqO+LWKHGJLZzAsphfin0yYAZ6wccZCfwSM6sq
 ljvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RJu/AuLG41tv3IGJK1rwhcStlwPDE3jmlfjcNPoALb4=;
 fh=+GE4uuNixY6ykUTqaIC7EsHPOjlTrNpUQuG83S7yUq8=;
 b=Rq83yaG9WQJ5krh1DZkF9qQ1CCIU9INUMgI8jb9B/JP8XO/aBTnJBgsWAQt3vo0jAo
 hai8rFUQ+Rkxsqi8wQbW/PsAdJurOcMGzY8ylsfz6/rzLVn72fXcCJzxUwN3qg3UxOtU
 2hR+8qG+XllpQYLi81YNUWtP8+5IWtF2a0lCn7NPg8VBZ4MAdd9rkClEQn+rWxanfh63
 DvQwlvA1W7VnWpYHJaOfaBOA9yw8/1RqXrJJpcRlfANKUsD1jrsw0XjU0dXakZN2yPuh
 al7kJnT6XdIhox530fjxSk80Ojnqlx5UPGpqKAc818EjCJlIq7W2bKjU8gKxDKmBITMz
 B9bA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790237874; x=1790842674; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RJu/AuLG41tv3IGJK1rwhcStlwPDE3jmlfjcNPoALb4=;
 b=BwT1nakYyYmiNiKVENsFimUMqF5q52yktbMru6m7MByZ2nPkdln2Fjry8MRroYvmPI
 7fG0ARmFeyEUUe9L0272TwJZkbBKmDOC49nQnOMMAUEc5MELJGfDcP3AaHTWVA2aZbmv
 OpYDxFjcgKhaXh9iAymWiV4mHdJrvsxmXUZenWf3l8oGdAqVOqH1AHq1XGQobNUThzw4
 FrU7pWv1Xbc05P4HWh06/AF6XsOLPo+3uyB1GKYSsH3hP2Ws/KvJrbP6CFOucjDdJZjC
 t6zpY4+TD5gh7s1L/qiWYNyIeIreObtq8CIjLmtB6a64h0Vj7ajdOut6+hHRmn3Ps6rV
 Yo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790237874; x=1790842674;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RJu/AuLG41tv3IGJK1rwhcStlwPDE3jmlfjcNPoALb4=;
 b=ZhctIH2T9L4vLzVi+aOXgB0WCD5Zj5wfoOCBdVAHlMn+hrSchhfcr3kVNCrS3EkFXh
 gJv8ChxEKUCbGweRQx6ttOqFknwvL8fttNmrOnvns7YJtmPkAf6hQ9jEfdurhx95ZCac
 y2aPJVXhuxhrwSxPyUMU8ibdXsQdxpCzOkcNj6utFraSE1j3mDVSsWHZp1ZEMfO/Lc8M
 cpZyD2mwFdSkQvYNI1aZXdybu2baqyvw1aqwANdbnDxVS573J62RB22hVj6jcVjJsNI2
 q32dO6k5jdoDHINJfAv7IRVLAwqgVO0U6DFwpPOuj72OaBDYmkr72bs+ncHl9SO2+Y+A
 uZXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx22wjtNE6wuyIhZ+dpW9FppVbVpeOG9NkPTcCSqAINHG24UPxvBkVZrrwT29XYgqOjFVwag0F4HmOBjcehbC2v@lists.sourceforge.net
X-Gm-Message-State: AFuF++lSqo6P5JMRKFQqdghTbKgQj3q1AQpol6ZUfBDQKegxJuXApHOD
 l5r+u7QAObRD3PnQ5bCr9ndkR3CqO1aNmp1QJqBHEAaCsa6HiMpSY7Rgn0aXfbj922hio5S/XvJ
 +6qG/3UqPcOOPk+0HABk5cTwBS9ZsCoSlAroH
X-Gm-Gg: AYBFou0ZXNZj5YTd/VLzNlVq+KDSu2pauhp1Dq4DHKIXwJL8B2GtkE1zbh3dMujTTh8
 8iHrfyKACC+setYpZhBis7KzN6IkUF7CI9AkjwWCjU3x40zGgVcGl8yE5Z2wNmH6s8TEArW6Ayz
 C7ugWi4vEJGfazbqwqDPNsSkxcciYPtzzZzXhIahtymGurXjG6S7/H5q9IYyuTPaHpylzDvyJ3L
 nn1uySJsyW2+GSjGH4NRg2CGphQj9hfyOuN8XlLQcZYmeYL8c3mxhkmVKr2qfSyD3B2+yXj2Jzz
 sHCSFTORL+EZuaol9d/n9vVG3LIFCaWtjDePDi/S0Vro1RgMv3CljBRr
X-Received: by 2002:a5d:5d08:0:b0:487:981:4e07 with SMTP id
 ffacd0b85a97d-488716e720cmr2718944f8f.4.1790237873691; Thu, 24 Sep 2026
 01:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
 <20260924072315.57755-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260924072315.57755-1-zhanxusheng@xiaomi.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 24 Sep 2026 16:17:17 +0800
X-Gm-Features: AclHuK8MlAR9NE9XSLRPlwO41-nSBJGfzUFuPyLjpLvxKU0346lg-LM-V_3sBYY
Message-ID: <CAHJ8P3+3NTEf0z1XyJ4PeHQru_XCzo37eHqvfJGoLHO8JHc-wA@mail.gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Headers-End: 1x9eeW-0008Q7-Dd
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: simplify node footer check in
 f2fs_cache_write_end_io
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgWHVzaGVuZwoKWmhhbiBYdXNoZW5nIDx6aGFueHVzaGVuZzEwMjRAZ21haWwuY29tPiDkuo4y
MDI25bm0OeaciDI05pel5ZGo5ZubIDE1OjIz5YaZ6YGT77yaCj4KPiBPbiBUaHUsIFNlcCAyNCwg
MjAyNiBhdCAwOTo1MjoxMkFNICswODAwLCBaaGlndW8gTml1IHdyb3RlOgo+ID4gLSAgICAgICAg
ICAgICBmMmZzX2J1Z19vbihzYmksIGVudHJ5LT5pbmRleCAhPSBuaWRfb2Zfbm9kZShzYmksIGVu
dHJ5KSk7Cj4gPiArICAgICAgICAgICAgIGYyZnNfYnVnX29uKHNiaSwgZjJmc19zYW5pdHlfY2hl
Y2tfbm9kZV9mb290ZXIoc2JpLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGVudHJ5LCBlbnRy
eS0+aW5kZXgsIE5PREVfVFlQRV9SRUdVTEFSLCB0cnVlKSk7Cj4KPiBUaGlzIGFsc28gcHJvbW90
ZXMgZXZlcnkgb3RoZXIgZm9vdGVyIGluY29uc2lzdGVuY3kgdG8gYW4gYXNzZXJ0aW9uLgo+IEJl
Zm9yZSwgb25seSBhIG5pZCBtaXNtYXRjaCByZWFjaGVkIGYyZnNfYnVnX29uKCk7IHRoZSByZXN0
IHdlbnQgdGhyb3VnaAo+IHRoZSBoZWxwZXIncyBvd24gcGF0aCwgd2hpY2ggc2V0cyBTQklfTkVF
RF9GU0NLLCB3YXJucyBhbmQgY2FsbHMKPiBmMmZzX2hhbmRsZV9lcnJvcigpLiAgQWZ0ZXIsIGFu
eSBvZiB0aGVtIEJVRygpIHVuZGVyIENPTkZJR19GMkZTX0NIRUNLX0ZTLgpGb3IgTk9ERV9UWVBF
X1JFR1VMQVIsICBhZGQgdGhlICBjYXNlIG9mIOKAnGlmKGlzX2lub2RlICYmIGlzX3hub2RlKeKA
nSB0bwp0aGlzIGZsb3csCmFpbSB0byBjaGVjayByZXR1cm4gdmFsdWUgIG9mIGYyZnNfc2FuaXR5
X2NoZWNrX25vZGVfZm9vdGVyICYmIHJlbW92ZQpyZWR1bmRhbnQgIGZvb3RlciBpbmNvbnNpc3Rl
bmN5IGNoZWNr44CCCj4KPiBUaGUgb3RoZXIgdHdvIGNhbGxlcnMgd2VudCB0aGUgb3RoZXIgd2F5
LiAgX193cml0ZV9ub2RlX2NhY2hlKCk6Cj4KPiAgICAgICAgIGlmIChmMmZzX3Nhbml0eV9jaGVj
a19ub2RlX2Zvb3RlcihzYmksIGVudHJ5LCBlbnRyeS0+aW5kZXgsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5PREVfVFlQRV9SRUdVTEFSLCBmYWxzZSkpIHsKPiAg
ICAgICAgICAgICAgICAgZnNlcnJvcl9yZXBvcnRfbWV0YWRhdGEoc2JpLT5zYiwgLUVGU0NPUlJV
UFRFRCwgR0ZQX05PRlMpOwo+ICAgICAgICAgICAgICAgICBmMmZzX3N0b3BfY2hlY2twb2ludChz
YmksIGZhbHNlLCBTVE9QX0NQX1JFQVNPTl9DT1JSVVBURURfTklEKTsKPiAgICAgICAgICAgICAg
ICAgZ290byByZWRpcnR5X291dDsKPiAgICAgICAgIH0KPgo+IGFuZCB0aGUgcmVhZCBjb21wbGV0
aW9uIHR1cm5zIGl0IGludG8gQkxLX1NUU19JT0VSUi4gIFdvcnRoIGEgbGluZSBpbiB0aGUKPiBj
aGFuZ2Vsb2cgZWl0aGVyIHdheS4KPgo+IEZBVUxUX0lOQ09OU0lTVEVOVF9GT09URVIgaXMgaW5q
ZWN0ZWQgaW5zaWRlIHRoYXQgaGVscGVyLCBzbyB3aXRoCj4gQ09ORklHX0YyRlNfQ0hFQ0tfRlM9
eSBpbmplY3RpbmcgaXQgbm93IHBhbmljcyBpbnN0ZWFkIG9mIGV4ZXJjaXNpbmcgdGhlCj4gZXJy
b3IgcGF0aC4gIERlbGliZXJhdGU/Cm9oICxzb3JyeSwgSSBtaXNzZWQgdGhpcywgdGhhbnNrIGZv
ciBwb2ludGluZyBpdC4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
