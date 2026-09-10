Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09139C79FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9QAw8G78wdazUL0eicXC1FipzIx1FX9ZnJiQ2tb93CY=; b=INVtpUcGFZDBxi2Xur+K7DIueM
	fMi5FNR4PJqeTnrFruSiM3DE2tnikbeFbvCK6ulKQ02OOENb50A46jGtkl4987nASWpOFun7uFjdZ
	UobVRzcSDFojk1nBPKgHEf44w/ewf7bmM6elv2zbUcaeZyLwrRuGhk0RUwT1hkD/6YG0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4Z7X-00052e-0M;
	Thu, 10 Sep 2026 07:22:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x4Z7G-00052P-70
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l5Wu7YrtYFqk2A1LMgO87zFbbXnbSNxs3gHTR4Q+xNo=; b=AYlFvW/WS6guw/VwucSzaCMD5B
 MQzgIE4TWxix46WsPAoAUIkNg2rcBZHxxAZobRUB4TDOj1nT2tuoKLn1L4C+qcH5Kd5B0hwcSbvom
 rX2qtXRy1wA98xR9cQDj1wLMlwTZHHQT/WE3w/io4YAxDu8+ZCYPqmPdnyuZ9iypi9HQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l5Wu7YrtYFqk2A1LMgO87zFbbXnbSNxs3gHTR4Q+xNo=; b=WMloItXFY/HE4bj33VeTB0qq8O
 aUBnaVR6fh6zNhuMXzTpjfmjfHaI7N8a4RpgndZqaz99LM/s0WrtBEYLint5AzMYnRmhQqtaIfVjU
 PDx4xMd7WMfJmNhvdmOdIxjAg3tildv/JaVgHUKqaix9NUYmbEVMWcgJRRT211bjlSg4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Z7C-0005fe-LC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 07:22:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499db1740f2so2792745e9.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 00:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789024948; cv=none;
 d=google.com; s=arc-20260327;
 b=b3+UrsJrC4v+152+WuWB5Ow2lC1EeHCs/j19WoZ5maZ2Agk4uBLLUi2I7Z4Ilfa6VN
 fXGOMsVoBulFs4EKW0TRRpswhoIKbKj86W5Xd04DIpzrX0APzRfinGumOlFYIo+u2rfY
 gsMpBbwRhTo9QPJiklsJ5asW6G7TIUgFayDhP6mDXH94SmvR7wPYYQwXRBWqZQNWQmc5
 9YNcRsVwAuGmrGWQn2t4dRziJT+PYUlHvdWOOUtPqXOEvnCCg9OjFBCgY02W2JyKQqlY
 Li3ODuZ8QaBttAGmyA1+kt+tNGybeao5LqhwyXUBFmlNlLzpFzJVs9ZqO7JOL7ejzKQj
 FYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l5Wu7YrtYFqk2A1LMgO87zFbbXnbSNxs3gHTR4Q+xNo=;
 fh=ZmoWWhxvL51DOnhfLpAelmtnE5s7LUOF8I9v+W+Fz4c=;
 b=bdllEtYEFxgYuQRnzoULQwg+ZIJZxBgwi08hSeRfN8kcbL4mAyhOnl3ZwOlob1alSv
 Kx7/KRBNzu8yNq20Clq2Is9F4WWuljBa0lxvupQOWg3OQ92rP7rP9YomfdfhSErz6chy
 zZoll1iYcm1xdJxOTyvTAvSfta8KIrF6kYW/dmWd+DomfFSiDCsBWwox+FQnIF74Uo/e
 L1I8NVIsAozZqYs8mAiLwk4WA+3XWSB6ammi3K6EV7kjUsmXz7HUzcYKT4vwEebU4sFT
 npzZkh8RqTMEmgFd3AGCKLsWJ/5B6j3IFiePo1mEb0P1jQoSnw9XYhN6nhbT74DdHzdv
 z3PQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789024948; x=1789629748; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l5Wu7YrtYFqk2A1LMgO87zFbbXnbSNxs3gHTR4Q+xNo=;
 b=T4holiIbgMAAYyt9/vV5hd8jRZt0hU0J1n/x1/KyDUEjikdxNKHBd81MI88fB7jytn
 L/d1A3Lup63NNlD/3e4EYFsrPobCVOGGbqPq3g0+Rv2YrRajc2/zOvrm6Y47ReE9LjZR
 k5/wTlUg/H+gMmIMqoqkX9faqkJpjBAu679pA24et3Jb2G72Hu15w6Y8Z8pndX24WmLU
 uBirYrg1dyXUIbPUFVTe6h8wpXA1RTVTHRKzu7WOFFFZjoO//TW2gHQMkdU0iuJF0DwU
 9gPi7GLQF9FH6Y6zVAYDbrJLR8YuOXpAjDecu4DOeEyjUIQZeFvvgDhu8yratCvIN6q0
 SPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789024948; x=1789629748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l5Wu7YrtYFqk2A1LMgO87zFbbXnbSNxs3gHTR4Q+xNo=;
 b=fm6M0E90F8EclLTuLt+YGPaRY9D4I3TtZRaz8ZktWKOKQDzJH62bBBkAOlabCKSs1T
 BFhTcccVBg0YfnbHqBvtVQ3RQyI35Yb9ckz9sR2uQTBi+KCgxzMK8D8edNmdwwxgfWgj
 tbO77Y1pPmdm+JetSp7EsGbgTvl50adt6hIfxlMK2UwMUYDM1do/KneCLEVb5X8stP6Z
 hLWbec8Zez26vfLhCHf46tybcWo5QlYAPSnYYfW0GB/adM02szgq5+9nQa/dx5/Sksci
 BPvx95PLGS9AnbH2Qcp9QW/yL/4M9LMKivY4LgLsW7IVDV9aFSNMIrgD9KOQGSsKGJq4
 RTvg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXXeP5XMp24SECvphj20RzZqgEG0HfCecyBl/AjBE9UGjhujTDeYnpgCvBQsnV4gYULwNu1zzHxZmXDFZ9hbZ4@lists.sourceforge.net
X-Gm-Message-State: AFuF++mWJwR4jtIWztKjIODjaT4SOGBFBuSqxvIIYE7tPDenuUcgmKFT
 moNK2cXLgkWJsyBYfR4BFTutowEiPNehC2S/rntGx3JWqgCRTnQYOKhT97BsnbjRyU/OhdIFInF
 vCsZD01ijfpf0C0/Eg6mNITRbHXKxCBNxUj7a
X-Gm-Gg: AYBFou2/m0kK6H2mNoj+3XsAYPiwC76Rnk1/op/d7ov9RGAvNsyMNrX+NfhuX3VaG2j
 66JY2qoyWSwK/b3ql/cVORkBis0ly0ap/GTEdE03ZTrikY/fVngDx5obwEtfuj4FCvh6T4SWT2p
 2hzuG98zNB0WUFCaEPGPGhj4aUJVvB4uPdbSytVb8fROLzZq2C1GQg7TGuDkFZgFP+jY9OMtTU/
 W5tXViPTV7az6VL81PiqY3z8L+qqBKzMH9N6k2L/FX9YLtP7nMzDT2vRcHpr7tObAU83K5KKgTu
 Da7XUNQmT11v67T05y2Yy6AnBs2eyFo4R1f3ecdTTBjho3qcRjiKLLPm
X-Received: by 2002:a05:600c:6289:b0:49d:1da4:511b with SMTP id
 5b1f17b1804b1-49d27670d04mr22165515e9.1.1789024947960; Thu, 10 Sep 2026
 00:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260910022258.3308187-1-chao@kernel.org>
In-Reply-To: <20260910022258.3308187-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 10 Sep 2026 15:22:14 +0800
X-Gm-Features: AcwNN1VIotxYcfepBaV4DRS_s_5RX8jAe5pbtNh52LTKDkYSGXp9aQO81YuJ_Jc
Message-ID: <CAHJ8P3Kah8NTiSMsXdb1PF9yA59UE+MZTg8MkcYcH4OrVQVjQw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x4Z7C-0005fe-LC
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to handle race between
 truncate and writeback
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ55pyIMTDml6Xlkajlm5sgMTA6MjTlhpnpgZPvvJoKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IGZzc3RyZXNzIHJlcG9ydHMgYSBr
ZXJuZWwgQlVHIGluIGYyZnNfdHJ1bmNhdGVfcGFydGlhbF9jbHVzdGVyKCk6Cj4KPiBrZXJuZWwg
QlVHIGF0IGZzL2YyZnMvY29tcHJlc3MuYzoxMjM4IQo+IFJJUDogMDAxMDpmMmZzX3RydW5jYXRl
X3BhcnRpYWxfY2x1c3RlcisweDI5Mi8weDJhMAo+IENhbGwgVHJhY2U6Cj4gIDxUQVNLPgo+ICBm
MmZzX3RydW5jYXRlKzB4ZjYvMHgyMTAKPiAgZjJmc19zZXRhdHRyKzB4NmI3LzB4NzcwCj4gIG5v
dGlmeV9jaGFuZ2UrMHgzM2IvMHg1MjAKPiAgZG9fdHJ1bmNhdGUrMHhjMi8weGYwCj4gIHZmc190
cnVuY2F0ZSsweDE1My8weDFkMAo+ICBrc3lzX3RydW5jYXRlKzB4NzgvMHhkMAo+ICBfX3g2NF9z
eXNfdHJ1bmNhdGUrMHgxNi8weDIwCj4gIGRvX3N5c2NhbGxfNjQrMHhiZS8weDU0MAo+Cj4gVGhl
IHJvb3QgY2F1c2UgaXMgdGhhdCBUaHJlYWQgQSAodHJ1bmNhdGUpIGFuZCBUaHJlYWQgQiAoYmFj
a2dyb3VuZAo+IHdyaXRlYmFjayBvciBmc3luYykgY2FuIHJhY2UgYXMgZm9sbG93czoKPgo+IFRo
cmVhZCBBICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaHJlYWQgQgo+IC0gZjJmc19zZXRh
dHRyCj4gIC0gZjJmc190cnVuY2F0ZQo+ICAgLSBmMmZzX3RydW5jYXRlX2Jsb2Nrcwo+ICAgIC0g
ZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIKPiAgICAgLSBmMmZzX2lzX2NvbXByZXNzZWRf
Y2x1c3Rlcgo+ICAgICAgIHJldHVybiAxCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC0gZjJmc193cml0ZV9jYWNoZV9wYWdlcwo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLSBmMmZzX3dyaXRlX211bHRpX3BhZ2VzCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLSBmMmZzX3dyaXRlX3Jhd19wYWdlcwo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGYyZnNfd3JpdGVfc2luZ2xlX2RhdGFf
cGFnZQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRuLmRhdGFf
YmxrYWRkciAhPSBDT01QUkVTU19BRERSCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKGNsdXN0ZXIgY29udmVydGVkIHRvIG5vcm1hbCkKPiAgICAgLSBmMmZzX3By
ZXBhcmVfY29tcHJlc3Nfb3ZlcndyaXRlCj4gICAgICAtIGYyZnNfaXNfY29tcHJlc3NlZF9jbHVz
dGVyCj4gICAgICAgIHJldHVybiAwCj4gICAgICAtIHJldHVybiAwCj4gICAgIC0gZjJmc19idWdf
b24oc2JpLCBlcnIgPT0gMCk6IEJVRyEKPgo+IFdyaXRlYmFjayBwYXRoIGRvZXMgbm90IGFjcXVp
cmUgaV9nY19yd3NlbSBvciBmaWxlbWFwX2ludmFsaWRhdGVfbG9jay4KPiBXaGVuIGEgY29tcHJl
c3NlZCBjbHVzdGVyIGZhaWxzIGNvbXByZXNzaW9uIGR1cmluZyB3cml0ZWJhY2ssIGl0IGlzCj4g
b3ZlcndyaXR0ZW4gd2l0aCByYXcgZGF0YSBibG9ja3MuIElmIFRocmVhZCBBIGNoZWNrZWQKPiBm
MmZzX2lzX2NvbXByZXNzZWRfY2x1c3RlcigpIGJlZm9yZSB0aGUgY29udmVyc2lvbiwgYnV0IGNh
bGxzCj4gZjJmc19wcmVwYXJlX2NvbXByZXNzX292ZXJ3cml0ZSgpIGFmdGVyIHRoZSBjb252ZXJz
aW9uLAo+IGYyZnNfcHJlcGFyZV9jb21wcmVzc19vdmVyd3JpdGUoKSByZXR1cm5zIDAgYmVjYXVz
ZSB0aGUgY2x1c3RlciBpcyBubwo+IGxvbmdlciBhIGNvbXByZXNzZWQgY2x1c3Rlci4KPgo+IFRv
IGZpeCB0aGlzLCByZW1vdmUgdGhlIGYyZnNfYnVnX29uKCkgYW5kIHJldHJ5IGNoZWNraW5nIHRo
ZSBjbHVzdGVyIHN0YXR1cwo+IHdoZW4gZjJmc19wcmVwYXJlX2NvbXByZXNzX292ZXJ3cml0ZSgp
IHJldHVybnMgMCwgc28gdGhhdCBpdCBjYW4gZmFsbCBiYWNrCj4gdG8gZjJmc19kb190cnVuY2F0
ZV9ibG9ja3MoKSB0byBoYW5kbGUgaXQgYXMgYSBub3JtYWwgY2x1c3Rlci4KPgo+IENjOiBzdGFi
bGVAa2VybmVsLm9yZwo+IEZpeGVzOiAzMjY1ZDNkYjFmMTYgKCJmMmZzOiBzdXBwb3J0IHBhcnRp
YWwgdHJ1bmNhdGlvbiBvbiBjb21wcmVzc2VkIGlub2RlIikKPiBTaWduZWQtb2ZmLWJ5OiBDaGFv
IFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIGZzL2YyZnMvY29tcHJlc3MuYyB8IDggKysr
Ky0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2NvbXByZXNzLmMgYi9mcy9mMmZzL2NvbXByZXNzLmMK
PiBpbmRleCBjZTg4MDkyZDljZTIuLmUxY2M3MTg1NDI4ZSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZz
L2NvbXByZXNzLmMKPiArKysgYi9mcy9mMmZzL2NvbXByZXNzLmMKPiBAQCAtMTIyMiw2ICsxMjIy
LDcgQEAgaW50IGYyZnNfdHJ1bmNhdGVfcGFydGlhbF9jbHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHU2NCBmcm9tLCBib29sIGxvY2spCj4gICAgICAgICBpbnQgaTsKPiAgICAgICAgIGludCBl
cnI7Cj4KPiArcmVwZWF0Ogo+ICAgICAgICAgZXJyID0gZjJmc19pc19jb21wcmVzc2VkX2NsdXN0
ZXIoaW5vZGUsIHN0YXJ0X2lkeCk7Cj4gICAgICAgICBpZiAoZXJyIDwgMCkKPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIGVycjsKPiBAQCAtMTIzMywxMSArMTIzNCwxMCBAQCBpbnQgZjJmc190cnVu
Y2F0ZV9wYXJ0aWFsX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdTY0IGZyb20sIGJvb2wg
bG9jaykKPiAgICAgICAgIC8qIHRydW5jYXRlIGNvbXByZXNzZWQgY2x1c3RlciAqLwo+ICAgICAg
ICAgZXJyID0gZjJmc19wcmVwYXJlX2NvbXByZXNzX292ZXJ3cml0ZShpbm9kZSwgJnBhZ2VwLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0X2lk
eCwgJmZzZGF0YSk7Cj4gKyAgICAgICBpZiAoZXJyID09IDApCj4gKyAgICAgICAgICAgICAgIGdv
dG8gcmVwZWF0OwpIaSBDaGFvLAogc29tZSBjb21tZW50cyBoZXJlIHdpbGwgYmUgZWFzaWVyIHRv
IHVuZGVyc3RhbmTvvJ8Kb3RoZXIgTEdUTQpSZXZpZXdlZC1ieTogWmhpZ3VvIE5pdSA8emhpZ3Vv
Lm5pdUB1bmlzb2MuY29tPgp0aGFua3MhCj4KPiAtICAgICAgIC8qIHNob3VsZCBub3QgYmUgYSBu
b3JtYWwgY2x1c3RlciAqLwo+IC0gICAgICAgZjJmc19idWdfb24oRjJGU19JX1NCKGlub2RlKSwg
ZXJyID09IDApOwo+IC0KPiAtICAgICAgIGlmIChlcnIgPD0gMCkKPiArICAgICAgIGlmIChlcnIg
PCAwKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Cj4gICAgICAgICBycGFnZXMgPSBm
c2RhdGE7Cj4gLS0KPiAyLjQ5LjAKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
