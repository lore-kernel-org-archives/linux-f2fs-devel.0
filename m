Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C64C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHJ6VlZlEBptl8MdZynkjF0OhaMehzHd7ggTLN7wl4A=; b=CDOqDgxzMTO0or8io2mc5mSBZm
	CeUwADbZ0MybM4uoBiYsx0VUYZkoCTQVf0FMjv4PC0gWzybTI8Juh6Z+EHbtHMS9gHSr/L4N3N13t
	ONEh/a3KxnRqzXkMHSO3ox19cQ6oEfgh68y+/QLeOJC3SvTieKv9ZfLuRiYrBZMy2U84=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx5K4-0004ti-Q8;
	Thu, 20 Aug 2026 16:08:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wx5Jn-0004sD-ND
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FnbK1fa5qtNeOCNcLqDiv9tA5MF1h5wBy8LmHNqsEvE=; b=kJ1/gU0EYXQ0K/Cyp/oZCLE8Zz
 GVzIgooNVIDVLwfWGBlA8SqKO3wWl+REVJJTqRue4yF4HH/iBhU/W6qHLEOM3VjWO/0BbzUmVgUms
 DarxVuyY8poWRn5DTlaHIMLEzFh4Ugyp5mGQMC5v1iZbD9aKqIMvFSM3qh4SUqTwTx1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FnbK1fa5qtNeOCNcLqDiv9tA5MF1h5wBy8LmHNqsEvE=; b=O9prR4/zcrJbIliS/Od+/1lHse
 iXB7SgO5mzSHSeRXioFlYSwr5HV9zNCKvcrhylRheweKg25jsHJ1YC1NBEqc7YXvnzdTzqXS/cAp0
 WXcjBH8Hs16FRyxhk7hF+snj0FHr3x9caxaDvDADpfhqQ1bKpOj0O421Bknf6+tztB08=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx5Jm-0000ql-GM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:08:39 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3811f512167so3351448a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 09:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787242113; cv=none;
 d=google.com; s=arc-20260327;
 b=Ub0taDuWJo4A0w4Po9j/NB2L/PA7b3/91TIXWXRa03cLQLcjSuoSssdQagg711I0YJ
 mBCUXapFKxIgQ+b6qV17T2+HdbcZIAB2Ci5lWVWGSwChl1WK66jIZnQ2NANY6QBwt8+i
 z+zCJifqxY45tZZE+BcTScWz5jpIpAfVuIGinmcjkDY4AYij/kWvQzaqrFwgj3zb+Lnv
 Kq7CG0KXJ+SXYzgs2U8kbCPhi49r4OK7mRE892spznCB6F/FIMgk6HXQm1TRPfb7bREN
 u6Ssv+cU2tmFO6y55H03dJyeIlI66287p0Xo5RQjzWTqC0X7rJ6y++uWoM46dqguBhIN
 No2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FnbK1fa5qtNeOCNcLqDiv9tA5MF1h5wBy8LmHNqsEvE=;
 fh=2Y/8/74mp7ye/5T13uxIOlDamP7eJacY2h+rj79kDg8=;
 b=phAp31PkZI0BZSkTy6SyBj/zuJDACtJXJlEUoOJMytFWEUApkUgdY/i4Cu4BLOyHnc
 hFf/IKyP3lNdN2E3y5c1dbPIDKKjSqxI+ZBg9ybPXIfTDzc2FmoHPYTmFPBnWT4//S8n
 TXbb5tp7Vr31pXTezFvzaqF52Ys6XjDNW6mG4FQ+8qC6LzGlBJpsNsiQKArSi0p8B/uo
 9hmBWbDVZIAKUZPzJI30UweovwlNeWWGY3joYeqEjgPLmqLCsVXQOjAzTRzd93cdcrNP
 FJ4XUwe3E+ZNeJiaZ/bAN3sXYTwN32JXBfkeNJHxufmqpB5llOs+lhROADsoaBGE4VzX
 5dsQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787242113; x=1787846913; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FnbK1fa5qtNeOCNcLqDiv9tA5MF1h5wBy8LmHNqsEvE=;
 b=ZRpvnXql+avm3Uwi6sJQx/A6BwJqV5szlooruieKYhyNuVc+DZ2bX/ITS1KkZXGNyC
 ObXowk1ddzEDmfpQdIHVqb2H1QtzPx8Ch3j40A9gjNJoLrZo7E1cR112eRq2KwKpFiJM
 GvMmaq8poHxYg2/13OYDY9XA1wvi6m5UXut7dC64sUAPnLmscYp5sZZuqTccbgUvYaOa
 mDC0uvZyp+FhcivS95xwfQwmRtN0H7rUFT0xixBoeTNDw88YIrVtdzj9Avff/+3h1n0Z
 TOa+4ZTrLCGdVuPyYJpKvMHnRHZ0IRRlogTfju5NzbCkjhMRyNTvhizTC/I6hWTxVx8R
 nJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787242113; x=1787846913;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FnbK1fa5qtNeOCNcLqDiv9tA5MF1h5wBy8LmHNqsEvE=;
 b=PQHnPM++1cmsggFNohooyPKVXo+rWD4NJEzBbaZ124HmaJDGg2QrZAuaC6yhIK3RQE
 6nXlv2b8UgvvN62PefhwPPAXd4Z8oHnCbz5FKHbaz5YEy9A/j7nESchShzdN1E1S+KyI
 7XaAUnhSWTaLlKIgMfH0j2E+CuTVeafoX9lWHQ0J3qPyxZIne1huQFL4LiVVPvRY3PIi
 rWAHFj/3CQNTqGjsBXAZJoIjLSw8BPWIsT3O+ShRhj6HvxKum/bNxrFY1sks8r6L1ZkY
 8QJnL/kWg7YWiNW1OIGoMu4dGBb8iYvqUwTTInipQITanXPxOkA9TmV5Aly6Gy/SK5vV
 51Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzsguIbvqHWuc/9wFBJHdAY8VXadz+fTiB3iyXsr7gbCmBVfSsbNky/ZxGIEjm4gKLbV6fz3XgUbazypsVQMqp@lists.sourceforge.net
X-Gm-Message-State: AFuF++kfc+ZxEr2n8fbwO8oNsCbjQirXTfE+j5RbjPK2rHdHfKRD8JQM
 qQdu8TFdm+BkiuyZXVhM1qPm+kh0fyWBJ/VIZ1lvWcjYFkJteWk3SSZPS+J/oDioiONytIZI3v+
 bhmOENutW/sSBcrgcRE2OGsYBzVQ1XG4=
X-Gm-Gg: AR+sD120caB3LEj0UDA44GF0XMG0s+XK8DScYUbxNfNSzeYTFCLPLE+WvF9TYyURRv5
 Aonmj+XiqTm1bFN2tugv6IR57zN1Lq+IVsSkB+K4altiQlMIv92Dd7EifInAzmxAhu3etxYvDvO
 Fjk/zy+Rz/WnG9R8mouY9RLPilCdpxUDcMoBm/N2YOGCizd22f+5sFkCvEsZCvPFaviUAWlw+rI
 EDPNVXVND5dOxre0hhKaBUPIMn8NqBAGprmnpDQNqwSbkmM9qMBD06kGcZDLgP2vOIbbQralk/3
 30+9rftQuXbTk4HqDLC+xZQdw2/FxhtGhn0zuuuuFzKgo7oMKHfZBRikAqHtapJeZD/rp46/7T0
 ZDIww4yDKpZIi+DQLqLj+aGDjqqAQ63U=
X-Received: by 2002:a17:90b:2f06:b0:37f:e177:f58 with SMTP id
 98e67ed59e1d1-3958108a0f9mr27320587a91.9.1787242112536; Thu, 20 Aug 2026
 09:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260818171412.3201082-1-daeho43@gmail.com>
 <0e1162de-1ad4-4c24-a5c9-cd05c5b08cc0@kernel.org>
 <CACOAw_zQNVUtoPat0v1KFD5hkqBF1d=+3FwiGAf0bLma=xdq8g@mail.gmail.com>
 <8c21e8cb-00ba-497b-94a8-55219e14653f@kernel.org>
In-Reply-To: <8c21e8cb-00ba-497b-94a8-55219e14653f@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 20 Aug 2026 09:08:17 -0700
X-Gm-Features: AcwNN1VWU-o_r1GSV0L_PkUxG797gr81RN_G027wf1ByDfKRe6_AL2Qtc95Raqo
Message-ID: <CACOAw_xdzvksT=C-ZgSEo1gXXyqYF_-CYXWbn-3ZRZkFYGJCKw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wx5Jm-0000ql-GM
Subject: Re: [f2fs-dev] [PATCH] f2fs: accurately adjust free_sections during
 free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBdWcgMjAsIDIwMjYgYXQgNjoxOeKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiA4LzIwLzI2IDAyOjI2LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IE9u
IFR1ZSwgQXVnIDE4LCAyMDI2IGF0IDg6NTfigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+
IHdyb3RlOgo+ID4+Cj4gPj4gT24gOC8xOS8yNiAwMToxNCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4g
Pj4+IEZyb206IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPj4+Cj4gPj4+
IEluIGZyZWVfc2VnbWVudF9yYW5nZSgpLCBNQUlOX1NFQ1Moc2JpKSBpcyB0ZW1wb3JhcmlseSBy
ZWR1Y2VkIGJ5IGBzZWNzYAo+ID4+PiB3aGlsZSB2YWxpZCBibG9ja3MgaW4gdGhlIHRydW5jYXRl
ZCByYW5nZSBhcmUgZXZhY3VhdGVkIGJ5IEdDLgo+ID4+Pgo+ID4+PiBIb3dldmVyLCBpZiBhbnkg
c2VjdGlvbnMgd2l0aGluIHRoZSB0cnVuY2F0ZWQgcmFuZ2Ugd2VyZSBhbHJlYWR5IGZyZWUsCj4g
Pj4+IGZhaWxpbmcgdG8gZGVkdWN0IHRoZW0gZnJvbSBGUkVFX0koc2JpKS0+ZnJlZV9zZWN0aW9u
cyBsZWFkcyB0byBhbgo+ID4+PiBvdmVyLWVzdGltYXRpb24gb2YgYXZhaWxhYmxlIHNwYWNlIGlu
IHRoZSByZWR1Y2VkIG1haW4gYXJlYSwgY2F1c2luZwo+ID4+PiBpbmNvbnNpc3RlbnQgZnJlZSBz
ZWN0aW9uIGFjY291bnRpbmcuCj4gPj4KPiA+PiBDYW4geW91IHBsZWFzZSBzaG93IG1lIGFuIGV4
YW1wbGUgZm9yIGFib3ZlIGNhc2U/IEkgZGlkbid0IGdldCBpdC4KPiA+Cj4gPiBIZXJlIGlzIGEg
Y29uY3JldGUgZXhhbXBsZSBleHBsYWluaW5nIHdoeSB0aGlzIGFkanVzdG1lbnQgaXMgbmVlZGVk
Ogo+Cj4gVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uCj4KPiA+Cj4gPiBTdXBw
b3NlOgo+ID4gLSBUb3RhbCBtYWluIHNlY3Rpb25zOiBNQUlOX1NFQ1MgPSAxMDAgKHNlY3Rpb25z
IDAgLi4gOTkpCj4gPiAtIFRvdGFsIGZyZWUgc2VjdGlvbnM6IGZyZWVfc2VjdGlvbnMgPSAzMAo+
ID4gLSBXZSB3YW50IHRvIHNocmluayB0aGUgZmlsZXN5c3RlbSBieSAxMCBzZWN0aW9ucyAoc2Vj
cyA9IDEwLCByYW5nZSA5MCAuLiA5OSkuCj4gPiAtIFdpdGhpbiB0aGUgdHJ1bmNhdGVkIHJhbmdl
IChzZWN0aW9ucyA5MCAuLiA5OSk6Cj4gPiAgICAqIDYgc2VjdGlvbnMgYXJlIGFscmVhZHkgZnJl
ZSAoZnJlZV9zZWNtYXAgYml0IGlzIDApCj4gPiAgICAqIDQgc2VjdGlvbnMgYXJlIGluLXVzZSB3
aXRoIHZhbGlkIGJsb2NrcyB0aGF0IG5lZWQgdG8gYmUgbWlncmF0ZWQgYnkgR0MuCj4gPiBXaGVu
IGZyZWVfc2VnbWVudF9yYW5nZSgpIGVudGVyczoKPiA+IDEuIE1BSU5fU0VDUyBpcyB0ZW1wb3Jh
cmlseSByZWR1Y2VkIGZyb20gMTAwIHRvIDkwIHNvIHRoYXQgbmV3IGJsb2NrCj4gPiAgICAgYWxs
b2NhdGlvbnMgYXJlIGNvbnN0cmFpbmVkIHRvIHNlY3Rpb25zIDAgLi4gODkuCj4gPiAyLiBUaGUg
YWN0dWFsIG51bWJlciBvZiBmcmVlIHNlY3Rpb25zIGF2YWlsYWJsZSBpbiB0aGUgcmVkdWNlZCBy
YW5nZQo+ID4gICAgICgwIC4uIDg5KSBpcyBvbmx5IDI0ICgzMCAtIDYgPSAyNCkuCj4gPiAzLiBX
aXRob3V0IHRoaXMgcGF0Y2g6Cj4gPiAgICAgLSBmcmVlX3NlY3Rpb25zIHJlbWFpbnMgMzAgd2hp
bGUgTUFJTl9TRUNTIGlzIDkwLgo+ID4gICAgIC0gRHVyaW5nIHRoZSBzdWJzZXF1ZW50IEdDIG1p
Z3JhdGlvbnMsIGZyZWUgc2VjdGlvbiBjaGVja3MgKHN1Y2ggYXMKPiA+ICAgICAgIGhhc19ub3Rf
ZW5vdWdoX2ZyZWVfc2VjcygpKSB3aWxsIG92ZXItZXN0aW1hdGUgYXZhaWxhYmxlIHNwYWNlIGJ5
IDYKPgo+IEJ1dCBmcmVlX3NlZ21lbnRfcmFuZ2UoKSB3b24ndCBjYWxsIGludG8gaGFzX25vdF9l
bm91Z2hfZnJlZV9zZWNzKCksIGlmIEknbSBub3QKPiBtaXNzaW5nIGFueXRoaW5nLgoKT2gsIHJp
Z2h0LiBJIG1pc3NlZCBpdCdzIEZHX0dDLgpJIHRoaW5rIHdlIGNhbiBkcm9wIHRoaXMgcGF0Y2gu
CgpUaGFua3MuCgo+Cj4gTm90IHN1cmUsIG1heWJlIHlvdSBtZWFuIG90aGVyIHRocmVhZHMgd2ls
bCBjYWxsIGhhc19ub3RfZW5vdWdoX2ZyZWVfc2VjcygpLCBhcmUKPiB5b3Ugd29ycmllZCBhYm91
dCB0aGF0IHdlIG1heSBtaXNzIGNoYW5jZXMgdG8gY2FsbCBmZ2djIGVhcmxpZXIgaW4gYmVsb3cg
Y2FzZXM6Cj4KPiBmMmZzX2JhbGFuY2VfZnMgLT4gaGFzX2Vub3VnaF9mcmVlX3NlY3MgLT4gZjJm
c19nYz8gSSBndWVzcyBpdCB3aWxsIGJsb2NrZWQgb24KPiBnY19sb2NrLgoKPgo+ID4gICAgICAg
c2VjdGlvbnMgaW4gdGhlIGFjdGl2ZSAwIC4uIDg5IHJhbmdlLgo+ID4gICAgIC0gSWYgZnJlZV9z
ZWdtZW50X3JhbmdlKCkgZmFpbHMgbWlkd2F5IChlLmcuIC1FQUdBSU4pLCBmcmVlX3NlY3Rpb25z
Cj4gPiAgICAgICBhY2NvdW50aW5nIGJlY29tZXMgaW5jb25zaXN0ZW50Lgo+Cj4gV2h5IGZyZWVf
c2VjdGlvbnMgYWNjb3VudGluZyBiZWNvbWVzIGluY29uc2lzdGVudCBpZiBmcmVlX3NlZ21lbnRf
cmFuZ2UoKSBmYWlscwo+IG1pZHdheT8KPgo+IFRoYW5rcywKPgo+ID4gV2l0aCB0aGlzIHBhdGNo
Ogo+ID4gLSBXZSBjb3VudCB0aGUgNiBhbHJlYWR5LWZyZWUgc2VjdGlvbnMgaW4gdGhlIHRydW5j
YXRlZCByYW5nZSAoOTAgLi4gOTkpIGFuZAo+ID4gICAgZGVkdWN0IHRoZW0gZnJvbSBmcmVlX3Nl
Y3Rpb25zIHVwb24gZW50ZXJpbmcgKDMwIC0gNiA9IDI0KSwgcGVyZmVjdGx5Cj4gPiAgICBtYXRj
aGluZyB0aGUgYWN0dWFsIGZyZWUgc2VjdGlvbnMgaW4gdGhlIGFjdGl2ZSByYW5nZSAwIC4uIDg5
Lgo+ID4gLSBPbiBleGl0LCB0aGUgZGVkdWN0ZWQgYW1vdW50IGlzIHJlc3RvcmVkLCBrZWVwaW5n
IGZyZWVfc2VjdGlvbnMgY29uc2lzdGVudAo+ID4gICAgdGhyb3VnaG91dCB0aGUgZW50aXJlIHJl
c2l6ZSBsaWZlY3ljbGUuCj4gPgo+ID4gSG9wZSB0aGlzIGNsYXJpZmllcyB0aGUgc2NlbmFyaW8h
Cj4gPgo+ID4gVGhhbmtzLAo+ID4KPiA+Pgo+ID4+IEJUVywgaXQgbmVlZHMgdG8gcmViYXNlIHRo
aXMgcGF0Y2ggb24gZGV2LXRlc3QgYnJhbmNoLgo+ID4+Cj4gPj4gVGhhbmtzLAo+ID4+Cj4gPj4+
Cj4gPj4+IEZpeCB0aGlzIGJ5IGNhbGN1bGF0aW5nIHRoZSBudW1iZXIgb2YgYWxyZWFkeS1mcmVl
IHNlY3Rpb25zIGluIHRoZQo+ID4+PiB0cnVuY2F0ZWQgcmFuZ2UgdW5kZXIgc2VnbWFwX2xvY2ss
IGRlZHVjdGluZyB0aGVtIGZyb20gZnJlZV9zZWN0aW9ucyB1cG9uCj4gPj4+IGVudGVyaW5nIGZy
ZWVfc2VnbWVudF9yYW5nZSgpLCBhbmQgcmVzdG9yaW5nIHRoZW0gdW5kZXIgc2VnbWFwX2xvY2sg
b24gZXhpdC4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVv
bmdAZ29vZ2xlLmNvbT4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU3VubWluIEplb25nIDxzX21pbi5q
ZW9uZ0BzYW1zdW5nLmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICAgZnMvZjJmcy9nYy5jIHwgMTUgKysr
KysrKysrKysrKystCj4gPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZ2MuYyBiL2ZzL2Yy
ZnMvZ2MuYwo+ID4+PiBpbmRleCA3ODcxMzNlZTJlYjIuLmYzYTZmYzZkMDhhZSAxMDA2NDQKPiA+
Pj4gLS0tIGEvZnMvZjJmcy9nYy5jCj4gPj4+ICsrKyBiL2ZzL2YyZnMvZ2MuYwo+ID4+PiBAQCAt
MjIwMCw4ICsyMjAwLDkgQEAgaW50IGYyZnNfZ2NfcmFuZ2Uoc3RydWN0IGYyZnNfc2JfaW5mbyAq
c2JpLAo+ID4+PiAgIHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBmMmZzX3Ni
X2luZm8gKnNiaSwKPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCBzZWNzLCBib29sIGRyeV9ydW4pCj4gPj4+ICAgewo+ID4+PiAtICAgICB1bnNpZ25lZCBp
bnQgbmV4dF9pbnVzZSwgc3RhcnQsIGVuZDsKPiA+Pj4gKyAgICAgdW5zaWduZWQgaW50IHNlY25v
LCBuZXh0X2ludXNlLCBzdGFydCwgZW5kLCBlbmRfc2Vjbm87Cj4gPj4+ICAgICAgICBzdHJ1Y3Qg
Y3BfY29udHJvbCBjcGMgPSB7IENQX1JFU0laRSwgMCwgMCwgMCB9Owo+ID4+PiArICAgICB1bnNp
Z25lZCBpbnQgZnJlZWRfc2VjcyA9IDA7Cj4gPj4+ICAgICAgICBpbnQgZ2NfbW9kZSwgZ2NfdHlw
ZTsKPiA+Pj4gICAgICAgIGludCBlcnIgPSAwOwo+ID4+PiAgICAgICAgaW50IHR5cGU7Cj4gPj4+
IEBAIC0yMjEwLDYgKzIyMTEsNyBAQCBzdGF0aWMgaW50IGZyZWVfc2VnbWVudF9yYW5nZShzdHJ1
Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gPj4+ICAgICAgICBNQUlOX1NFQ1Moc2JpKSAtPSBzZWNz
Owo+ID4+PiAgICAgICAgc3RhcnQgPSBNQUlOX1NFQ1Moc2JpKSAqIFNFR1NfUEVSX1NFQyhzYmkp
Owo+ID4+PiAgICAgICAgZW5kID0gTUFJTl9TRUdTKHNiaSkgLSAxOwo+ID4+PiArICAgICBlbmRf
c2Vjbm8gPSBHRVRfU0VDX0ZST01fU0VHKHNiaSwgZW5kKTsKPiA+Pj4KPiA+Pj4gICAgICAgIG11
dGV4X2xvY2soJkRJUlRZX0koc2JpKS0+c2VnbGlzdF9sb2NrKTsKPiA+Pj4gICAgICAgIGZvciAo
Z2NfbW9kZSA9IDA7IGdjX21vZGUgPCBNQVhfR0NfUE9MSUNZOyBnY19tb2RlKyspCj4gPj4+IEBA
IC0yMjIxLDYgKzIyMjMsMTQgQEAgc3RhdGljIGludCBmcmVlX3NlZ21lbnRfcmFuZ2Uoc3RydWN0
IGYyZnNfc2JfaW5mbyAqc2JpLAo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgIHNiaS0+bmV4
dF92aWN0aW1fc2VnW2djX3R5cGVdID0gTlVMTF9TRUdOTzsKPiA+Pj4gICAgICAgIG11dGV4X3Vu
bG9jaygmRElSVFlfSShzYmkpLT5zZWdsaXN0X2xvY2spOwo+ID4+Pgo+ID4+PiArICAgICBzcGlu
X2xvY2soJkZSRUVfSShzYmkpLT5zZWdtYXBfbG9jayk7Cj4gPj4+ICsgICAgIGZvciAoc2Vjbm8g
PSBNQUlOX1NFQ1Moc2JpKTsgc2Vjbm8gPD0gZW5kX3NlY25vOyBzZWNubysrKSB7Cj4gPj4+ICsg
ICAgICAgICAgICAgaWYgKCF0ZXN0X2JpdChzZWNubywgRlJFRV9JKHNiaSktPmZyZWVfc2VjbWFw
KSkKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGZyZWVkX3NlY3MrKzsKPiA+Pj4gKyAgICAg
fQo+ID4+PiArICAgICBGUkVFX0koc2JpKS0+ZnJlZV9zZWN0aW9ucyAtPSBmcmVlZF9zZWNzOwo+
ID4+PiArICAgICBzcGluX3VubG9jaygmRlJFRV9JKHNiaSktPnNlZ21hcF9sb2NrKTsKPiA+Pj4g
Kwo+ID4+PiAgICAgICAgLyogTW92ZSBvdXQgY3Vyc2VncyBmcm9tIHRoZSB0YXJnZXQgcmFuZ2Ug
Ki8KPiA+Pj4gICAgICAgIGZvciAodHlwZSA9IENVUlNFR19IT1RfREFUQTsgdHlwZSA8IE5SX0NV
UlNFR19UWVBFOyB0eXBlKyspIHsKPiA+Pj4gICAgICAgICAgICAgICAgZXJyID0gZjJmc19hbGxv
Y2F0ZV9zZWdtZW50X2Zvcl9yZXNpemUoc2JpLCB0eXBlLCBzdGFydCwgZW5kKTsKPiA+Pj4gQEAg
LTIyNDUsNiArMjI1NSw5IEBAIHN0YXRpYyBpbnQgZnJlZV9zZWdtZW50X3JhbmdlKHN0cnVjdCBm
MmZzX3NiX2luZm8gKnNiaSwKPiA+Pj4gICAgICAgICAgICAgICAgZjJmc19idWdfb24oc2JpLCAx
KTsKPiA+Pj4gICAgICAgIH0KPiA+Pj4gICBvdXQ6Cj4gPj4+ICsgICAgIHNwaW5fbG9jaygmRlJF
RV9JKHNiaSktPnNlZ21hcF9sb2NrKTsKPiA+Pj4gKyAgICAgRlJFRV9JKHNiaSktPmZyZWVfc2Vj
dGlvbnMgKz0gZnJlZWRfc2VjczsKPiA+Pj4gKyAgICAgc3Bpbl91bmxvY2soJkZSRUVfSShzYmkp
LT5zZWdtYXBfbG9jayk7Cj4gPj4+ICAgICAgICBNQUlOX1NFQ1Moc2JpKSArPSBzZWNzOwo+ID4+
PiAgICAgICAgcmV0dXJuIGVycjsKPiA+Pj4gICB9Cj4gPj4KPgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
