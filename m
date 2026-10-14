Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FD2CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bl+dqldBwpsg7wsc9idh95P4cvbMN8OjJlcVyZ0zIfU=; b=ZKw0z7gGpGZTO8ehi3EsEx6Doa
	xxH4i32lzmvzB2QSyMfMRxLg00rd1MKjdQJjq2nJZWSxjUIdR+Pv+IJZbmNmA1vVa6OBhCSJZOaFu
	3arCcaKn6S6jYaoKb56FvFqdRO457OpReh5PAQyyCjPAXxwcma3YcyELI8kyDBWyjkKk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGr2S-0008J4-6D;
	Wed, 14 Oct 2026 04:56:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGr23-0008Ik-22
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 04:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=72b+1LHt9+hdKqPyNvJXnq6JkgqKmPUrz61pnObU+/c=; b=ZQjSvo16B+e6kEEtW/CgLtAz9A
 L4I4v3syHS9Mb146HPFMHChj/MepDJlfVvEXZcCkcC7FvQbfAy6JeptOJ4T/HTCqId0uFOVF8h/hI
 04Rr2tu1XoWFeh5arlyWxPe1s8SD7ssWghgWA/OPMoGS3vZpjnicyC22kXMKdQtKQfxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=72b+1LHt9+hdKqPyNvJXnq6JkgqKmPUrz61pnObU+/c=; b=LnwTCZ0/KrODeRNPhetuvP4bDN
 emHd+rbD4FQn4aot4D4G27w02Bw8lvfohjkCggBxfkiHtP3FPYKYo1RvWLNFVHBlSZV1PQBz9K+os
 ggvH30atwsgijQdRFRyZsrO1DAU9ugW6ZuApEspqh9zX5yXAOvDYQntt8xhxSgRILK3A=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGr22-00033j-Cc for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 04:56:03 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-88bd2b44f3aso1744883b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 21:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791953757; cv=none;
 d=google.com; s=arc-20260327;
 b=AFpOew+C5SZzfjp7IwC+HYX/cmWipSPCYtIspI5reT5Rep6bEZTEiwZmAF8M/RdH07
 SSWScbPK+v6gW/P9rrPZ/qnsvGgzxEoTMNjIzWPgz68viFTYoOVVlWfcJW8lGDFFvOKB
 MzfqefleTnXHiDw2rTf3pME2le/weMZmj2BOI8fust+DH5M+gOmYRmCTSIooSr3vqz1J
 4+JXrA1CGpZanunK+W1oSLqUBCELVxfVzV1pja/vLu1EUiF7bhuey843qgts3jxOMrYl
 DDKGherOsWGH2d1AyGDLbYSSOezq5LDE4ah9HwSB/sPE67aibjvk5xyd7UQ4S2Bgcsb7
 bObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=72b+1LHt9+hdKqPyNvJXnq6JkgqKmPUrz61pnObU+/c=;
 fh=jxoP1fT7Ojq3Ay3Td1KxvMvbE9oUJ6z0e870KwLoXlQ=;
 b=Rzf/iK2Hm+gVrIW4RNiqwDL4zujL8j+w9NUM5IJ0U3BRCT7uTHqrANcdB3u5j5Sqiy
 gpe3Rpdmkur5n9x1vJ/SuM5X27AJU4v9txvJ2rLdsP9ZkxjoJHLh3ZrLk7105N1dZsSw
 DsT+WuOxXi+SmGwIYu8UMHDgezgcECMNzoU4foi3VAivqmxMpDTqsu1QD72XkgzVbqx1
 orAS8Ux6sn1ifppfZ5amifjItiaiFV4NggUptpxvjSz2isvxH6HsN2yZPOkkemGWdzwq
 Jt/nurWViSd7/KL3k85ck8WliQoeWBeEA2c+0Cd3XWpYOdtzxU3GgTHrCkUqksVYart5
 NqJA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791953757; x=1792558557; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=72b+1LHt9+hdKqPyNvJXnq6JkgqKmPUrz61pnObU+/c=;
 b=M+KosgKj6TbwGISacSpg6pL1VpjtN7+4e1Bg+H+MK9kI/lZkLrFHuPlT/DTTNQlypD
 StbmWbnYxQHTw9uSF3UkeP3JXOv7rZiM7bdFZCk6EtimTZdqcnhjcHhlgHpg+UcvDilo
 YYPO6/hRpVfEV0IapkcY8zaTXgHcd0foqUO+CQ20XVZXxHmqUZNvNu+9xDQ4a+38INhJ
 VzRTiOkeDLowdbKsyoA37X8eZA13R/LsvIi/CQDy/WHCUrZjcUD5XSgd3Or5qzo7QHcD
 utJs8oRz2B4j6JIKW9B11QKUTLGphsWILF09XrL5NI1wQZ/JmJgmEd0OTheIyDvXJhAK
 2UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791953757; x=1792558557;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=72b+1LHt9+hdKqPyNvJXnq6JkgqKmPUrz61pnObU+/c=;
 b=aH8QjSg2IOZw8ifdZklphoX1kyH9NVCuTDSk7WUNQdauyDaMwf7fEGRXBXZI2ixZsh
 bP1y2LaV9sWZAKaotr4Ssuv9sDzvd93i3D6KjZbQhcrI5jFqnRicqeMQ0l2mqRScDINs
 8IrzRNM9AieUwJwXR1r0MOB1Cim5v3+2K4YK1bfrSjhkUCtVkAJcyHCiXippB7QvgCYD
 CcXz8Q2cxCZgASCK3h3Dj/QiOhLIvpFi1gnjnlXBdieLvTNhD7A3BoD4DywToMWD0xoQ
 BcHFFdew3n7QHuCMmx1kT09Rq9LLarLykUx7ZTI2SeM7bJAQYlrukYP146YeSgjGMn5R
 pWyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgvBa5Ii2NDpbpLmXjD7YMTg6jUyyEpXdT9RrgNmqPksB7h6Do7ZjU2jDYSX5P8BAK3imwfJg+FlaDr3g95O6r@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI2YQe2mbQn9/TsO0Ro45l7wCVegYRaQDzp1ov+TLZdl8mRjHNM
 hK04ozN1YXXGsxN3nSpzX9RM6XZG8LsMHfao845HJXGPrx+H/wkeUpB3N4mvU0F5rQvDTik0l4m
 hozHt2nbQKuKrp9TxRmj45XUXhgxTpxW2GqE8XNE=
X-Gm-Gg: AYBFou38M71SrDfKB2heQ2SJSeTL1Qs8tIFnHl8yEooxHmBIrMWEOPhP4RyDThhoOVQ
 Spv40NBMThDCTtIHWwy3ohQjnXzyHjCK5X9OhqD2k860hkOVbLSTCdSy2EeoRbv3ZqFl/6r8akp
 3hjsZeWwjqv/GvJcKeYiWPQCVM2rlBEK5R1NKILo9jPfuaPjMSc7/11a4o0tneJIQ7L9e56XrsH
 RUWEz8DFGoHzdbaJM46opujjY0o9LfA66SBk47vNwhaKbrOEY2ynfD8DabwR6da7eOZgB9EVA3u
 r57r84LSAWd2mZmeKRgWucuRs29MLJfaJBeRK6IFksUrlsnjyKe8NUcDKAo7kqpOuybXQB64Dt6
 x17SA7wm8wgBgM9goSB5m1gMCFWUzee70utAqTYyv9OM7
X-Received: by 2002:a05:6a00:368e:b0:883:71f6:601 with SMTP id
 d2e1a72fcca58-897c76e3765mr11567880b3a.41.1791953756545; Tue, 13 Oct 2026
 21:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
 <20260829060524.2656620-2-qiwenjie@xiaomi.com>
 <20260829060524.2656620-3-qiwenjie@xiaomi.com>
 <CACOAw_z1UUG0e+LSGmer_mPv+YcYVcjFiMLZ6RwhmYtmrObKXA@mail.gmail.com>
 <20260901025344.3466776-1-qiwenjie@xiaomi.com>
 <CACOAw_wnDrd_iQ1GALuYx59Pc3-qJeZbNU1JajsHJ5zMSvabow@mail.gmail.com>
In-Reply-To: <CACOAw_wnDrd_iQ1GALuYx59Pc3-qJeZbNU1JajsHJ5zMSvabow@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 13 Oct 2026 21:55:42 -0700
X-Gm-Features: AclHuK_crll8FUHdLlNNloeiQF3l22usDO_LM1nZ5NybgUyewYvKqc9W-b88SdA
Message-ID: <CACOAw_xV4J8r6exS3ZdTA1aY_bjQ+PFL5LVn4ymLanxqHGqLGQ@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1xGr22-00033j-Cc
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

T24gVHVlLCBTZXAgMSwgMjAyNiBhdCA4OjU44oCvQU0gRGFlaG8gSmVvbmcgPGRhZWhvNDNAZ21h
aWwuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgQXVnIDMxLCAyMDI2IGF0IDc6NTPigK9QTSBXZW5q
aWUgUWkgPHF3amh1c3RAZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBIaSBEYWVobywKPiA+Cj4g
PiBUaGUgc2Vjb25kIGNoZWNrIGlzIGludGVudGlvbmFsLiBUaGUgZmlyc3QgY2hlY2sgaXMgb25s
eSBhbiBlYXJseQo+ID4gdmFsaWRhdGlvbiBiZWZvcmUgbW50X3dhbnRfd3JpdGVfZmlsZSgpLCBi
dXQgbW50X3dhbnRfd3JpdGVfZmlsZSgpIGRvZXMKPiA+IG5vdCBob2xkIHNiLT5zX3Vtb3VudC4g
QSBjb25jdXJyZW50IHJlbW91bnQgY2FuIHRoZXJlZm9yZSBjaGFuZ2UKPiA+IHJlc2l6YWJsZV90
YWlsX3NlY25vIGJlZm9yZSBmcmVlemVfc3VwZXIoKSBvYnRhaW5zIHRoZSBleGNsdXNpdmUKPiA+
IHN1cGVyYmxvY2sgbG9jay4KPiA+Cj4gPiBBIHRlc3Qtb25seSBob29rIHBhdXNlcyByZXNpemUg
YWZ0ZXIgdGhlIGVhcmx5IGNoZWNrIGFuZCBiZWZvcmUKPiA+IG1udF93YW50X3dyaXRlX2ZpbGUo
KSwgYWxsb3dpbmcgYSBjb25jdXJyZW50IHJlbW91bnQgdG8gY2hhbmdlCj4gPiByZXNpemFibGVf
dGFpbF9zZWNubyBiZWZvcmUgcmVzaXplIGNvbnRpbnVlcy4gU3RhcnRpbmcgd2l0aCA1MDYgc2Vj
dGlvbnMKPiA+IGFuZCB0YWlsPTEsIHRoZSBzaW5nbGUtY2hlY2sgdmVyc2lvbiBsZXQgYSByZW1v
dW50IGNoYW5nZSB0aGUgdGFpbCB0bwo+ID4gMTI4IGFuZCBpbmNvcnJlY3RseSByZXR1cm5lZCBz
dWNjZXNzLiBXaXRoIHRoZSBzZWNvbmQgY2hlY2ssIHJlc2l6ZQo+ID4gcmV0dXJuZWQgLUVJTlZB
TCBhbmQgcHJlc2VydmVkIDUwNiBzZWN0aW9ucyB3aXRoCj4gPiBwaW5uZWRfYXJlYV9tYXhfc2Vj
bm89Mzc4Lgo+ID4KPiA+IFRoZSBmaXJzdCBjaGVjayBpcyB0aGUgZmFzdCBwYXRoIGZvciBpbnZh
bGlkIHJlcXVlc3RzLCB3aGlsZSB0aGUgc2Vjb25kCj4gPiBjaGVjayB2YWxpZGF0ZXMgdGhlIGZp
bmFsIGdlb21ldHJ5IGFmdGVyIGZyZWV6aW5nIHRoZSBmaWxlc3lzdGVtIGFuZAo+ID4gdGFraW5n
IHRoZSByZXNpemUgbG9ja3MuIEJvdGggY2hlY2tzIGFyZSBuZWVkZWQuCj4gPgo+ID4gVGhhbmtz
LAo+ID4gV2VuamllCj4KPiBSZXZpZXdlZC1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29v
Z2xlLmNvbT4KPgo+IFRoYW5rcywKCkhpIFdlbmppZSwKClRoaW5raW5nIGFib3V0IHRoZSBhY3R1
YWwgdXNlIGNhc2Ugb2YgcmVzaXphYmxlX3RhaWxfc2Vjbm8gYSBiaXQgbW9yZSwKSSByZWFsaXpl
ZCB0aGVyZSBpcyBhIHNlbWFudGljIGlzc3VlIHdpdGgga2VlcGluZyByZXNpemFibGVfdGFpbF9z
ZWNubwp1bmNoYW5nZWQgYWZ0ZXIgc2hyaW5raW5nIHRoZSBmaWxlc3lzdGVtLgoKVGhlIHB1cnBv
c2Ugb2YgcmVzaXphYmxlX3RhaWxfc2Vjbm89TiBpcyB0byByZXNlcnZlIE4gc2VjdGlvbnMgYXQg
dGhlCnRhaWwgb2YgdGhlIGZpbGVzeXN0ZW0gKFtNQUlOX1NFQ1MgLSBOLCBNQUlOX1NFQ1MpKSBh
cyBhbiB1bnBpbm5lZCBhcmVhCnNvIHRoYXQgdGhvc2UgdGFpbCBzZWN0aW9ucyBjYW4gYmUgc2hy
dW5rIGxhdGVyIHZpYSBGMkZTX0lPQ19SRVNJWkVfRlMsCndoaWxlIGtlZXBpbmcgdGhlIHBpbm5l
ZCBhcmVhIGJvdW5kYXJ5IGZpeGVkIGF0IChNQUlOX1NFQ1MgLSBOKS4KCkZvciBleGFtcGxlLCBz
dXBwb3NlIGEgMzAgR2lCIGZpbGVzeXN0ZW0gKDE1LDM2MCBzZWN0aW9ucykgaXMgbW91bnRlZAp3
aXRoIHJlc2l6YWJsZV90YWlsX3NlY25vPTEwMjQwICgyMCBHaUIgcmVzZXJ2ZWQgYXQgdGhlIHRh
aWwgZm9yCnNocmlua2luZyksIHNvIHBpbm5lZF9hcmVhX21heF9zZWNubyBpcyA1LDEyMCAodGhl
IGZpcnN0IDEwIEdpQikuCgpXaXRoIHRoZSBjdXJyZW50IHBhdGNoLCBGMkZTX09QVElPTihzYmkp
LnJlc2l6YWJsZV90YWlsX3NlY25vIGlzIGtlcHQgYXQKMTAsMjQwIGFmdGVyIHJlc2l6ZSwgd2hp
Y2ggY2F1c2VzIHR3byBwcm9ibGVtczoKCjEuIFNocmlua2luZyB0aGUgdGFpbCBlYXRzIGludG8g
dGhlIHBpbm5lZCBhcmVhIGluc3RlYWQgb2YgY29uc3VtaW5nIHRoZQogICByZXNlcnZlZCB0YWls
OgogICBJZiB3ZSBzaHJpbmsgdGhlIGZpbGVzeXN0ZW0gYnkgNjQgc2VjdGlvbnMgKDEyOCBNaUIp
LCBNQUlOX1NFQ1MKICAgYmVjb21lcyAxNSwyOTYsIGFuZCBmMmZzX2FkanVzdF9waW5uZWRfYXJl
YV9ib3VuZGFyeSgpIHJlY2FsY3VsYXRlczoKICAgICBwaW5uZWRfYXJlYV9tYXhfc2Vjbm8gPSAx
NSwyOTYgLSAxMCwyNDAgPSA1LDA1NgogICBFdmVuIHRob3VnaCB3ZSBvbmx5IHNocnVuayA2NCBz
ZWN0aW9ucyBmcm9tIHRoZSB1bnBpbm5lZCB0YWlsLCB0aGUKICAgcGlubmVkIGFyZWEgYm91bmRh
cnkgc2hyaW5rcyBmcm9tIDUsMTIwIHRvIDUsMDU2LgoKMi4gV2UgY2FuIG5ldmVyIHNocmluayB0
aGUgZnVsbCByZXNlcnZlZCB0YWlsIChvciBldmVuIHBhcnQgb2YgaXQgaWYKICAgc2VjcyArIHJl
c2l6YWJsZV90YWlsX3NlY25vID49IE1BSU5fU0VDUyk6CiAgIEluIHRoZSBleGFtcGxlIGFib3Zl
LCBpZiB3ZSB0cnkgdG8gc2hyaW5rIGFsbCAyMCBHaUIgKDEwLDI0MCBzZWN0aW9ucykKICAgb3Ig
ZXZlbiAxMCBHaUIgKDUsMTIwIHNlY3Rpb25zKSBvZiB0aGUgcmVzZXJ2ZWQgdGFpbCwKICAgZjJm
c19yZXNpemVfdGFpbF9pbnZhbGlkKCkgcmVqZWN0cyB0aGUgcmVzaXplIHdpdGggLUVJTlZBTCBi
ZWNhdXNlCiAgIHNlY3MgKyByZXNpemFibGVfdGFpbF9zZWNubyA+PSBNQUlOX1NFQ1MgKDEwLDI0
MCArIDEwLDI0MCA+PSAxNSwzNjApLgoKV2hlbiB0aGUgZmlsZXN5c3RlbSBpcyBzaHJ1bmsgYnkg
YHNlY3NgIHNlY3Rpb25zIGZyb20gdGhlIHRhaWwsIHRoZQpyZXNlcnZlZCB0YWlsIGl0c2VsZiBp
cyB3aGF0IGlzIGJlaW5nIGNvbnN1bWVkLiBTbyBpbnN0ZWFkIG9mIGtlZXBpbmcKcmVzaXphYmxl
X3RhaWxfc2Vjbm8gZml4ZWQsIHdlIHNob3VsZCBkZWR1Y3QgdGhlIHNocnVuayBzZWN0aW9ucyBm
cm9tCkYyRlNfT1BUSU9OKHNiaSkucmVzaXphYmxlX3RhaWxfc2Vjbm8gKG9yIGNsYW1wIGl0IHRv
IDAgaWYgc2VjcyA+PQpyZXNpemFibGVfdGFpbF9zZWNubywgYW5kIHJlc3RvcmUgdGhlIG9sZCB2
YWx1ZSBvbiBjaGVja3BvaW50IGZhaWx1cmUKcm9sbGJhY2spIGJlZm9yZSBjYWxsaW5nIGYyZnNf
YWRqdXN0X3Bpbm5lZF9hcmVhX2JvdW5kYXJ5KHNiaSkuCgpUaGF0IHdheToKLSBXaGlsZSBzaHJp
bmtpbmcgd2l0aGluIHRoZSByZXNlcnZlZCB0YWlsIChzZWNzIDw9IHJlc2l6YWJsZV90YWlsX3Nl
Y25vKSwKICByZXNpemFibGVfdGFpbF9zZWNubyBkZWNyZWFzZXMgYnkgYHNlY3NgIGFuZCBwaW5u
ZWRfYXJlYV9tYXhfc2Vjbm8KICAoTUFJTl9TRUNTIC0gcmVzaXphYmxlX3RhaWxfc2Vjbm8pIHJl
bWFpbnMgdW5jaGFuZ2VkIGF0IDUsMTIwLgotIE9uY2UgdGhlIGVudGlyZSByZXNlcnZlZCB0YWls
IGlzIHNocnVuayAoc2VjcyA9PSByZXNpemFibGVfdGFpbF9zZWNubyksCiAgcmVzaXphYmxlX3Rh
aWxfc2Vjbm8gYmVjb21lcyAwIGFuZCBwaW5uZWRfYXJlYV9tYXhfc2Vjbm8gZXF1YWxzIHRoZQog
IG5ldyBNQUlOX1NFQ1MgKDUsMTIwKS4KLSBJZiBzb21lb25lIHNocmlua3MgYmV5b25kIHJlc2l6
YWJsZV90YWlsX3NlY25vIChvciB3aGVuCiAgcmVzaXphYmxlX3RhaWxfc2Vjbm8gaXMgMCksIHJl
c2l6YWJsZV90YWlsX3NlY25vIGJlY29tZXMgMCBhbmQKICBwaW5uZWRfYXJlYV9tYXhfc2Vjbm8g
aXMgY2xhbXBlZCB0byB0aGUgbmV3IE1BSU5fU0VDUyB3aXRob3V0CiAgdW5kZXJmbG93aW5nLgoK
Q291bGQgeW91IHVwZGF0ZSB0aGUgcGF0Y2ggdG8gYWRqdXN0IHJlc2l6YWJsZV90YWlsX3NlY25v
IGFjY29yZGluZ2x5PwoKVGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
