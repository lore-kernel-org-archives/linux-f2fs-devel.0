Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286EEC5DF86
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTncVW4RWUeDJybZ0vfrYzO7n77/aVGGUGtn1J8He2g=; b=gWo9h/0XuZrb/YPOXeKtCUQs8z
	NrMLHNzfIgxOaUfoIcuO3EGQSVFiArdz8Cr5QSmsSFoF90B38H1Vr03JSrg/jKnvG8c/Sj8Xq/8En
	h2wBLC5dbyg7fhmEmZHQCGYEbjWEukJA9gdAJipeoqdfZPXyiOqMD9o7Oq2rjyWyXtVw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx9tG-0003gT-KN;
	Thu, 20 Aug 2026 21:01:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wx9tE-0003gN-OC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 21:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lsQDy5D1zmni7O2MBnvXWalrUx1/84UfOaV4LUwOgNY=; b=bJJsf5gIdNfnfehOVp3KiRejni
 MeHCW5uyIvoQR4lOddZFjRa2SbJybK968lNBwwV3TajY6O7J22aW5/Etr6rif37/hf+O5LqEubXBr
 PBUv9YkkjrmWpHfBq44KV6CtZqqwLlvs9d04gtg2V0AJnKRGNKH1D7H3NEDrXFy3tV4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lsQDy5D1zmni7O2MBnvXWalrUx1/84UfOaV4LUwOgNY=; b=ezw4g8ZXT2X1fj44CTMwEHL+bG
 Is6Dm/P3VuaM6hgUPhDDupywNlCcSzM2Xfd0n0JTolwghD7sQHUjBW0WOBoEQlUZT4xg3YJCEiTjU
 Xl6DXl6runPdLixbbMgouazEznL89EkRYFbQF8nZwPFltqHS+elnUPunW2q0WeeOxIEU=;
Received: from mail-lf1-f52.google.com ([209.85.167.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx9t9-0005wX-Tw for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 21:01:29 +0000
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aec6360133so235099e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 14:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787259681; cv=none;
 d=google.com; s=arc-20260327;
 b=i+G0DDLk1MndWQLYNYElAY6GwydoHAJr8vrfVjjkIVVE/UBtDjfUmLofWCIrOWKOzW
 J1RTsA9igl+aSRv+yyIcTsjZT2KBN/NiFznPsnrAAvj+QnwpuewWDa+z4Il4lX+xqmid
 VZSS0jLUbYzogv1y5zD9SsaXACFb3PnvSETPq9KcQirZWVMWoRWe7iVDxQWKmOHgSHzb
 ytfnGwoTXTOZenqZ0tSUDctDqtbdUe/k+02EBocegrWUgancXuB9KUpYYTWUUYvuQhE9
 1egGC67IWP7SdtXOkUpL3Tb82OMAv+knmgpgWE28cb5qEivKgg1zJmKQBJH5lPk8piob
 nONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lsQDy5D1zmni7O2MBnvXWalrUx1/84UfOaV4LUwOgNY=;
 fh=dLKDPTPk0lqafujOy7yaw/831KlxDNnaOf+uG7l+kEU=;
 b=sZLjgTdK5KoZ+o4zB3yf1oriUgpA26aRoE9O7FZQbphzvTxwFpq8lmJyWnyt4eQlCL
 lq0NQ0RtFbHtM3R7q/tpF6vWnW8GHZTzN0Gqq9/pNKuGVRIXgr/j9B2/M2Ir6D9RYG+4
 G3XfI98ynzCwg3pIhoTbDWYP1vPg4/ApN8yKtGYusB4hSWr6nQsKsSo9VrScZK8wGJrR
 6nRexp5G5HKhw7O0vCtuh4XfJgGcie0FSkmNgrAxjdNIZDoAkuvUDJLASjhcpM/RSFH8
 /msywZyRZdIdTD3y8cw8XQFG+1ddkmrVLTt/sUD9DfxgvUodzo3rL1qGoSlOqXwsB+4i
 77xg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787259681; x=1787864481; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lsQDy5D1zmni7O2MBnvXWalrUx1/84UfOaV4LUwOgNY=;
 b=BOamjcFYNwSJ6moIoN+gzbmmX6JQLvPNl287MiHhQN11c0ZcA6i6u32aCGUMLZmoWY
 aPDFBZ2RX97D1/4qp926WXftk2NwK4qch/+SuzAiuUmvek0SouY/KVRd/NLmSDRHiHEx
 wOjpC4iZvBNltEx8aAQNFOaO3fpuJN+CL6x0sM7EixYA7bCwHKEelc5W2hKAG16bSpWl
 krvw76TkONvPbmU8E6XmSH6uVBbJMk4blohKef3CKyqorXbyzjhxxe+9uvpzg2H64Kng
 LxZ0YwWNFxX87q32CQcenqMx5lwrBNOthzt9Nkb5K1ZCtqcP8CdofDsiBOWkxUmkSJsl
 BFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787259681; x=1787864481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lsQDy5D1zmni7O2MBnvXWalrUx1/84UfOaV4LUwOgNY=;
 b=ASHoMaKsJsWbjSyM55JfUwfzCsa1JNLpzHLl07JndT7WF3tlzFJZ8TWWcwMMRtdJtR
 XizELjprcXA1sLdUqeaZPNLy4qkQ6OjnPYYi+pUfCAJl+6UCYc9DOOW8i9o4Al5N76rA
 pXVDMTcNG8VWJoX0/3GWYzv69A/y8xkeA4r8MzannVfYV3g9g3C9tgTTDkQd0IVwN5B6
 HqT1Ue57Wo+7JzZNo8krpsZO/wgDNI1uoOUapi3P5O3bH9hA0IhgCzKD+ixrCr5IhW8f
 wBUFQp68bppAg/1baVvd9Spqz2AQmQ3VVeYQP2S8rYuhWS54nd/d/vaPWzToZMVHI+Vu
 cI4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rog/LowB4d7qmFh0rVvm5dIdKjfwsCu1gHrQGTb6wO+RG/XG7yjtO9qPtYbNl2OFeE86Ga/t+iqsf7gWWwDpPO8@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMwGLZ8hQPkW/8KqPce+9rVtMguInWS441vkTE1VcP/QG327of
 ZAIrNnSKILJl6LoNYs8IF1iMtWCtWT2kgW3HjGWOoi7bIbjW1vFbQDVqub34xTh1m5tK7OKG6n4
 qGmRFlMTZDO9PdkpWOSqZ07AiIsYQCjE=
X-Gm-Gg: AR+sD10Q0GPZmSMcnJ+XuYpz5w/Tv3jTkOFTDcfestzX7iitGqN3/kh6FblPhHdml+y
 Q3hWJHMfhOc7u4esGaQvIR1VuAS4TScBoFfeq8J+1FflPqOeZNeq3fA3dzpp1gpcgs1XzCmx92p
 eINLnMhpY0pcRLj47CTjI9ABXcrM8GniCpuIF4SmddDMZzX1kQEv6z/fMA4D9NxykNJstJ+LQmt
 AMioFJ0SzuzQoIL2YUXGUeTdRDT6w6QuSmYazsrcoCLrBsrJWbm7ZxSrUi8+jdm3r9w0gSzb3Wb
 nxxq6P5XbfyPN/5XJA0vRMG49P3eXxwSqdELehl6b4kDdUPLnZfAQZ8cljYfpCcDgB+hb8LQ17O
 a3eyhZm/8OE81pHHfrzU9J3CzCJMnqPQ=
X-Received: by 2002:a05:6512:2304:b0:5ae:bce4:b696 with SMTP id
 2adb3069b0e04-5b4842223d6mr309490e87.15.1787259680764; Thu, 20 Aug 2026
 14:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260806014813.1587003-1-daeho43@gmail.com>
 <ccec912d-5d80-4f9d-bdb2-c07a16c72b46@wanadoo.fr>
In-Reply-To: <ccec912d-5d80-4f9d-bdb2-c07a16c72b46@wanadoo.fr>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 20 Aug 2026 14:01:08 -0700
X-Gm-Features: AcwNN1WV9dREAVyw6beGMWhBkhAPXtH_wBMzWFeSnfW5aoeJs4NqQqFlgtjtEMI
Message-ID: <CACOAw_xfMD1ewRwpQY4D3rSX_5_PWg3mNg9HyApZuZ=50HsNVQ@mail.gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Headers-End: 1wx9t9-0005wX-Tw
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: support dynamic reserve/release for
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

T24gVGh1LCBBdWcgMjAsIDIwMjYgYXQgMTozMOKAr1BNIENocmlzdG9waGUgSkFJTExFVAo8Y2hy
aXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+IHdyb3RlOgo+Cj4gTGUgMDYvMDgvMjAyNiDDoCAw
Mzo0OCwgRGFlaG8gSmVvbmcgYSDDqWNyaXQgOgo+ID4gRnJvbTogRGFlaG8gSmVvbmcgPGRhZWhv
amVvbmdAZ29vZ2xlLmNvbT4KPiA+Cj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBkeW5hbWljIG1hbmFn
ZW1lbnQgZmVhdHVyZSB0byB0aGUgZXhpc3RpbmcgZGV2aWNlCj4gPiBhbGlhc2luZyBmdW5jdGlv
bmFsaXR5LiBJdCBhbGxvd3MgdXNlcnMgdG8gZHluYW1pY2FsbHkgcmVzZXJ2ZSBvcgo+ID4gcmVs
ZWFzZSBzcGVjaWZpYyBkZXZpY2VzIGZyb20gdGhlIGZpbGVzeXN0ZW0ncyBmcmVlIHBvb2wgYXQg
cnVudGltZQo+ID4gdGhyb3VnaCBuZXcgaW9jdGxzLgo+ID4KPiA+IFRvIHN1cHBvcnQgdGhpcywg
dGhyZWUgbmV3IGlvY3RscyBhcmUgaW50cm9kdWNlZDoKPiA+IC0gRjJGU19JT0NfUkVTRVJWRV9E
RVZfQUxJQVM6IFRoaXMgcmVjbGFpbXMgdGhlIHNwYWNlIG9jY3VwaWVkIGJ5IGEKPiA+ICAgIGRl
dmljZSBhbGlhc2luZyBmaWxlLiBJdCBmaXJzdCBwZXJmb3JtcyBhIGNhcGFjaXR5IGNoZWNrLCBy
ZXNldHMgR0MKPiA+ICAgIHZpY3RpbSBpbmZvcm1hdGlvbiBmb3IgdGhlIHRhcmdldCByYW5nZSwg
bWFya3MgdGhlIHNlZ21lbnRzIGFzIGluLXVzZQo+ID4gICAgdG8gcHJldmVudCBuZXcgYWxsb2Nh
dGlvbnMsIGFuZCB0aGVuIHRyaWdnZXJzIEdDIHRvIG1pZ3JhdGUgZXhpc3RpbmcKPiA+ICAgIHZh
bGlkIGRhdGEgb3V0IG9mIHRoZSByYW5nZS4gRmluYWxseSwgaXQgcmVzZXJ2ZXMgdGhlc2UgYmxv
Y2tzIGluIHRoZQo+ID4gICAgU0lUIHRvIGVmZmVjdGl2ZWx5IGV4Y2x1ZGUgdGhlIGRldmljZSBm
cm9tIHRoZSB1c2FibGUgY2FwYWNpdHkuCj4gPgo+ID4gLSBGMkZTX0lPQ19SRUxFQVNFX0RFVl9B
TElBUzogVGhpcyByZWxlYXNlcyB0aGUgcmVzZXJ2ZWQgc3BhY2Ugb2YgYQo+ID4gICAgcHJldmlv
dXNseSByZXNlcnZlZCBkZXZpY2UgYWxpYXNpbmcgZmlsZS4gSXQgdHJ1bmNhdGVzIHRoZSBibG9j
a3MKPiA+ICAgIGFzc29jaWF0ZWQgd2l0aCB0aGUgZmlsZSwgd2hpY2ggbWFrZXMgdGhlbSBhdmFp
bGFibGUgZm9yIGdlbmVyYWwKPiA+ICAgIGZpbGVzeXN0ZW0gYWxsb2NhdGlvbiBhZ2Fpbi4KPiA+
Cj4gPiAtIEYyRlNfSU9DX0dFVF9ERVZfQUxJQVNfU1RBVFVTOiBUaGlzIHJldHJpZXZlcyB0aGUg
Y3VycmVudCBhbGlhc2luZwo+ID4gICAgc3RhdHVzIG9mIGEgZGV2aWNlIGFsaWFzaW5nIGZpbGUs
IHJldHVybmluZyB3aGV0aGVyIHRoZSBmaWxlIGlzCj4gPiAgICByZWxlYXNlZCAoaW5hY3RpdmUg
YWxpYXMpIG9yIHJlc2VydmVkIChhY3RpdmUgYWxpYXMsIHdpdGggYmxvY2tzCj4gPiAgICBmdWxs
eSBhbGxvY2F0ZWQgb24gdGhlIGRldmljZSkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRGFlaG8g
SmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPgo+IEhpLAo+Cj4gdGhpcyBwYXRjaCBoYXMg
YWxyZWFkeSByZWFjaGVkIC1uZXh0LCBidXQgMiBjb21tZW50cyBiZWxvdywgc2hvdWxkIHRoZXkK
PiBtYWtlIGFueSBzZW5zZS4KPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvbmFtZWkuYyBiL2Zz
L2YyZnMvbmFtZWkuYwo+ID4gaW5kZXggY2FjMDNiOGU5MWExLi44YzNiNTc5ODdmNmMgMTAwNjQ0
Cj4gPiAtLS0gYS9mcy9mMmZzL25hbWVpLmMKPiA+ICsrKyBiL2ZzL2YyZnMvbmFtZWkuYwo+ID4g
QEAgLTQyNSw2ICs0MjUsOSBAQCBzdGF0aWMgaW50IGYyZnNfbGluayhzdHJ1Y3QgZGVudHJ5ICpv
bGRfZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmRpciwKPiA+ICAgICAgIGlmICghZjJmc19pc19jaGVj
a3BvaW50X3JlYWR5KHNiaSkpCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRU5PU1BDOwo+ID4K
PiA+ICsgICAgIGlmIChJU19ERVZJQ0VfQUxJQVNJTkcoaW5vZGUpKQo+ID4gKyAgICAgICAgICAg
ICByZXR1cm4gLUVQRVJNOwo+ID4gKwo+ID4gICAgICAgZXJyID0gZnNjcnlwdF9wcmVwYXJlX2xp
bmsob2xkX2RlbnRyeSwgZGlyLCBkZW50cnkpOwo+ID4gICAgICAgaWYgKGVycikKPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsKPiA+IEBAIC01NjgsNiArNTcxLDkgQEAgc3RhdGljIGludCBm
MmZzX3VubGluayhzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQo+ID4K
PiA+ICAgICAgIHRyYWNlX2YyZnNfdW5saW5rX2VudGVyKGRpciwgZGVudHJ5KTsKPiA+Cj4gPiAr
ICAgICBpZiAoSVNfREVWSUNFX0FMSUFTSU5HKGlub2RlKSkKPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FUEVSTTsKPiA+ICsKPgo+IEJhc2VkIG9uIHN1cnJvdW5kaW5nIGdvdG8sIHNob3VsZCB0
aGlzIG9uZSBiZToKPiAgICAgZXJyID0gLUVQRVJNCj4gICAgIGdvdG8gb3V0Owo+ID8KPgo+ID4g
ICAgICAgaWYgKHVubGlrZWx5KGYyZnNfY3BfZXJyb3Ioc2JpKSkpIHsKPiA+ICAgICAgICAgICAg
ICAgZXJyID0gLUVJTzsKPiA+ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiBAQCAtOTQ2LDYg
Kzk1Miw5IEBAIHN0YXRpYyBpbnQgZjJmc19yZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAs
IHN0cnVjdCBpbm9kZSAqb2xkX2RpciwKPiA+ICAgICAgIGJvb2wgb2xkX2lzX2RpciA9IFNfSVNE
SVIob2xkX2lub2RlLT5pX21vZGUpOwo+ID4gICAgICAgaW50IGVycjsKPiA+Cj4gPiArICAgICBp
ZiAoSVNfREVWSUNFX0FMSUFTSU5HKG9sZF9pbm9kZSkpCj4gPiArICAgICAgICAgICAgIHJldHVy
biAtRVBFUk07Cj4gPiArCj4gPiAgICAgICBpZiAodW5saWtlbHkoZjJmc19jcF9lcnJvcihzYmkp
KSkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87Cj4gPiAgICAgICBpZiAoIWYyZnNfaXNf
Y2hlY2twb2ludF9yZWFkeShzYmkpKQo+ID4gQEAgLTEwMTYsNiArMTAyNSw4IEBAIHN0YXRpYyBp
bnQgZjJmc19yZW5hbWUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAqb2xk
X2RpciwKPiA+ICAgICAgIH0KPiA+Cj4gPiAgICAgICBpZiAobmV3X2lub2RlKSB7Cj4gPiArICAg
ICAgICAgICAgIGlmIChJU19ERVZJQ0VfQUxJQVNJTkcobmV3X2lub2RlKSkKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOwo+Cj4gQmFzZWQgb24gc3Vycm91bmRpbmcgZ290
bywgc2hvdWxkIHRoaXMgb25lIGJlOgo+ICAgICBlcnIgPSAtRVBFUk0KPiAgICAgZ290byBvdXRf
ZGlyOwo+ID8KCk9oLCByaWdodC4gVGhhbmsgeW91IGZvciBsZXR0aW5nIG1lIGtub3cgdGhpcy4K
Cj4KPiA+Cj4gPiAgICAgICAgICAgICAgIGVyciA9IC1FTk9URU1QVFk7Cj4gPiAgICAgICAgICAg
ICAgIGlmIChvbGRfaXNfZGlyICYmICFmMmZzX2VtcHR5X2RpcihuZXdfaW5vZGUpKQo+ID4gQEAg
LTExNDMsNiArMTE1NCw5IEBAIHN0YXRpYyBpbnQgZjJmc19jcm9zc19yZW5hbWUoc3RydWN0IGlu
b2RlICpvbGRfZGlyLCBzdHJ1Y3QgZGVudHJ5ICpvbGRfZGVudHJ5LAo+ID4gICAgICAgaW50IG9s
ZF9ubGluayA9IDAsIG5ld19ubGluayA9IDA7Cj4gPiAgICAgICBpbnQgZXJyOwo+ID4KPiA+ICsg
ICAgIGlmIChJU19ERVZJQ0VfQUxJQVNJTkcob2xkX2lub2RlKSB8fCBJU19ERVZJQ0VfQUxJQVNJ
TkcobmV3X2lub2RlKSkKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsKPiA+ICsKPiA+
ICAgICAgIGlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKHNiaSkpKQo+ID4gICAgICAgICAgICAg
ICByZXR1cm4gLUVJTzsKPiA+ICAgICAgIGlmICghZjJmc19pc19jaGVja3BvaW50X3JlYWR5KHNi
aSkpCj4gWy4uLl0KPgo+IENKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
