Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F86C61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJpt8yuSWXOOYseFWZKPjMqf6+qK000dphm9ha9TGmI=; b=htgZL6fcpxQrC85o92LMBOzapk
	rbJl6gHunWISBf/Nw6XOQLWYGSjkaZi225Gd1P33EhrGxn+kAASH8YK2lWVxskrg7NPzYvGYepyGA
	3pDlNtN9jAXh6DznYtgbqNlBdm1JUrpbE+8tIMYppgeafofEsW7Le8fqmb26GLgnUDK0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzdmL-0001vJ-EB;
	Thu, 27 Aug 2026 17:20:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wzdmG-0001vA-Pj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 17:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Q2WP3xYXvtNm+8JHX/keBD8T0fHDerrdRWjZNJYCX0=; b=jCev1IiF3qAKgHG+jO0avJTMeJ
 UkmzLFgm18SgwxqDVrDfZDS7cmsxrcfGNU0g7TOsZJcJNrcs+sw9E/2fUxOH2P3RagSmD/u9CyIXV
 o9gvBoUmKYO1TVKusjeJCWkDEEKLt2tLInvlbo6CHyrGdEGVRF348vCCmeTpWUBKJsu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4Q2WP3xYXvtNm+8JHX/keBD8T0fHDerrdRWjZNJYCX0=; b=RJwS23NlA4b+AWEc3vW9vbwVkx
 AyuxPcabv9gOAMMwezubd1FZzoqgOP6zC1gbA0TSKh5FHXIJSNXOlsBfcYuUuEsMz4DZQ9xMrxmZJ
 fNIoMJjPO/N6J/UnJ6alt2Zjc65elWy+qejs/iQ9F9ZjKF0z1evGo2V3MVOtajQHNzho=;
Received: from mail-lf1-f53.google.com ([209.85.167.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzdmE-000091-CR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 17:20:37 +0000
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5b4adcce4b1so27290e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 10:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787851227; cv=none;
 d=google.com; s=arc-20260327;
 b=GJeKaTI/S0Fqq/qO788lxnTmclh6I8W+d3tGs0oBAIHiJ9DC817sNkmec0GNIb3HI0
 esuOnyeZ4JmlMvnSN4TL20ngAJVESAurlbhLdKggTFUPfHtjt0pONCKHQPNS3uP45x+e
 /bruiha10hHSGfTbrZdmimAGJsLrlQqwP7B0BJRHVolgwTRnfHGa16WkP3oGT7PF9akO
 esyQRR/H5J7SShCGTbYw2uJk1QWGxDVEr/2SDhZdIkbGDN5/hJSR9GzvcNBguYMgoOQP
 KD4/vArApj5BkvjEJP1FofOsjvQeamw10YT89K3zBhP4O+Py7wEhBnnGJMuuln4uIRCH
 WZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Q2WP3xYXvtNm+8JHX/keBD8T0fHDerrdRWjZNJYCX0=;
 fh=L2WoFJah4KbM6IZe+8dT6zBkiSlvoA1VzxvfKbFiZaI=;
 b=GCm/FF82nh9aSAVFaHHDzNvYlnrdf8LUCkcW2C0Fg9V1OL9T/ek3Gazasi1YiVdyq4
 JWFl7o5ps/3XnAw/9sUAOG+CmW2jOkvDJLwF5Xt6ZxgAHtpv59YDyxpzDE9Z5qn/VNnR
 e+BKuq1CRAMjaIljS9s4DvCsNKxnBBReo50lMq2zxCysBfI75R7m2nWrYTTZ3pavPNDo
 Y5yYf4juGcN9vwUiTC6D6f3qz89YlmTgVz4xSp4Ze8bfIP2UDLmi74TBQfPCpq4OZpY8
 RjuSf2YUT70/1BJ5DPg5q1PapSmfK1iSCbhTzXg600zaUWdtd0UaAWKXwGK6YVVyw5C8
 IR7A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787851227; x=1788456027; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Q2WP3xYXvtNm+8JHX/keBD8T0fHDerrdRWjZNJYCX0=;
 b=kJ4G96KDRhk+pbQ457VmKRLn1zIKAgynaSlDdiIGnmEWjbMdn2vR/RgmQRf+IIs1Lq
 zBOpxFbksL8trzGJMb/8EfKhoNfQT4mvInLa8NbfKROt0hs7CoSDZ5ZlOJPU/FUh8J7z
 hD2zyRm1hvZ0ujQ78X1YbFJRZhKTEghdPZwlVdjvhmH5T3V1CtjQvHyA4GZEtpJlP94Y
 AD62CY8RQBMPOqhDUfGegQfj3FSieTmu6glLd3IPMeLz2EqvwqJEam6HXezeheyaeHkz
 HYmLCRvF7DpCe+2OTN4lGdxDBnnm6f4DdxcCEfMltfB0h5KV+UGyLcpQQ27Am3ApaHtV
 XIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787851227; x=1788456027;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Q2WP3xYXvtNm+8JHX/keBD8T0fHDerrdRWjZNJYCX0=;
 b=VNK9P9RIVOCBICQDkl+6A+aNd2Ud7iA472WKXKS1inmFcLjVIbgaorcC87KalI5Jl3
 /ErZWscw7zHyCQDpYHbul9e+2eUUAdSxPKkkQ8b5o/k4PjYfqH+32kmRKmj385grchtJ
 5SNxhadwwWsVAaibczSLQYlIou9J/hThrlcdEHHOX90KLr0gC2D2e0Btr2un4sJDYkpc
 cDGAsrmlrMlLec1kUUipmRWe/CnpTQoorSmIIS9Q8cceLeg/cHC2R+8L8Xi6YUOzxi6A
 5iTpxFL4uBS33xuWnarafTCPtYa+L5zLiZWDE9OFk022LInBoLkThDMx9a1yRrfForKZ
 PXYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoX3kgVTCDB9BcGH3wviDu//qTH2dvTjGIFuxD3Jj2NIQgbxxifUYYCjsakRP9VoZMceKwbhdfEBKbpzBsbtY7s@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1rGtJtlB2t5pC5348HiJ1OgijJznoc+9RRdSTd33ZzreEW1KV
 QLzqDGVnu77II6lan0m0d6jb596zNoM2Isgi5ZUUNLnCVU9mF6gXy+FBryXh4vI613KA3TXo1Y7
 fpLi5H/RwgqhH9Ed/q7TXw4liwYN2E89t8cXqWZ4=
X-Gm-Gg: AR+sD11W4tjf2VYzAHELYuUGbYffV9rgtHDljOPqMjY3vTxxf+zUcTvWuulTXchlPG8
 q8k5vG/BVb4PB3lUYqWQ2SBZa+niE+O7Fy722G38uedgPCXL9YlVGGdU/QlU+lvcqm67olChDl1
 ES7UXUXL4l+98gos86obJFuF7dqWdDrGGSbs5Sq6bldvEP/QW0on16OeYwOWNnwo+MQD1GR4WYD
 VEuv8BEVUJQDj2fMn97ZNwB1IO37HmcPKfTT4MU3r+KZWaGsVoHrT2KZaaeY8XrA125xLY5MCxh
 xFRZKya4EwrDBYkAtSvmWmHcCjNeBsqkTa9KJXbP9/dL3FFFwLV51SUp+0M1WeHobMj/M9pEHOG
 iRbHhSpiuqBrVK830epn5bEqhfA9NQ2QS
X-Received: by 2002:a05:6512:220c:b0:5b4:3ddd:8996 with SMTP id
 2adb3069b0e04-5b5e68de595mr55082e87.15.1787851227372; Thu, 27 Aug 2026
 10:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
 <8e02060f-6921-4d3c-abb2-cc36fe1e9594@kernel.org>
In-Reply-To: <8e02060f-6921-4d3c-abb2-cc36fe1e9594@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 27 Aug 2026 10:20:14 -0700
X-Gm-Features: AcwNN1U7PNNLW0IUB1V-PjZHUSzb3AnJaCjYPBfr_1O0hFm2d1nERUvn4m841Rk
Message-ID: <CACOAw_ySh3pW5tg7pa6r7Rr7tuqp9btPWvN-rrWN7mOpKcw3kQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wzdmE-000091-CR
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

T24gV2VkLCBBdWcgMjYsIDIwMjYgYXQgODoyNOKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzI3LzI2IDA0OjA0LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+PiAt
c3RhdGljIHZvaWQgZjJmc190cnVuY2F0ZV9jYWNoZShzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2sg
KmVudHJ5LAo+ID4+ICt2b2lkIGYyZnNfdHJ1bmNhdGVfY2FjaGUoc3RydWN0IGYyZnNfY2FjaGVk
X2Jsb2NrICplbnRyeSwKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYm9vbCBkcm9wX2RpcnR5KQo+ID4KPiA+IC0+IF9fZjJmc190cnVuY2F0ZV9jYWNoZSgpIHdp
dGhvdXQgbG9ja2luZz8KPiBPciwgSSBndWVzcyB5b3UgbWVhbiB3ZSBuZWVkIGEgY2xlYW51cCBo
ZXJlPwo+Cj4gV2hhdCBhYm91dDoKPgo+IHZvaWQgZjJmc190cnVuY2F0ZV9jYWNoZShzdHJ1Y3Qg
ZjJmc19jYWNoZWRfYmxvY2sgKmVudHJ5LCBib29sIGRyb3BfZGlydHkpCj4gewo+ICAgICAgICAg
aWYgKCFlbnRyeS0+Y2FjaGUpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPiAgICAgICAgIGYy
ZnNfZG9fdHJ1bmNhdGVfY2FjaGUoZW50cnksIGRyb3BfZGlydHkpOwo+IH0KPgo+IHN0YXRpYyB2
b2lkIGYyZnNfdHJ1bmNhdGVfY2FjaGVfbG9ja2VkKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAq
ZW50cnksIGJvb2wgZHJvcF9kaXJ0eSkKPiB7Cj4gICAgICAgICBmMmZzX2xvY2tfY2FjaGUoZW50
cnkpOwo+ICAgICAgICAgZjJmc190cnVuY2F0ZV9jYWNoZShlbnRyeSwgZHJvcF9kaXJ0eSk7Cj4g
ICAgICAgICBmMmZzX3VubG9ja19jYWNoZShlbnRyeSk7Cj4gfQo+Cj4gZjJmc190cnVuY2F0ZV9j
YWNoZSgpIHdhcyBleHBvcnRlZCBmb3IgdXNpbmcgaW4gb3RoZXIgLmMgZmlsZSwgaW4gdGhlIG1l
YW50aW1lLAo+IHN0YXRpYyBmMmZzX3RydW5jYXRlX2NhY2hlX2xvY2tlZCgpIGNhbiBiZSB1c2Vk
IGluc2lkZSBjYWNoZS5jLgoKU3BsaXR0aW5nIHRoZW0gaW50byB0d28gaGVscGVycyAob25lIHdp
dGggbG9ja2luZywgb25lIHdpdGhvdXQpIG1ha2VzCnRvdGFsIHNlbnNlLgoKSG93ZXZlciwgaW4g
dGhlIExpbnV4IGtlcm5lbCBjb252ZW50aW9uLCBoYXZpbmcgYF9sb2NrZWRgIG9yIGBfX2AKdXN1
YWxseSBpbmRpY2F0ZXMgdGhhdCB0aGUgY2FsbGVyIGlzIGV4cGVjdGVkIHRvIEFMUkVBRFkgaG9s
ZCB0aGUgbG9jawooZS5nLiBgX19saXN0X2FkZCgpYCwgYF9fZm9saW9fbWFya19kaXJ0eSgpYCku
CgpJZiBhbiBleHBvcnRlZCBmdW5jdGlvbiBpcyBuYW1lZCBgZjJmc190cnVuY2F0ZV9jYWNoZSgp
YCB3aXRob3V0IGBfX2AsCmNhbGxlcnMgd291bGQgbmF0dXJhbGx5IGFzc3VtZSBpdCBoYW5kbGVz
IGxvY2tpbmcgaW50ZXJuYWxseS4KClNvIEknZCBzdWdnZXN0IGZvbGxvd2luZyB0aGUgc3RhbmRh
cmQga2VybmVsIHBhdHRlcm46CgovKiBDYWxsZXIgbXVzdCBob2xkIGYyZnNfbG9ja19jYWNoZShl
bnRyeSkgKi8Kdm9pZCBfX2YyZnNfdHJ1bmNhdGVfY2FjaGUoc3RydWN0IGYyZnNfY2FjaGVkX2Js
b2NrICplbnRyeSwgYm9vbCBkcm9wX2RpcnR5KQp7CmlmICghZW50cnktPmNhY2hlKQpyZXR1cm47
CmYyZnNfZG9fdHJ1bmNhdGVfY2FjaGUoZW50cnksIGRyb3BfZGlydHkpOwp9CgovKiBTYWZlIHdy
YXBwZXIgdGhhdCBhY3F1aXJlcyBlbnRyeSBsb2NrIGludGVybmFsbHkgKi8Kdm9pZCBmMmZzX3Ry
dW5jYXRlX2NhY2hlKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAqZW50cnksIGJvb2wgZHJvcF9k
aXJ0eSkKewpmMmZzX2xvY2tfY2FjaGUoZW50cnkpOwpfX2YyZnNfdHJ1bmNhdGVfY2FjaGUoZW50
cnksIGRyb3BfZGlydHkpOwpmMmZzX3VubG9ja19jYWNoZShlbnRyeSk7Cn0KClRoZW4gY29tcHJl
c3MuYyAod2hpY2ggYWxyZWFkeSBob2xkcyB0aGUgbG9jayB0byBjaGVjayBlbnRyeS0+aW5vKSBj
YW4KY2FsbCBgX19mMmZzX3RydW5jYXRlX2NhY2hlKClgLCB3aGlsZSBvdGhlciBjYWxsZXJzIGNh
biBzYWZlbHkgdXNlCmBmMmZzX3RydW5jYXRlX2NhY2hlKClgLgoKV2hhdCBkbyB5b3UgdGhpbms/
CgpUaGFua3MsCgo+Cj4gVGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
