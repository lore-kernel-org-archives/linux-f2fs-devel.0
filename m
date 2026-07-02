Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48099C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWjuwkyjXo+3czoZd4c1i2l8vvF6ZTYuSePms189Prs=; b=d9wkz6V0Nz9VQaMdN0Amy0vkw8
	/iaYq9mnAUbTDeoZbKTje6qXe2JRMyNZBhX430Qg2gnEWKzNyU7hMP/k+kA1WR0mfmmPlDa40rWE4
	W1J1zP4s0CakhLWsv0DQTYsvtn9iYiPOjRDEsE08KkJOapnr9HHLS4QkEvYkzxKj2D1g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfIEc-0001ji-Ci;
	Thu, 02 Jul 2026 14:17:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1wfIE0-0001iJ-Qs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 14:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Vs2Z4z+ikjNqh66f70bwK/9lq6Kqa61we4hzSTm8oo=; b=A49zCoGPqAs3glTgMphRKCSIAD
 H5kFxx6c+0lcVq4tHcCFot5ACAdLqQGJ+nv/JHo/xVD3FtX83W4FLIB83cr4Jc5Bp/y8JUzTdPjux
 pJtrYg7LajOUIlSwSkiNIc9AS4Mh+rhsycCKMsVUeSdMsEfJm+PNgg5UUnWwf/wk4LiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Vs2Z4z+ikjNqh66f70bwK/9lq6Kqa61we4hzSTm8oo=; b=a82BIgxr6uX3/RihEDG2APAx0F
 FmN0ZbFudCwqWzvxBithJvma06XVlPU394D3eqtcG43jbeu/5F+YC4Z/HANEPvqYUp+zXxrJF40E0
 /PDx2zx80QcWDrBbWsA+DF39SX+2hryc/PWC5R46ldi3s2xRJEn60pHFBEfdPOjFHeEU=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfIDy-0003kI-BM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 14:17:09 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2c9c9913ddaso4595125ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783001821; x=1783606621; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Vs2Z4z+ikjNqh66f70bwK/9lq6Kqa61we4hzSTm8oo=;
 b=dJZzWu4EzCiYFiz5gjXOHpog34gW3qfFFIuEc/6/iOpk0433uiisrp0qYbADCCKnxy
 CHN9ThN/a8kdkPYaFfu3X+FMcfrVyCfTnCNFnZ/UANkDJs7CTluJEc2IxH2o5XkM6qay
 IY5W/K9glYxlnAPJFcroACQa/S1Mrw8Pauwpv5dljk1rlT06F5TQhrI75ACwPL8ElOTq
 6oLHzdKb6CB0iu0LSIngJKvDf8d4FLYv+bSteRO0jY8glj+vZBpgYIF5TY3jDe7fiLET
 k2+T0uf0iCSjY4MuwAiMadSuf9L2UnkHvpsaP4Zq+Her9C+ct2tnd296b5I6dFic7Mp8
 nFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783001821; x=1783606621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Vs2Z4z+ikjNqh66f70bwK/9lq6Kqa61we4hzSTm8oo=;
 b=i/0JdlI3dXri5OI3KUUV4azMmRV/SiMmAf1E3SDagv+cXKHLpad5I/e8CwpOzN97nX
 Owl3R9piut/NZyofubhml1iShHRtWedtuhSTskAkd3jn/1zivPm22t+ELVPdNxJATdRt
 QJ4stgqDl1b2kl5dxD8lUIZDA7NmUY+AejJONYDZpGS6V8aqihPD7Lu7WGBw+S9Y2VLy
 COfZnM20miviEV6Oadi1cq1+JJ9juyVI8sJO1sbtBPJRz5n2Tpozh6LZTLZNKkj01Yow
 tm0Dg+RJFXCNiFMYZbd32wGk9HEhE3DWVyL3k7ZYwChnlKgwCyt0NzJwel0E5LCvdq7D
 FIGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2y5hNdhvjvXDGRsqFa8Z77UN1y/FLf2YLFk2jaO1y5rkGwIwKbAtTI1LXTE9cza0N1D2AbizV3Pp2ui4ZitT9@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzUzIo+nVsRoQcWgss86U++CSgXgdYoxpPfsBwb5hHZmJVlzUxH
 TasmvsUgUJhFUP/DluSrl2nHppm5DB3iSYeYwvcCNkiIWWM/fQJ2pm1f
X-Gm-Gg: AfdE7cmtkfAv2TpXcG7JEePYvwL3khT0B+nXjRH2eznW/XVbaUky2kpzxLp8tQxM7Vo
 +g7GPqdfI2W5vU4XmwR6vxVVOxBBF2CN9mXIAdmWMHgBBXsYKIJP/8K7L4YYEKxhFUyVTVRSniU
 OK9mHEoX5Wwh5zm/nGn48nC2sd70ZAAWKaN6kZi+c91LHnwbFFihEUqL5Jeo2zF4/GMCHz3976y
 JSolTK903GBD2lyGBwEePtjFlSb8mXwFJi54wcq2jLqSW8CQGb6BmQEkbNHTxqLNglZVpTmXMgf
 RVyj+NgOqyRVXAMUfRr/TMDobisq3zQKDP+zaz0fPCbQS6vsjWbDZ2kwo0r2XtUUHrQB0ZB5F2w
 4V2r9hSDPh7K5DbetqeXa6HjYZIIJNRsFbnujIvrEe15x/HRHoWv/3DqtYyPdCJTXaECe7q3N/x
 it4Llu9logCnb04BvqrddrO5TytbVyLUgamKz4br5xRJUGBZtVcbsOuVfTOw==
X-Received: by 2002:a17:903:2450:b0:2c9:b911:bdc2 with SMTP id
 d9443c01a7336-2cacacd3fbfmr1045015ad.6.1783001820745; 
 Thu, 02 Jul 2026 07:17:00 -0700 (PDT)
Received: from ?IPV6:2408:8607:1b00:8:7faa:628e:a3d0:9e66?
 ([2408:8607:1b00:8:7faa:628e:a3d0:9e66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a9fee7csm14120135ad.69.2026.07.02.07.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 07:17:00 -0700 (PDT)
Message-ID: <0985e6b6-9562-4151-9449-4c94a422fe12@gmail.com>
Date: Thu, 2 Jul 2026 22:16:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jaegeuk@kernel.org
References: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
Content-Language: en-US
From: liujinbao1 <jinbaoliu365@gmail.com>
In-Reply-To: <20260530123038.2101877-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wfIDy-0003kI-BM
Subject: Re: [f2fs-dev] [PATCH] inject.f2fs: fix injecting nat/sit journal
 in compact summary
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
Cc: Sheng Yong <shengyong1@xiaomi.com>, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

cGluZwoK5ZyoIDIwMjYvNS8zMCAyMDozMCwgbGl1amluYmFvMSDlhpnpgZM6Cj4gRnJvbTogbGl1
amluYmFvMSA8bGl1amluYmFvMUB4aWFvbWkuY29tPgo+Cj4gV2hlbiBDUCBoYXMgQ1BfQ09NUEFD
VF9TVU1fRkxBRyBzZXQsIHRoZSBuYXQvc2l0IGpvdXJuYWwgaXMgc3RvcmVkIGluCj4gY29tcGFj
dCBzdW1tYXJ5IGJsb2NrcyBhdCBzdGFydF9zdW1fYmxvY2soKSByYXRoZXIgdGhhbiBpbiB0aGUg
cmVndWxhcgo+IHN1bW1hcnkgYXJlYS4gSG93ZXZlciwgcmV3cml0ZV9uYXRfaW5fam91cm5hbCgp
IGFuZAo+IHJld3JpdGVfc2l0X2luX2pvdXJuYWwoKSBvbmx5IGhhbmRsZWQgQ1BfVU1PVU5UX0ZM
QUcgYW5kIHRoZSBydW5uaW5nCj4gc3RhdGUsIG1pc3NpbmcgdGhlIGNvbXBhY3Qgc3VtbWFyeSBj
YXNlLlRoaXMgY2F1c2VkIHRoZSBmYXVsdCBpbmplY3Rpb24KPiB0byBmYWlsLgo+Cj4gRml4IHRo
aXMgYnkgYWRkaW5nIHRoZSBDUF9DT01QQUNUX1NVTV9GTEFHIGNoZWNrIGJlZm9yZSB0aGUgZXhp
c3RpbmcKPiBDUF9VTU9VTlRfRkxBRyBjaGVjayBpbiBib3RoIGZ1bmN0aW9ucywgd3JpdGluZyB0
aGUgam91cm5hbCB0byB0aGUKPiBjb3JyZWN0IGNvbXBhY3Qgc3VtbWFyeSBibG9jayBsb2NhdGlv
bi4KPgo+IFRlc3Qgc3RlcHM6Cj4gMS4gTkFUIGpvdXJuYWwgaW5qZWN0aW9uIChuaWQ9NCwgcXVv
dGEgZmlsZSk6Cj4gICAgaW5qZWN0LmYyZnMgLS1uYXQgMCAtLW1iIGJsb2NrX2FkZHIgLS1uaWQg
NCAtLXZhbCAxMjM0NSAvZGV2L2Jsb2NrL2J5LW5hbWUvdXNlcmRhdGEKPiAgICBCZWZvcmU6IGJs
a2FkZHIgdW5jaGFuZ2VkICgzMDgyMjUpCj4gICAgQWZ0ZXI6ICBibGthZGRyID0gMTIzNDUKPgo+
IDIuIFNJVCBqb3VybmFsIGluamVjdGlvbiAoc2Vnbm89NjEwNzUsIENVUlNFR19DT0xEX0RBVEEp
Ogo+ICAgIGluamVjdC5mMmZzIC0tc2l0IDAgLS1ibGsgMHgxZTFkYTAwIC0tbWIgdmJsb2NrcyAt
LXZhbCAxMjMgL2Rldi9ibG9jay9ieS1uYW1lL3VzZXJkYXRhCj4gICAgQmVmb3JlOiB2YmxvY2tz
IHVuY2hhbmdlZCAoMCkKPiAgICBBZnRlcjogIHZibG9ja3MgPSAxMjMKPgo+IFNpZ25lZC1vZmYt
Ynk6IFNoZW5nIFlvbmcgPHNoZW5neW9uZzFAeGlhb21pLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBs
aXVqaW5iYW8xIDxsaXVqaW5iYW8xQHhpYW9taS5jb20+Cj4gLS0tCj4gICBmc2NrL2luamVjdC5j
IHwgMTYgKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9mc2NrL2luamVjdC5jIGIvZnNjay9pbmplY3QuYwo+IGluZGV4
IGIwMGUzNTYuLjYwYTJkMjAgMTAwNjQ0Cj4gLS0tIGEvZnNjay9pbmplY3QuYwo+ICsrKyBiL2Zz
Y2svaW5qZWN0LmMKPiBAQCAtNjc1LDYgKzY3NSwxNCBAQCBzdGF0aWMgdm9pZCByZXdyaXRlX25h
dF9pbl9qb3VybmFsKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgdTMyIG5pZCwKPiAgIAkJfQo+
ICAgCX0KPiAgIAo+ICsJaWYgKGlzX3NldF9ja3B0X2ZsYWdzKGNwLCBDUF9DT01QQUNUX1NVTV9G
TEFHKSkgewo+ICsJCWJsa2FkZHIgPSBzdGFydF9zdW1fYmxvY2soc2JpKTsKPiArCQlyZXQgPSBk
ZXZfd3JpdGUoJmpvdXJuYWwtPm5fbmF0cywgYmxrYWRkciA8PCBGMkZTX0JMS1NJWkVfQklUUywK
PiArCQkJCVNVTV9KT1VSTkFMX1NJWkUsIFdSSVRFX0xJRkVfTk9ORSk7Cj4gKwkJQVNTRVJUKHJl
dCA+PSAwKTsKPiArCQlyZXR1cm47Cj4gKwl9Cj4gKwo+ICAgCWlmIChpc19zZXRfY2twdF9mbGFn
cyhjcCwgQ1BfVU1PVU5UX0ZMQUcpKQo+ICAgCQlibGthZGRyID0gc3VtX2Jsa19hZGRyKHNiaSwg
TlJfQ1VSU0VHX1RZUEUsIENVUlNFR19IT1RfREFUQSk7Cj4gICAJZWxzZQo+IEBAIC04MDYsNiAr
ODE0LDE0IEBAIHN0YXRpYyB2b2lkIHJld3JpdGVfc2l0X2luX2pvdXJuYWwoc3RydWN0IGYyZnNf
c2JfaW5mbyAqc2JpLCB1bnNpZ25lZCBpbnQgc2Vnbm8sCj4gICAJCX0KPiAgIAl9Cj4gICAKPiAr
CWlmIChpc19zZXRfY2twdF9mbGFncyhjcCwgQ1BfQ09NUEFDVF9TVU1fRkxBRykpIHsKPiArCQli
bGthZGRyID0gc3RhcnRfc3VtX2Jsb2NrKHNiaSk7Cj4gKwkJcmV0ID0gZGV2X3dyaXRlKCZqb3Vy
bmFsLT5uX3NpdHMsIChibGthZGRyIDw8IEYyRlNfQkxLU0laRV9CSVRTKSArIFNVTV9KT1VSTkFM
X1NJWkUsCj4gKwkJCQlTVU1fSk9VUk5BTF9TSVpFLCBXUklURV9MSUZFX05PTkUpOwo+ICsJCUFT
U0VSVChyZXQgPj0gMCk7Cj4gKwkJcmV0dXJuOwo+ICsJfQo+ICsKPiAgIAlpZiAoaXNfc2V0X2Nr
cHRfZmxhZ3MoY3AsIENQX1VNT1VOVF9GTEFHKSkKPiAgIAkJYmxrYWRkciA9IHN1bV9ibGtfYWRk
cihzYmksIE5SX0NVUlNFR19UWVBFLCBDVVJTRUdfQ09MRF9EQVRBKTsKPiAgIAllbHNlCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
