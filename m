Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD62C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iVRXhHC2GfKW/ifWBg78JjQ+0dFpNWh4zvRFrlGcvw=; b=Oevzxd+De7IylD8uN3gWla0FGD
	gwKh9oXrrHSGFfMLO1VO9aWbbyfFKsYvLDNeDhY9XRT+n+geMFYKMMKVAwmDAToiJJwrmLCzk803p
	4J4IfR9/lO9pDeYwB5O6ZRrrizHAcrM0nHC7ycKw3nFGLKVscmRLh6hnrDoRT0vEPjK4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4Nts-0000Be-Dg;
	Wed, 09 Sep 2026 19:24:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4Ntq-0000BC-90
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZYzMItfvZx4mEK7bjd4sez4FOL2n4oCIU1L5QhytUE8=; b=RIPTz71JH4VWW5Xwz+4WkpISDW
 n6tTyiid1kcuFWHwdgV8uwcy9O9sIWYuHymbU2YR4sX57sWBquTFs/LP8JaF/hPFb50QyMA1Eo7Vo
 hFqZWR+eobgkV5j5xgzaqL7ymLcWYaERBSShIApv6w0LRJJ3wXFz8FqyHKrZTZsb9cAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZYzMItfvZx4mEK7bjd4sez4FOL2n4oCIU1L5QhytUE8=; b=cK1HozmQZTIZ2PmtDlqIWL/bHa
 XOdHfyGajyvOA8aOZ9h5RxNe690w6NQYxcGP+llypP3N8aroiFCWRFUkZ1Z52zGl5xoMPumPHFcez
 fPmtUUtCAM2/INHE8JJHkTQO+M1YFNVK9J+fImp0mJD7eEUxCOAFskMs4MBs4AKv7te8=;
Received: from mail-lr2-f12.google.com ([74.125.230.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Ntn-0004Er-Cy for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 19:23:59 +0000
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff16c0e6so5420721fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 12:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788981832; cv=none;
 d=google.com; s=arc-20260327;
 b=WWYF1Ww0O8HoDQNSuKgENwbJIpLJQ9lcaBmj2BBAsBhQpLg1Qz9zurbYvz0Uoi/Ec1
 RnrlxHOA24MI/FagiY4H5bmjTUKme5dGra9GA54p7aa89/Pa6zBheUOHwVkPRECROD3i
 QSNBP6+kaV4Hfmu1fcgDKdDheoA3gy5JDtdNhU+fKDaHql9GA9V+y0/peo0dbqz45smu
 2nBpEtuCLIDlFSrDwWfI1csh7BeByhRPg9Vumnt/4DnMcWVx0cxtP8g1law+e9xw7ASJ
 IetExYeuUAi0mLUB3rW1+ZtbsLUmkPWtEBSV6nOPS0LsnjDtgrDHDGf6nnBVXM9rjS4J
 0nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYzMItfvZx4mEK7bjd4sez4FOL2n4oCIU1L5QhytUE8=;
 fh=PLIvtr0vWkxwklbn1WgXxQSouMn0H8LnqihB3yBeoLo=;
 b=hCPU0BHhoAeuu/8IP/+ivzDOtpjfyFuA2r23GQRD740vnPKLLmPLb0eFdzsZTGvbL8
 4IteTVgAvma/JQFuXO56L5Ffu/nIruNvP9A4Dl3sCGGT2t6faWVFX4TfSXbNYGr40EkH
 WWy5KlF7lK37PowykTF5NZdweQfP+4SE+7ot/QNz8b87d/qAQ2QSig8y8/gE2QrGvTEC
 Ny7GyTCpEqg6KmB6QeLLoMjqRpJr1Wywyx9Dy3l5aNhobo1P4FQtRux94bD2RE/d+Ow1
 ClMMRUswLfMh22y1lyYKCo98SKpJ6jQneGnGtcDRmJzf12UVA3CCn0fK7KP2vJ+2mRX/
 6buw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788981832; x=1789586632; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZYzMItfvZx4mEK7bjd4sez4FOL2n4oCIU1L5QhytUE8=;
 b=JVQmNj2HP3dspnrwqtpl+zHgQE4KG9Mwph1NVbztiHEa+7zde5H8CXp1+5n9lO4dax
 3zNG0rjNfbBjW5KPRUFYk83jwQ17qcGI/ZxPKGJ79C2wPkjQ0L0v1PLwvy75dQdVpxss
 pK7hw0h3DSGx4F6ZXwI73xf40RtWgciQO6mQiFEvwEj012DmYl7vRD7Xu0QTvrXklxbD
 1s1RuqXa9ZaVoosG9ljpnz8GkreByvexrcTrUuUn1oOtnXvza1tiEjaLM3jRoOXFllUx
 +ERckoK8MF7MhKDvlusHWKQ8VHY9tpi8tKsmqdVFPDFxiUdQCaxyALLgQN6jdXV6Sz08
 iXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788981832; x=1789586632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYzMItfvZx4mEK7bjd4sez4FOL2n4oCIU1L5QhytUE8=;
 b=hdOPErWB2zpo2pZ7jAkGesHwviKJCCTwnWpD6/nTvy2iQDXbX7Hrjk6J4lMJDsZmWp
 7yPm1YCWgB/i3g247E7Xq+fu0frOuiQZXj8kvlfucb4q7jxrHyFTY9hr5BpKuNHiRGab
 lJA09Up6mvA6fcAeBAsK493gJPDjWA6fs97pseEGIk6bRuWqZ5JMZ94UCATQ75lhiRNG
 3lUqW14W6I5a36ZS1ryftn4nxgxzYpEs5TIChK12s6SY3XS7DH83MNdfDF5SIA72GpyO
 7Z8uPwdh+Jq7/EzfQqe/Hd7PQr31t+u3l8Y0thFna3OvllmRl9c6xcaEcoFQawiUpzwj
 lDMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy70kwRfsptLm27fL0qT3R1W+iBchFxwwfQr424K+DX9VzuKfGvE5buIyAMYoDUWG4JV5ziy0/HFd5FHo22NYc1@lists.sourceforge.net
X-Gm-Message-State: AFuF++mCTwsOQkb8ZLnH5IQnL9lTihzTl6c6nkHeCFHzqPSiiYWaIArS
 gtyW2mIVC/KnBf1SCNf/S3UUignwuRrKMVYNSuBPkniJh+hFXhAt+fvI5oIyvmu2KndxM5jum/y
 42gbewXa8wZ8fU3T+Quagz4XBC3+un6s=
X-Gm-Gg: AYBFou1woOveKgBGQj/aur7i3nX//Q4D3wrkdKlHgrJM0pQl8P/hRGA7Aw0QwPmy2xv
 kGxyfAznnV9lQtwqt+Boigo68A5b1ELOKKMPgTL8vlyjCdD3Rn4kLYMPAzqJVHDsv8PzCFkWsu7
 yZRRjQ1bFoxlMKkMsd3RZyuJkTXN/YnBPqDw0AGbKiubW1lMF2iM/JncPatU7UedxZsuoPTXa8F
 EiL5ZdiVOEkyVZNWRq5V1sZWfl+iJY1YrMUlaxssEygVD+bu/sF3ta8+f//1I/Z8W6J9+1LrLBD
 6I++glvL8F9oyIEdha49FaTvZ5CkL1jpQYdTTu0T0zoPuC3AIDxq3yKGUI4nkXm6cy+u5Whlql9
 Z1QuCArjw3vQ4li6AUUWv3CLBrH2+xoJxDVbTA3GuveL8
X-Received: by 2002:a05:6512:b28:b0:5b7:651b:1cc2 with SMTP id
 2adb3069b0e04-5b8980b93a1mr670838e87.6.1788981832445; Wed, 09 Sep 2026
 12:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_ybFr8thjmy3ayzB0u+1f5vSFnR8km67J4bkOE7czSyYw@mail.gmail.com>
 <20260907063342.2300274-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260907063342.2300274-1-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 12:23:39 -0700
X-Gm-Features: AcwNN1U5VkqFiMoVvDZffZUiikt238FMeWd_dqJeezEdVeG8xHgapBFftAlD2rc
Message-ID: <CACOAw_zZPUNNEM_Cdi42ik45S6qA96+igptFZL4ZLrg6tJ-7ug@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Headers-End: 1x4Ntn-0004Er-Cy
Subject: Re: [f2fs-dev] [PATCH 13/14] f2fs: allow large folio support to
 writeable files
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBTZXAgNiwgMjAyNiBhdCAxMTozM+KAr1BNIE5hbnpoZSBaaGFvIDxuenpoYW8uc2ln
bWFAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgMjggQXVnIDIwMjYgMTA6NDQ6NDYgLTA3
MDAsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gSW4gRjJGUywgbmV3bHkgY3JlYXRlZCBmaWxlcyBh
bG1vc3QgYWx3YXlzIHN0YXJ0IHdpdGggaW5saW5lX2RhdGEKPiA+IChgRklfSU5MSU5FX0RBVEFg
KS4KPiA+IEJlY2F1c2UgZjJmc19oYXNfaW5saW5lX2RhdGEoKSBpcyB0cnVlIGR1cmluZyBmMmZz
X25ld19pbm9kZSgpIC8gZjJmc19pZ2V0KCksCj4gPiBtYXBwaW5nX3NldF9sYXJnZV9mb2xpb3Mg
aXMgc2tpcHBlZC4KPiA+IFdoZW4gdGhlIGZpbGUgbGF0ZXIgZXhwYW5kcyBhbmQgaXMgY29udmVy
dGVkIHRvIHJlZ3VsYXIgYmxvY2tzIGluCj4gPiBmMmZzX2NvbnZlcnRfaW5saW5lX2lub2RlKCks
Cj4gPiBgZjJmc19tYXBwaW5nX3NldF9sYXJnZV9mb2xpbygpYCBpcyBORVZFUiBjYWxsZWQuCj4g
PiBBcyBhIHJlc3VsdCwgYWxtb3N0IE5PIG5ld2x5IGNyZWF0ZWQgZmlsZSB3aWxsIGV2ZXIgdXNl
IExhcmdlIEZvbGlvcwo+ID4gZHVyaW5nIGl0cyBsaWZldGltZS4KPiA+IEZpeDogQ2FsbCBgZjJm
c19tYXBwaW5nX3NldF9sYXJnZV9mb2xpbyhpbm9kZSlgIGluc2lkZQo+ID4gYGYyZnNfY29udmVy
dF9pbmxpbmVfaW5vZGUoKWAgb25jZQo+ID4gaW5saW5lIGRhdGEgaXMgY29udmVydGVkLiBBbHNv
IGNvbnNpZGVyIHVzaW5nIHRoZSBzdGFuZGFyZAo+ID4gYG1hcHBpbmdfc2V0X2xhcmdlX2ZvbGlv
cyhtYXBwaW5nKWAKPiA+IGhlbHBlciBpbnN0ZWFkIG9mIGBtYXBwaW5nX3NldF9mb2xpb19taW5f
b3JkZXIobWFwcGluZywgMClgLgo+Cj4gSSdtIGNvbmNlcm5lZCB0aGF0IGNhbGxpbmcgbWFwcGlu
Z19zZXRfbGFyZ2VfZm9saW9zKCkgaGVyZSB3b3VsZAo+IHZpb2xhdGUgdGhlIHNwZWNpZmljYXRp
b24gZm9yIGVuYWJsaW5nIGxhcmdlIGZvbGlvcyBvbiBhIGZpbGUsIGJlY2F1c2UKPiB3ZSB3b3Vs
ZCBiZSBlbmFibGluZyBsYXJnZSBmb2xpb3Mgb24gYW4gYWN0aXZlIGlub2RlLiBQbGVhc2UgdGFr
ZSBhCj4gbG9vayBhdCB0aGUgY29tbWVudCBvZiBtYXBwaW5nX3NldF9sYXJnZV9mb2xpb3MoKSBp
bgo+IGluY2x1ZGUvbGludXgvcGFnZW1hcC5oLgoKSGkgTmFuemhlLAoKVGhhbmtzIGZvciBwb2lu
dGluZyB0aGF0IG91dC4gWW91IGFyZSByaWdodCB0aGF0IGNhbGxpbmcKbWFwcGluZ19zZXRfbGFy
Z2VfZm9saW9zKCkKb24gYW4gYWN0aXZlIGlub2RlIGluc2lkZSBmMmZzX2NvbnZlcnRfaW5saW5l
X2lub2RlKCkgdmlvbGF0ZXMgdGhlIHBhZ2VtYXAuaApzcGVjaWZpY2F0aW9uIGR1ZSB0byB0aGUg
bm9uLWF0b21pYyB1cGRhdGUgb24gbWFwcGluZy0+ZmxhZ3MuCgpIb3dldmVyLCBpZiB5b3UgbG9v
ayByaWdodCBhYm92ZSB0aGF0IGluIGluY2x1ZGUvbGludXgvcGFnZW1hcC5oCihsaW5lcyA0MDgt
NDE0KSwKaXQgYWxzbyBleHBsaWNpdGx5IHN0YXRlczoKIlRoZSBmaWxlc3lzdGVtIHNob3VsZCBj
YWxsIHRoaXMgZnVubGljdGlvbiBpbiBpdHMgaW5vZGUgY29uc3RydWN0b3IuLi4KIERvIG5vdCB0
dW5lIGl0IGJhc2VkIG9uLCBlZywgaV9zaXplLiIKCkluIEYyRlMsIGlubGluZV9kYXRhIGlzIGVz
c2VudGlhbGx5IGFuIGlfc2l6ZS1iYXNlZCBsYXlvdXQgb3B0aW1pemF0aW9uIChmaWxlcwo8PSB+
My40S0IpLCBub3QgYSBwZXJzaXN0ZW50IGZpbGUgcHJvcGVydHkuIFZpcnR1YWxseSBhbGwgbmV3
bHkgY3JlYXRlZCByZWd1bGFyCmZpbGVzIHN0YXJ0IHdpdGggRklfSU5MSU5FX0RBVEEuIFR5aW5n
IGxhcmdlIGZvbGlvIHN1cHBvcnQgdG8gaW5saW5lX2RhdGEgYXQKaW5vZGUgY3JlYXRpb24gdGlt
ZSB2aW9sYXRlcyB0aGUgcnVsZSBvZiBub3QgdHVuaW5nIGxhcmdlIGZvbGlvIHN1cHBvcnQgYmFz
ZWQgb24KZmlsZSBzaXplLCBhbmQgcGVybWFuZW50bHkgcHJldmVudHMgYWxtb3N0IGFsbCBuZXds
eSBjcmVhdGVkIGZpbGVzIGZyb20gZXZlcgp1c2luZyBsYXJnZSBmb2xpb3MgZXZlbiBhZnRlciB0
aGV5IGdyb3cgaW50byBsYXJnZSBmaWxlcy4KClRoZXJlZm9yZSwgd2Ugc2hvdWxkIGVuYWJsZSBs
YXJnZSBmb2xpb3MgdW5jb25kaXRpb25hbGx5IGZvciByZWd1bGFyIGZpbGVzIGluCnRoZSBpbm9k
ZSBjb25zdHJ1Y3RvciAoZjJmc19uZXdfaW5vZGUoKSBhbmQgZjJmc19pZ2V0KCkpIGJ5IHJlbW92
aW5nIHRoZQpmMmZzX2hhc19pbmxpbmVfZGF0YSgpIGNoZWNrIGZyb20gZjJmc19tYXBwaW5nX3Nl
dF9sYXJnZV9mb2xpbygpLgoKVGhhbmtzLAoKPgo+IFRoYW5rcywKPiBOYW56aGUKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
