Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B435C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjJb+/SBGuLsM5dBr7WsROB7wtE+BMAfXAlRooLSdJ0=; b=jFvdt+5iZcYWPkNQjgSQ7m3Eyb
	k8oW0stvDJrUTNvg+xyRhvrsnvEUskASqa2mxF21GxFTvnM8t9jZsb2JWU2PCQtmwqLbx4aPWgrPv
	vhDuliyg6Sgm4DtX/M19Ynnp3gBIDNZNsuRtdDlfUGldJdfsBiFjFmpplxY0vvtPikhg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x01ET-0000IS-H0;
	Fri, 28 Aug 2026 18:23:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x01EC-0000GM-BU
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 18:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oLLWpA7UkByQ7zwy3ykP7hLm5Nq+lnUYf3Hct5wt0Lc=; b=JWyBBr2Bsh7qM3lyID+tmryOC0
 TfA3/Gzwjz+QEpHt6w6XU2TeZmP2GK5NPJ7YDqeRYE2C7CAPnSEOEsyc8w9A+cTPiNkZrFFkV0PUW
 gPQcE3s0EiQp2mtVLU0hJxYoGf2Z28TkOle64PltlTtZNKTyi2IRVVzEq6/LkmNIafAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oLLWpA7UkByQ7zwy3ykP7hLm5Nq+lnUYf3Hct5wt0Lc=; b=EMcbltm5uoq/s72IcNPLYEJt7F
 PUjlH4ib2wZDQMHSyZoMSjXj9AiY6FnByhBc6ewx9RKOos+ez57QllQXZU2sDqlouzI7/zI+Lccrr
 UPLNdseY6mIGIvJ/aWTzAFGYwt+hqagKfPvdecFi9awAnN7u3+oQtVp+yOzweymNo7Kk=;
Received: from mail-lf1-f54.google.com ([209.85.167.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x01EB-0002l5-Nh for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 18:23:01 +0000
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b4aff8e8c4so1191272e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 11:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787941373; cv=none;
 d=google.com; s=arc-20260327;
 b=O0wrs5uRUGNkzYFNTFHy4EGjeo7X8UFBVg1IOGg1OJnfLlzNAvxEHJxk4+HEbh/Da7
 1cl/EFpUnCpl5qTX0aFTYEuph+jItL51CcV/UYAs0JQLABBSUdGb1R84UpJtths+T7I1
 q6i/Y6SC855ou7Yusgifm35jMiQerG7ra1MVDB19wqkNzLcR4BVjuCC/K59L1KV407du
 EUqTey8L1Gg1xo+CUFNM2HbmbJWwCL8DwZdbanKweHRPeGX01p8NpFWy9I6zwsIEbxGh
 SKfmNi8dn8dvgyQ5kSwgU5rLCTCFHzXdIOY4V+KQdBJF1xqtOWF4NRg1syjyoL/UQn0K
 G1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oLLWpA7UkByQ7zwy3ykP7hLm5Nq+lnUYf3Hct5wt0Lc=;
 fh=Svio2X2feZhqiP46Y+sYTCL3aujR3QMQnrxpvWbYzTA=;
 b=dRcrKts2OIhVOdbFYSgMNa+KiF2nOxvsKvIkR5TWZpWTpKbMFYMgmLKAfyKLfVZLcG
 jfxpO3ZpTy1RjGf+wflBJ0bfkINgC2UyDRm8k8iFtxpjLrSShFzN+94LQVcUdWo14pxj
 a5NINYZvMEG70hMPqBrmmU/sUOIxiL5WDxA9wIyJxU4Dg5U5s9eGOwIWMHa+yQmMYCzE
 MyDT8SbTVvEXW+Hfk4ewa9vksHkGYQMeCGZigcRMfAmGlLs2pxkPZuycms7L3DVodXX1
 IhLSefJd2+sqVxAuYHL7OOKr6puHAECMSl0AHd2zus/b+/zw5Au2THrmMv1bwRq7lVlJ
 j5sw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787941373; x=1788546173; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLLWpA7UkByQ7zwy3ykP7hLm5Nq+lnUYf3Hct5wt0Lc=;
 b=SMzzMVOD/6ePTGBIwr/tCbq5Jyn5eVo1wZwmW0jVIeTkQda3zGwMbW/MBo5mjFcqNu
 IkDOtCKvN0mmshV3B83kGkjJS3c/BRSs38TRjhkstg4CdAKYXRJQF3mPM8z1ozgqJTcd
 zNnfjTGoCnP7U1EUu4BwyWBkgrJzX/7eZRshenmlrhFSflQtBkDBculDQbStvW4DFI+/
 8rwO47aKLCbxoLOYTOKPIiATPx1jZM7fPHomHSRLKA5EKqJwvAQG+IEYLYuutkxQA9py
 kcS8j/LJ8WPWPxsBvu2p9smjVhXjCHwi6rZl7Nl4ABJwmP5uVX6K/5fVlTPzhdvSqQ6L
 xuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787941373; x=1788546173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLLWpA7UkByQ7zwy3ykP7hLm5Nq+lnUYf3Hct5wt0Lc=;
 b=lPZScYFQGmhF5qCGwyKMJuiV5j/BuWF0ogI0TsZ54pFPfkpL6f68FpHYoD5ecypG9r
 AN7/cvSTdZcKbJjtqdz4QZqBSWBheM4q2fDU6fMbJiObfiZ3I9nw8Gh0INHZXaYN4l44
 9Tt30Qej1s3+zwWcB04fAy5ZyYutJAw7ZewkJ9ZWdVyPzGP/l/vrCZhXqDeSAvYTx/q1
 T9J29EhuJWS9D8lZ/CwkqX7ufzYD32Ci4ahNJy+GoflgXhW6988Yu/2LMqal3MFzxZEr
 V9vuS3vz4QP9f/Gxkz6xUKdQ7gAE8y79qnz3B8ujYgQk+o6dxh63fOys/2wic+Dh0fDn
 ibtw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8yRyEOFqNDYBm+yB2ubeXjUk6AHyo3fv6HjH0ZL8jFSz4zVlnf8sgyNELaDqYPxBzNiTRCswL8LKE3TuCpWq/@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1Pm06mHsif93PE0jwsGDpwcdWA0fy7kM2zGaB0XfPTG0On9z4
 aHXF066uKy+RK4S162sMUjwsdv0iwon1BEsItflT+eBWgJ0ecY/GxmyaVU9hmPv5j13TnJjO7Vw
 izQuF3P9Fgf7ZRP9dYJNgwwTbjKg1v2A=
X-Gm-Gg: AR+sD10zwF9lmlVD6z9e0BiD1XMT7LUAyWg2UOvVNdbqLgb4GlgqWoO/wbwWSw3gkMe
 U8oOGh6PNS6ZXNsS+WOatGPEeZt9ZE+mXzVO40IWP2nMmApBZ30KRXnpqYb/VZZQxd8GApkTTXC
 Kf2X95PYH7nA0qwDTbWxEJ5tzB11F19fkSo20sQrlqNEAOTdYr+U+RDs0obJJJOzhlnX5DKyLO3
 M/FY+yT3UdgRjyAXpwyfPoq3TN7U0Q7k2+0kqGgafQ7hUAVA0DlLvWwQcQfYgBh3TZozcsH+OgO
 FwDCZTf4X8oU0b1qsTgqnfUAgmK5Ytm0eZyl8wEL+SqOtLCC7xDYJAXrLz+y6/Hx75M0lvr6c9+
 DLHn7XU6uGDZBJlnqUZr1i4SU3lJMIOoknrA=
X-Received: by 2002:a05:6512:1248:b0:5b5:ef13:5bda with SMTP id
 2adb3069b0e04-5b5ef135cd3mr136646e87.9.1787941372640; Fri, 28 Aug 2026
 11:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
 <b4711014-844e-45c0-b85a-4e3a98d7137c@kernel.org>
 <12dc55dd-f85d-4f21-8eac-f1042bcf0565@kernel.org>
In-Reply-To: <12dc55dd-f85d-4f21-8eac-f1042bcf0565@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 28 Aug 2026 11:22:40 -0700
X-Gm-Features: AcwNN1UEfcN4VxIkT4-9GbXI8caiY-ku97cijW_B7gjP7FaCFtCNTayTSYPOTUc
Message-ID: <CACOAw_zaxYUzPUSktX1KWeZ1Ha1gH1dC4hX81d9CehWDGTqtDg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x01EB-0002l5-Nh
Subject: Re: [f2fs-dev] [PATCH v3 09/12] f2fs: cache: use compress cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBBdWcgMjgsIDIwMjYgYXQgNToyNeKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzI4LzI2IDIwOjAwLCBDaGFvIFl1IHdyb3RlOgo+ID4gT24gOC8y
Ny8yNiAwNDowNCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPj4gT24gVHVlLCBBdWcgMjUsIDIwMjYg
YXQgNjowM+KAr0FNIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwKPiA+Pj4gKyAgICAgICAg
ICAgICAgIGYyZnNfbG9ja19jYWNoZShlbnRyeSk7Cj4gPj4+Cj4gPj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGlmIChpbm8gIT0gZm9saW9fZ2V0X2YyZnNfZGF0YShmb2xpbykpIHsKPiA+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOwo+ID4+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ID4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICB9Cj4gPj4+IC0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Z2VuZXJpY19lcnJvcl9yZW1vdmVfZm9saW8obWFwcGluZywgZm9saW8pOwo+ID4+PiAtICAgICAg
ICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOwo+ID4+PiArICAgICAgICAgICAg
ICAgaWYgKCFmMmZzX2lzX2NvbXByZXNzX2NhY2hlKGVudHJ5KSkgewo+ID4+Cj4gPj4gSG93IGlz
IHRoaXMgcG9zc2libGU/Cj4gPj4gb3IgaWYgKCFlbnRyeS0+Y2FjaGUpPwo+ID4KPiA+IEkgc3Vm
ZmVyIGEgcGFuaWMgZnJvbSBmMmZzX2J1Z19vbihzYmksICFmMmZzX2lzX2NvbXByZXNzX2NhY2hl
KGVudHJ5KSkgaGVyZSwKPiA+IGl0IG1heSBzdWZmZXIgcmFjZSBjb25kaXRpb24gdy8gc2hyaW5r
ZXIuCj4KPiBJIGNoYW5nZWQgbGlrZSB0aGlzLCBiZWNhdXNlOgo+IDEuIHdlIHdpbGwgbmV2ZXIg
dXBkYXRlIGVudHJ5LT5pbm8gYWZ0ZXIgaW5pdGlhbGl6YXRpb24sIHNvIGl0J3Mgc2FmZSB0bwo+
IGNoZWNrIHcvbyBsb2NrLgo+IDIuIGYyZnNfdHJ1bmNhdGVfY2FjaGUoKSBoYXMgY2hlY2tlZCBl
bnRyeS0+Y2FjaGUgYnkgaXRzZWxmLCBzbyBpdCBkb2Vzbid0Cj4gbmVlZCB0byBjaGVjayB3LyBm
MmZzX2lzX2NvbXByZXNzX2NhY2hlKCkgb3V0c2lkZSBfX2YyZnNfdHJ1bmNhdGVfY2FjaGUoKS4K
Pgo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG5yOyBpKyspIHsKPiAgICAgICAgICAgICAgICAg
c3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrICplbnRyeSA9IGVudHJpZXNbaV07Cj4KPiAgICAgICAg
ICAgICAgICAgaW5kZXggPSBlbnRyeS0+aW5kZXggKyAxOwo+Cj4gICAgICAgICAgICAgICAgIGlm
IChlbnRyeS0+aW5vICE9IGlubykKPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsK
Pgo+ICAgICAgICAgICAgICAgICBmMmZzX3RydW5jYXRlX2NhY2hlKGVudHJ5LCBmYWxzZSk7Cj4g
ICAgICAgICB9Cj4KPiBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgY29uY2VybiBhYm91dCB0
aGlzLgoKSGkgQ2hhbywKClRoaXMgbG9va3MgbXVjaCBjbGVhbmVyIGFuZCBzdHJhaWdodGZvcndh
cmQuCgpJIGhhdmUgbm8gZnVydGhlciBjb25jZXJucyBvbiB0aGlzIHBhcnQuCgpUaGFua3MsCgo+
Cj4gVGhhbmtzLAo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
