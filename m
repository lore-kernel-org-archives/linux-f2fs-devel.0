Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F9BC55838
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o56zZ+EN4TlP5/5q78oLTfws9Xji0zoThRRttNweKMg=; b=a9I2RXqIcixFs0m+CJ+2FyU7kH
	FdvEJrR+nk4/JkwaWPzZfELgkSZsfWNYqR2/glG/4OYDL5q2MymEc9y3hnfb/NPLLifSABHWmkfot
	ZA8jHDqR/kXete07ChSYl+t2RBag/IAUecCdmt7K8nIu+PM6uQqF87+IL9c5YCSr669Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqr2p-0003fx-Pn;
	Mon, 03 Aug 2026 11:41:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqr2o-0003fk-Bn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PCte4ILrokHlhwgHYiDq3frpp63OWKmVk6h0PM3T4CA=; b=Nqp18HxhGfTb0YnCL1//QoPwrO
 gOQstGmXq8CQnM7ME3fdF36PjqhmoeF2tsUJPAzWoESeqLDWdb7IO54rILbVXFjTWIS/6NvulRUex
 TQsEvE4C1VlQXdtxj+KjT4uVTPVvcLV/wEKFAmQmB1Sscl7gPTfonjICc3s/62/Rh/Ag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PCte4ILrokHlhwgHYiDq3frpp63OWKmVk6h0PM3T4CA=; b=N04cDee78nQ4pwHdsqe0RATRUS
 du9XcQwx68czCvNtFNcq4OwN8GaIgMPA6Jv4OvPe+rTZnqUcf2JDkAidIxmWNUFj544y3+EvWYv7O
 qd3Yg7vx0MEuZwMPZfEWY5LRijB/ISERjqqT+iQBeu1C8vvkr1UmmHeBU2EpI88gx2VA=;
Received: from mail-lf1-f41.google.com ([209.85.167.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqr2n-0008Mu-Ie for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:41:23 +0000
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b013aa02b2so4856439e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 04:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785757275; cv=none;
 d=google.com; s=arc-20260327;
 b=bj6nFllYSoqMggqGosgi4yvwNtlpGAvkU8oP6/gZAQyWQE7bJTuWrUyB0cCdcQ8dHI
 NcalBuKY0p4Lg/SP4kOKmaW+WcFDOZDZkwnLamAob5+bJmAMQC9LEIw/fVFoa8eHkOh5
 yI+S5lHlDlu1rXLsOAxq+5rWP0GEQ/YvtzFT51wRcf9yX37BN03DDEO86W+KjS0Yc39J
 MDRCPaM/8OwiOZLQ5DMge4kv6nSbll2iojk9FfK96zyWmgSeaAzcHkdrrfdEdvKVdFGf
 T0LWF7kSNjLfUCmUQI/EUmWeVNNjyC3yRzDjswGyEAZn55QtvcXZl1/LSWXx72KwvgV5
 7t4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PCte4ILrokHlhwgHYiDq3frpp63OWKmVk6h0PM3T4CA=;
 fh=miq6uGgVB6uKAxwdSSDNk5MWp1bNdhnMEsWGLw70dQ4=;
 b=Dto8/Cc1ZWRVNsJ3ECxZqmV2eZwk6Yp6MMLtGXUTH3HmtfSJPHmTSzW9SFu+R5Aaym
 AjeFc7j7CEk9dlxOMTbi5QjZbc0E6/rLkCWIFKH8tN3ZDpj78uqZ/LgLz673CzZSJ6Bj
 VddMyXWPa701dltxE+8o1ahsBl/wc2m9l4gCCZ4scPDXsBWxMC3NO8R26y/MMjflus4B
 UxxVz46aSo0hAyjx06LDwWN6WHV/CJqDgqGUcNycdot6uY4jig6YAaY006AEjEiRoyI6
 nkRVndq5frhDdvGfkEDaRjsPQbo6I/XzyeoFlSsm6oTQFeTADW5MQ9NdRgrfXYqIOOVJ
 e+jw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785757275; x=1786362075; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PCte4ILrokHlhwgHYiDq3frpp63OWKmVk6h0PM3T4CA=;
 b=m8PfmrTSIVMHL/MS12UTpo6ylcpaun+r1oeXoL5U6fqF1b5RSloxWz8fmEWeo80Ytr
 QmZzlVAmPwsqnJA+9uK83gurqjqynnpufAxGI5v4UPgQMU739e6xbMTf7zmmlF1S38h/
 8ePJazo1cVpyxqlHNVPwRrny/iYM3NKAFjS06FSevoEi8bP2m70aIo0IN7h5yKpKY6Lh
 pigS0qodhcx9JlIc8x6m9l9YSDKYw3Nv9IYTssF2V47fWmd4LNmWgEmaT/GOVPrlANOA
 4lQ5MjPL+RAiSbBJhK9pIT4gd3dQRc9848nrvFcyIEgd6UUYueLhZUgs9l3ewOhgCiGQ
 0oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785757275; x=1786362075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCte4ILrokHlhwgHYiDq3frpp63OWKmVk6h0PM3T4CA=;
 b=ADgusYvsNHgKaBsy/pwp45cqCxO+/xqCqmx0H+MczvnXGEsKgpTEiqTrH1o+St5l7a
 wY41qdjzsJAAPGaTCWhWKcFMPi6YeAgg9vDzTOyuClXCHISUhA/BDRcMD61+5fQD4ulO
 sjr3RGVDcraLh+FnYqEuSMeA9MqQ2JCTTqdyrwj8IQ2Ct8315/NSzDK6NQP3galDkDXC
 pudXM0U+5bdqRLnjtb5nEU0oVbIXbY0P8kJ/O8dZa4JqCtasQIXWuvMSnyh16FczCfbZ
 EvAXqROZzvWPRg0ljz5BkzYF1jBd8zoMDKnC2f+FMGQ8xfuVEnS0hXJUInfAlb00IFoP
 m6qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKgw/VgxRdO8IcEDK10hKEL8txcHfj5ZhUOfJ5BSxMh8mAmIAC5HnWZbW89b9OdxGAh9hg6NTC0Jyx8GDcYmdb@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz3UwKMaYPLr+4P8u0+Bsz4x4HcUoGNWZ0NNHXkPwPvTzloZuGi
 zNKupsyDyazOy531O9Eyh/+eTf7iiahtU+AboF0VjHCwF2eLDMCybzLoa5DN/e3wbx589miyHi2
 vaaeuMs1Fs7VKQDnJJKO+FYd7o7G76JI=
X-Gm-Gg: AR+sD12xtO2WslZzD67f+7qTrkKu5MGSG3OwwnIJFnSYplMKGRYa3I6qDuHcYkompeB
 dSHXblYgm3MQB8W5Ebq2R9QPmwEiM34CNYEt7Zs4jZLaFJCOA6ejCYs2dUX2TQdnXDkFV5ryxz4
 xFuW6UVF/1hUDXQjMdVAOhXnoiHTGBw3Odo0hTrzFci6vT43qDWNGltkgTLFZHPQFp2QNbI06V4
 pPA8PxY7o7GHt9MZBkXkm8jnbaY3BUZBOdXEfhs2QuszYdaJxcCX5gRJcwd5Lwsub7knD7UNa8w
 t3urFTfspXJQlMLY3pjKHKMGy5Xb1MXCrOg8G5fjjwzJrA==
X-Received: by 2002:a05:6512:2459:b0:5b2:e178:4088 with SMTP id
 2adb3069b0e04-5b2e23015aamr2217787e87.4.1785757274533; Mon, 03 Aug 2026
 04:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260729114156.3348582-1-qiwenjie@xiaomi.com>
 <08a3a204-e151-4d55-8141-2bdd5ef4fea5@kernel.org>
In-Reply-To: <08a3a204-e151-4d55-8141-2bdd5ef4fea5@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Mon, 3 Aug 2026 19:41:03 +0800
X-Gm-Features: AUfX_myoqbVYvQPR73TG-aa0rwrV6oV64y4N3-VL8xJ-JCRoV6CWVbd2ztDIxds
Message-ID: <CAGFpFsQwo0SFv=OCyQprbOndTu_5SoBvjsq60MWN6sSGGY_d+A@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wqr2n-0008Mu-Ie
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject invalid recovered filename
 lengths
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBZZXMsIEkgaGF2ZSBhIHJlcHJvZHVjZXIuCgogIFRoaXMgb25lIGlzIG5vdCBuYXR1cmFsbHkg
dHJpZ2dlcmVkIGJ5IGluamVjdC5mMmZzLCBzaW5jZSB0aGUgYnVnCmNvbWVzCiAgZnJvbSBtYWxm
b3JtZWQgb24tZGlzayByZWNvdmVyeSBtZXRhZGF0YSByYXRoZXIgdGhhbiBhIHJ1bnRpbWUgZmF1
bHQKICBzaXRlLgoKICBUaGUgcmVwcm9kdWNlciBJIHVzZWQgaXM6CgogIDEuIGNyZWF0ZSBhIGZp
bGUgd2l0aCBhIDI1NS1ieXRlIG5hbWU7CiAgMi4gZnN5bmMgdGhlIGZpbGUgb25seSwgd2l0aG91
dCBmc3luY2luZyB0aGUgcGFyZW50IGRpcmVjdG9yeTsKICAzLiBjcmFzaCBiZWZvcmUgY2hlY2tw
b2ludCBzbyB0aGUgZnN5bmNlZCBpbm9kZSBzdGF5cyBpbiByb2xsLWZvcndhcmQgZGF0YTsKICA0
LiBwYXRjaCB0aGUgcmVjb3ZlcnkgbG9nIGVudHJ5IG9uIHRoZSBpbWFnZSBhbmQgY2hhbmdlIGlf
bmFtZWxlbiBmcm9tCiAgICAgMjU1IHRvIDA7CiAgNS4gbW91bnQgYW5kIGxldCByZWNvdmVyeSBy
dW4uCgogIE9uIGN1cnJlbnQgY29kZSwgcmVjb3ZlcnkgcmVwb3J0cyBzdWNjZXNzLCBidXQgdGhl
IGZzeW5jZWQgZmlsZSBpcwpub3QKICByZWNyZWF0ZWQgYWZ0ZXIgbW91bnQuCgogSSBhZ3JlZSB0
aGlzIHdvdWxkIGJlIGJldHRlciBjb3ZlcmVkIGJ5IGFuIHhmc3Rlc3RzIGNhc2UuIEkgY2FuIGxv
b2sgYXQKICB0dXJuaW5nIHRoZSByZXByb2R1Y2VyIGludG8gb25lLCB0aG91Z2ggaXQgbmVlZHMg
YW4gaW1hZ2UtY29ycnVwdGlvbgogIHN0ZXAgYmV0d2VlbiBjcmFzaCBhbmQgcmVtb3VudCwgc28g
aXQgaXMgYSBiaXQgZGlmZmVyZW50IGZyb20KICBpbmplY3QuZjJmcy1iYXNlZCB0ZXN0cy4KCiAg
Rm9yIHRoZSBjb2RlLCBJIGNhbiBhZGQgdW5saWtlbHkoKSB0byB0aGUgemVyby9vdmVyc2l6ZWQg
bGVuZ3RoIGNoZWNrIGluCiAgdGhlIG5leHQgdmVyc2lvbi4KCgpPbiBNb24sIEF1ZyAzLCAyMDI2
IGF0IDQ6NTPigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gNy8y
OS8yNiAxOTo0MSwgV2VuamllIFFpIHdyb3RlOgo+ID4gUmVjb3ZlcnkgdXNlcyByYXdfaW5vZGUt
PmlfbmFtZWxlbiBkaXJlY3RseSB3aGVuIHJlYnVpbGRpbmcgZnN5bmNlZAo+ID4gZGVudHJpZXMu
IEEgemVyby1sZW5ndGggbmFtZSB1c2VzIG5vIGRlbnRyeSBzbG90cywgc28gcmVjb3ZlcnkgY2Fu
Cj4gPiByZXBvcnQgc3VjY2VzcyB3aXRob3V0IHJlY3JlYXRpbmcgdGhlIGRlbnRyeS4KPiA+Cj4g
PiBUcmVhdCB6ZXJvLWxlbmd0aCBhbmQgb3ZlcnNpemVkIHJlY292ZXJlZCBuYW1lcyBhcyBjb3Jy
dXB0aW9uLCBtYXJrCj4gPiBORUVEX0ZTQ0ssIGFuZCBzdG9wIHJlY292ZXJ5IHdpdGggLUVGU0NP
UlJVUFRFRC4KPgo+IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBmb3IgdGhpcz8gbWF5YmUgdXNp
bmcgaW5qZWN0LmYyZnM/IEl0IHdpbGwgYmUKPiBiZXR0ZXIgdG8gY292ZXIgdGhvc2UgYnVncyB3
LyB4ZnNxYSB0ZXN0Y2FzZSwgY291bGQgeW91IHBsZWFzZSBjb25zaWRlcgo+IHRvIGFkZCBpdD8K
Pgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8cWl3ZW5qaWVAeGlhb21pLmNvbT4K
PiA+IC0tLQo+ID4gICBmcy9mMmZzL3JlY292ZXJ5LmMgfCAxNCArKysrKysrKysrKy0tLQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9yZWNvdmVyeS5jIGIvZnMvZjJmcy9yZWNvdmVyeS5jCj4g
PiBpbmRleCA4OWFmODQwN2I2NjcuLjcwY2Y5OWVmY2IzYyAxMDA2NDQKPiA+IC0tLSBhL2ZzL2Yy
ZnMvcmVjb3ZlcnkuYwo+ID4gKysrIGIvZnMvZjJmcy9yZWNvdmVyeS5jCj4gPiBAQCAtMTI2LDgg
KzEyNiw4IEBAIHN0YXRpYyBpbnQgaW5pdF9yZWNvdmVyZWRfZmlsZW5hbWUoY29uc3Qgc3RydWN0
IGlub2RlICpkaXIsCj4gPiAgICAgICBmbmFtZS0+ZGlza19uYW1lLmxlbiA9IGxlMzJfdG9fY3B1
KHJhd19pbm9kZS0+aV9uYW1lbGVuKTsKPiA+ICAgICAgIGZuYW1lLT5kaXNrX25hbWUubmFtZSA9
IHJhd19pbm9kZS0+aV9uYW1lOwo+ID4KPiA+IC0gICAgIGlmIChXQVJOX09OKGZuYW1lLT5kaXNr
X25hbWUubGVuID4gRjJGU19OQU1FX0xFTikpCj4gPiAtICAgICAgICAgICAgIHJldHVybiAtRU5B
TUVUT09MT05HOwo+ID4gKyAgICAgaWYgKCFmbmFtZS0+ZGlza19uYW1lLmxlbiB8fCBmbmFtZS0+
ZGlza19uYW1lLmxlbiA+IEYyRlNfTkFNRV9MRU4pCj4KPiB1bmxpa2VseT8KPgo+IHJlbG9jYXRl
IGVycm9yIGhhbmRsaW5nIGhlcmU/Cj4KPiBUaGFua3MsCj4KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FRlNDT1JSVVBURUQ7Cj4gPgo+ID4gICAgICAgaWYgKCFJU19FTkNSWVBURUQoZGlyKSkg
ewo+ID4gICAgICAgICAgICAgICB1c3JfZm5hbWUtPm5hbWUgPSBmbmFtZS0+ZGlza19uYW1lLm5h
bWU7Cj4gPiBAQCAtMTg1LDggKzE4NSwxNiBAQCBzdGF0aWMgaW50IHJlY292ZXJfZGVudHJ5KHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmb2xpbyAqaWZvbGlvLAo+ID4KPiA+ICAgICAgIGRp
ciA9IGVudHJ5LT5pbm9kZTsKPiA+ICAgICAgIGVyciA9IGluaXRfcmVjb3ZlcmVkX2ZpbGVuYW1l
KGRpciwgcmF3X2lub2RlLCAmZm5hbWUsICZ1c3JfZm5hbWUpOwo+ID4gLSAgICAgaWYgKGVycikK
PiA+ICsgICAgIGlmIChlcnIpIHsKPiA+ICsgICAgICAgICAgICAgaWYgKGVyciA9PSAtRUZTQ09S
UlVQVEVEKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgZjJmc19lcnIoRjJGU19JX1NCKGlu
b2RlKSwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaW52YWxpZCByZWNvdmVy
ZWQgZmlsZW5hbWUgbGVuZ3RoICV1IGZvciBpbm8gJWxsdSIsCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbGUzMl90b19jcHUocmF3X2lub2RlLT5pX25hbWVsZW4pLCBpbm9kZS0+
aV9pbm8pOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNldF9zYmlfZmxhZyhGMkZTX0lfU0Io
aW5vZGUpLCBTQklfTkVFRF9GU0NLKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBmMmZzX2hh
bmRsZV9lcnJvcihGMkZTX0lfU0IoaW5vZGUpLCBFUlJPUl9DT1JSVVBURURfSU5PREUpOwo+ID4g
KyAgICAgICAgICAgICB9Cj4gPiAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4gKyAgICAgfQo+
ID4gICByZXRyeToKPiA+ICAgICAgIGRlID0gX19mMmZzX2ZpbmRfZW50cnkoZGlyLCAmZm5hbWUs
ICZmb2xpbyk7Cj4gPiAgICAgICBpZiAoZGUgJiYgaW5vZGUtPmlfaW5vID09IGxlMzJfdG9fY3B1
KGRlLT5pbm8pKQo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
