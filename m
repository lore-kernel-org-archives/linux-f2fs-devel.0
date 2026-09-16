Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A8C982CB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdAJYpKrzKBA7cvRMMRH5jVVluGthMcPuuf4EzVE/1s=; b=Xwc6HnrnxXJpY8bpkhAej8VJrr
	F7yJ4q7hHqX7Kh7yMzq+ZhEVdPQjeSWOYUKu2iB5QZ2nfutRSOhb7VYaIcVNxQwrhYaRotsdxsSLf
	W3yRQ830K4vcm2Bg11mbrl5pGJMiUd58hv1cl1ppnba39uaJSqVbiBjPkqY09yzYyY98=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6l7N-0002KV-DB;
	Wed, 16 Sep 2026 08:35:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x6l7L-0002Js-S2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DiIs+u5F3s4/IwOJgsmJuG+HupZ2YoIV8nI6XUYYhZk=; b=Z+irs3I434KUw877VrAw15AS6p
 H4bwVhR9Sg4QU/7k/oYc2yhSqywXSV1wLLgecgwqprLnOF4k6C3RN/DdkBWjQZL5k3dHm9O4Mu8Ra
 mNvB5GPm3VvgC5hB/3uB58lXKXZNIJl+ztMz/iCuOGt0QEA1/MRebooIqLD9c4UfCDeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DiIs+u5F3s4/IwOJgsmJuG+HupZ2YoIV8nI6XUYYhZk=; b=lSmoLP4WQArb5oWx1kU6o76afx
 +7FiMoOoLukF7A6OXVTEvAm0QmZwNtEi5/aYTc/+KbgjF3Oxz0itTXW0wA5xrqU1cuDismekCjWzZ
 Isy7653KLPAaft9QZRaHvrHFv5ywLu8dHAAHHUXItMWCOqeJt74sz4ky9E0qnrvVBVl0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6l7K-00053W-9w for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:35:47 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e82ea30faso1060355e9.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789547740; cv=none;
 d=google.com; s=arc-20260327;
 b=BVB8kJA6WNYeeLs65qtehS7AiMOzMdCiWOgtJQCfWEr8H6ReQ+eIvzTycMinzoeCez
 8IyiMQhrXq2Yt4dvB/7T98FgAeybEanD7ejZU5Sutb7juL35zXylHn0u//bDuQcQekdq
 IbkaQAiuTs7hYGFGLjvOc5/GPI8+AUNC9sYmqV1nrHEgH3Yroedn8gBBwGDOS4sxTX8t
 K9NEn72X/hbccuA//FXgsdt3HSs3L7pIwNyurVdq+hljwPyFqY98RCUt5sjV4tjbCjsg
 5g749rikac1acawIdHIQjip3zRYkrvmb95ZbIAz1D+l+KSvtW6YY1hDOtmCYdQW5A+Zn
 n9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DiIs+u5F3s4/IwOJgsmJuG+HupZ2YoIV8nI6XUYYhZk=;
 fh=hnJCIXIzRgBWc46yL5JpnXe8I0tht8A2shNTaFXVr1A=;
 b=rLHbGBOvbusP1E6jAeztxspFFdF+bx4Jko+6YY8lXx4MWSq6lR2xaoDc6Dw5Gj5SO0
 wHUN0IjYSzjQf4maaW8xTbexo+fbuLAeflBc7RdgrlhDJlqt2SStX7xWJ1RbGiJ1dGDw
 roc1nb2bhn6t6Hj0FzSP9rOIcGLHC/2igvq3x8yAPtsRau3LnKgiMHwuIUL3c4HSPe/e
 GRAJf3k4+bF/Kni6fKsZeJnl1jcfiNJ4oyKDEKzp+FWAVgtzlpDtYf+/CgackXFKhoPi
 U8+c9rBK6mFo3ptUUtvOkYMya0Zo1bZEjxP5h2PKzc/BE8Rm9h9j+9VTvnPRjnBOGKz5
 CB3Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789547740; x=1790152540; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DiIs+u5F3s4/IwOJgsmJuG+HupZ2YoIV8nI6XUYYhZk=;
 b=N/NlvgK3+3jIbplyO6ekulqon+DlkkBtx2ZcEgeFWI6sehLASm5uFNXvMdOV3q5fbL
 +1cfu7iECe4pdMdskyJue/wkBhvl6WePAG+keilyrlB5Gq60iIxCEPKc33jA3VOpw9AL
 RMVVM+jCEVS8fI/cuRxseDeYTc5Czdph5KBnLJDc08VaPgMq1m5PIT9CkAGHaXQ+fMEl
 52tOxSL88IvpiArLg0rtGhIVLUSEcFthuQKr5qCbfi2GiFzGuqTIpHL57pJKtv4CsfHD
 eYwpGNehnSCMaihquh8BLkkWSpV+zWmHyM9VW1cfy9Hkp2TqIpljuvrGM77xHPCEMpbF
 fTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789547740; x=1790152540;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DiIs+u5F3s4/IwOJgsmJuG+HupZ2YoIV8nI6XUYYhZk=;
 b=fBs4Yxqf9jJEfn7mP4gOslX/50t2oQRPuLwujujIqPCPepDR8EgeLNo1m3ZF63y4FI
 5wrQzBYDJBDmST539t/V+KZYxfyzBfM0wVAYE4WzW2elpWUQG71k60NWvkBo9bcxcUYx
 /7hbXOSQSGubUhRnZs/mQt0JzU1Nzm0GIM9YQoKkLDYLpwyuDPNxSDRnCqs8VEuFTEON
 P+/Zx99EVEwDCDwzPfnIZid7cfNEr9vcn9lbIJUG9OnfOAvz7kKMZii24y5MLcizQYCn
 so8nGidbbWgI3Aviwm0sFde5DnwVej1uq8oMY9O7ds2Zro+NOIhDRr9gXRpEhGDGQH7d
 eadA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsjN1gbgKXOLkZl+o+K4E5JIQrxEO0tu9kvKUYEagvKAO3OWqe9dsKBz83YP/Q3qjpA3VmqG0NjAelwF3aPW2I@lists.sourceforge.net
X-Gm-Message-State: AFuF++mVpgEvWGExup4yByN0wLLirqIx6n/4lzeo21P5vtAYCJDkW3DQ
 bn0shv5kfVBL8zx+L9uVNgcO1zJY9UbVqWRNo0A5SjZNPzQOSdmOy7TEOMUeg22yAUTsGu8vOh1
 MpuSbfLUR7pS+1qKHff+F5+7zRBN3jC0=
X-Gm-Gg: AYBFou3/+szxJYf/tfDASABNVmYdvhSTUj4fwfzHfgpQKQsmJREWpJXd1NfQ6G+py36
 0eTi6Ub8ejTITHWCOpT2CxFjt7tU0ikAYJnzqBVB7QpHBKo2E2QUXFIfCrrxw/xdHt9dXf7KWpB
 /Q+ikzOK8edGF3V7hROQzcsNVU6xo/WSywL1XctHerTw53uGhPIbyLiAkC1Ulquq1fnHyRBsAkp
 XAU5QLTNz3ESvgjTwbw+eTXop46c587Xzo61SkcZ67oUMl61McRGNKfNcShzveI6eht+78kgJ40
 VQtQYQPH/8wj0pwF+zhlj6++b7CmjR8BSAzxOY5oYql63PyA6UX62ek3
X-Received: by 2002:a05:6000:1848:b0:487:ab1:d2aa with SMTP id
 ffacd0b85a97d-4870cd9f3dcmr2407692f8f.0.1789547739693; Wed, 16 Sep 2026
 01:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260916015440.2232938-1-chao@kernel.org>
 <20260916015440.2232938-11-chao@kernel.org>
In-Reply-To: <20260916015440.2232938-11-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 16 Sep 2026 16:35:02 +0800
X-Gm-Features: AcwNN1VGLJPCwy_K-vNDX0HGDG60UyOOcB9dsUueX3WxxPWTskZ_vhb9XQiYzBc
Message-ID: <CAHJ8P3+1J1M4ehLoT-MSuUWcHM-TAr3rwu2z6fjjh9RntM7VGw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x6l7K-00053W-9w
Subject: Re: [f2fs-dev] [PATCH v8 10/12] f2fs: cache: support fault injection
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
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ55pyIMTbml6XlkajkuIkgMDk6NTflhpnpgZPvvJoKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoaXMgcGF0Y2ggYWRkcyBmYXVs
dCBpbmplY3Rpb24gc3VwcG9ydCBmb3IgbWV0YWRhdGEgY2FjaGUgYWxsb2NhdGlvbnMKPiB0byBp
bXByb3ZlIGVycm9yLXBhdGggdGVzdCBjb3ZlcmFnZS4KPiAtIGl0IGludGVncmF0ZXMgZW50cnkg
YWxsb2NhdGlvbnMgd2l0aCBGQVVMVF9LTUFMTE9DCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1
IDxjaGFvQGtlcm5lbC5vcmc+ClJldmlld2VkLWJ5OiBaaGlndW8gTml1IDx6aGlndW8ubml1QHVu
aXNvYy5jb20+CnRoYW5rcyEKPiAtLS0KPiAgZnMvZjJmcy9jYWNoZS5jIHwgMjQgKysrKysrKysr
KysrKystLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2NhY2hlLmMgYi9mcy9mMmZzL2Nh
Y2hlLmMKPiBpbmRleCAzZTZhMTk4ZWYzYjMuLjI3NjI0YjY3OTlhOSAxMDA2NDQKPiAtLS0gYS9m
cy9mMmZzL2NhY2hlLmMKPiArKysgYi9mcy9mMmZzL2NhY2hlLmMKPiBAQCAtMTU0LDIzICsxNTQs
MjcgQEAgc3RhdGljIHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9jayAqZjJmc19jcmVhdGVfY2FjaGUo
Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9ja19saXN0ICpjYWNoZSwK
PiAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBpbmRleCwgYm9vbCBub2ZhaWwpCj4gIHsK
PiArICAgICAgIHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSA9IGNhY2hlLT5zYmk7Cj4gICAgICAg
ICBzdHJ1Y3QgZjJmc19jYWNoZWRfYmxvY2sgKmVudHJ5Owo+ICAgICAgICAgdW5zaWduZWQgaW50
IGZsYWdzID0gR0ZQX05PRlM7Cj4KPiAgICAgICAgIGlmIChpbmRleCA9PSBVTE9OR19NQVgpCj4g
ICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FUkFOR0UpOwo+Cj4gLSAgICAgICBpZiAo
bm9mYWlsKQo+ICsgICAgICAgaWYgKG5vZmFpbCkgewo+ICAgICAgICAgICAgICAgICBmbGFncyB8
PSBfX0dGUF9OT0ZBSUw7Cj4gLQo+IC0gICAgICAgZW50cnkgPSBremFsbG9jX29iaigqZW50cnks
IGZsYWdzKTsKPiAtICAgICAgIGlmICghZW50cnkpCj4gLSAgICAgICAgICAgICAgIHJldHVybiBF
UlJfUFRSKC1FTk9NRU0pOwo+IC0KPiAtICAgICAgIGVudHJ5LT5kYXRhID0ga21hbGxvYyhjYWNo
ZS0+c2JpLT5ibG9ja3NpemUsIGZsYWdzKTsKPiAtICAgICAgIGlmICghZW50cnktPmRhdGEpIHsK
PiAtICAgICAgICAgICAgICAga2ZyZWUoZW50cnkpOwo+IC0gICAgICAgICAgICAgICByZXR1cm4g
RVJSX1BUUigtRU5PTUVNKTsKPiArICAgICAgICAgICAgICAgZW50cnkgPSBremFsbG9jX29iaigq
ZW50cnksIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgZW50cnktPmRhdGEgPSBrbWFsbG9jKHNi
aS0+YmxvY2tzaXplLCBmbGFncyk7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAg
ICBlbnRyeSA9IGYyZnNfa3phbGxvYyhzYmksIHNpemVvZigqZW50cnkpLCBmbGFncyk7Cj4gKyAg
ICAgICAgICAgICAgIGlmICghZW50cnkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7Cj4gKwo+ICsgICAgICAgICAgICAgICBlbnRyeS0+ZGF0YSA9IGYy
ZnNfa21hbGxvYyhzYmksIHNiaS0+YmxvY2tzaXplLCBmbGFncyk7Cj4gKyAgICAgICAgICAgICAg
IGlmICghZW50cnktPmRhdGEpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShlbnRy
eSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4g
KyAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+ICAgICAgICAgZW50cnktPmluZGV4ID0g
aW5kZXg7Cj4gLS0KPiAyLjQ5LjAKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
