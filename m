Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09FCC6B2E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFrCmhjXCWuWyZF+szYoNK1Dyfn0xAEvYP4pMMYWsws=; b=V0IZBcXSeob7yxfhOOA83rSAa4
	Z8y60cSLbRsS20wW99EwQ38i2u+g0IWLSjQlGcpEuKd72ViTuFV+7NR9x9L1/J70Xpx5JFFP+9xdD
	2ayluAnwALx9OdynHmIuExNvdhireHCiRpYEoqlOIUHSbRGUaT1PvJld7f6V8R/HfO74=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH68H-0008DM-0w;
	Wed, 14 Oct 2026 21:03:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xH68D-0008DF-QT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 21:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=; b=EyjWzxuKGHfAsADG9N/DAt/PRC
 QsQdqxeyzJ73J8W1IiK9c2SyeOzR7vl9XEBD7mBxN9MJi7aYOiGmQyC1rD0uTecqGTGgM36faTZHE
 JAihSsgU3uEzjbJ67svetzjLWLJdw7EmssurzR3tgiplAM4hpEmDjlXvT4Z5jMecEGkQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=; b=dfR4gnqPKw8cvzV858QQIjYrFd
 F9nc5Igr4YHME1k3XssNGriA+Fo/PMLNrxlEgtWQbMdeDVzOIwuxtc1VofrHa25YjxQm8ZBrAp5/3
 B0fcKMcHZBhvhLuLqKyE+pm7R1ESNHvIPioQ6EqgPUal60HS3+4vxzLSeCLj9b/JQmtI=;
Received: from mail-lj1-f169.google.com ([209.85.208.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH689-0005NF-Mj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 21:03:23 +0000
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3a75f960be3so16735791fa.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 14:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792011795; cv=none;
 d=google.com; s=arc-20260327;
 b=GFG5qYIACa6Wj5FClb+Ww9Cg+fMX4jaqaIYwCrOSArEb+/wRk4HyiNQ8PQU998FhJP
 Jhdp+fP+pb6uRkhP3El27haYJBZUon4uG4oxGPB6eybSs+mg3KRAKMp7ee1qCurH2TjZ
 dVoO4HamJVSGKyC+jg4RB7WnhgsOlHRDgRDO7TZFWZ/Uepjzm7PWxEH4GMXnYhoF1j98
 U+a1xjCR7tsGG9Rbs2Kozv6Z5ZEM9+1fY++tI7j3rJbaVk2lc4yy/zqRnYc5A7XZ7OUG
 9ICetIw1IixTkDrcRaFE+NpXI5PG6Jp3LFagOoopTidr4e2ESvDYjx3L+1qY6YC5dgGs
 owOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
 fh=8sTkGXvE3fpnS2eymWunenOr5hG4sdyWmX2WZzfuFCI=;
 b=Y0bxvn0V3HFFW5NEXXVbA6QlxqVsIFag3TO/TAY4GxZRxul9Ck5XtRoCNOEz+H/aTv
 wcTIra4MC3CNWPvG03UFoBgeRnMwrNc0Y8DtEaejOu5zeUYw6jllbunjDlnmKKpdH4Dn
 p27yem5d68j1ZRCHi4QHI5EWSzW24P9ZEKbThys8NeL/EJBE80PZ1+FhL0MHT7sbIrIi
 ARaMs5su12e8GOPlthuGyRxpfj9XFB1PZQChwlfdhhu7iJ57CU8gbj9kRMKJp4tmpIQ4
 6gugZ9twHfTi5KT3JyyOZ3wFZ1VX/IIq+4yH9iDrchJuwjCEI9SyWNl30CkPfTfaztqa
 pnlA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792011795; x=1792616595; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
 b=CLjXgpZqRP9a1XyEU1tH04wAY3hzeKcoAaDldH1X8ytlSf10UdsXBoB8AqPfhrgwGS
 /xm9NWdc3joTf2006HcjcTF6Qu9ZR7wlrPzeiFMqag4t2asWNUprn8DuWtkurvPijHl3
 vK3HtSsC8CTClqi1F0iaMWlBxVNSso7+o2p2I7KtNhkaKInRsXl0SmQ29AvpKMPW7+cR
 ZFS0Znc51pwPRqRIM4UZpKzr52PumGW4dm44G1U5ooZkbidzGpuKaMtlXJziTYMn1JlB
 zMZPKy/RP6CMJ3mkN0YG1IDe/HmYMaho/Y4fe6NhHUfNYWN5xFqL5JpjEDDiHVzOcPSf
 8nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011795; x=1792616595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rlL07No56m0cxdKc4fCRf+IU8nDpAMVPkbecBDh9W4s=;
 b=OaScmXmi6fgFj2MGdNEpb2ZYr7m0wUldWw3zuStfEAFk/XfN2M4XBjgs2c7kLAnhld
 1W9TVkFoWBZFUsxMjV0CDby8mF+HjZd7lD7VQ/ScvBogRPz2JpWtd2nE6aGBfoqivhka
 Rp6oN8C8xIiGFA/1bBtGtMhQKrM2GWTZ3Dx4pgZt350V2W8ZUcCv7akFAlawq6N77t4s
 +KuyFFnSYEEPGrrxQTZDxVTsLZYR0loAP+OHswmePzpAgFadblbkB6jY+evRZT47AHjs
 906bcLrbzwjP0aBlxxF1h5ob/pRsBD6o7ZOFMkGf7djQ2L8ugnDL0R/SaJ8wGvStAGo9
 jLwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYcTOr2wK2YOR3m8BENDw/YSzT/J26lQ9ZlY3jxXAEMWKct/vKVXwRGbr7OUhF/+cXNlzro3uGYaVVeZt4zkIJ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLxT23Bam5JJj5i9ynkFgkO903PHn966+fVcdFvgiuF8Zl31rCx
 jsQoYibQYqLESaiL0eHj1343iQ3DEn6l6z/JzjRA8DZ1EtVU6qcjuIjcJElHFLhCbJ6L4dEbpdc
 mcPO4mFlEIsELd956RB21OVRjCqIfaR8=
X-Gm-Gg: AYBFou0DdU2qNj/8A540cWOQ2HgWtwCYppq8LuRKLBKHMzBw/dDoZ/Ut10H/xf2AnsL
 LEWUZcqD5sdzhkMXtwpLytWsgb/Le+x8MvpgLCg08Gql0XGg9ayR1Jqx1665TSM699wHPnixx/0
 weD/ga41opOxe1PmxvP50BV1qaTsXYNDxKinuWHHFMaOPtEBcF8jmntolQ/bKAWYHcwjAVYz/HC
 q7SNr9lnJX4DuQZuB50+rbYVGmDWLh+mFNyhTNVm87N2J4TpwGlstNefnw41ri/p+25F2FxNpM1
 bcV0fHBA+VwfLghXHPq3LWszLs8M/qH7+hXqyekCqxupc9ZAw0r5q6EJWrWtelWHTsGtSYRo/jC
 cMeYnM1F783olfAr88jdQtCd/XB5Ies5TwLN4s2qxzP9j
X-Received: by 2002:a05:651c:2221:b0:3a6:58f7:da9a with SMTP id
 38308e7fff4ca-3a9c54acd7bmr39702171fa.27.1792011793698; Wed, 14 Oct 2026
 14:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261014152138.138281-1-daeho43@gmail.com>
In-Reply-To: <20261014152138.138281-1-daeho43@gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 14 Oct 2026 14:03:01 -0700
X-Gm-Features: AclHuK9ssELmbfFeOdtC11wQQOkFMUhWUeAu0fXdFEVJnCmum3r_7J3AOUUwHzg
Message-ID: <CACOAw_yLf9MDqBdkvhY9rwe=pLjkrGkcrHtAmdsvhcOdU4Zt3Q@mail.gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 kernel-team@android.com
X-Headers-End: 1xH689-0005NF-Mj
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose resizable_tail feature via sysfs
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Daniel Zheng <zhengdaniel@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

KyBjYzogemhlbmdkYW5pZWxAZ29vZ2xlLmNvbQoKT24gV2VkLCBPY3QgMTQsIDIwMjYgYXQgODoy
MeKAr0FNIERhZWhvIEplb25nIDxkYWVobzQzQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBE
YWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+Cj4gVXNlcnNwYWNlIGhhcyBubyB3
YXkgdG8ga25vdyB3aGV0aGVyIHRoZSBrZXJuZWwgc3VwcG9ydHMgdGhlCj4gcmVzaXphYmxlX3Rh
aWxfc2Vjbm8gbW91bnQgb3B0aW9uIGJlZm9yZSBtb3VudGluZy4gUGFzc2luZyBpdCB0byBhCj4g
a2VybmVsIHdpdGhvdXQgdGhlIHN1cHBvcnQgZmFpbHMgdGhlIG1vdW50IHdpdGggLUVJTlZBTCwg
YW5kIGNoZWNraW5nCj4gL3N5cy9mcy9mMmZzLzxkaXNrPi9waW5uZWRfYXJlYV9tYXhfc2Vjbm8g
cmVxdWlyZXMgYW4gZjJmcyBpbnN0YW5jZQo+IHRvIGJlIG1vdW50ZWQgYWxyZWFkeS4KPgo+IEV4
cG9ydCAvc3lzL2ZzL2YyZnMvZmVhdHVyZXMvcmVzaXphYmxlX3RhaWwgc28gdGhhdCB1c2Vyc3Bh
Y2UgY2FuIGNoZWNrCj4gdGhlIHN1cHBvcnQgYmVmb3JlIGZvcm1hdHRpbmcgb3IgbW91bnRpbmcg
YSBmaWxlc3lzdGVtIHRoYXQgcmVsaWVzIG9uCj4gcmVzaXphYmxlX3RhaWxfc2Vjbm8sIGUuZy4g
YSBmaWxlc3lzdGVtIHdob3NlIHRhaWwgaXMgZ29pbmcgdG8gYmUgc2hydW5rCj4gb25saW5lIGxh
dGVyLgo+Cj4gRml4ZXM6IGM5NjZkMjllMDFiYiAoImYyZnM6IHN1cHBvcnQgcmVzaXphYmxlIHRh
aWwgc2VjdGlvbiBhbmQgdW5pZnkgcGlubmVkIGFsbG9jYXRpb24iKQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29v
Z2xlLmNvbT4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1mcy1mMmZz
IHwgMiArLQo+ICBmcy9mMmZzL3N5c2ZzLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICsr
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1mcy1mMmZzIGIvRG9j
dW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1mcy1mMmZzCj4gaW5kZXggYzQ3NDZjNDE2YWMu
LjhkZjE4YjVkNDc5IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtZnMtZjJmcwo+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZnMtZjJm
cwo+IEBAIC0yNzEsNyArMjcxLDcgQEAgRGVzY3JpcHRpb246ICAgICAgICBTaG93cyBhbGwgZW5h
YmxlZCBrZXJuZWwgZmVhdHVyZXMuCj4gICAgICAgICAgICAgICAgIGlub2RlX2NydGltZSwgbG9z
dF9mb3VuZCwgdmVyaXR5LCBzYl9jaGVja3N1bSwKPiAgICAgICAgICAgICAgICAgY2FzZWZvbGQs
IHJlYWRvbmx5LCBjb21wcmVzc2lvbiwgdGVzdF9kdW1teV9lbmNyeXB0aW9uX3YyLAo+ICAgICAg
ICAgICAgICAgICBhdG9taWNfd3JpdGUsIHBpbl9maWxlLCBlbmNyeXB0ZWRfY2FzZWZvbGQsIGxp
bmVhcl9sb29rdXAsCj4gLSAgICAgICAgICAgICAgIGZzZXJyb3IuCj4gKyAgICAgICAgICAgICAg
IGZzZXJyb3IsIHJlc2l6YWJsZV90YWlsLgo+Cj4gIFdoYXQ6ICAgICAgICAgIC9zeXMvZnMvZjJm
cy88ZGlzaz4vaW5qZWN0X3JhdGUKPiAgRGF0ZTogICAgICAgICAgTWF5IDIwMTYKPiBkaWZmIC0t
Z2l0IGEvZnMvZjJmcy9zeXNmcy5jIGIvZnMvZjJmcy9zeXNmcy5jCj4gaW5kZXggOTc0OWRhNzAw
ODkuLjhiODQ0YThiMGJmIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvc3lzZnMuYwo+ICsrKyBiL2Zz
L2YyZnMvc3lzZnMuYwo+IEBAIC0xNDIxLDYgKzE0MjEsNyBAQCBGMkZTX0ZFQVRVUkVfUk9fQVRU
UihsaW5lYXJfbG9va3VwKTsKPiAgI2VuZGlmCj4gIEYyRlNfRkVBVFVSRV9ST19BVFRSKHBhY2tl
ZF9zc2EpOwo+ICBGMkZTX0ZFQVRVUkVfUk9fQVRUUihmc2Vycm9yKTsKPiArRjJGU19GRUFUVVJF
X1JPX0FUVFIocmVzaXphYmxlX3RhaWwpOwo+Cj4gICNkZWZpbmUgQVRUUl9MSVNUKG5hbWUpICgm
ZjJmc19hdHRyXyMjbmFtZS5hdHRyKQo+ICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqZjJmc19h
dHRyc1tdID0gewo+IEBAIC0xNTkyLDYgKzE1OTMsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0
ZSAqZjJmc19mZWF0X2F0dHJzW10gPSB7Cj4gICNlbmRpZgo+ICAgICAgICAgQkFTRV9BVFRSX0xJ
U1QocGFja2VkX3NzYSksCj4gICAgICAgICBCQVNFX0FUVFJfTElTVChmc2Vycm9yKSwKPiArICAg
ICAgIEJBU0VfQVRUUl9MSVNUKHJlc2l6YWJsZV90YWlsKSwKPiAgICAgICAgIE5VTEwsCj4gIH07
Cj4gIEFUVFJJQlVURV9HUk9VUFMoZjJmc19mZWF0KTsKPiAtLQo+IDIuNTYuMC4zODUuZ2QzYWNi
OTBlZjgtZ29vZwo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
