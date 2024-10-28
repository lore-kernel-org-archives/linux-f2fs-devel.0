Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED9D339AE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:05:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5U7I-00079m-97;
	Mon, 28 Oct 2024 18:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1t5U7G-00079e-HC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 18:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=; b=PH4Z4GGJFuNsbO48OYfZaRz1m5
 6ZQHfDZhpkTLK8BFd0aoQbw+d2XAFR3ETvDi6uQfbBvAPfV2yVJSYqF98A2I0LAbDfRIo1c8+5Ip0
 i0mMOLqPXGOF4JaWw9cIvMy0gNDBis6AxJz/GFzysyPDszNTbSMJsoxl/qUDZ9/afe2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=; b=Y5JV4LF93tG5vkbGaFaazgaE4W
 lOhSYhMWYfRcGgDKLJJUsaAEvcL3o1Ly9k+tA9q4bHRxBhw1gGH5XqL5mkhiwWapvCJNcwtQnKxUe
 EpvXwk2dlwdfawyVHbCjnES5jknep3V1PqTg1TaVUnoSrdoVs48Fs+DAzd1sgvg+66DU=;
Received: from mail-oi1-f177.google.com ([209.85.167.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t5U7F-0007EN-Ss for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 18:05:22 +0000
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-3e60fca5350so2907898b6e.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Oct 2024 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730138711; x=1730743511; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=;
 b=eIACV2JwOUDlKFiYmq00oAel7SXJWtgb/PttqA6rcs3B4Wak+1C1gVGv5YvFHQzt2K
 lQxArXnL0eT7qUkOxvvlWdshX7vmFPtYkjYQOm6Qa4ivXwpq6Xey8PV4LvVhfI5wq08T
 UwCnp3uLQqJxHKMVSVH2b3IhHI4h57rvid0HunqA4PFmTgFnYOtwlSYkI4A05z91D+V7
 5f6ibH6DmgVWyEmp3/7ZA4fcRWwlsaG1a81QyL2P62B7ou0TUqG9oY3VYw7kqHoh0XDQ
 qdRWvWNkp7pIpGt66UcZ3GNu1N9wDfIsS5tu2qUpeAWTX9xtciHdXLImE5MDCrPrl9pd
 hqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730138711; x=1730743511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wswnbw8lU1S7U5OtdXiVOyVdMtF0YmqSGDwUZ9wzt4g=;
 b=EDpOuYE9tPWLmNOjMijoyFVY5jORGGmNzWLo70oRp9eiWgxXNMdRrKH46/R00IT0kd
 7IgbXl1Ic+MusqwgtEQ4sB06w2SqkcAfZ6+r/wOexHLU3M3XKN9l3kLYkFhELXNtF7LU
 ThSUKXn0NEftNXsg83iq377Xf/CWT4pVHm6dTuzuRS5sVpOAjIzebA9VZttVBxMsDe+O
 W9V2oMK4D2JXKqzjA471DC1U5gvEGRmUURMKdagOxw/AIqio734TdywJ2it5vUaZwT99
 hdn9v4Eqz70eKQr6soO6IKZ+WOjxvzmSYaNMd1iMbz1PFRoQCuKJhvRIfAWeiSGqwh9d
 YOCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIn9Vhqba6QDySjOT54nypGyRNsy9IS7t526KR8QePsts3FFaFm971cOfw9euWyxhj2c6z1gXM3XFsh2mCs3o8@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw0Ha9J5xR4L1h89iVJitOKuaIvF3958ENRXwuck4/h6cpIVMIn
 CzIJbyoDmiuwTrEJ/yy1AcXA9UK4LeHR8iNoPM4PCCmOC4mJg+3Z26cLjUNqLrITjVEJyJ/LK9t
 cN3fPo0evU8SOV+bRnAQGLh7MhoQ=
X-Google-Smtp-Source: AGHT+IHPNrC5vf1ML24eVNYAP5ct4DSvt3rL9mZBLn7KPA1QPcJgfE52/9sBY+Ej74RzxNvGmdlg39oVrmDWNBOCNVU=
X-Received: by 2002:a05:6808:2e8f:b0:3e6:3eff:30bb with SMTP id
 5614622812f47-3e63eff31ffmr6708579b6e.9.1730138711120; Mon, 28 Oct 2024
 11:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240910135636.471-1-yohan.joung@sk.com>
In-Reply-To: <20240910135636.471-1-yohan.joung@sk.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 28 Oct 2024 11:05:00 -0700
Message-ID: <CACOAw_xp94tOAeh=yG93Oh+-y95vh+JzHGpqWmJhYUt4obCvUg@mail.gmail.com>
To: Yohan Joung <jyh429@gmail.com>
X-Headers-End: 1t5U7F-0007EN-Ss
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: adjust zone alignment when using
 convention partition with zoned one
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

T24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgNjo1OOKAr0FNIFlvaGFuIEpvdW5nIDxqeWg0MjlAZ21h
aWwuY29tPiB3cm90ZToKPgo+IFdoZW4gZm9ybWF0dGluZyBjb252ZW50aW9uYWwgcGFydGl0aW9u
IHdpdGggem9uZWQgb25lLCB3ZSBhcmUgYWxyZWFkeQo+IGFsaWduaW5nIHRoZSBzdGFydGluZyBi
bG9jayBhZGRyZXNzIG9mIHRoZSBuZXh0IGRldmljZSB0byB0aGUgem9uZSBzaXplLgo+IFRoZXJl
Zm9yZSwgd2UgZG8gbm90IGFsaWduIHRoZSBzZWdtZW50MCBhZGRyZXNzIHRvIHRoZSB6b25lIGFs
aWdubWVudC4KPiBUaGlzIHJlZHVjZXMgdGhlIHdhc3RlZCB6b25lX2FsaWduX3N0YXJ0X29mZnNl
dC4KPgo+IFNpZ25lZC1vZmYtYnk6IFlvaGFuIEpvdW5nIDx5b2hhbi5qb3VuZ0Bzay5jb20+Cj4g
LS0tCj4gIG1rZnMvZjJmc19mb3JtYXQuYyB8IDE4ICsrKysrKysrKysrKystLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9ta2ZzL2YyZnNfZm9ybWF0LmMgYi9ta2ZzL2YyZnNfZm9ybWF0LmMKPiBpbmRleCAzN2Qy
M2YzLi43MWY1ZWM4IDEwMDY0NAo+IC0tLSBhL21rZnMvZjJmc19mb3JtYXQuYwo+ICsrKyBiL21r
ZnMvZjJmc19mb3JtYXQuYwo+IEBAIC0yNTIsMTEgKzI1MiwxOSBAQCBzdGF0aWMgaW50IGYyZnNf
cHJlcGFyZV9zdXBlcl9ibG9jayh2b2lkKQo+Cj4gICAgICAgICBzZXRfc2IoYmxvY2tfY291bnQs
IGMudG90YWxfc2VjdG9ycyA+PiBsb2dfc2VjdG9yc19wZXJfYmxvY2spOwo+Cj4gLSAgICAgICB6
b25lX2FsaWduX3N0YXJ0X29mZnNldCA9Cj4gLSAgICAgICAgICAgICAgICgodWludDY0X3QpIGMu
c3RhcnRfc2VjdG9yICogREVGQVVMVF9TRUNUT1JfU0laRSArCj4gLSAgICAgICAgICAgICAgIDIg
KiBGMkZTX0JMS1NJWkUgKyB6b25lX3NpemVfYnl0ZXMgLSAxKSAvCj4gLSAgICAgICAgICAgICAg
IHpvbmVfc2l6ZV9ieXRlcyAqIHpvbmVfc2l6ZV9ieXRlcyAtCj4gLSAgICAgICAgICAgICAgICh1
aW50NjRfdCkgYy5zdGFydF9zZWN0b3IgKiBERUZBVUxUX1NFQ1RPUl9TSVpFOwo+ICsgICAgICAg
aWYgKGMuem9uZWRfbW9kZSAmJiBjLm5kZXZzID4gMSkgewo+ICsgICAgICAgICAgICAgICB6b25l
X2FsaWduX3N0YXJ0X29mZnNldCA9Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgKCh1aW50NjRf
dCkgYy5zdGFydF9zZWN0b3IgKiBERUZBVUxUX1NFQ1RPUl9TSVpFICsKPiArICAgICAgICAgICAg
ICAgICAgICAgICAyICogRjJGU19CTEtTSVpFICsgc2VnbWVudF9zaXplX2J5dGVzIC0gMSkgLwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHNlZ21lbnRfc2l6ZV9ieXRlcyAqIHNlZ21lbnRfc2l6
ZV9ieXRlcyAtCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQ2NF90KSBjLnN0YXJ0X3Nl
Y3RvciAqIERFRkFVTFRfU0VDVE9SX1NJWkU7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsgICAgICAg
ICAgICAgICB6b25lX2FsaWduX3N0YXJ0X29mZnNldCA9Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgKCh1aW50NjRfdCkgYy5zdGFydF9zZWN0b3IgKiBERUZBVUxUX1NFQ1RPUl9TSVpFICsKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAyICogRjJGU19CTEtTSVpFICsgem9uZV9zaXplX2J5dGVz
IC0gMSkgLwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHpvbmVfc2l6ZV9ieXRlcyAqIHpvbmVf
c2l6ZV9ieXRlcyAtCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQ2NF90KSBjLnN0YXJ0
X3NlY3RvciAqIERFRkFVTFRfU0VDVE9SX1NJWkU7Cj4gKyAgICAgICB9CgpIb3cgYWJvdXQgdXNp
bmcgYSB2YXJpYWJsZSBsaWtlICJhbGlnbm1lbnRfYnl0ZXMiIHRvIGFjY29tbW9kYXRlIGJvdGgK
InNlZ21lbnRfc2l6ZV9ieXRlcyIgYW5kICJ6b25lX3NpemVfYnl0ZXMiPwoKICAgICAgICAgICAg
ICAgem9uZV9hbGlnbl9zdGFydF9vZmZzZXQgPQogICAgICAgICAgICAgICAgICAgICAgICgodWlu
dDY0X3QpIGMuc3RhcnRfc2VjdG9yICogREVGQVVMVF9TRUNUT1JfU0laRSArCiAgICAgICAgICAg
ICAgICAgICAgICAgMiAqIEYyRlNfQkxLU0laRSArIGFsaWdubWVudF9ieXRlcyAtIDEpIC8KICAg
ICAgICAgICAgICAgICAgICAgICBhbGlnbm1lbnRfYnl0ZXMgKiBhbGlnbm1lbnRfYnl0ZXMgLQog
ICAgICAgICAgICAgICAgICAgICAgICh1aW50NjRfdCkgYy5zdGFydF9zZWN0b3IgKiBERUZBVUxU
X1NFQ1RPUl9TSVpFOwoKVGhhbmtzLAoKPgo+ICAgICAgICAgaWYgKGMuZmVhdHVyZSAmIEYyRlNf
RkVBVFVSRV9STykKPiAgICAgICAgICAgICAgICAgem9uZV9hbGlnbl9zdGFydF9vZmZzZXQgPSA4
MTkyOwo+IC0tCj4gMi4yNS4xCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
