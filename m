Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8A6C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8uACE7zbnVyJHRQu2Qt7aS6uOnwUdYHW8u3fyJqen4=; b=YNvdEwBf0aCFDMgzhXNn38AX/R
	RXRRbBonJsygu1uLiviq4ySaDJk5VctUxHVYoEAJjKFgtM4vEXYbEl5xN50MEMw+AiopE3iL/ZSHi
	qNkM5MK0MpXV7Uut+6uu/fNH/gJldaDBeiu/3YFt1ymudlcPNAucg/et6CD2YMmVj4ro=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzI4j-0006bA-5N;
	Wed, 26 Aug 2026 18:10:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wzI4i-0006b4-0v
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HKlNWChrlTdknNsFl50kDymmeGcJ6nBkHT+ji7+M0pY=; b=Y5K3VEaS+2Ic/0m6ivKPDg0zcR
 cwhxIAg4TsWrWk9MAwaidP4Jj9WDCT8tfEeDW6RCzLzB7pYzRbCYzGMgbBNnsHoJgFwspRQnqlTPV
 9mHrfEthrjsJoZwPkjkbMHluXjvS9EA1eZAppAqQLdi26lflslDQfZpvF+MLWfURKUpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HKlNWChrlTdknNsFl50kDymmeGcJ6nBkHT+ji7+M0pY=; b=FbIFjgREXKB1ODKVCChClEToAw
 /YWKVcXC+Wnkvhi49BOIDw+HQ59/o7X9K6/xO5mGjPlxBLaAVNRcnUOhATSAsnBsx2k9vKB5JjsF4
 R7ZNvENnUK8xyRjymSBTClJbDrtw0QTmXho3ZzXaZr8UHik35O4xmiCVscNgUzELxOLQ=;
Received: from mail-lf1-f46.google.com ([209.85.167.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzI4g-0004XQ-0R for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:10:12 +0000
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b4740ec30cso1080415e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 11:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787767803; cv=none;
 d=google.com; s=arc-20260327;
 b=m2b0qoQ1jhhi/HcnzEVFK2BB+Ae3jSyDXcUf65h3svhb28z5U8RIaGKfGHBrW5L7nn
 mjXx+lffog4Xf9VKDFLTvfoj/wk2yXB90tzoYN9iCqZZzIEx7XlmLLfa8IXDxd7zXSis
 qpOr9l46zBd77lXDSLo1Ln0Poy82n7nvuqNYvu8bmuyuLRQiATlmTjGKypsZ+ql453Yx
 QeBFYUcyy8baKg3d89cDBeGQ8JqQrQx1UpdHxJdh5pxnr5yEOtiEMjrnkO9yR5Je0bfu
 Q9rxGhksJ59/VstpJcVOpKfEl0gI56HXPE+1sntpPwEXyDeFezKF1S8CAcpj7XTz68A2
 EyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HKlNWChrlTdknNsFl50kDymmeGcJ6nBkHT+ji7+M0pY=;
 fh=vazqkcntwzLThPpzntvnb10UQdEjUPxaJ4Ql1qzGlRM=;
 b=OxbEEmcD25IX5Ha/gvAApFTPSFOt+x8qk0Ooqs7ZNWRMs0LqSKNmw8L+XV3S6De0sn
 gYaztzHw0kKNwZ50qbLrgoaSGIYa0tELJaC7vKK3hgLmPyFp6deagP5jRmY133SZQ6cx
 KigrimPI7Z8Z45xIgOvxvN5mNQHu+We2brpBn2lO137YJHyNK38HkewvFPW30edwPfnM
 q49XE5Q2oanbKDaqvCI3SlY3EWiHN+uV+fDjY45hBvlb01O7cML0yUNtGrCADz0xLLiU
 LVqNjTts9H+/PmTYO3VoFyTRpz0pXVpG5DsD6KaFm1kLsmX7VEp+sf7FmYJSqrNN+AAG
 qmAg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787767803; x=1788372603; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HKlNWChrlTdknNsFl50kDymmeGcJ6nBkHT+ji7+M0pY=;
 b=nUQitDYSsDavDgqWcTr1tmuChqG0GKt8h8R4SYCg0o2WKh5T6mw3yhUcQWkwR55Zfh
 mwtaQ/YDEXeqVSxdD2zHZLLALg8svZGGclhbcHdST96Vku47uT57L/x8YBphqJSYVgXl
 mHFq9V7RFssAgoRif8tHvSyX24DSm+TFIMg/JoYtTT4eVWqneAGsrjZVCkxVX/JWIO2M
 Tonr18j9PvMC8Ecl46tg4A9TXSH7OWQ8oob+Br4imau/TSeAY+NIIxP0Yn/YgUNsyzd7
 vwQLifAMX3KYHMoeGzqj90J5qTqsjgXSsJz6GlGyTey64z1DEXF5Q5iJrTfjiC/9sj5n
 WBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767803; x=1788372603;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HKlNWChrlTdknNsFl50kDymmeGcJ6nBkHT+ji7+M0pY=;
 b=XIwn4IR8ygx+4B6K1F0cp0Z9wU/3x8Ekf/lkltJCA1/gKowFfr5H9YX2HQ71TN/Wob
 lRpKPa2QMafTFw+zP8Qm7DiazPN2OdPKmmbD7fvwMUtLANqmJXnIsp2CeV9iR93p58sT
 nWLthY43xoBTMmR6pp9P2yWFANiy8ndn+hMWxrenRQqIHDP5fKtEO86GDIyKeMJEt8di
 BuDdbrpeG7k6nFXTZoiyAabT5mimsuyZFca07sCguQg3+vyjSLZEibEi10nlbW8ruJHb
 LzrnQ6SfxinlTap32u3GrjgQgWkY1VtnS2vMcetA5pMQl6+dhRaBOVKlXHB96L9U+f/T
 ydUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri4Z78Yoh0m329rgvUda9xOgC+I2pfE7RbrQNj5gxNp7NHZmts4SQ+iBADl+HUlnKWk2unlcKFa5hprgMf8o9P@lists.sourceforge.net
X-Gm-Message-State: AFuF++nGEXrAlKvpfignFs0naOIUXiLU5mqUtas6fh/XxrPMN8x/fvSv
 jAi+RgJvB8ADJ28TvYq0MeQMCOQtnK7cP1H4soevgSluEWKRRGPU5EK9HdzimCAlKQyIrycuF1j
 tp9C8AxEgHxrlLZWZyU8s3S/WE2bGe4k=
X-Gm-Gg: AR+sD1269HRDDlKMO+qoRIJjSyehSOOnmfkJaWN9Hh5YAj4PNxMrYdGLxZZWh8A/z6u
 AvJ5FQP4Qvu0dIZHNP7Y4IutPvTmQjdSwfz1u2kGD5yzuNevH1Nc7c6q/jGKTyaTYmWjMpBXKqy
 lUFXeTe9oV6zI8Mgo88yt/dc3xqRkLGzYIx5sClbtmOIHvmwkiVHt/BnV3RuZYc5EnkjIlPn/rS
 pCw47Rw3w5SEgsPHM7VDrIFjl0AThrrdEJkq+PXO2rWxSV8RFoP8EzNNbwGpnieWSeZB9tU4eVI
 uVg8Jy85uUyz9Ew6M4uAsdFdHxcLa9UVy7vk5FGQpgNxkfzGLJzIjBP1xbsGWIjBZtV4ljZb+SY
 Ui6k/hXjQnxyg0jlyyJjQiJp32ZxNE6EznQ==
X-Received: by 2002:a05:6512:220d:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b4a901ba54mr2637553e87.8.1787767802762; Wed, 26 Aug 2026
 11:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_xpF2fBnJwXPATANo5bK0UWUEx2uNKpy2RCfZRzhOphoA@mail.gmail.com>
 <20260826170954.3878638-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260826170954.3878638-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 26 Aug 2026 11:09:46 -0700
X-Gm-Features: AcwNN1U6mFU_aQynqdGD2J9fZeJHXDULG_iVi6h_430q97y92VMIyrXjYn534_0
Message-ID: <CACOAw_zpa79gA7JO8FX2kiLnXSnCcaKuVTNaL0fH-6LfpTpS0Q@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wzI4g-0004XQ-0R
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: fix device alias state across
 remount
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
 jaegeuk@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBBdWcgMjYsIDIwMjYgYXQgMTA6MTDigK9BTSBXZW5qaWUgUWkgPHF3amh1c3RAZ21h
aWwuY29tPiB3cm90ZToKPgo+IEhpIERhZWhvLAo+Cj4gVGhlIGYyZnMtdG9vbHMgY29tcGFuaW9u
IHBhdGNoIHdhcyBzZW50IHNlcGFyYXRlbHkuIEl0IHBvcHVsYXRlcwo+IGRldl9hbGlhc19pbm9b
XSB3aGVuIG1rZnMgYXNzaWducyB0aGUgYWxpYXMgaW5vZGVzLCBiZWZvcmUgY2FsY3VsYXRpbmcK
PiB0aGUgc3VwZXJibG9jayBjaGVja3N1bSwgc28gYSBmaWxlc3lzdGVtIGNyZWF0ZWQgd2l0aCB0
aGUgdXBkYXRlZCB0b29scwo+IGhhcyB0aGUgbWFwcGluZyBvbiBpdHMgZmlyc3QgbW91bnQuCj4K
PiBDdXJyZW50IG1rZnMuZjJmcyBhY2NlcHRzIGFuIGFyYml0cmFyeSBzbGFzaC1mcmVlIGFsaWFz
X2ZpbGVuYW1lLgo+IEVuZm9yY2luZyBiYXNlbmFtZSBlcXVhbGl0eSB3aWxsIHByZXZlbnQgbmV3
IGN1c3RvbSBhbGlhc2VzLCBidXQgaXQgZG9lcwo+IG5vdCBoYW5kbGUgZXhpc3RpbmcgZmlsZXN5
c3RlbXM6IGFmdGVyIHJlbGVhc2UgYW5kIHJlbW91bnQsIHJlc2VydmUKPiBjYW5ub3QgaWRlbnRp
ZnkgYSBjdXN0b20tbmFtZWQgYWxpYXMsIGFuZCBoYXNfYWxpYXMgaXMgbm90IHJlc3RvcmVkIGZv
cgo+IHBpbm5lZCBhbGxvY2F0aW9uLgo+Cj4gVGhlIGFkZGVkIHN1cGVyYmxvY2sgY29tbWl0IGlz
IG5lZWRlZCBvbmx5IHdoZW4gdGhlIG1hcHBpbmcgaXMgZmlyc3QKPiByZWNvcmRlZCwgYW5kIHRo
ZSByZWxlYXNlIGlvY3RsIGFscmVhZHkgZW5kcyB3aXRoIGEgc3luY2hyb25vdXMKPiBjaGVja3Bv
aW50Lgo+Cj4gU2hvdWxkIGV4aXN0aW5nIGZpbGVzeXN0ZW1zIGNyZWF0ZWQgd2l0aCBjdXN0b20g
YWxpYXMgZmlsZW5hbWVzIHJlbWFpbgo+IHN1cHBvcnRlZD8gSWYgc28sIGEgdG9vbHMtb25seSBy
ZXN0cmljdGlvbiBkb2VzIG5vdCBzZWVtIHN1ZmZpY2llbnQuCj4KClRoYW5rcyBmb3IgdGhlIGNs
YXJpZmljYXRpb24uCgpIb3dldmVyLCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gbW9kaWZ5IHRo
ZSBvbi1kaXNrIHN1cGVyYmxvY2sgZm9ybWF0IGZvciB0aGlzOgoKMS4gQ3VzdG9tIGFsaWFzIGZp
bGVuYW1lcyB3aXRoIGR5bmFtaWMgcmVzZXJ2ZS9yZWxlYXNlIGhhdmUgbmV2ZXIKd29ya2VkIHBy
b3Blcmx5IGZyb20gdGhlIGJlZ2lubmluZyAoYXMgeW91IG5vdGVkLCByZXNlcnZlIGFuZCByZW1v
dW50CndpdGggaGFzX2FsaWFzIHdlcmUgYWxyZWFkeSBicm9rZW4gdXBvbiB0aGUgaW50cm9kdWN0
aW9uKS4KU2luY2UgaXQgd2FzIG5ldmVyIGEgZnVuY3Rpb25pbmcgZmVhdHVyZSBpbiB0aGUgd2ls
ZCwgZW5mb3JjaW5nIHRoZQpuYW1lIGFsaWdubWVudCBpbiBta2ZzLmYyZnMgZG9lcyBub3QgYnJl
YWsgYW55IGV4aXN0aW5nIHdvcmtpbmcKc2V0dXBzLgoKMi4gSW4gcmVhbC13b3JsZCBwcm9kdWN0
aW9uIGVudmlyb25tZW50cyAoc3VjaCBhcyBBbmRyb2lkKSwgdGhlCnBhcnRpdGlvbiBuYW1lIGFu
ZCBhbGlhcyBmaWxlbmFtZSBhcmUgYWxyZWFkeSBjb25maWd1cmVkIGlkZW50aWNhbGx5CnZpYSAv
ZGV2L2Jsb2NrL2J5LW5hbWUvIHN5bWxpbmtzIChlLmcuLCAtYwovZGV2L2Jsb2NrL2J5LW5hbWUv
Zm9vQGZvbykuCgozLiBJZiBzb21lb25lIHJlYWxseSB3YW50cyBhIHNwZWNpZmljIGFsaWFzIGZp
bGVuYW1lLCB0aGV5IGNhbiBzaW1wbHkKcG9pbnQgdG8gYW4gYXBwcm9wcmlhdGVseSBuYW1lZCBk
ZXZpY2Ugbm9kZSBvciBzeW1saW5rIChlLmcuLAovZGV2L2Jsb2NrL2J5LW5hbWUvbXlfYWxpYXNA
KS4KCk1vZGlmeWluZyB0aGUgb24tZGlzayBzdXBlcmJsb2NrIGxheW91dCBhbmQgcGVyZm9ybWlu
ZyBydW50aW1lCnN1cGVyYmxvY2sgd3JpdGVzIChmMmZzX2NvbW1pdF9zdXBlcigpKSBpbiBpb2N0
bCBwYXRocyBpbnRyb2R1Y2UKcGVybWFuZW50IGFyY2hpdGVjdHVyYWwgYmFnZ2FnZSBhbmQgY29t
cGxleGl0eSB0byB0aGUga2VybmVsLCBqdXN0IHRvCnN1cHBvcnQgYSBjb3JuZXIgY2FzZSB0aGF0
IHdhcyBicm9rZW4gc2luY2UgaXRzIGluY2VwdGlvbiBhbmQgY2FuIGJlCmNsZWFubHkgcHJldmVu
dGVkIGF0IGZvcm1hdCB0aW1lLgoKVGhhbmtzLAoKPiBUaGFua3MsCj4gV2VuamllCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAo=
