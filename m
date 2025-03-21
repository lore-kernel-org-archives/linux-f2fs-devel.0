Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18624C36002
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Mar 2025 21:16:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tvjjS-0001Qu-QR;
	Fri, 21 Mar 2025 21:16:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1tvjjP-0001QW-Fx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Mar 2025 21:16:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=; b=J5Jd/Cq0PdT5LKrYnoXoQgRHvj
 zgN3zfJG4GmoCJ6IuzZNraeyWAVgm6mXlpySkWWgtGV9tIdUJRWkESMrS9HfeRkapbJ6UvIOUZ+u/
 qXNpYvPeTeQ68bCOMHOQzbCKCMsfdpCD5rXXns81PNFHlxBY4+KCdSRFsDbtagUv5LNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=; b=CytzufuvPtXPbUCmLIkx2W9AAe
 GMniDa+8CkF5BLiFoNak32QdQG5RSGigyYq3ZNkn533K80qL6ItR1vvHKeWBz5klxaKF0hfF20ITH
 YYoRyV32rhnF1cU82d1ZN4HdOXLGFEu6YjMlVnrL6/nPIuKs8NMwMJiMiXk8EfbCEJCE=;
Received: from mail-vk1-f181.google.com ([209.85.221.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tvjjP-0004jt-MZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Mar 2025 21:16:44 +0000
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-52413efd0d3so1087724e0c.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Mar 2025 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742591793; x=1743196593; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=;
 b=gjyUXEcWYNOPIYSrOI4/hQI8uMzXOiGm01WqrrOAvx1cTebw7EtrblviA3Jtio4DrX
 Np2qSwnnHTGYQFYAumD2xF/XYWXfxCQqMWBznRf6MVeq4hdzbwsU4b1bMjygJ9omVSyt
 aYO4jcKMHQSIom4FjPnzNSHUDGQhFgu0H7HRJ7BV1mDrnltPoDKRwsVe2xaB4m9tOK7r
 Ezx9HkAEHoBfxkiGi15yIYHJrky+I2xTMAaeYF5eoEbKuuxDB3P7Hh/hXVn/ZfpPUFaO
 6g0jUIoUZAvzgjx5CYWK37P7USZgKxmNN6Cm2B3JZJ+QUBBVV5CE/iz0xCBAP/TIc6SH
 GKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742591793; x=1743196593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=;
 b=mZhVxatVNoWpq+eQwRKPYUskhsNE2TU7ezDrZlEoz95FEexmKddWaHkbNbVAtIIMyQ
 lnNexweByO5mjJDmDnOp7uh90LZRH0vFkCEbTs4zPXFNs1suRDehaOfFjfdUiJKTJdXQ
 bFBDMeoU2vbelRZq/i9SWIOkHu66Gf+xVo0gzjsxpPNGAoS7JHug0o7ZcDU/vJwfnT2D
 +1pnRf7c2dhSLMrfu6iK+R+JOKiIcBM/9TH6RUsqQRG0xszZ21bdtxNM+7SLhyiiTmim
 TmugMe6jbL0b6vd1yEWzyv5GgOG6sOQmuBYPLKkUn6pqJI5mw2+G2gRX7Yqm3rkVPMxY
 Qtmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhHQSmQFgpSGqd/qsyrFlSfQyYTEyoAZuPfyhwQoS0DNSFCr+R+hIN6RxmaieFjBTsxRBl1alfGEqRgFQs7GNd@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyZ7qdqzVUdXkZVduAk+R79xFfs4dxR/2llQzNzFCW/YCvL8kB+
 HaDeQ87uBn5t02argvQvpe2wqMX31IL0zO5sx93RNrtvmbDatqP2ZRPUAOpo0c/LFFq/eXroC+b
 grA3aqRZOEjoOCbFBUdTyS7HahVo=
X-Gm-Gg: ASbGnctvcsu2SoLURkyxH1JOIm2+or1mB5/jyrp5KzkUSWTgynSkGXzwFZogcuYU/k1
 aiwMX5pkJ8TSBAM5xrE0pfWD5MNnEHmjGxJBtmivXuALMipeeYfEK+GBrFdyxlsaXaaid2ZkyBf
 7axhNn944++DfjxXKwjJth39G8R4Mj5wXp2xw5nIz5GzZvjE8I3nA6fCvl6/8=
X-Google-Smtp-Source: AGHT+IHvsFdkFEAa9eO0IQCA1HOgDBxu4qKbvZx/tf6NJrTq009BFqrlAQC5xjZ+LuQRbFwwo+1TP7Nb3OLCG5AzT4E=
X-Received: by 2002:a05:6122:1989:b0:520:5a87:66fa with SMTP id
 71dfb90a1353d-525a834239cmr4956406e0c.3.1742591792546; Fri, 21 Mar 2025
 14:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250317190809.678626-1-daeho43@gmail.com>
 <ea3988c6-7708-4da9-8009-85708a27275b@kernel.org>
In-Reply-To: <ea3988c6-7708-4da9-8009-85708a27275b@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 21 Mar 2025 14:16:21 -0700
X-Gm-Features: AQ5f1Jr6GrdhGsN2xcP0b4Yh2BAHbCIC2Xw4WIdrgQR3tTNnjyKGXUpV2KwDBGA
Message-ID: <CACOAw_yhfZtmVkmuN0jNVxiEkcEdpmQrSZPiK2CTY6mjjcrUKw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tvjjP-0004jt-MZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: support zero sized file truncate for
 device aliasing files
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

T24gTW9uLCBNYXIgMTcsIDIwMjUgYXQgODo0NeKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiAzLzE4LzI1IDAzOjA4LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEZy
b206IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPgo+ID4gc3VwcG9ydCBh
IGZpbGUgdHJ1bmNhdGlvbiB0byB6ZXJvIHNpemUgZm9yIGRldmljZSBhbGlhc2luZyBmaWxlcy4K
PiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29t
Pgo+ID4gLS0tCj4gPiAgZnMvZjJmcy9maWxlLmMgfCA1ICsrKystCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9m
cy9mMmZzL2ZpbGUuYyBiL2ZzL2YyZnMvZmlsZS5jCj4gPiBpbmRleCBmOTJhOWZiYTk5OTEuLjdh
ZTVhNWFmNWVkOSAxMDA2NDQKPiA+IC0tLSBhL2ZzL2YyZnMvZmlsZS5jCj4gPiArKysgYi9mcy9m
MmZzL2ZpbGUuYwo+ID4gQEAgLTEwMzYsNyArMTAzNiw3IEBAIGludCBmMmZzX3NldGF0dHIoc3Ry
dWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKPiA+Cj4gPiAgICAg
ICBpZiAoKGF0dHItPmlhX3ZhbGlkICYgQVRUUl9TSVpFKSkgewo+ID4gICAgICAgICAgICAgICBp
ZiAoIWYyZnNfaXNfY29tcHJlc3NfYmFja2VuZF9yZWFkeShpbm9kZSkgfHwKPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIElTX0RFVklDRV9BTElBU0lORyhpbm9kZSkpCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAoSVNfREVWSUNFX0FMSUFTSU5HKGlub2RlKSAmJiBh
dHRyLT5pYV9zaXplKSkKPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNV
UFA7Cj4gPiAgICAgICAgICAgICAgIGlmIChpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfQ09N
UFJFU1NfUkVMRUFTRUQpICYmCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIUlTX0FMSUdORUQo
YXR0ci0+aWFfc2l6ZSwKPiA+IEBAIC0xMTE3LDYgKzExMTcsOSBAQCBpbnQgZjJmc19zZXRhdHRy
KHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCj4gPiAgICAg
ICAgICAgICAgIGlmIChlcnIpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsK
Pgo+IERhZWhvLAo+Cj4gSWYgdHJ1bmNhdGUoLCAwKSBmYWlsZWQgZHVlIHRvIHNvbWUgcmVhc29u
cywgbWF5YmUsIHRoZSBmaWxlIHdhcyBwYXJ0aWFsbHkKPiB0cnVuY2F0ZWQsIHNob3VsZCB3ZSB0
YWcgaXQgYXMgaW5jb25zaXN0ZW50IHN0YXR1cyB0byBhdm9pZCBpdHMgbGF0ZXIgYWNjZXNzPwo+
IHRob3VnaHRzPwoKSG1tLCBsb29rcyBsaWtlIEkgZGlkIGl0IHdyb25nLgpJbnN0ZWFkIG9mIGlu
dm9raW5nIGYyZnNfZGVzdHJveV9leHRlbnRfdHJlZSgpLCBJIG5lZWQgdG8gbWFrZSB0aGUKbGVu
Z3RoIG9mIHRoZSBleHRlbnQgdG8gemVybyB3aGVuIHRydW5jYXRpbmcgdGhlIGZpbGUuCklzIGl0
IG9rYXkgd2l0aCB5b3U/Cgo+Cj4gVGhhbmtzLAo+Cj4gPgo+ID4gKyAgICAgICAgICAgICBpZiAo
SVNfREVWSUNFX0FMSUFTSU5HKGlub2RlKSkKPiA+ICsgICAgICAgICAgICAgICAgICAgICBmMmZz
X2Rlc3Ryb3lfZXh0ZW50X3RyZWUoaW5vZGUpOwo+ID4gKwo+ID4gICAgICAgICAgICAgICBzcGlu
X2xvY2soJmZpLT5pX3NpemVfbG9jayk7Cj4gPiAgICAgICAgICAgICAgIGlub2RlX3NldF9tdGlt
ZV90b190cyhpbm9kZSwgaW5vZGVfc2V0X2N0aW1lX2N1cnJlbnQoaW5vZGUpKTsKPiA+ICAgICAg
ICAgICAgICAgZmktPmxhc3RfZGlza19zaXplID0gaV9zaXplX3JlYWQoaW5vZGUpOwo+CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
