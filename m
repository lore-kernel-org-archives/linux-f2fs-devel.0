Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4275DC88E77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbMO+h2bHAswB8tO5b5IplQEMdIQx0fEVZLeQp/74CM=; b=QBi0ErpMVGbQCndRxapGVuDJPo
	xZySn4ZBysOyz4wCicT6BeQh+b75VkOOocOYAm2CzG6G157bRphFTj90p47eR2tZR0PCVAw4yCMCx
	5p/3JsEYpzSzWSURLOKvRU3vZXkchKpDvQGt26cri0d06jQMhsXEPiOa8YfTE1ZjbR0s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6lIf-0000ZV-7Y;
	Wed, 16 Sep 2026 08:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x6lIZ-0000XL-RG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QR5oPNk/jNiLxqkh/Mwul2PMMrQIX1+RCusUg4zvBbg=; b=XNYwNgvkQXcmsAosK4w4XdrPDI
 Nn15K3u8roVCGsdSDSrg9G+WnI+zgtBUm579JPgQawTEtZpkxtBp2USC2nEagXxIRVUW8F5/TWU6J
 URy/Tte447l6ka/0eLd2nI5IavAy9lHduK410vo77hTxGxvBLpizMPr/soNy+YyqgW9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QR5oPNk/jNiLxqkh/Mwul2PMMrQIX1+RCusUg4zvBbg=; b=UT5lCd3msykYVI1FNH2p5U/Opm
 bn5WT/IliRPYflEMw9exc6h/WQGFWTtU6aTlnpRH9woeS3/GZQvXWtXs8Taki+lZCmUdyIbinGpkU
 7BYctbd3Na094CtrXbCwZoD2L/nobVrSLaYTGnwzSGMGqISX6vaJBM0/AwIkO/Riyn5g=;
Received: from mail-lf2-f13.google.com ([74.125.229.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6lIP-0001Rt-9g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 08:47:21 +0000
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b79786cdafso96646e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789548426; cv=none;
 d=google.com; s=arc-20260327;
 b=ebORtNiMdeIjI1eJ94OnLhD4PZABmx/uOGka3Xqbbmp+DdVMmWhHr2Bl9jalzFFbFj
 3plQG+QMMt4AQlxOOHoG0ubVWWBD3DjVTajzDUoo8xhHX/vsiD5f6xe699ZY7zeQ6MWZ
 lcZdGI0AFyjHKtEQ7rXZfsu/PLPGjvSUi7rnDJrkKNYb44Gv08lD1iZa1Pejk+/SpzvL
 Vf/IGbCfVhSfWP7Z44MphZy7elInFuH9JcwAFUrYZUTVNRi70zrV91Xj0p5ExeY6veqd
 PtZDljJM2zEkWQEJCR2/kENjoNiSQxeH6t9U+212eHnxO5wWQaYH2klJMQ0hHGQxXuQG
 g2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QR5oPNk/jNiLxqkh/Mwul2PMMrQIX1+RCusUg4zvBbg=;
 fh=8KYaQ56PdQT+83hlJcADc0iznzFM7YkKrup8jA9SEtY=;
 b=Hf4NNaSDQXdKyPtgM/RVVunaC22DTK9hbcFc94j9pO4hLcww13Z0DvU16195dnj0dN
 L+1ANIq964TqMvGaPeQ0V3RHqYSD4r4bH6pLV7RBjT7p0nc+aTUjiw6awwq7wNoNOSv+
 ltWTdT5pQ+2/1bU0IUASXcj3+mifQVHf4fAxdef7Hhz8EipMk3giiLhGukNeCUZjWcul
 TCMVhPSmz05XmyjJEvO4dpBPhaMNTngcFsAbQYFkS8WuvdcjOiu4IC0b8vEJdO991cDV
 Ihc+pFzh2ZxsC76JwVYeGOJIZRIFO8uyAosh3Yq/6+XEgYykauRUQc0C5yUtUPc2kexl
 WGbg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789548426; x=1790153226; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QR5oPNk/jNiLxqkh/Mwul2PMMrQIX1+RCusUg4zvBbg=;
 b=YavuvLhEmxEdLivtYrSjPjQTYfMQea1mmKwDiWnVPNW17MPBDobTKhuqiK6RbfD8rt
 iwO2CN7c2JwU3nTeAuOuPSAzBJdtcic4Hf9FroITDuMigNA5b3+7NaeF/gDP2qaRc37+
 1tSV7S+rZA0kwae0cRWq6CZgJ26DH30x2dJXJEQFlmfby9SAR4lR6rRNCQnP+HGnfNqx
 SIzN0YcdQcfb70Vkd1FlhAaog9XiCx1ksjb+nLaXDWmksc2taAOZasAb4dhJQ5akCHHV
 DWCfYXewBUNUPzS57IwwcZGtmFSPoDLAmWUdD0liNwUnLnSlDIMc75jOfsuh6g72xqTI
 7+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548426; x=1790153226;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QR5oPNk/jNiLxqkh/Mwul2PMMrQIX1+RCusUg4zvBbg=;
 b=ZNNrUwFB2ucQcoGMfFRKSNMo3u4cAWbthhITEBQoSHZf3oCtDyLrzDLtnuLYxUyE92
 HaKgRHAHCbZZTc2dRhkRzcLEyAZEE4qQ0kqfJQnfNiQQ6NaoiaX82mpSEheCoXFLkKmn
 glbnQfpfSj2uuzm1VPO/Qu9S+J/6T3+j2lMu1XtqkmvCdnIuvg8LyZ8DmY/fxO8GYCzJ
 NfG+yNO3HEL5zqgb6uCnI8wktDE/GRrjc0uOnk3suny2VvjnaHZQo1ytam4R9hK8AIuV
 PFgAsv243ywtEeTCeuNHmjfJQ40xiVkyyhHl58viPaE0kAu0lRt1rC57fNvC+eRXmi5v
 I95Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRhMXgD88mBzmtnE4w5sZ6Bc0hO2RnVTKqZ7pxD6Ajh57+MNE+wrGS6ceP+Wp1QM4QRBQIJuelcs+MSWK3y4hG@lists.sourceforge.net
X-Gm-Message-State: AFuF++kv+PLJ0TES7Zi0rbN2/uENct1Mt+WF86cjWSqaj47HsvllY8ic
 muKndJa5LOibRJ2rdK4s4zVhglwQKsnoljMHwhyd9m5oYUiNgdjpyiPnR9KI70+duWMUF85qIUb
 teH0vFimSpw482GSRSpLOqxW6OFqf83o=
X-Gm-Gg: AYBFou08RrOeQDpuiZW0GESP44IEDIdQdro429EM06e8tYmLaSFTgnY0vGQuBF09fin
 7MFI07E2s8lIjPA6e9gTnRb+YeDdM6MpXgg7BNamrpwRBxmdhn0rNDuScPQTSuB2EzVXOWpDJ91
 uxvQleJ/E7mbs0CLu7Feqbv+GQ4973NTLVnKOKBFkUyOf7GroD2jRhS910qlRxs5CB5Ls/nDET5
 6cGlplyoPLU5PrCNz8YHaCNoUik3y0jkyDdAy4dWgmWdcox/qQd0/hDZljeMoUPNiMd4ERfDLM9
 pnOXdpbSMSjclylfGwybt1x/ah492akaTI7MTOTlk3malhoQOaJsihMk
X-Received: by 2002:a05:6512:2246:b0:5b7:5281:b8a1 with SMTP id
 2adb3069b0e04-5b8b666ee86mr414510e87.5.1789548426043; Wed, 16 Sep 2026
 01:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260916015440.2232938-1-chao@kernel.org>
 <20260916015440.2232938-7-chao@kernel.org>
In-Reply-To: <20260916015440.2232938-7-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 16 Sep 2026 16:46:28 +0800
X-Gm-Features: AcwNN1VJfhZN3FSG6Q7vrlO-QyNk2XRyZ-lLT3oNdOzm6O_7iRkWt_zUZXaIQeQ
Message-ID: <CAHJ8P3LYuT747ZVd2-ihOuPQwryxUhSTOgHm7Ygq6u3n3twh_w@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x6lIP-0001Rt-9g
Subject: Re: [f2fs-dev] [PATCH v8 06/12] f2fs: cache: initialize node cache
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
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBub2RlX2Jsb2NrcyBpbiBmMmZzX3NiX2luZm8gc3RydWN0dXJlLCBpbml0aWFsaXplcwo+IGFu
ZCBkZXN0cm95cyB0aGUgbm9kZSBjYWNoZSBkdXJpbmcgZmlsZXN5c3RlbSBtb3VudCBhbmQgdW5t
b3VudC4KPgo+IEl0IGFsc28gaW50cm9kdWNlcyBoZWxwZXIgd3JhcHBlcnMgZm9yIG5vZGUgY2Fj
aGUgb3BlcmF0aW9uLCBhbmQgcmVnaXN0ZXJzCj4gbm9kZSBjYWNoZSBpbnRvIHRoZSBtZW1vcnkg
c2hyaW5rZXIgYW5kIHdyaXRlYmFjayBrdGhyZWFkLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZ
dSA8Y2hhb0BrZXJuZWwub3JnPgpSZXZpZXdlZC1ieTogWmhpZ3VvIE5pdSA8emhpZ3VvLm5pdUB1
bmlzb2MuY29tPgp0aGFua3MhCj4gLS0tCj4gIGZzL2YyZnMvY2FjaGUuYyB8ICA5ICsrKysrKysr
LQo+ICBmcy9mMmZzL2NhY2hlLmggfCAxMSArKysrKysrKysrKwo+ICBmcy9mMmZzL2YyZnMuaCAg
fCAgMSArCj4gIGZzL2YyZnMvc3VwZXIuYyB8ICA3ICsrKysrLS0KPiAgNCBmaWxlcyBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2ZzL2Yy
ZnMvY2FjaGUuYyBiL2ZzL2YyZnMvY2FjaGUuYwo+IGluZGV4IDRkODI2OTcwNjBkMC4uOGFiNWUw
ZTQ2YjRlIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvY2FjaGUuYwo+ICsrKyBiL2ZzL2YyZnMvY2Fj
aGUuYwo+IEBAIC02MjQsNyArNjI0LDE0IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGYyZnNfZG9f
c2hyaW5rX2NhY2hlKHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9ja19saXN0ICpjYWNoZSwKPiAgdW5z
aWduZWQgbG9uZyBmMmZzX3Nocmlua19jYWNoZShzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbnJf
dG9fc2NhbikKPiAgewo+IC0gICAgICAgcmV0dXJuIGYyZnNfZG9fc2hyaW5rX2NhY2hlKE1FVEFf
Q0FDSEUoc2JpKSwgbnJfdG9fc2Nhbik7Cj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGZyZWVkOwo+
ICsKPiArICAgICAgIGZyZWVkID0gZjJmc19kb19zaHJpbmtfY2FjaGUoTUVUQV9DQUNIRShzYmkp
LCBucl90b19zY2FuKTsKPiArICAgICAgIGlmIChmcmVlZCA+PSBucl90b19zY2FuKQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZnJlZWQ7Cj4gKwo+ICsgICAgICAgZnJlZWQgKz0gZjJmc19kb19z
aHJpbmtfY2FjaGUoTk9ERV9DQUNIRShzYmkpLCBucl90b19zY2FuIC0gZnJlZWQpOwo+ICsgICAg
ICAgcmV0dXJuIGZyZWVkOwo+ICB9Cj4KPiAgc3RhdGljIGludCBmMmZzX2NhY2hlX3dyaXRlYmFj
a19rdGhyZWFkKHZvaWQgKmRhdGEpCj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvY2FjaGUuaCBiL2Zz
L2YyZnMvY2FjaGUuaAo+IGluZGV4IDFlODRlNjZlY2E3OS4uMWVhYmQ3ODdiNGI3IDEwMDY0NAo+
IC0tLSBhL2ZzL2YyZnMvY2FjaGUuaAo+ICsrKyBiL2ZzL2YyZnMvY2FjaGUuaAo+IEBAIC0xOTQs
NiArMTk0LDcgQEAgdm9pZCBmMmZzX2Ryb3BfY2FjaGVfcmFuZ2Uoc3RydWN0IGYyZnNfY2FjaGVk
X2Jsb2NrX2xpc3QgKmNhY2hlLAo+ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0
LCB1bnNpZ25lZCBsb25nIGxlbiwgYm9vbCBkcm9wX2RpcnR5KTsKPgo+ICAjZGVmaW5lIE1FVEFf
Q0FDSEUoc2JpKSAgICAgICAgICAgICAgICAoJihzYmkpLT5tZXRhX2Jsb2NrcykKPiArI2RlZmlu
ZSBOT0RFX0NBQ0hFKHNiaSkgICAgICAgICAgICAgICAgKCYoc2JpKS0+bm9kZV9ibG9ja3MpCj4K
PiAgI2RlZmluZSBmMmZzX2ZpbmRfbWV0YV9jYWNoZShzYmksIGJsa2FkZHIpICAgICAgICAgICAg
IFwKPiAgICAgICAgIGYyZnNfZmluZF9jYWNoZShNRVRBX0NBQ0hFKHNiaSksIGJsa2FkZHIsIDAp
Cj4gQEAgLTIwMiw2ICsyMDMsMTYgQEAgdm9pZCBmMmZzX2Ryb3BfY2FjaGVfcmFuZ2Uoc3RydWN0
IGYyZnNfY2FjaGVkX2Jsb2NrX2xpc3QgKmNhY2hlLAo+ICAjZGVmaW5lIGYyZnNfdHJ1bmNhdGVf
bWV0YV9jYWNoZXMoc2JpLCBzdGFydCwgbGVuKSAgICAgXAo+ICAgICAgICAgZjJmc19kcm9wX2Nh
Y2hlX3JhbmdlKE1FVEFfQ0FDSEUoc2JpKSwgc3RhcnQsIGxlbiwgdHJ1ZSkKPgo+ICsjZGVmaW5l
IGYyZnNfZ3JhYl9ub2RlX2NhY2hlKHNiaSwgYmxrYWRkcikgICAgICAgICAgICAgXAo+ICsgICAg
ICAgZjJmc19ncmFiX2NhY2hlKE5PREVfQ0FDSEUoc2JpKSwgYmxrYWRkciwgICAgICAgXAo+ICsg
ICAgICAgRjJGU19DQUNIRV9MT0NLX0NSRUFURSkKPiArI2RlZmluZSBmMmZzX2ZpbmRfbm9kZV9j
YWNoZShzYmksIGJsa2FkZHIpICAgICAgICAgICAgIFwKPiArICAgICAgIGYyZnNfZmluZF9jYWNo
ZShOT0RFX0NBQ0hFKHNiaSksIGJsa2FkZHIpCj4gKyNkZWZpbmUgZjJmc19pbnZhbGlkYXRlX25v
ZGVfY2FjaGUoc2JpLCBibGthZGRyKSAgICAgICBcCj4gKyAgICAgICBmMmZzX2Ryb3BfY2FjaGVf
cmFuZ2UoTk9ERV9DQUNIRShzYmkpLCBibGthZGRyLCAxLCBmYWxzZSkKPiArI2RlZmluZSBmMmZz
X3RydW5jYXRlX25vZGVfY2FjaGVzKHNiaSwgc3RhcnQsIGxlbikgICAgIFwKPiArICAgICAgIGYy
ZnNfZHJvcF9jYWNoZV9yYW5nZShOT0RFX0NBQ0hFKHNiaSksIHN0YXJ0LCBsZW4sIHRydWUpCj4g
Kwo+ICB1bnNpZ25lZCBsb25nIGYyZnNfc2hyaW5rX2NhY2hlKHN0cnVjdCBmMmZzX3NiX2luZm8g
KnNiaSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbnJf
dG9fc2Nhbik7Cj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9mcy9mMmZzL2YyZnMu
aAo+IGluZGV4IGUyYjI5MDY3ZWIwYS4uNTFjMTkxYzUxNGJjIDEwMDY0NAo+IC0tLSBhL2ZzL2Yy
ZnMvZjJmcy5oCj4gKysrIGIvZnMvZjJmcy9mMmZzLmgKPiBAQCAtMjEwOCw2ICsyMTA4LDcgQEAg
c3RydWN0IGYyZnNfc2JfaW5mbyB7Cj4KPiAgICAgICAgIC8qIGYyZnMgaW50ZXJuYWwgY2FjaGUg
Ki8KPiAgICAgICAgIHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9ja19saXN0IG1ldGFfYmxvY2tzOwo+
ICsgICAgICAgc3RydWN0IGYyZnNfY2FjaGVkX2Jsb2NrX2xpc3Qgbm9kZV9ibG9ja3M7Cj4KPiAg
ICAgICAgIC8qIGludGVybmFsIGNhY2hlIGZsdXNoIHRocmVhZCAqLwo+ICAgICAgICAgc3RydWN0
IGYyZnNfY2FjaGVfa3RocmVhZCBjYWNoZV90aHJlYWQ7Cj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMv
c3VwZXIuYyBiL2ZzL2YyZnMvc3VwZXIuYwo+IGluZGV4IDFlNmI5Mzc0ZGY5Ny4uZmExOTE1MmNk
NGRhIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvc3VwZXIuYwo+ICsrKyBiL2ZzL2YyZnMvc3VwZXIu
Ywo+IEBAIC0yMDkyLDYgKzIwOTIsNyBAQCBzdGF0aWMgdm9pZCBmMmZzX3B1dF9zdXBlcihzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiKQo+ICAgICAgICAgc2JpLT5ub2RlX2lub2RlID0gTlVMTDsKPgo+
ICAgICAgICAgZjJmc19kZXN0cm95X2NhY2hlKE1FVEFfQ0FDSEUoc2JpKSk7Cj4gKyAgICAgICBm
MmZzX2Rlc3Ryb3lfY2FjaGUoTk9ERV9DQUNIRShzYmkpKTsKPgo+ICAgICAgICAgLyogU2hvdWxk
IGNoZWNrIHRoZSBwYWdlIGNvdW50cyBhZnRlciBkcm9wcGluZyBhbGwgbm9kZS9tZXRhIHBhZ2Vz
ICovCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgTlJfQ09VTlRfVFlQRTsgaSsrKSB7Cj4gQEAg
LTUyODIsMTEgKzUyODMsMTIgQEAgc3RhdGljIGludCBmMmZzX2ZpbGxfc3VwZXIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQo+ICAgICAgICAgICAgICAgICBn
b3RvIGZyZWVfcGVyY3B1Owo+Cj4gICAgICAgICBmMmZzX2luaXRfY2FjaGUoc2JpLCBNRVRBX0NB
Q0hFKHNiaSksIEYyRlNfTUVUQV9DQUNIRSk7Cj4gKyAgICAgICBmMmZzX2luaXRfY2FjaGUoc2Jp
LCBOT0RFX0NBQ0hFKHNiaSksIEYyRlNfTk9ERV9DQUNIRSk7Cj4KPiAgICAgICAgIGVyciA9IGYy
ZnNfZ2V0X3ZhbGlkX2NoZWNrcG9pbnQoc2JpKTsKPiAgICAgICAgIGlmIChlcnIpIHsKPiAgICAg
ICAgICAgICAgICAgZjJmc19lcnIoc2JpLCAiRmFpbGVkIHRvIGdldCB2YWxpZCBGMkZTIGNoZWNr
cG9pbnQiKTsKPiAtICAgICAgICAgICAgICAgZ290byBmcmVlX21ldGFfY2FjaGU7Cj4gKyAgICAg
ICAgICAgICAgIGdvdG8gZnJlZV9ub2RlX2NhY2hlOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICBp
ZiAoX19pc19zZXRfY2twdF9mbGFncyhGMkZTX0NLUFQoc2JpKSwgQ1BfUVVPVEFfTkVFRF9GU0NL
X0ZMQUcpKQo+IEBAIC01NjEyLDcgKzU2MTQsOCBAQCBzdGF0aWMgaW50IGYyZnNfZmlsbF9zdXBl
cihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpCj4gIGZyZWVf
ZGV2aWNlczoKPiAgICAgICAgIGRlc3Ryb3lfZGV2aWNlX2xpc3Qoc2JpKTsKPiAgICAgICAgIGt2
ZnJlZShzYmktPmNrcHQpOwo+IC1mcmVlX21ldGFfY2FjaGU6Cj4gK2ZyZWVfbm9kZV9jYWNoZToK
PiArICAgICAgIGYyZnNfZGVzdHJveV9jYWNoZShOT0RFX0NBQ0hFKHNiaSkpOwo+ICAgICAgICAg
ZjJmc19kZXN0cm95X2NhY2hlKE1FVEFfQ0FDSEUoc2JpKSk7Cj4gICAgICAgICBmMmZzX2Rlc3Ry
b3lfcGFnZV9hcnJheV9jYWNoZShzYmkpOwo+ICBmcmVlX3BlcmNwdToKPiAtLQo+IDIuNDkuMAo+
Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
TGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
