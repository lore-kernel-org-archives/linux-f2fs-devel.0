Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A348BC561E6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVDfe8X1DmyU2rigS11HxYGtlqjGae/5l5MKLT3c3nI=; b=S2C+kCKL3unnuFG3d4KwXFQ4Ey
	90YB7lEc4ORr/bZGC+uMZcJJV3h1DCD24oHCHkrFQTqOwSiwhTl50C4DCNTixfYMEHPvCiM5bath4
	RiTzj9rgf9s1o3vfzdf7VF5sR+nZ1CBfD8yWLj/eWU/lImQyMt6ttk58XrD7Mvc9lMKo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wreiY-00058w-Go;
	Wed, 05 Aug 2026 16:43:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wreiX-00058q-1q
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bG5WngiaKg2lX8XJS/Xcgxbxv+8dY6CFj4hPyjJY/BM=; b=T/IzKA5GbOeNf+sY42SnZekw0Y
 dTeFzoLNHV6AW9AoK8w5cOcNdv78gAV/t7/oFsWFgkawm75apRqk0A9bYax+Ghbs0ESE0z59x07JG
 jslIg3ZXHe6qx1kNHYsPgVM/FwbVqJQuTQWJ4gvLyvXotjfwv0FBbhEMjUoPsoQO2dbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bG5WngiaKg2lX8XJS/Xcgxbxv+8dY6CFj4hPyjJY/BM=; b=O9k+tWKuvqOBY+wbaYRgq5ZZ4J
 CgHNF7ihNMQoKMfGXSPlFzXl/ZrcEbxdsWPJIC34fnxxjb0T+kuG4SGru3B4QJaxKYo4fIGOLOJUc
 FWNM4MwLvVG6n59x8IjA4eGImE0/af9RlqkQZH1sUR1A7dZaZvVm08Aq8XgbJdf34ryU=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wreiW-0005S2-Or for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:43:42 +0000
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39ca300db70so11716321fa.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 09:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785948214; cv=none;
 d=google.com; s=arc-20260327;
 b=iGWgshZuqdIQxhtJRe8tiPB1+oVTSPlS3D5KDSHC6kVdE0tovuZIrEkOgQ3ubaD7kc
 BcdFNCgGjdBPue/oeIspFtwXnsNEYnhR/tVd4MogA1OfkHzRgmZBNaus0G8NU3CYnoy5
 tvkdI6UdoKwHqwEcTHbRveHxIBJO6Vb/EHCOBmvu4dVlb5qMvWvdH959nY23Bwr99+q7
 fyXgNjfyBVnqcwUriNNEIajvOmsVMQU/QCtzThI7mlL/2LKpd8o6aJUSlzngWFsuYGCW
 4PvbsZcqlBmsN1xemfGcJrJjFY68W8xwrqOgmBcwgpNK6RVJPi+AgWsIfj/caRu2axZ5
 Xt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bG5WngiaKg2lX8XJS/Xcgxbxv+8dY6CFj4hPyjJY/BM=;
 fh=R71IwRPqsoo5I8snc12u6hJSmObk1DyICHKUiKngiR4=;
 b=VqRZPzzGiPed/H4R/pLVZEHl/pqvZqjmhVAEkM60zowFfh7UMfQMX3hEu5p8c1Zr3A
 xtgGeD17/MzFDGRICyBib7wilR9a9wS+GqNNmmZ6XxfdCPMc6PslIusG670h7U7z3Ldi
 xivJGFyPsRilGYBxKUhmTmbQ9p5CL198q1Xv5QbtMC0WMZ+o+5yBDOS1rOrzv6YinLkD
 156/eHI7i/idPOgSkpu2Jx+89yoIyfrhyC8TTP6rCZ+lkIs76tuL9f1RhSBuRKZinPpn
 0P23Kl8Nv2MlmHLHE5EWxflPldJ+SyOw27ZfzuXIiUWuk2Z+zUB89C+CA/j6/nDYkgmH
 N69Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785948214; x=1786553014; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bG5WngiaKg2lX8XJS/Xcgxbxv+8dY6CFj4hPyjJY/BM=;
 b=VxvzpvQsHCHbeYioMjIHTQKkSGUKds57xjn48DLkrgxuFyxuAH0vzanpqUxjsuxCEl
 LT4zUemKS5vadHB0R+Rg57xK1Vq4uLZA5L1RVc3PtfMJrNE8skNB/Vrsvgwm3pC4BeSC
 8OYSbUHAdV/VssO22/LUXUJaQi7kFOS5IebnDpNv+IYD365qfx4YmDS1GLUmsZkczTpM
 2ubjxbLSe4C7wxaoxfUELnfkDE+iKN5tub2rVxSaeb3WyFHkI+MLV93QvS2i8PTg/UGu
 oIeVgWUx2Ro2ESDixQxIsa1EK21fO0y6JdFI8mNI3c0EJuXvC9bufLKKDNII6vJSdE5s
 uCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948214; x=1786553014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bG5WngiaKg2lX8XJS/Xcgxbxv+8dY6CFj4hPyjJY/BM=;
 b=JfguqDPnZ7QVTaSM8JcEIWsiHAerZmQZ7lIVB+sYBSZQEPhzUvnS/Sb+lIbINxbQUZ
 7cOzJ+8wZgS6k2xlIV/7W3yIrCa4nYI3LQl4y9IwSPQxb8/lkeP+8eHeCOIKHjDuT1hK
 Omq5xkCzVI6YVl86nKYJnVQGY1L+LdbPqXuycvRL0qbw7pEIntzVv0oLFKAEPYQ5r6A/
 NRMTXMxtRBlsamHmTtXB6J4OL7OQz6RJlkCM7r9qp5xuV8LQdaNrFII1xeOvnbL0ObMQ
 //zjZ99cETUMO9rXIuIzY6g1Ds6KlTuJZ568Uq6PLYX3BqAbFtt3AM8aUTqaAD9JfhXZ
 VjPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMieA4HByGKKHjETUV3bhdxKCRH/9ziHq5TQj43cgTsWnrPIP4U/jHVP4Mbt5CZ1QPOmqX6+s0HpO9v8DjrXdZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzKXnYpR5QGwRLYdEju54jLt8TftX4VdUNHwAVp5aad8TmlRPXh
 o0kafyqECFyjmQhYF9MHCA3LstwpexIxKdsnLwfb5AeypeQ/GdBilc12i/ITuapYCO1gUAQt/m1
 qNnWYmcIm/blUZZyLEbVfjk5jCUBZU1s=
X-Gm-Gg: AR+sD127i7e05TI3WRW0mNarHYLsb8hEUVF72vEr+M2WCnF72Wk/TLL9X0jVqTHdR2A
 4AirdMRQzAQKaBANLJAsjqvZBg7Kb1XQ+F0TDUPLMSSSzliilz4396h6ePinSQABQhoC6KEvxYS
 UV0Q+wfk4x1Akc6K9QSX8OkGzD5aIksv+AswMnijTzixcLODpByjnqB11qBqD9cDhpVYqsqE0AE
 CiF/X79Wi68c07JxZ+9ROAJLDlmWqablC8AxFVSi/ONQNjw/0NzxaRLFa8OwrUiTBiZ8t9FWQso
 Ispb3RhKeaItEL3qOtpB0ZHCYHpgKxxgy5mOZdElOUbxxZRvtdKe8hCISsGdnivj8t2Zz/re5uZ
 xG+ChDmdv3WfPaO0lmgTbNZfU3WWjcqlC2DUAI0ZcFqfl
X-Received: by 2002:a05:651c:a38b:10b0:39b:1b6d:5027 with SMTP id
 38308e7fff4ca-39fbb1b273bmr8346381fa.11.1785948214185; Wed, 05 Aug 2026
 09:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260730154618.2166947-1-daeho43@gmail.com>
 <8b643643-17d5-4c80-9548-c8dc461c9d2d@kernel.org>
In-Reply-To: <8b643643-17d5-4c80-9548-c8dc461c9d2d@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 5 Aug 2026 09:43:21 -0700
X-Gm-Features: AUfX_mzlVIHVS05NuJidBw-uzBu733Fp7U3k7p6zs-DHiuQnfIdIBLr3CL2OF9c
Message-ID: <CACOAw_ynod+nrwrqfoqLK4NOPvVTHoG+3z5FFcF-YByJ7uUEzw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wreiW-0005S2-Or
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: support dynamic reserve/release for
 device aliasing
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

T24gVHVlLCBBdWcgNCwgMjAyNiBhdCA2OjIw4oCvUE0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
PiB3cm90ZToKPgo+IE9uIDcvMzAvMjYgMjM6NDYsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gRnJv
bTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBUaGlzIHBhdGNo
IGFkZHMgYSBkeW5hbWljIG1hbmFnZW1lbnQgZmVhdHVyZSB0byB0aGUgZXhpc3RpbmcgZGV2aWNl
Cj4gPiBhbGlhc2luZyBmdW5jdGlvbmFsaXR5LiBJdCBhbGxvd3MgdXNlcnMgdG8gZHluYW1pY2Fs
bHkgcmVzZXJ2ZSBvcgo+ID4gcmVsZWFzZSBzcGVjaWZpYyBkZXZpY2VzIGZyb20gdGhlIGZpbGVz
eXN0ZW0ncyBmcmVlIHBvb2wgYXQgcnVudGltZQo+ID4gdGhyb3VnaCBuZXcgaW9jdGxzLgo+ID4K
PiA+IFRvIHN1cHBvcnQgdGhpcywgdGhyZWUgbmV3IGlvY3RscyBhcmUgaW50cm9kdWNlZDoKPiA+
IC0gRjJGU19JT0NfUkVTRVJWRV9ERVZfQUxJQVM6IFRoaXMgcmVjbGFpbXMgdGhlIHNwYWNlIG9j
Y3VwaWVkIGJ5IGEKPiA+ICAgZGV2aWNlIGFsaWFzaW5nIGZpbGUuIEl0IGZpcnN0IHBlcmZvcm1z
IGEgY2FwYWNpdHkgY2hlY2ssIHJlc2V0cyBHQwo+ID4gICB2aWN0aW0gaW5mb3JtYXRpb24gZm9y
IHRoZSB0YXJnZXQgcmFuZ2UsIG1hcmtzIHRoZSBzZWdtZW50cyBhcyBpbi11c2UKPiA+ICAgdG8g
cHJldmVudCBuZXcgYWxsb2NhdGlvbnMsIGFuZCB0aGVuIHRyaWdnZXJzIEdDIHRvIG1pZ3JhdGUg
ZXhpc3RpbmcKPiA+ICAgdmFsaWQgZGF0YSBvdXQgb2YgdGhlIHJhbmdlLiBGaW5hbGx5LCBpdCBy
ZXNlcnZlcyB0aGVzZSBibG9ja3MgaW4gdGhlCj4gPiAgIFNJVCB0byBlZmZlY3RpdmVseSBleGNs
dWRlIHRoZSBkZXZpY2UgZnJvbSB0aGUgdXNhYmxlIGNhcGFjaXR5Lgo+ID4KPiA+IC0gRjJGU19J
T0NfUkVMRUFTRV9ERVZfQUxJQVM6IFRoaXMgcmVsZWFzZXMgdGhlIHJlc2VydmVkIHNwYWNlIG9m
IGEKPiA+ICAgcHJldmlvdXNseSByZXNlcnZlZCBkZXZpY2UgYWxpYXNpbmcgZmlsZS4gSXQgdHJ1
bmNhdGVzIHRoZSBibG9ja3MKPiA+ICAgYXNzb2NpYXRlZCB3aXRoIHRoZSBmaWxlLCB3aGljaCBt
YWtlcyB0aGVtIGF2YWlsYWJsZSBmb3IgZ2VuZXJhbAo+ID4gICBmaWxlc3lzdGVtIGFsbG9jYXRp
b24gYWdhaW4uCj4gPgo+ID4gLSBGMkZTX0lPQ19HRVRfREVWX0FMSUFTX1NUQVRVUzogVGhpcyBy
ZXRyaWV2ZXMgdGhlIGN1cnJlbnQgYWxpYXNpbmcKPiA+ICAgc3RhdHVzIG9mIGEgZGV2aWNlIGFs
aWFzaW5nIGZpbGUsIHJldHVybmluZyB3aGV0aGVyIHRoZSBmaWxlIGlzCj4gPiAgIHJlbGVhc2Vk
IChpbmFjdGl2ZSBhbGlhcykgb3IgcmVzZXJ2ZWQgKGFjdGl2ZSBhbGlhcywgd2l0aCBibG9ja3MK
PiA+ICAgZnVsbHkgYWxsb2NhdGVkIG9uIHRoZSBkZXZpY2UpLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gUmV2aWV3ZWQtYnk6IENo
YW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoYW5rcywKCk9oLCBJIG92ZXJsb29rZWQgdGhh
dCBlaS5ibGsgaW5jbHVkZXMgdGhlIHNlZ21lbnQwX2Jsa2FkZHIgb2Zmc2V0ICh0aGUKbWV0YWRh
dGEgYXJlYSksIHNvIGBlaS5ibGsgJSBCTEtTX1BFUl9TRUMoc2JpKWAgaW5jb3JyZWN0bHkgY2hl
Y2tlZAphbGlnbm1lbnQgZnJvbSBibG9jayAwIHJhdGhlciB0aGFuIHRoZSBzZWdtZW50IGFyZWEg
c3RhcnQuCgpJIGFtIGdvaW5nIHRvIGZpeCBpdCB1c2luZyB0aGUgYEdFVF9TRUdPRkZfRlJPTV9T
RUcwKClgIG1hY3JvOgppZiAoKEdFVF9TRUdPRkZfRlJPTV9TRUcwKHNiaSwgZWkuYmxrKSAlIEJM
S1NfUEVSX1NFQyhzYmkpKSB8fAooZWkubGVuICUgQkxLU19QRVJfU0VDKHNiaSkpKSB7Ci4uLgp9
CgpUaGFua3MsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbGludXgtZjJmcy1kZXZlbAo=
