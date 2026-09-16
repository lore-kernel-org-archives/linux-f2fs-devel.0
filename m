Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887B6C88E77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1zFohw8ZMXcFr6GO7bgCBnY9SNEyNKdcbBuszfxrTc=; b=GOxxzvDo6aYjBc8ujj3Vmb+83c
	qm5acJp37hOAPxFv3/pk0An72QJR8rgmFUVlmwUunV6jI+/DknoHGnqt5dB5+j8r/7vAZ4MPee/9r
	mYFbGRn+DPl0MlGChioHFkCVfgpwlCiO9myEUm+Ldnx3UoZt53wGh7fXDYNFQhu1FDag=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6l9l-0005YN-KX;
	Wed, 16 Sep 2026 08:38:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x6l9c-0005UW-Fr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lnh066cTCuiyfMtY1uf8/R+IhGvvfeHGl2UzvvrxbQ4=; b=byX6LOm9S85aLhy/o0HgjqJ+wp
 OFx8qOUxKLE73SWhPy9zhBPQ00a9CFe8pObeV4Cmv/grJPVd5RiOH2B4FTSOSqlpthLxe2e39LhY5
 X0PeteWHRwqe7eU/FU477wTfodtGvjV149Zee75yQnBJ/NRu1uozR4qC01THQO4PEi4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lnh066cTCuiyfMtY1uf8/R+IhGvvfeHGl2UzvvrxbQ4=; b=a96PA1T0hTdaTIG9rgILI7I5sY
 63wqgbODFp/sFeVmfRHMwrimltdXd1JpFl2PBX9kPHTMID8BJ5OWilSwtSVSIYO+0KpJE2J8EKY3G
 UuU6sYrv0TwDXV1xI+EhFQ2ygdTDm9TV52s6XTR3bRnH9vDYmvo6mTKpdc5GEaP01Nmw=;
Received: from mail-lr2-f12.google.com ([74.125.230.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6l9Z-0000vJ-DR for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:38:05 +0000
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a1f76ec590so317301fa.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789547879; cv=none;
 d=google.com; s=arc-20260327;
 b=ijwsGy1AaANSlcJok9K0lfl5KkCBFxS0D3mNaemFInx+v9ILIQZT8NNCyl23aLWxhH
 +KdX7jV7DdjTbIfVc9cAQhsDWtqUrF08b8VbbkWL+mBstm1D4gIMSEdzX4sTSrqV4gI7
 WsTPZFpiZOu01LARddgoFsbg48d296l/T6VwEDuQte7Ox2ZxJQK4fOut78tR2n4EviUh
 RL8yGCqOphJ+hEgLp446x2szk+8G90BeoOL/PocScJa8V42kqLsiHZJjrZDQXIqQ9fFe
 IOYw43wWc9jh9B1K2x0CEzctPyZ8qnZTo0KZ6fe+NSUt5C6r9Bm06wJa8XnXx6cnwFLx
 ftlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lnh066cTCuiyfMtY1uf8/R+IhGvvfeHGl2UzvvrxbQ4=;
 fh=0k9N23pwr9XNM62sMu668ziUxCw5Kh8jHMJukflZUNQ=;
 b=Z2+JakjQ66DeAL4hanTiXz2NMuosq8oMM2UwVM+/mt9UAsM/F9+th2p6Mn0aVhGPNG
 ZBSPn2dkon7Cq0zeqlb9h1pABr8l/Wovi16CZF0jiZRSExg7ZAH5BkYBdWRSLR/9nZLb
 kDtlPuQOubN9obwrxiRzbVT8Gy5JHue38Sho2bANxnzUXbEg6XvU3Mmn70JxD/2+L/ag
 FWUjZJbX9zLbKBUlQO5IunP1rNuNu5XkRtTv9GgTCESa9v64bw3agFAVWL43RtneDDr3
 c5CUobk//W8lGpNy+de3eon6aa50Zh6AUwTkDb7kBnvfyB97YhzTnuopHttkeFpZgmC6
 LyxQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789547879; x=1790152679; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lnh066cTCuiyfMtY1uf8/R+IhGvvfeHGl2UzvvrxbQ4=;
 b=VmwvvANDRj03X6eMxWU9akQZcYBZLoFRfqkitoipLRBjTpDrUYSn+Lq42fMbQMf/t+
 kOYHh9yuGt1wW1JpzdUilFtKnlf0znHQ0f0G4iYFd+kqyYtLmZepoGarzhioJFdv4/XC
 E5aBWDH8+7VGTzKfQ+WrrIzmR8aPQrh4Y//PnaZGWAaZmhZ71jDNhc1Qss4lEdS01CCo
 Zw5Na4ZYulmWZrMajQY8+aSrkUzGhsDvE573oG6kdUr1aH5nlVh0z4pTPxhPAYbnZG1t
 qCtzz9CnuaSgY/97HYSOJvUco0T9f7PHfzEDJMg1UbXm7GAipKJaRV9FvMeZUfx5JCGY
 vw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789547879; x=1790152679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lnh066cTCuiyfMtY1uf8/R+IhGvvfeHGl2UzvvrxbQ4=;
 b=vwwwR0H3ZjN1jsHuHTqGCxmsLug8infE+qTdskDt6v1FHNFdKVE0Ds2kIkeWSALS5q
 k9f1dLb5clk0/vbH9SwRUHZlVG/mNRN0wg5btJ+7BCci0jOQ1t4EQr6U7plCwSRNmifx
 PY5ozuzp6L10p5iocDt4rxF6ThS7j2nhQiBLZKw7WOSCfP1vhaobNpaPvP+3dXRjekaO
 glQjtadk7rbsF2C3W46BDXnwe31RkUYkENbKuyqNNc5g6h3k9fXvNblPCf2bmW5n/Fg1
 s3/Y/v8/g0A7LS7SriVIHW5JEWml8NhYDq1RJeE+fuFMUBxzg7pbn0qZsZoLw3zFQuKT
 dsHg==
X-Forwarded-Encrypted: i=1;
 AKwUvByeCEWhtFpPX8ASHg4eU+BRypTq4GbaVgNuVGgeDiGQ/Q1dJgo5x/TQ4M9/xeEILpSIJ5YiQC3KfsqN0wBwN8Ho@lists.sourceforge.net
X-Gm-Message-State: AFuF++kW8PYCKApPPzzzM7RylFZhtp/Mmmbf0rb4ZxsyAgqfboYWBg9U
 nRIcX2qlvHkI6yu7Z0Iznhn7coZwMf+6lUQ1Ph5T8BbABg6AkazihzViIbvvx2Sun2nOhhQa6lI
 w7cDEuNB6Ey0/oXzzXSzHhHmKjWj347A=
X-Gm-Gg: AYBFou2gMiWGXnUC8D2hnTM7TSByYBXQD8O0lRXO9Jax4PhVf2gE6KJ62UXvx9YfUEF
 hCyPWToGQlyVPumx13ygQ1tldZLWlgSZ+dNO1nM3ReNU2yJdPyaX7dn2Hp7Fub9bXKo9k88zk6F
 XPfhgSody9mc/1pqhuMELyOh5mriPyNvBPTnRaZP3YwTIFNP6+SH97JA/M1a8pRSvsNilqPK+VA
 r3RGiWdiL3lJiiyjeiOhcyOFJi3QLrot3bdfgPyIAn2TPgZgkHIp3q7wLtr9ftafK5bH2k6H72r
 IjvwkEedBaY/1bxkaN1yTez17n1hxl1xHBEKq6nzFPCNRrpGmsyTRNXN
X-Received: by 2002:a05:6512:39c7:b0:5ae:b6cf:2864 with SMTP id
 2adb3069b0e04-5b8b65b6cffmr482758e87.0.1789547878435; Wed, 16 Sep 2026
 01:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260916015440.2232938-1-chao@kernel.org>
 <20260916015440.2232938-3-chao@kernel.org>
In-Reply-To: <20260916015440.2232938-3-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 16 Sep 2026 16:37:21 +0800
X-Gm-Features: AcwNN1U6Tc80FmVy85b5zrXcT4bV9m6x-OTxVM01uNOxzH9Wj1CoLqa7L-FkLXw
Message-ID: <CAHJ8P3Jk-4ds5CcsBTtYJDv4wFQGr1JwneSOKroRANVe7BXYgw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x6l9Z-0000vJ-DR
Subject: Re: [f2fs-dev] [PATCH v8 02/12] f2fs: cache: initialize meta cache
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

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ55pyIMTbml6XlkajkuIkgMDk6NTnlhpnpgZPvvJoKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBtZXRhX2Jsb2NrcyBpbiBmMmZzX3NiX2luZm8gc3RydWN0dXJlLCBpbml0aWFsaXplcwo+IGFu
ZCBkZXN0cm95cyB0aGUgbWV0YSBjYWNoZSBkdXJpbmcgZmlsZXN5c3RlbSBtb3VudCBhbmQgdW5t
b3VudC4KPgo+IEl0IGFsc28gaW50cm9kdWNlcyBoZWxwZXIgd3JhcHBlcnMgZm9yIG1ldGEgY2Fj
aGUgb3BlcmF0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
PgpSZXZpZXdlZC1ieTogWmhpZ3VvIE5pdSA8emhpZ3VvLm5pdUB1bmlzb2MuY29tPgp0aGFua3Mh
Cj4gLS0tCj4gIGZzL2YyZnMvY2FjaGUuaCB8IDkgKysrKysrKysrCj4gIGZzL2YyZnMvZGF0YS5j
ICB8IDMgKysrCj4gIGZzL2YyZnMvZjJmcy5oICB8IDMgKysrCj4gIGZzL2YyZnMvc3VwZXIuYyB8
IDkgKysrKysrKy0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2NhY2hlLmggYi9mcy9mMmZzL2NhY2hl
LmgKPiBpbmRleCAxZmEyNzlmOWQ2OWUuLmQ4MTIzYTg2Y2RmOCAxMDA2NDQKPiAtLS0gYS9mcy9m
MmZzL2NhY2hlLmgKPiArKysgYi9mcy9mMmZzL2NhY2hlLmgKPiBAQCAtMTkzLDQgKzE5MywxMyBA
QCB2b2lkIGYyZnNfdHJ1bmNhdGVfY2FjaGUoc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrICplbnRy
eSwgYm9vbCBkcm9wX2RpcnR5KTsKPiAgdm9pZCBmMmZzX2Ryb3BfY2FjaGVfcmFuZ2Uoc3RydWN0
IGYyZnNfY2FjaGVkX2Jsb2NrX2xpc3QgKmNhY2hlLAo+ICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGxlbiwgYm9vbCBkcm9wX2RpcnR5KTsKPgo+ICsj
ZGVmaW5lIE1FVEFfQ0FDSEUoc2JpKSAgICAgICAgICAgICAgICAoJihzYmkpLT5tZXRhX2Jsb2Nr
cykKPiArCj4gKyNkZWZpbmUgZjJmc19maW5kX21ldGFfY2FjaGUoc2JpLCBibGthZGRyKSAgICAg
ICAgICAgICBcCj4gKyAgICAgICBmMmZzX2ZpbmRfY2FjaGUoTUVUQV9DQUNIRShzYmkpLCBibGth
ZGRyKQo+ICsjZGVmaW5lIGYyZnNfaW52YWxpZGF0ZV9tZXRhX2NhY2hlcyhzYmksIHN0YXJ0LCBs
ZW4pICAgXAo+ICsgICAgICAgZjJmc19kcm9wX2NhY2hlX3JhbmdlKE1FVEFfQ0FDSEUoc2JpKSwg
c3RhcnQsIGxlbiwgZmFsc2UpCj4gKyNkZWZpbmUgZjJmc190cnVuY2F0ZV9tZXRhX2NhY2hlcyhz
YmksIHN0YXJ0LCBsZW4pICAgICBcCj4gKyAgICAgICBmMmZzX2Ryb3BfY2FjaGVfcmFuZ2UoTUVU
QV9DQUNIRShzYmkpLCBzdGFydCwgbGVuLCB0cnVlKQo+ICsKPiAgI2VuZGlmIC8qIF9MSU5VWF9G
MkZTX0NBQ0hFX0ggKi8KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2Rh
dGEuYwo+IGluZGV4IGQ4NjhiOTM5Y2FlZS4uNTlmZWYyMTMyMTc3IDEwMDY0NAo+IC0tLSBhL2Zz
L2YyZnMvZGF0YS5jCj4gKysrIGIvZnMvZjJmcy9kYXRhLmMKPiBAQCAtNjcwLDYgKzY3MCw5IEBA
IHN0YXRpYyBib29sIF9faGFzX21lcmdlZF9wYWdlKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwg
c3RydWN0IGJpbyAqYmlvLAo+ICAgICAgICAgaWYgKCFpbm9kZSAmJiAhZm9saW8gJiYgIWlubykK
PiAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4KPiArICAgICAgIGlmIChmMmZzX2lzX2Nh
Y2hlX2JpbyhiaW8pKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gKwo+ICAgICAg
ICAgYmlvX2Zvcl9lYWNoX2ZvbGlvX2FsbChmaSwgYmlvKSB7Cj4gICAgICAgICAgICAgICAgIHN0
cnVjdCBmb2xpbyAqdGFyZ2V0ID0gZmkuZm9saW87Cj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9m
MmZzLmggYi9mcy9mMmZzL2YyZnMuaAo+IGluZGV4IGMwYzdkNTFjODMwZi4uODVjNGJmNDBiNGFh
IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZjJmcy5oCj4gKysrIGIvZnMvZjJmcy9mMmZzLmgKPiBA
QCAtMjEwNyw2ICsyMTA3LDkgQEAgc3RydWN0IGYyZnNfc2JfaW5mbyB7Cj4gICNpZmRlZiBDT05G
SUdfREVCVUdfTE9DS19BTExPQwo+ICAgICAgICAgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IGNwX2ds
b2JhbF9zZW1fa2V5Owo+ICAjZW5kaWYKPiArCj4gKyAgICAgICAvKiBmMmZzIGludGVybmFsIGNh
Y2hlICovCj4gKyAgICAgICBzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2tfbGlzdCBtZXRhX2Jsb2Nr
czsKPiAgfTsKPgo+ICAvKiBEZWZpbml0aW9ucyB0byBhY2Nlc3MgZjJmc19zYl9pbmZvICovCj4g
ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwo+IGluZGV4IDZh
MmYwOWM2MWRjZC4uYmMzZDM3ODM3MWU1IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvc3VwZXIuYwo+
ICsrKyBiL2ZzL2YyZnMvc3VwZXIuYwo+IEBAIC0yMDk0LDYgKzIwOTQsOCBAQCBzdGF0aWMgdm9p
ZCBmMmZzX3B1dF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQo+ICAgICAgICAgaXB1dChz
YmktPm1ldGFfaW5vZGUpOwo+ICAgICAgICAgc2JpLT5tZXRhX2lub2RlID0gTlVMTDsKPgo+ICsg
ICAgICAgZjJmc19kZXN0cm95X2NhY2hlKE1FVEFfQ0FDSEUoc2JpKSk7Cj4gKwo+ICAgICAgICAg
LyogU2hvdWxkIGNoZWNrIHRoZSBwYWdlIGNvdW50cyBhZnRlciBkcm9wcGluZyBhbGwgbm9kZS9t
ZXRhIHBhZ2VzICovCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgTlJfQ09VTlRfVFlQRTsgaSsr
KSB7Cj4gICAgICAgICAgICAgICAgIGlmICghZ2V0X3BhZ2VzKHNiaSwgaSkpCj4gQEAgLTUyNjMs
MTIgKzUyNjUsMTQgQEAgc3RhdGljIGludCBmMmZzX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQo+ICAgICAgICAgaWYgKGVycikKPiAgICAg
ICAgICAgICAgICAgZ290byBmcmVlX3BlcmNwdTsKPgo+ICsgICAgICAgZjJmc19pbml0X2NhY2hl
KHNiaSwgTUVUQV9DQUNIRShzYmkpLCBGMkZTX01FVEFfQ0FDSEUpOwo+ICsKPiAgICAgICAgIC8q
IGdldCBhbiBpbm9kZSBmb3IgbWV0YSBzcGFjZSAqLwo+ICAgICAgICAgc2JpLT5tZXRhX2lub2Rl
ID0gZjJmc19pZ2V0KHNiLCBGMkZTX01FVEFfSU5PKHNiaSkpOwo+ICAgICAgICAgaWYgKElTX0VS
UihzYmktPm1ldGFfaW5vZGUpKSB7Cj4gICAgICAgICAgICAgICAgIGYyZnNfZXJyKHNiaSwgIkZh
aWxlZCB0byByZWFkIEYyRlMgbWV0YSBkYXRhIGlub2RlIik7Cj4gICAgICAgICAgICAgICAgIGVy
ciA9IFBUUl9FUlIoc2JpLT5tZXRhX2lub2RlKTsKPiAtICAgICAgICAgICAgICAgZ290byBmcmVl
X3BhZ2VfYXJyYXlfY2FjaGU7Cj4gKyAgICAgICAgICAgICAgIGdvdG8gZnJlZV9tZXRhX2NhY2hl
Owo+ICAgICAgICAgfQo+Cj4gICAgICAgICBlcnIgPSBmMmZzX2dldF92YWxpZF9jaGVja3BvaW50
KHNiaSk7Cj4gQEAgLTU1OTYsNyArNTYwMCw4IEBAIHN0YXRpYyBpbnQgZjJmc19maWxsX3N1cGVy
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykKPiAgICAgICAg
IG1ha2VfYmFkX2lub2RlKHNiaS0+bWV0YV9pbm9kZSk7Cj4gICAgICAgICBpcHV0KHNiaS0+bWV0
YV9pbm9kZSk7Cj4gICAgICAgICBzYmktPm1ldGFfaW5vZGUgPSBOVUxMOwo+IC1mcmVlX3BhZ2Vf
YXJyYXlfY2FjaGU6Cj4gK2ZyZWVfbWV0YV9jYWNoZToKPiArICAgICAgIGYyZnNfZGVzdHJveV9j
YWNoZShNRVRBX0NBQ0hFKHNiaSkpOwo+ICAgICAgICAgZjJmc19kZXN0cm95X3BhZ2VfYXJyYXlf
Y2FjaGUoc2JpKTsKPiAgZnJlZV9wZXJjcHU6Cj4gICAgICAgICBkZXN0cm95X3BlcmNwdV9pbmZv
KHNiaSk7Cj4gLS0KPiAyLjQ5LjAKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
