Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E491C5475B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:45:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ridLM-0006Yj-US;
	Fri, 08 Mar 2024 16:45:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ridLL-0006Yd-2z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Mar 2024 16:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5wSPkqNQKuirNVQysLHjiteBxJpX+2d65nTJ9uim6LA=; b=ltcfAAY9Nv6U3dRsa07UJuv6rm
 cOggmyF4y1LXiJeAykdGIirPGar6JkSMtME0Yj7eX7lzHdcLM10eKRvu1cFKdiVS687ZsZUi2YHJt
 MVYsdsIiXz3nzCvrFFyRuK9VvIjFIj81KnN1XgGqNFCmwK3bBTCrwTqatfjZm2B7Yd9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5wSPkqNQKuirNVQysLHjiteBxJpX+2d65nTJ9uim6LA=; b=CyafN1n9/hExdhOMV6072SydVM
 xE++c+hoOjERNXYrK2NbW9ZFWgf6L3Qu75d9rCGYy4pqm2HS+Shs0hZabG/Dlt3bAUBx1CK15J74i
 d86biNzSF4LpLefLZ4RFxMb/z7jVHufnIonDkF+MYY/qUoCVqD6+15J7dE/A4cytmbBw=;
Received: from mail-vk1-f177.google.com ([209.85.221.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ridLA-0003CL-8Q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Mar 2024 16:45:11 +0000
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-4d33e0c1b3eso342080e0c.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 08 Mar 2024 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709916300; x=1710521100; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wSPkqNQKuirNVQysLHjiteBxJpX+2d65nTJ9uim6LA=;
 b=LG5ywKx/Om7mhQeBniyj+YVLHMWUmI7/DBkG3s5zQKUYUSnT+iAL8Q6FDc0HC9OLN8
 MsaCHBlQ4vID0u59BvLnJppaaWtYEKSzMCcWBHLWPJBxbG2Y9u8lQ8SI53Z9ASJgMYlo
 crKO3luaHLamQJl0XIJu5GKpPTVmD+1g3+G3EMOUYh+D5ur6XVQ0AwBBjVw3+21T5zKd
 bCZIE7QBlwJtMr+DyUH9abm2E3E9qno91f85Pm0XIkXFmON7beNrM82CT+mnahh2/bzv
 pc6Bp5z/QISGcKj8ZMr3ItoE/bB0ug+H8Q0zWKn61cvUkmagweRhXxkAhUcSdfxhbBaD
 dBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709916300; x=1710521100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wSPkqNQKuirNVQysLHjiteBxJpX+2d65nTJ9uim6LA=;
 b=EPmwU97VKNg4N7BYRUyQDZAZfz3JymvwD+2ef+ttfqygqI7rALhwZoMZBjEanQ5ScY
 nHCXqo1DylDMCoChf+ofm4r7mw/J1OaIdWSIO1Dh9KJ0jQcmek7CeOQB7knfV9E23X7V
 +Ty2SbKscB0/lDjwgEsGWUfkCJZl82YiO+dHEB5Z+omr+d6WPYSVbhMzHuAIcvhIDPEL
 yXw+/AVCTr38n5ljXNluoR1u503hOj0qCRbiZlJJHDREtJef4N/rSF7ylTITUyBlUXQ+
 BfO5Y8pwTkGkTBxf/68JcXul9o/kTn0/+dWZEqZc+OYb3b9M3XIzdK44QO1elb3T9urR
 gPHQ==
X-Gm-Message-State: AOJu0Yy1BIRj8CwqmQejssAp3Q2+chDqGWfJHZ3Qf3Aenjq+1fdSbXi6
 03rO2Me76BkKYysWZa3r0c+6BPseE3ob+LZasHrfeMEvu1jap4iHQeEIW5J21EpMsZW1+QUmRPK
 /r9Nfjz+cp1vr9p1g9ToFPhbQcCb1vZACIr4=
X-Google-Smtp-Source: AGHT+IH3fn1Arav1LCNeWZCdoVuzsKeGCmBuFPAbAV2y+CK8RXQId0X+jUe9jI88j6EiaOXIrcuf51P8/P/FIaR5zyQ=
X-Received: by 2002:a1f:7308:0:b0:4d3:b9c0:c735 with SMTP id
 o8-20020a1f7308000000b004d3b9c0c735mr5794919vkc.2.1709916298638; Fri, 08 Mar
 2024 08:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20240224011411.3820719-1-jaegeuk@kernel.org>
 <ZdlNtvzBXOXmUBg8@google.com>
In-Reply-To: <ZdlNtvzBXOXmUBg8@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 8 Mar 2024 08:44:47 -0800
Message-ID: <CACOAw_xyPNCMPbEQTBO-zNE63nChc2kmx+mHE+AE26m2LDcP7A@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1ridLA-0003CL-8Q
Subject: Re: [f2fs-dev] [PATCH v2] mkfs.f2fs: should give section-aligned
 reserved segments
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

UmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+CgpPbiBGcmks
IEZlYiAyMywgMjAyNCBhdCA2OjAy4oCvUE0gSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBUaGUgcmVzZXJ2ZWQgc2VnbWVudHMgc2hvdWxkIGJlIGFsaWduZWQgdG8g
dGhlIHNlY3Rpb24gYm91bmRhcnkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYWVnZXVrIEtpbSA8amFl
Z2V1a0BrZXJuZWwub3JnPgo+IC0tLQo+Cj4gICB2MjoKPiAgIC0gZml4IGJ1Zwo+Cj4gIGluY2x1
ZGUvZjJmc19mcy5oIHwgMTIgKysrKysrKy0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9mMmZzX2Zz
LmggYi9pbmNsdWRlL2YyZnNfZnMuaAo+IGluZGV4IDkwNTZlMDJhY2QyOS4uZmM1NjM5NmZhMzU4
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvZjJmc19mcy5oCj4gKysrIGIvaW5jbHVkZS9mMmZzX2Zz
LmgKPiBAQCAtMTc2MCwyNSArMTc2MCwyNyBAQCBleHRlcm4gdWludDMyX3QgZjJmc19nZXRfdXNh
YmxlX3NlZ21lbnRzKHN0cnVjdCBmMmZzX3N1cGVyX2Jsb2NrICpzYik7Cj4gICNkZWZpbmUgWk9O
RV9BTElHTihibGtzKSAgICAgICBTSVpFX0FMSUdOKGJsa3MsIGMuYmxrc19wZXJfc2VnICogXAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjLnNlZ3NfcGVyX3pvbmUp
Cj4KPiAtc3RhdGljIGlubGluZSBkb3VibGUgZ2V0X3Jlc2VydmVkKHN0cnVjdCBmMmZzX3N1cGVy
X2Jsb2NrICpzYiwgZG91YmxlIG92cCkKPiArc3RhdGljIGlubGluZSB1aW50MzJfdCBnZXRfcmVz
ZXJ2ZWQoc3RydWN0IGYyZnNfc3VwZXJfYmxvY2sgKnNiLCBkb3VibGUgb3ZwKQo+ICB7Cj4gLSAg
ICAgICBkb3VibGUgcmVzZXJ2ZWQ7Cj4gICAgICAgICB1aW50MzJfdCB1c2FibGVfbWFpbl9zZWdz
ID0gZjJmc19nZXRfdXNhYmxlX3NlZ21lbnRzKHNiKTsKPiAgICAgICAgIHVpbnQzMl90IHNlZ3Nf
cGVyX3NlYyA9IHJvdW5kX3VwKHVzYWJsZV9tYWluX3NlZ3MsIGdldF9zYihzZWN0aW9uX2NvdW50
KSk7Cj4gKyAgICAgICB1aW50MzJfdCByZXNlcnZlZDsKPgo+ICAgICAgICAgaWYgKGMuY29uZl9y
ZXNlcnZlZF9zZWN0aW9ucykKPiAgICAgICAgICAgICAgICAgcmVzZXJ2ZWQgPSBjLmNvbmZfcmVz
ZXJ2ZWRfc2VjdGlvbnMgKiBzZWdzX3Blcl9zZWM7Cj4gICAgICAgICBlbHNlCj4gICAgICAgICAg
ICAgICAgIHJlc2VydmVkID0gKDEwMCAvIG92cCArIDEgKyBOUl9DVVJTRUdfVFlQRSkgKiBzZWdz
X3Blcl9zZWM7Cj4KPiAtICAgICAgIHJldHVybiByZXNlcnZlZDsKPiArICAgICAgIC8qIExldCdz
IGtlZXAgdGhlIHNlY3Rpb24gYWxpZ25tZW50ICovCj4gKyAgICAgICByZXR1cm4gcm91bmRfdXAo
cmVzZXJ2ZWQsIHNlZ3NfcGVyX3NlYykgKiBzZWdzX3Blcl9zZWM7Cj4gIH0KPgo+ICBzdGF0aWMg
aW5saW5lIGRvdWJsZSBnZXRfYmVzdF9vdmVycHJvdmlzaW9uKHN0cnVjdCBmMmZzX3N1cGVyX2Js
b2NrICpzYikKPiAgewo+IC0gICAgICAgZG91YmxlIHJlc2VydmVkLCBvdnAsIGNhbmRpZGF0ZSwg
ZW5kLCBkaWZmLCBzcGFjZTsKPiArICAgICAgIGRvdWJsZSBvdnAsIGNhbmRpZGF0ZSwgZW5kLCBk
aWZmLCBzcGFjZTsKPiAgICAgICAgIGRvdWJsZSBtYXhfb3ZwID0gMCwgbWF4X3NwYWNlID0gMDsK
PiAgICAgICAgIHVpbnQzMl90IHVzYWJsZV9tYWluX3NlZ3MgPSBmMmZzX2dldF91c2FibGVfc2Vn
bWVudHMoc2IpOwo+ICsgICAgICAgdWludDMyX3QgcmVzZXJ2ZWQ7Cj4KPiAgICAgICAgIGlmIChn
ZXRfc2Ioc2VnbWVudF9jb3VudF9tYWluKSA8IDI1Nikgewo+ICAgICAgICAgICAgICAgICBjYW5k
aWRhdGUgPSAxMDsKPiBAQCAtMTc5NSw3ICsxNzk3LDcgQEAgc3RhdGljIGlubGluZSBkb3VibGUg
Z2V0X2Jlc3Rfb3ZlcnByb3Zpc2lvbihzdHJ1Y3QgZjJmc19zdXBlcl9ibG9jayAqc2IpCj4gICAg
ICAgICAgICAgICAgIG92cCA9ICh1c2FibGVfbWFpbl9zZWdzIC0gcmVzZXJ2ZWQpICogY2FuZGlk
YXRlIC8gMTAwOwo+ICAgICAgICAgICAgICAgICBpZiAob3ZwIDwgMCkKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKPiAtICAgICAgICAgICAgICAgc3BhY2UgPSB1c2FibGVfbWFp
bl9zZWdzIC0gbWF4KHJlc2VydmVkLCBvdnApIC0KPiArICAgICAgICAgICAgICAgc3BhY2UgPSB1
c2FibGVfbWFpbl9zZWdzIC0gbWF4KChkb3VibGUpcmVzZXJ2ZWQsIG92cCkgLQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyICogZ2V0X3NiKHNlZ3NfcGVyX3NlYyk7
Cj4gICAgICAgICAgICAgICAgIGlmIChtYXhfc3BhY2UgPCBzcGFjZSkgewo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIG1heF9zcGFjZSA9IHNwYWNlOwo+IC0tCj4gMi40NC4wLnJjMC4yNTguZzcz
MjBlOTU4ODYtZ29vZwo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
