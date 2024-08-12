Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D8EC531DC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:42:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sdZzl-0006Se-Gs;
	Mon, 12 Aug 2024 18:42:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1sdZzk-0006SW-KH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Aug 2024 18:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uwYw9OCc/HgSoYmixTC1LPRnkOINmzwnWqyf3sfoIOk=; b=Jo54yf8v42cED7BgHCzFdtpwom
 t1NDtT4zCvq9qzX2hcYOPUidLYKepXb4f1XxgD8znd7jO1d1rmfQuaU2K0c8HaC2+gTVy/NOSC32P
 pvTakt0OqDpmvjElJhCFyEs2myWPt3wvAB5so7ibw5v3LBH1q9vwLUwzBjXF537u+U+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uwYw9OCc/HgSoYmixTC1LPRnkOINmzwnWqyf3sfoIOk=; b=WASRg2iNXlqekQv0xQqE3S5sEJ
 ZYbxsei5WYcIsFvslRKU00lRf4Y0NCHJa0AC5W6fEk840ExVTWkuDYMehd8dINu9VTF/mgmZPUWro
 HG0kEpVdflZCpqQCgciPUqtWvG20mTMxglvKl7q4WBeCLeEXYjXOgFQCwnGr8+0QJwMY=;
Received: from mail-vs1-f49.google.com ([209.85.217.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sdZzj-0004Mc-A1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Aug 2024 18:42:15 +0000
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-49299323d71so1753568137.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Aug 2024 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723488124; x=1724092924; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwYw9OCc/HgSoYmixTC1LPRnkOINmzwnWqyf3sfoIOk=;
 b=mCkZvZ3LGSqQwHCXd+OHXk9U9Vvy2har7cOypQFJH2NyVEcMSNLjnQAHF94qqXV51D
 OKXuQwh1dsxJunCxJjNbxzmCCVo3GPVHlrmBABkCZln7fYuY4p25II7TmvE6mqE+G4NS
 XFSDdfsXPIy+Qp82Zn6bEn93mmeTT/m2q9PevaYz0oH7k9R1D6kcRSbWyLdO2TWemS0I
 XvcZnKKfGvA46ceX+JONPu6KJhnAxVtd7JKKbnG/2rT/K9mOJCSMVAeq+wWXPPJONbYt
 kg5pXZpfE/Dekib1zAGJabnSh0IjgfbUH+qbV4D52xgYs+9Gj154whrpw5hqIcL7fnpP
 R+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488124; x=1724092924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwYw9OCc/HgSoYmixTC1LPRnkOINmzwnWqyf3sfoIOk=;
 b=sAqQpxbex6cXBmeWbCwAYuCLDcXlb+aWZWgrd/5zDbY6HFWloxzIqgUdpdEm1iFv5F
 p/HVa0jy91mZBCTLJnUMCCDR9NSpeN65YdrjOPTFnB75V+PYbMSGSCn2OdTx35zsz8Wf
 G4y2IlPqw3EYnOKFHGuut3ki9gTDL/vV5XTJFDlJX99qgSzJQSbUbk0coOZOc97XcO7y
 F+tdvKq3gNfXZg1AxMKSonkWrc0jMPz9d4PCYHoHwnUkOHvOKzot0MpRLKTxMbS7V5cv
 zF7wXlsB2guRe6JHh+Xu26gSwQktVPR5c/Qobz+Oon4tSAbi3QAQV2BJd29ynkZIwzc9
 PCFw==
X-Gm-Message-State: AOJu0YwSNUe0pl1JevrbvSEqy5L0RmIpRxS2ZjPubiGkAxUq3eLOHOS5
 RXXfQDwLE9RRY3RQA8Wcv0LQYwQeWqM7ytO9jkeAVpUCELzePUtgDWuX4q0W3v5HaxxJrNeinLU
 mSiHSXkgTWNffMlhMuEZs4RRPqTFCqw==
X-Google-Smtp-Source: AGHT+IFPR8dxMNitqSevaMy7WGRKhWUv94jJj+GXscXCiYX/nIswGwJKg2JAYogapU1HWccYoF6z1EWPmNrKgL6H57w=
X-Received: by 2002:a05:6102:1625:b0:493:b3d8:bd8d with SMTP id
 ada2fe7eead31-49743b113eamr1759948137.26.1723488124306; Mon, 12 Aug 2024
 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240808233248.323318-1-jaegeuk@kernel.org>
In-Reply-To: <20240808233248.323318-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 12 Aug 2024 11:41:53 -0700
Message-ID: <CACOAw_zBs-K_6y45yUeuXwrrzzP1YXcMiuuR7OpoYRGrRJcz7w@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1sdZzj-0004Mc-A1
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: don't call dev_fill w/ null buffer
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

T24gVGh1LCBBdWcgOCwgMjAyNCBhdCA0OjM04oCvUE0gSmFlZ2V1ayBLaW0gPGphZWdldWtAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBJdCdsbCBjcmFjaCBmc2NrLmYyZnMuIEV2ZW4sIGxldCdzIGtl
ZXAgdGhlIHdyaXRlIHBvaW50ZXJzIGFuZCBqdXN0IGZpbmlzaCBpdC4KPgo+IFNpZ25lZC1vZmYt
Ynk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIGZzY2svZnNjay5j
IHwgMjAgKysrKysrKystLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZnNjay9mc2NrLmMgYi9mc2Nr
L2ZzY2suYwo+IGluZGV4IGExOGJlZTlkMGMzYi4uNWZlOGFkNGVmMzI3IDEwMDY0NAo+IC0tLSBh
L2ZzY2svZnNjay5jCj4gKysrIGIvZnNjay9mc2NrLmMKPiBAQCAtMzI5OSw4ICszMjk5LDkgQEAg
c3RhdGljIGludCBjaGtfYW5kX2ZpeF93cF93aXRoX3NpdChpbnQgVU5VU0VEKGkpLCB2b2lkICpi
bGt6b25lLCB2b2lkICpvcGFxdWUpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJzZWdtZW50IDB4JXgiLCB6b25lX3NlZ25vKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IGYyZnNfcmVzZXRfem9uZSh3cGQtPmRldl9pbmRleCwgYmxreik7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KSB7Cj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiW0ZTQ0tdIFdyaXRlIHBvaW50
ZXIgcmVzZXQgIgo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgImZhaWxlZDogJXNcbiIsIGRldi0+cGF0aCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFTU0VSVF9NU0coIldyaXRlIHBvaW50ZXIgcmVzZXQgIgo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZhaWxlZDogJXMsIGVy
cj0lZFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRldi0+cGF0aCwgcmV0KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZzY2stPmNoay53cF9maXhlZCA9IDE7Cj4gQEAg
LTMzMjYsMTggKzMzMjcsMTMgQEAgc3RhdGljIGludCBjaGtfYW5kX2ZpeF93cF93aXRoX3NpdChp
bnQgVU5VU0VEKGkpLCB2b2lkICpibGt6b25lLCB2b2lkICpvcGFxdWUpCj4KPiAgICAgICAgIHJl
dCA9IGYyZnNfZmluaXNoX3pvbmUod3BkLT5kZXZfaW5kZXgsIGJsa3opOwo+ICAgICAgICAgaWYg
KHJldCkgewo+IC0gICAgICAgICAgICAgICB1NjQgZmlsbF9zZWN0cyA9IGJsa196b25lX2xlbmd0
aChibGt6KSAtCj4gLSAgICAgICAgICAgICAgICAgICAgICAgKGJsa196b25lX3dwX3NlY3Rvcihi
bGt6KSAtIGJsa196b25lX3NlY3RvcihibGt6KSk7Cj4gLSAgICAgICAgICAgICAgIHByaW50Zigi
W0ZTQ0tdIEZpbmlzaGluZyB6b25lIGZhaWxlZDogJXNcbiIsIGRldi0+cGF0aCk7Cj4gLSAgICAg
ICAgICAgICAgIHJldCA9IGRldl9maWxsKE5VTEwsIHdwX2Jsb2NrICogRjJGU19CTEtTSVpFLAo+
IC0gICAgICAgICAgICAgICAgICAgICAgIChmaWxsX3NlY3RzID4+IGxvZ19zZWN0b3JzX3Blcl9i
bG9jaykgKiBGMkZTX0JMS1NJWkUpOwoKVGhpcyB3YXMgZm9yIHpvbmVkIGRldmljZXMgdGhhdCBk
b24ndCBzdXBwb3J0IHRoZSBGSU5JU0ggY29tbWFuZC4gSWYKTlVMTCBidWYgaXMgdGhlIHByb2Js
ZW0sIGhvdyBhYm91dCB1c2luZyB6ZXJvIHZhbHVlIGZpbGxlZCBidWZmZXI/Cgo+IC0gICAgICAg
ICAgICAgICBpZiAocmV0KQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiW0ZTQ0td
IEZpbGwgdXAgem9uZSBmYWlsZWQ6ICVzXG4iLCBkZXYtPnBhdGgpOwo+ICsgICAgICAgICAgICAg
ICBBU1NFUlRfTVNHKCJGaW5pc2hpbmcgem9uZSBmYWlsZWQ6ICVzLCBlcnI9JWRcbiIsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZGV2LT5wYXRoLCByZXQpOwo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Owo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBpZiAoIXJldCkKPiAtICAgICAgICAg
ICAgICAgZnNjay0+Y2hrLndwX2ZpeGVkID0gMTsKPiAtICAgICAgIHJldHVybiByZXQ7Cj4gKyAg
ICAgICBmc2NrLT5jaGsud3BfZml4ZWQgPSAxOwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+
ICBzdGF0aWMgdm9pZCBmaXhfd3Bfc2l0X2FsaWdubWVudChzdHJ1Y3QgZjJmc19zYl9pbmZvICpz
YmkpCj4gLS0KPiAyLjQ2LjAuNzYuZ2U1NTljNGJmMWEtZ29vZwo+Cj4KPgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
