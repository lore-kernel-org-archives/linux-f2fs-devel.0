Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EEDCDB474
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Oct 2023 09:03:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qsJVF-0005Gc-Cg;
	Mon, 16 Oct 2023 09:03:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1qsJVD-0005GR-Tr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 09:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=; b=Tpy6XrFD/9UuV2U/Wde36yCouJ
 ivRyVXsAr+WRFLY+TmHU+7sQ71s1eTjo/vZzhgGSn+9CkjxnWNsvm2WsF4HAixhpKO1KMKoe4gjHJ
 BKPwmThepV8iNZQnzqr2Hdf1jXy8IeORShHtop/UCkbRQK/rfV1RL5h92oA9wrQVJXSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=; b=ftwgdC5GqJXvKXLKzotrYWKNAL
 fPXlefb+wPxbHiybgmlE6DKu8Zk5Ldi03kGUZdtLaTau0IR6+LDU1tSjNN1NT+pAxqtCG2ShLNCTs
 seCugroyutTcaFIL4RCJsP5JReI+Mp5Uck2HxLELyopLgv7XGjYGF9gEESXzny8RWjvI=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qsJVB-0005XF-Lm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 09:03:07 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so7287321a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Oct 2023 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697446979; x=1698051779; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=;
 b=ieSaStbbYYnrEf5aBxzwfCEAy9l9807IK7YDZ7YluKGR4jxNGMHfVlkAkaXiRxQWZs
 Mrv0R4Yqg+xqCwPM/edI84gqzDr03XjwSJnEpKJxwkK86h0x3m15FelVaiKuYTqgDrVT
 CF15uFdCpyqolAH5h6EcjWf3Rs4C1X+dIHfxCpI8U/3XBN6iZo3lIi17Q1D9t1f/vpaf
 bPWS7Wabo/YdCQ2QSVDex29Kkvk+10SwKvf0Ni8PXMerI2J0Dljkkx+sCJ37Buh7VGDV
 7flX0pIAzBXYagceSxvrPPseaRYOlDv+TH68PVprnuwP27BKKYP9wasnlSadkn8qvH94
 SmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446979; x=1698051779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=;
 b=lZw+6rk5M1fQUsPKgkrxsfiYVBFnvJ47DsD2J4XQE13DM6+qC2azZWMu/uy+4aMhox
 ofqjU8dNRybjqS9QFO2CtVMsUBnf0XmSLuAZrvzBqP+S7EHd4m5Qr93fc0fcuMpE+jCZ
 lQO8iG0I48Vz4vw6djTYeIYn/tlCQHCTeiRBo8GL8MrxfD4cE/+tSozwc+IhdDvrDzWc
 myo6AAWGWf4iCWiRTwpPO8TXBLjMM3ZE3sRIAvVaEsKqKUxUIcKMXNrlkWtpQv0AnZfw
 IdFWSLB0/9zE3/eZb90Fjwseuo+Lijxb68dvgw4XZNIHcz02JbQbcprfOdfumKPBFHKD
 hZRQ==
X-Gm-Message-State: AOJu0YzY/xa5UO2xy0k0HMOwyS0tVnGxiGzUzwKRiSgqSmJztgIM7VId
 za6tBp5n5C2hAy0UmIWWzslqqus0MwhAQhel3lw=
X-Google-Smtp-Source: AGHT+IGTuzMF+kaLgulyD/Pi5k7gUXqsLRBL7hI18qBO8zB+xnaftx6sdgpW+RFfzWvTQN0tSV2gwQU5ZMQF+dzi2P8=
X-Received: by 2002:a05:6402:2293:b0:53d:7be0:4a93 with SMTP id
 cw19-20020a056402229300b0053d7be04a93mr15251802edb.11.1697446979146; Mon, 16
 Oct 2023 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1697194703-21371-1-git-send-email-zhiguo.niu@unisoc.com>
 <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org>
In-Reply-To: <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 16 Oct 2023 17:02:47 +0800
Message-ID: <CAHJ8P3J+Rnx4dUDGesdrtajDdP_SxDaM6yyYbHRt4ij_wVGhsg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qsJVB-0005XF-Lm
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error path of
 __f2fs_build_free_nids
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
Cc: jaegeuk@kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RGVhciBDaGFvLAoKT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgMzozN+KAr1BNIENoYW8gWXUgPGNo
YW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiAyMDIzLzEwLzEzIDE4OjU4LCBaaGlndW8gTml1
IHdyb3RlOgo+ID4gU0JJX05FRURfRlNDSyBzaG91bGQgYmUgc2V0IGZvciBmc2NrIGhhcyBhIGNo
YW5jZSB0bwo+ID4gcmVwYWlyIGluIGNhc2Ugb2Ygc2Nhbl9uYXRfcGFnZSBmYWlsIGluIHJ1biB0
aW1lLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29j
LmNvbT4KPgo+IEhpIFpoaWd1bywKPgo+IENhbiB5b3UgcGxlYXNlIGNoZWNrIGJlbG93IHVwZGF0
ZT8KPgo+ICBGcm9tIDlhMzQ1OWQyZDYyYTEyZjg3MDhkNzJhYTc4MDhhMWRlZjlmOWQ5MmYgTW9u
IFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogWmhpZ3VvIE5pdSA8emhpZ3VvLm5pdUB1bmlz
b2MuY29tPgo+IERhdGU6IEZyaSwgMTMgT2N0IDIwMjMgMTg6NTg6MjMgKzA4MDAKPiBTdWJqZWN0
OiBbUEFUQ0hdIGYyZnM6IGZpeCBlcnJvciBwYXRoIG9mIF9fZjJmc19idWlsZF9mcmVlX25pZHMK
Pgo+IElmIE5BVCBpcyBjb3JydXB0ZWQsIGxldCBzY2FuX25hdF9wYWdlKCkgcmV0dXJuIEVGU0NP
UlJVUFRFRCwgc28gdGhhdCwKPiBjYWxsZXIgY2FuIHNldCBTQklfTkVFRF9GU0NLIGZsYWcgaW50
byBjaGVja3BvaW50IGZvciBsYXRlciByZXBhaXIgYnkKPiBmc2NrLgo+Cj4gQWxzbywgdGhpcyBw
YXRjaCBpbnRyb2R1Y2VzIGEgbmV3IGZzY29ycnVwdGVkIGVycm9yIGZsYWcsIGFuZCBpbiBhYm92
ZQo+IHNjZW5hcmlvLCBpdCB3aWxsIHBlcnNpc3QgdGhlIGVycm9yIGZsYWcgaW50byBzdXBlcmJs
b2NrIHN5bmNocm9ub3VzbHkKPiB0byBhdm9pZCBpdCBoYXMgbm8gbHVjayB0byB0cmlnZ2VyIGEg
Y2hlY2twb2ludCB0byByZWNvcmQgU0JJX05FRURfRlNDSy4KPgo+IFNpZ25lZC1vZmYtYnk6IFpo
aWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29jLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1
IDxjaGFvQGtlcm5lbC5vcmc+Cj4gLS0tCj4gICBmcy9mMmZzL25vZGUuYyAgICAgICAgICB8IDEx
ICsrKysrKysrKy0tCj4gICBpbmNsdWRlL2xpbnV4L2YyZnNfZnMuaCB8ICAxICsKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL25vZGUuYyBiL2ZzL2YyZnMvbm9kZS5jCj4gaW5kZXggYTJiMmM2YzdmNjZk
Li41N2Q5ZGQzYTQzYmMgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9ub2RlLmMKPiArKysgYi9mcy9m
MmZzL25vZGUuYwo+IEBAIC0yMzg5LDcgKzIzODksNyBAQCBzdGF0aWMgaW50IHNjYW5fbmF0X3Bh
Z2Uoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLAo+ICAgICAgICAgICAgICAgICBibGtfYWRkciA9
IGxlMzJfdG9fY3B1KG5hdF9ibGstPmVudHJpZXNbaV0uYmxvY2tfYWRkcik7Cj4KPiAgICAgICAg
ICAgICAgICAgaWYgKGJsa19hZGRyID09IE5FV19BRERSKQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZT
Q09SUlVQVEVEOwo+Cj4gICAgICAgICAgICAgICAgIGlmIChibGtfYWRkciA9PSBOVUxMX0FERFIp
IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGRfZnJlZV9uaWQoc2JpLCBzdGFydF9uaWQs
IHRydWUsIHRydWUpOwo+IEBAIC0yNTA0LDcgKzI1MDQsMTQgQEAgc3RhdGljIGludCBfX2YyZnNf
YnVpbGRfZnJlZV9uaWRzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwKPgo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXQpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGYyZnNfdXBfcmVhZCgmbm1faS0+bmF0X3RyZWVfbG9jayk7Cj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmMmZzX2VycihzYmksICJOQVQgaXMgY29ycnVwdCwgcnVuIGZzY2sgdG8g
Zml4IGl0Iik7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCA9
PSAtRUZTQ09SUlVQVEVEKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGYyZnNfZXJyKHNiaSwgIk5BVCBpcyBjb3JydXB0LCBydW4gZnNjayB0byBmaXggaXQiKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X3NiaV9mbGFnKHNi
aSwgU0JJX05FRURfRlNDSyk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGYyZnNfaGFuZGxlX2Vycm9yKHNiaSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVSUk9SX0lOQ09OU0lTVEVOVF9OQVQpOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgICAgICAgICB9Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZjJmc19mcy5oIGIv
aW5jbHVkZS9saW51eC9mMmZzX2ZzLmgKPiBpbmRleCAwN2VkNjljMjg0MGQuLjAzOWZlMGNlOGQ4
MyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2YyZnNfZnMuaAo+ICsrKyBiL2luY2x1ZGUv
bGludXgvZjJmc19mcy5oCj4gQEAgLTEwNCw2ICsxMDQsNyBAQCBlbnVtIGYyZnNfZXJyb3Igewo+
ICAgICAgICAgRVJST1JfQ09SUlVQVEVEX1ZFUklUWV9YQVRUUiwKPiAgICAgICAgIEVSUk9SX0NP
UlJVUFRFRF9YQVRUUiwKPiAgICAgICAgIEVSUk9SX0lOVkFMSURfTk9ERV9SRUZFUkVOQ0UsCj4g
KyAgICAgICBFUlJPUl9JTkNPTlNJU1RFTlRfTkFULAo+ICAgICAgICAgRVJST1JfTUFYLAo+ICAg
fTsKPgo+IC0tCj4gMi40MC4xCgpUaGFuayB5b3UgZm9yIHlvdXIgdXBkYXRlcyBhbmQgdGhlc2Ug
dXBkYXRlcyBhcmUgbW9yZSByZWFzb25hYmxlIGJhc2VkCm9uIHRoZSBsYXRlc3QgY29kZS4KSW4g
YWRkaXRpb24sICBJIGFsc28gbW9kaWZpZWQgdGhlIGZvbGxvd2luZyBjb2RlIGFmdGVyIEkgY2hl
Y2tlZCB0aGUKcmVsYXRlZCBmbG93IG9mIGYyZnNfaGFuZGxlX2Vycm9yLgpFUlJPUl9JTkNPTlNJ
U1RFTlRfRk9PVEVSIGlzIHJldXNlZCBoZXJlLCAgIGFueSBzdWdnZXN0aW9ucyBmb3IgdGhpcz8K
ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvbm9kZS5jIGIvZnMvZjJmcy9ub2RlLmMKaW5kZXggZDllNjA4
Ny4uOTRmNWM3ZiAxMDA2NDQKLS0tIGEvZnMvZjJmcy9ub2RlLmMKKysrIGIvZnMvZjJmcy9ub2Rl
LmMKQEAgLTE0NjcsNiArMTQ2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqX19nZXRfbm9kZV9w
YWdlKHN0cnVjdApmMmZzX3NiX2luZm8gKnNiaSwgcGdvZmZfdCBuaWQsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgb2ZzX29mX25vZGUocGFnZSksIGNwdmVyX29mX25vZGUocGFnZSksCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgbmV4dF9ibGthZGRyX29mX25vZGUocGFnZSkpOwogICAgICAg
IHNldF9zYmlfZmxhZyhzYmksIFNCSV9ORUVEX0ZTQ0spOworICAgICAgIGYyZnNfaGFuZGxlX2Vy
cm9yKHNiaSwgRVJST1JfSU5DT05TSVNURU5UX0ZPT1RFUik7CiAgICAgICAgZXJyID0gLUVJTlZB
TDsKIG91dF9lcnI6CiAgICAgICAgQ2xlYXJQYWdlVXB0b2RhdGUocGFnZSk7CgpJZiB5b3UgaGF2
ZSBubyBvdGhlciBzdWdnZXN0aW9ucywgSSB3aWxsIHVwZGF0ZSB0aGUgIlBBVENIIFYyIgpUaGFu
a3MhCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
