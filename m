Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C110C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LqJ37yBgr2tsWskMaLezEySKFtDWO8/A/BnIf5N4QG8=; b=NidVexZbx1yfpH1ubOlq90PCF3
	qHRZ9T03jC3Sbvie7Wh0dNHSAFosPE55wetO5DcsLsJVFY4pLvV/Q4iI3x9dX22/E2Vec3Pn3xsi/
	1kfjVmrPiFfycY/A13C8KxbS+zugx+SMZeBkFlm4/X9tHG1DalZSChhv7m/IE1bKRAhs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wytOj-0006Er-Tr;
	Tue, 25 Aug 2026 15:49:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wytOj-0006El-IY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XdgDC3azhyh6W4VALE1sY4dtcOlfUwhhdipevw8/ehU=; b=aSrvcI+H9Rdgp4cpAYPco+jMQ7
 WeHWEJgGD7gaVPsb9BDlk0TaoSU+V6OD9MQ6w59/WZeglaGdZ0xZQKz7iDVr3KGc72bRGwkVBldhu
 VFC4atMZZfP3+jJZTjkuMoRlwUTrBxln3k+p3kDLDr8tnKdwTEIgnkvgzISpgmD3Ha+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XdgDC3azhyh6W4VALE1sY4dtcOlfUwhhdipevw8/ehU=; b=DuBRvNDc5tHuuCJLYRj8WG7zbE
 8aC6kuv0qYzsdcdSmoc6eJGZtKCYKnnhV60zvqtvFHr11As6fzy2iTBNN9BwJBVQYxxVs+CLeOIuI
 GWE5ckNnMA/lW4mYgnNFtGlwSugF8QwofiokLwxuoInjJoIdvmU0J1lED4tD70gQIsfE=;
Received: from mail-lf1-f47.google.com ([209.85.167.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytOi-0002Id-65 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:13 +0000
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5b011edaf7dso5582694e87.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787672945; cv=none;
 d=google.com; s=arc-20260327;
 b=Q0ohyTgoeDu08SUKqDdfH1gQbnOvpgQDmF34y5122RqrEM409YfWs+/a1bu7G6PoeQ
 9oEOnVoKHctYIbQzlZ0YyNxMT0ieXu6LKA8L1jL4+k6GUAa4ukar6zzzPVI6JNVaSgmP
 ZU3mqapP/RW+dTr8xHxIeG0uey8snFYOGmQGw2uLNzt6uWdt4bu43lHtxZDgOlCivbcM
 PB5KdKk8jrH6VUCpRcvVzfoL0IBzu1tIneJETWUmhtSBHxjrYEfBmUF7U7bt47OSMXXW
 WkVyBvkFw44j11BLaJwPb910SK8Me9yARsQB9QpQQAm7LMdeAIR88VMila+832JU8jbf
 YEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XdgDC3azhyh6W4VALE1sY4dtcOlfUwhhdipevw8/ehU=;
 fh=zfTxjgMiYEZFC2YPBkRcQpsbVs83wj/X9yDf4m9OKiU=;
 b=aVjfHp+eyM1f5bGhHx5xjhaDGiP3gYvlOBU0tLLAEFK+rhF9iVj0IwPs54nQquKQI4
 eWat1A7TroS9pwI5Jz1K9e6tQyHQZDGfwEXkt7QdRPDeTDSjCXH8AOl3Y6jy+FS7dk+8
 KfzTPlYSFg5KEEn4CNt9cL3lBFug3DmCIx47zVfOjUtxfNTZ71EriCw9q/qWQtdGr9ba
 GNTsHE/zn30cbS6+3mZLRi+azcIHJH2dQJ3KHWESAU5mq38zQXFCbkpVpPbxk/MXK38r
 MWGaxr4mRm0GqZIUnLwaBGvALuP9fJ0FMB28PQOVlVzWsHovO1NoEWgORn8jLNSAhxyu
 dB5A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787672945; x=1788277745; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XdgDC3azhyh6W4VALE1sY4dtcOlfUwhhdipevw8/ehU=;
 b=cnyJiO07zQkRZ5cCxpG1rrlBxonaMkecovAuP9wEKlxBcOERQZ1AcWIVItGxITk+bF
 dkSzKDaPgh7Ay1n6vmSQECLDdAuqq8Vbs3iOzDYbQMqRBE1xQ6KuyeeSOjmIXgHnecKw
 rZQ981ELqLzPG9r5r0UkpLG291cydeAKSHLFMo38GjhqkMzo5uIDL+cuIHHKon83w+TU
 fqgBsCUQi3Vi+l3TUvXwDh2CGLakge9Qp6nO06jz3Uc1nTw/h58atE9mjwc5tRAYpHCo
 g/jvb/4XeJWgTNdaZjt2sL88jc0NO407Agt3cEvsvVlvAe9kuEwXqHt3VqqFUPJA1eTP
 yvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672945; x=1788277745;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XdgDC3azhyh6W4VALE1sY4dtcOlfUwhhdipevw8/ehU=;
 b=bYi9chkOWzmZcfG+t3mYSYQYy4oQywdzFrIwFUD2F5464dtwqU0AMOdEu9rUpRIzZ+
 smv8A2c8fG4YmSSX85bZK8yYe/+RKzjkp7SGDX3BCgb4kvfU8S6vi1XdkE4gZOjGrHfS
 rgk1VSfncD3KRnFimRRiGI9f2rcySfeSAK9JgG+08EF3nZU90rgKUX7ssM+XCj/nMwjE
 mTclz0qQaAFYUCKhJ4iCBSWVwO89/7v4Mo3ZYtqoCxYGhnBYQTdJutolfvn48m0sUaDD
 IpYDO2r+giFGl6qh++7DBk00JsqtC9D/6n9N8n0ldnNb7JN8uZEa9vBLuSHgscMVpZNj
 xnxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpomBpebAP67pdPAouLqUpkZofYRB/MrkjrJJClukYibXEACdqAJMDs7URhbF2Y48oALbCAfpPu6GZU7PMMF0Bj@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxMF1BTEMlhBLfv89qpJtHfX6vhlyL4DVokf7cFevnR7VV01D5
 SdY+4fW7IHDWU1um0xnDP9Bv400e5GrR9bNVjch+MF9/wIiE8CvRHFDlYY524YruKdwGnyL2UcO
 5yc6m8bxWgVfsPY3u2hdpe8Cxg8d2b78=
X-Gm-Gg: AR+sD12jpKtL/Okr/uUfIglmPkOcr48CPY55AYT4st1Oe7jqI7myXmpv8NdhkxXDMoX
 Yhsaq50HUxQe4r+jTT98Eh4GzICuEaqwCr2lI+naiNy83/16jLfCSii8yKp8kLDz1XzUccj8lZj
 /o1lgUf01GPbX9iaO+ql5woxaxyAa9CnwHfO+AN6P10/k4ns7Y9IjTtMZf7T7vM6lhk6Zblwft+
 9NnA8MxSUJlQ4tj9A9sTC+EesWACQXYNdeFSbJG/qSaenVZqiFVKjkb8NfvOC5xn/NGztfEUBJH
 lDZwYUpFR5HL5akdfOZGcg1vT4BhWGQCQ2n2yUDwUYDc6sp9D9/B5WxddadXSxt/HNEuhOeRVEA
 /Wuqv1eB1UhjMxmV21lNo98qqS3LOlek=
X-Received: by 2002:a05:6512:3d04:b0:5b2:a339:b422 with SMTP id
 2adb3069b0e04-5b484250e4emr10859491e87.14.1787672944956; Tue, 25 Aug 2026
 08:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260825083738.526423-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260825083738.526423-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 25 Aug 2026 08:48:50 -0700
X-Gm-Features: AcwNN1U3wRlSDSnYDG-Kzww-S4xdF80Kov8BFnDjbutYvFTL5NSWeC1xaYRCgas
Message-ID: <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wytOi-0002Id-65
Subject: Re: [f2fs-dev] [PATCH] f2fs: propagate resizable_tail_secno mount
 option
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

T24gVHVlLCBBdWcgMjUsIDIwMjYgYXQgMTo0MuKAr0FNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gTW91bnQgcGFyc2luZyBzdG9yZXMgcmVzaXphYmxlX3RhaWxfc2Vj
bm8gaW4gRjJGU19DVFhfSU5GTyhjdHgpLAo+IGJ1dCBpdCBkb2VzIG5vdCBtYXJrIHRoZSBvcHRp
b24gaW4gY3R4LT5zcGVjX21hc2suIEFzIGEKPiByZXN1bHQsIGYyZnNfYXBwbHlfb3B0aW9ucygp
IG5ldmVyIGNvcGllcyB0aGUgdmFsdWUgaW50bwo+IEYyRlNfT1BUSU9OKHNiaSksIHNvIGFkanVz
dF9waW5uZWRfYXJlYV9ib3VuZGFyeSgpIGlnbm9yZXMKPiB0aGUgcmVxdWVzdGVkIHRhaWwgcmVz
ZXJ2YXRpb24uCj4KPiBTZXQgdGhlIG1pc3Npbmcgc3BlY19tYXNrIGJpdCBhbmQgcHJvcGFnYXRl
IHRoZSBwYXJzZWQgdmFsdWUKPiB0aHJvdWdoIGYyZnNfYXBwbHlfb3B0aW9ucygpLgo+Cj4gRml4
ZXM6IGQ4NzQ1YmEyNjBhYiAoImYyZnM6IHN1cHBvcnQgcmVzaXphYmxlIHRhaWwgc2VjdGlvbiBh
bmQgdW5pZnkgcGlubmVkIGFsbG9jYXRpb24iKQo+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8
cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiAtLS0KPiBRRU1VIHZhbGlkYXRpb24gc3VtbWFyeToKPiAt
IHBsYWluIG1vdW50IHJlcG9ydGVkIGBwaW5uZWRfYXJlYV9tYXhfc2Vjbm89NTAyYAo+IC0gYC1v
IHJlc2l6YWJsZV90YWlsX3NlY25vPTFgIHJlcG9ydGVkIGBwaW5uZWRfYXJlYV9tYXhfc2Vjbm89
NTAxYAo+IC0gYm91bmRlZCBmaWxsIHN0YXllZCB3aXRoaW4gdGhlIHJlZHVjZWQgYm91bmRhcnkg
dGhyb3VnaCB0aGUgZmlyc3QKPiAgIGBGQUxMT0NfUkVUPS0xIEVSUk5PPTI4YAo+Cj4gIGZzL2Yy
ZnMvc3VwZXIuYyB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+
Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvc3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwo+IGluZGV4
IGMxZTMxNTI4MmVjLi42MjM4ZGZlNmY0ZSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL3N1cGVyLmMK
PiArKysgYi9mcy9mMmZzL3N1cGVyLmMKPiBAQCAtNDA2LDYgKzQwNiw3IEBAIHN0YXRpYyBtYXRj
aF90YWJsZV90IGYyZnNfY2hlY2twb2ludF90b2tlbnMgPSB7Cj4gICNkZWZpbmUgRjJGU19TUEVD
X2Vycm9ycyAgICAgICAgICAgICAgICAgICAgICAgKDEgPDwgMjMpCj4gICNkZWZpbmUgRjJGU19T
UEVDX2xvb2t1cF9tb2RlICAgICAgICAgICAgICAgICAgKDEgPDwgMjQpCj4gICNkZWZpbmUgRjJG
U19TUEVDX3Jlc2VydmVfbm9kZSAgICAgICAgICAgICAgICAgKDEgPDwgMjUpCj4gKyNkZWZpbmUg
RjJGU19TUEVDX3Jlc2l6YWJsZV90YWlsX3NlY25vICAgICAgICAgQklUKDI2KQo+Cj4gIHN0cnVj
dCBmMmZzX2ZzX2NvbnRleHQgewo+ICAgICAgICAgc3RydWN0IGYyZnNfbW91bnRfaW5mbyBpbmZv
Owo+IEBAIC0xMjUwLDYgKzEyNTEsNyBAQCBzdGF0aWMgaW50IGYyZnNfcGFyc2VfcGFyYW0oc3Ry
dWN0IGZzX2NvbnRleHQgKmZjLCBzdHJ1Y3QgZnNfcGFyYW1ldGVyICpwYXJhbSkKPiAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIE9wdF9yZXNpemFibGVfdGFpbF9zZWNubzoK
PiAgICAgICAgICAgICAgICAgRjJGU19DVFhfSU5GTyhjdHgpLnJlc2l6YWJsZV90YWlsX3NlY25v
ID0gcmVzdWx0LnVpbnRfMzI7Cj4gKyAgICAgICAgICAgICAgIGN0eC0+c3BlY19tYXNrIHw9IEYy
RlNfU1BFQ19yZXNpemFibGVfdGFpbF9zZWNubzsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4g
ICAgICAgICB9Cj4gICAgICAgICByZXR1cm4gMDsKPiBAQCAtMTc3OSw2ICsxNzgxLDkgQEAgc3Rh
dGljIHZvaWQgZjJmc19hcHBseV9vcHRpb25zKHN0cnVjdCBmc19jb250ZXh0ICpmYywgc3RydWN0
IHN1cGVyX2Jsb2NrICpzYikKPiAgICAgICAgICAgICAgICAgRjJGU19PUFRJT04oc2JpKS5lcnJv
cnMgPSBGMkZTX0NUWF9JTkZPKGN0eCkuZXJyb3JzOwo+ICAgICAgICAgaWYgKGN0eC0+c3BlY19t
YXNrICYgRjJGU19TUEVDX2xvb2t1cF9tb2RlKQo+ICAgICAgICAgICAgICAgICBGMkZTX09QVElP
TihzYmkpLmxvb2t1cF9tb2RlID0gRjJGU19DVFhfSU5GTyhjdHgpLmxvb2t1cF9tb2RlOwo+ICsg
ICAgICAgaWYgKGN0eC0+c3BlY19tYXNrICYgRjJGU19TUEVDX3Jlc2l6YWJsZV90YWlsX3NlY25v
KQo+ICsgICAgICAgICAgICAgICBGMkZTX09QVElPTihzYmkpLnJlc2l6YWJsZV90YWlsX3NlY25v
ID0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEYyRlNfQ1RYX0lORk8oY3R4KS5y
ZXNpemFibGVfdGFpbF9zZWNubzsKCkhpIFdlbmppZSwKClRoZSBvcmlnaW5hbCBwYXRjaCBpcyBz
dGlsbCB1bmRlciByZXZpZXcuIElmIHlvdSBmb3VuZCBhbiBpc3N1ZSBvcgpoYXZlIGZlZWRiYWNr
LCBwbGVhc2UgcmVwbHkgd2l0aCBhIHJldmlldyBjb21tZW50IG9uIHRoZSBvcmlnaW5hbApwYXRj
aCB0aHJlYWQgaW5zdGVhZC4KCkFsc28sIGlmIHRoaXMgcGF0Y2ggd2FzIGF1dG8tZ2VuZXJhdGVk
IGJ5IEFJLCBwbGVhc2UgYWRqdXN0IHlvdXIKc3lzdGVtIGFjY29yZGluZ2x5LgoKVGhhbmtzLAoK
Pgo+ICAgICAgICAgZjJmc19hcHBseV9jb21wcmVzc2lvbihmYywgc2IpOwo+ICAgICAgICAgZjJm
c19hcHBseV90ZXN0X2R1bW15X2VuY3J5cHRpb24oZmMsIHNiKTsKPgo+IGJhc2UtY29tbWl0OiBk
ODc0NWJhMjYwYWJiY2FmNzVmZDQ1ODg4MTM4MTAxOWFiM2M1YzA3Cj4gLS0KPiAyLjQzLjAKPgo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
