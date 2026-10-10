Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D66CA9EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOnFjU5tJ2hsS+8z5p8DSQZCiHbHEY+jvgoXgeMr5EE=; b=jbAwibt4Axwn6GEByBr8YYjZDg
	qd6j4v9xvTZjrhK4pUkCQLJM2R6oSDv/CCbF9cEjJvqS3Zt/NF4HRtT95yHtL0tzqyfkGXj/Ew7oN
	nM17VcVKAsn8/1MC+nbRP6wIxWKmQ4NCy4Rwn7oflm3Whs2F8cC8NcvUhSyim8EmOKrQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFar6-0005It-Fq;
	Sat, 10 Oct 2026 17:27:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1xFar4-0005Ia-LN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 17:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:To:Subject:
 Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CC3Ndgu1DtsRC8vnhcTSTaw1b+YA0HnamcAkMulHtWo=; b=FlQX+qd9QudUVu1MZ9T9unJdgQ
 nl8ip61fEwg8f/VpoJNJGd1XL2n7eQ7lr/bMTgq8qckSDeU62jP4cInPQIzaj/HJA+UY5LCRggzox
 FCqNlSQIoUufbaVAu1xAOXtjdAZtNXbaue5RJ15f2rnIpBWws4xgVVzWVZO8cZo1aLI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CC3Ndgu1DtsRC8vnhcTSTaw1b+YA0HnamcAkMulHtWo=; b=CrlNseH+HAJbbTYwab8AikeQWA
 MyZ3F9dP6pEC5KdDsW8hqaWrI03RNhEhPgxxfx5pEvvsLifRFGYIQcfi5dOtJvGpB/W/cpRYTpE//
 hRMF+uvdAscpzk4zKOhVPUySkj1Vi8XP4hEmsZMBH/HOkpYYKKiPvcNdYmq3LpfeIcDw=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFar4-00061O-U3 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 17:27:31 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso115764966b.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 10:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791653244; cv=none;
 d=google.com; s=arc-20260327;
 b=jaea7XzmlB2fqPFSvMH8pP3MmdWyT468dGZraJSPFoLKYHnBRTmup0bZWl+oMeMXs1
 elzCHK8Sxn81E9VCR6TG9vLRFcV1RqC2bKM9C9hy6e6DFFuV7shdHbxfDKgV52tgdfRD
 WvfzX8ZfIeXTIsRN1/PDtkCqyx3JT3jcWFj49w1YvSrqGEICoOxrg6+Ok8p4L2ZdhAdv
 m9q+cpFpgnTRXwDFQ1fUnV5TnMd8SCZzc0JgkQVKRjotzfRBSXjOspNsE80PHaQwnb5P
 OafDRYnx5/IvE0jp1xJUVjTca/5pKDx5mwTqet0LyF1r2RDMz3yT/aFgdVWSvIsT9TUP
 mxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CC3Ndgu1DtsRC8vnhcTSTaw1b+YA0HnamcAkMulHtWo=;
 fh=V0zhxFRhJXSg6mZdUl5ExwVc82agGLUVeIxEmH43SsQ=;
 b=sYF2cTJE6lwhuuA+ZhOXP2SZv8EOjLOt6BMgxeTk4QrAbm7IMedOXi3jIytzzkGoAY
 uXgY/Ap/PFDnWY52AfheIwVRv0KPAVZHYQIxDw3wCGdZRuUxxSUsVWf3Y1DpZHcPvexD
 oR2oH9o4CR+8651l1wY7eFUbOSP8IulzVG1IbA5mYxAj4t8jjdbDUcxONqxlNbZ5fyFa
 spmnXfY+trH6hik1mOAnbXdLhhLUno7aT28Zd9GV7l8GCsMH0RT/VMQ20uJtAXVrcxza
 HZnZphX4DWpZeFSZyS6k0CY3egFKHQqFAc2gMbe+WJg7sxxkcEN5HMDl8PmqgPG223Y+
 jOrw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791653244; x=1792258044; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CC3Ndgu1DtsRC8vnhcTSTaw1b+YA0HnamcAkMulHtWo=;
 b=a2pBPNBF/64saNHHWnm08uyBY5CU2pwMQxAcpDeA7vW5huG8LoHTh4qnIm9gbUxE64
 gfCcK+gysMmlFd5FAHHwKzS1CGCYSpJliRZ81DlzpNGKSvLh6YlKx5DuBMwf7s7LYrU7
 JnaRC1kxLIc/1Ssxszmm+ok1D2Zjeaez+fm1dTgrZnX8Scx3oeF1se4Hh7h6b9cq2Ho8
 Zm+dEccV5Vw/x9YJ0jY7bBVlgoP4Qex8S9cOqMGPLpXdW7rk/aes3/BEAxLSIUEdYutL
 GvV4gQEBkbQens+3wcyJc2hFMrq1wp4kfsK/v80mY7/jvKFds0i3TkUMrOuqT1zULnFc
 zyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791653244; x=1792258044;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CC3Ndgu1DtsRC8vnhcTSTaw1b+YA0HnamcAkMulHtWo=;
 b=dz6ZZlGC/wTvUO2ijjcElg6XRGD+BZ4fPkEr+DGwbdGYoEWWgg93V1TZ+JgBTXCQFQ
 1NdXyFVyQCIKpGV0cSjTL4m3yuT2NCIhsdZbUHsh6TkbNLR8O6zz1GopRXaVn+VxtNCh
 dGKW2E8nu+rRF9ze3AfCbdYKH8a/5+jkLN3fKMXRzazVDaCshXREk18JV5BJbLO37rac
 b4Ov4N6PGOdhK9ss7pzv5NefpqLGen0REcEbUhKVKNIBdtvCvRzhkAfNqXvkTOHtq02r
 Hzof82wjb/9Kuca3DMjatYw6Dw9lgnk/VQYJ0ohvxeifLGyk9uCf6FqNgTgx9G6Bsstr
 D47w==
X-Gm-Message-State: AFq9FYIieNqKbz4+sQiV7nWhDrCs2aHZpFCOY/6I7+PRSaWxcPk3A6Tl
 EwUPAGn0PodIk8NlZyBUOePssqQqRaosLEiT+UTyuMP9DlA5kW+z89vuXX1lfkVy0OhkQRxinNK
 Jy3PxUYAfWZpMGJ+PZbj2BsbLuwU4bX+53w==
X-Gm-Gg: AYBFou0xISj3WBHlwKbR+AjQlDfHVku+FUOzhyR9jmor9QPbh6A1nTZ3SGhcRhp2ZF5
 h1ktb4k1LVbLnvBGopQQndJvpzAI5C7AnCTjpO4duxDu+/4jYsuLvisvGki4Y6CIH+GnF3CM9wS
 3Ki1fgxvTkxp5qLdYOJN0AHis27lHGPcAS0wOPx1SkekOetqCovz1MzqHbEK+toc61/xvQGMVxi
 cPUOEC9EmRub3EI+4Dx8txduj4rRY9ENClOzlLLgIV+bGrnWfK4+bc4NUbi9OEKHzl+FY7fQWM1
 iGgqmWZiFARbDGmBb7LpgUYjJbOuRIV/FxQm+NVDBFcnlSoNKSe8PB10jCASllmgL0w1Y6r6Wui
 EGyJtKXld2xmzio5+d2vwoAhOvClwvXuoFiqJkuEDMIoSsb/L8nBLvM/w1rRlFeXaDXiYNnJawg
 5tG5dqRm7+XTGTLA8EqSzib0vwdqZyxqkIqUj9TOQsx4MDaG4MdJHxA1FE/kGENbYAB4K8fFEzx
 PBm7zMvpVytC64TFZ95q2gBjjgcniF6hwwhEa0=
X-Received: by 2002:a17:906:c155:b0:c29:f5d5:5a92 with SMTP id
 a640c23a62f3a-c31aa03ccbcmr564403266b.28.1791653244107; Sat, 10 Oct 2026
 10:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261005201711.699080-1-qkrwngud825@gmail.com>
In-Reply-To: <20261005201711.699080-1-qkrwngud825@gmail.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Sun, 11 Oct 2026 02:27:13 +0900
X-Gm-Features: AclHuK9o9QYYKnnXt6tYGbmOAiEs4uXmlzmHpwwmikDoPXjWjo5Op9QP3YLM0aM
Message-ID: <CAD14+f1RXvOzvqfNv0aLLb2xGz7wxsQqcRvh7=GT3Fisqrb_1w@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, 
 kernel-team@android.com, Eric Biggers <ebiggers@kernel.org>, 
 Daniel Rosenberg <drosen@google.com>
X-Headers-End: 1xFar4-00061O-U3
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix casefolded dentry hash for
 names that fold beyond F2FS_NAME_LEN
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

KCtjYyBvcmlnaW5hbCBhdXRob3JzKQoKRnJpZW5kbHkgcGluZy4KCgpPbiBUdWUsIE9jdCA2LCAy
MDI2IGF0IDU6MTfigK9BTSBKdWh5dW5nIFBhcmsgPHFrcnduZ3VkODI1QGdtYWlsLmNvbT4gd3Jv
dGU6Cj4KPiBTaW5jZSBrZXJuZWwgY29tbWl0IDQzYzc4MGJhMjYyNCAoImYyZnM6IHJld29yayBm
aWxlbmFtZSBoYW5kbGluZyIsCj4gdjUuOCksIHRoZSBrZXJuZWwgY2FzZWZvbGRzIGEgbmFtZSBp
bnRvIGFuIEYyRlNfTkFNRV9MRU4gYnVmZmVyLCBhbmQgaWYKPiB0aGUgZm9sZGVkIG5hbWUgZG9l
c24ndCBmaXQsIGl0IGZhbGxzIGJhY2sgdG8gaGFzaGluZyB0aGUgcmF3IG9uLWRpc2sKPiBuYW1l
IChmMmZzX2luaXRfY2FzZWZvbGRlZF9uYW1lKCkpLgo+Cj4gZjJmc19kZW50cnlfaGFzaCgpIHN0
aWxsIGZvbGRzIGludG8gYSBQQVRIX01BWCBidWZmZXIsIGFzIHRoZSBvcmlnaW5hbAo+IGtlcm5l
bCBpbXBsZW1lbnRhdGlvbiBkaWQsIHNvIGl0IGhhc2hlcyB0aGUgZm9sZGVkIG5hbWUgaW5zdGVh
ZC4gTkZECj4gZGVjb21wb3NpdGlvbiBjYW4gZ3JvdyBhIG5hbWUgY29uc2lkZXJhYmx5IChlYWNo
IDMtYnl0ZSBIYW5ndWwgc3lsbGFibGUKPiBiZWNvbWVzIDYtOSBieXRlcyksIHNvIGEgdmFsaWQg
PD0gMjU1LWJ5dGUgbmFtZSBjYW4gZm9sZCB0byBtb3JlIHRoYW4KPiAyNTUgYnl0ZXMuIEZvciBz
dWNoIGEgbmFtZSwgZnNjay5mMmZzIGNvbXB1dGVzIGEgZGlmZmVyZW50IGhhc2ggdGhhbiB0aGUK
PiBrZXJuZWwuIEl0IHRoZW4gImZpeGVzIiB0aGUga2VybmVsLXdyaXR0ZW4gaGFzaF9jb2RlIHRv
IGEgd3JvbmcgdmFsdWUsCj4gYW5kIHRoZSBmaWxlIGJlY29tZXMgdW5yZWFjaGFibGUgdmlhIGxv
b2t1cCAoRU5PRU5UKSB1bmxlc3MgdGhlIGtlcm5lbAo+IGZhbGxzIGJhY2sgdG8gbGluZWFyIGxv
b2t1cCAoZS5nLiBsb29rdXBfbW9kZT1jb21wYXQpLiBMYXRlciBmc2NrIHJ1bnMKPiBjb25zaWRl
ciB0aGUgYnJva2VuIGhhc2ggY29ycmVjdCBhbmQgcmVwb3J0IG5vdGhpbmcuCj4KPiBUaGlzIHNp
bGVudGx5IG1ha2VzIHVzZXIgZmlsZXMgdW5yZWFjaGFibGUgb24gQW5kcm9pZCwgd2hlcmUgL2Rh
dGEvbWVkaWEKPiBpcyBjYXNlZm9sZGVkIGFuZCBmc2NrIGlzIHRyaWdnZXJlZCBvbiBhIGZ1bGwg
T1RBIGFuZCBhIGtlcm5lbCB2ZXJzaW9uCj4gY2hhbmdlLiBUaGlzIHBlcnNvbmFsbHkgaGFwcGVu
ZWQgdG8gbWUgb24gbXkgZGFpbHkgZHJpdmVyIHVuaXQuIFNpbmNlCj4gdGhlIGJ1Z2d5IGZzY2sg
Y29uc2lkZXJzIGl0cyBvd24gaGFzaCBjb3JyZWN0IGFmdGVyd2FyZHMsIHRoZSBkYW1hZ2UgaXMK
PiBuZXZlciByZXBvcnRlZCwgYW5kIGl0IHJlcGVhdHMgZm9yIGV2ZXJ5IG5ldyBzdWNoIGZpbGUg
dGhlIGtlcm5lbAo+IGNyZWF0ZXMuCj4KPiBNaW5pbWFsIHJlcHJvZHVjZXI6Cj4KPiAgIE5BTUU9
JChwcmludGYgJ+qwgCUuMHMnICQoc2VxIDQzKSkgICMgMTI5IGJ5dGVzIHJhdywgMjU4IGJ5dGVz
IGZvbGRlZAo+ICAgdHJ1bmNhdGUgLXMgMTI4TSBjZi5pbWcKPiAgIG1rZnMuZjJmcyAtcSAtTyBl
eHRyYV9hdHRyLGNhc2Vmb2xkIC1DIHV0ZjggY2YuaW1nCj4gICBtb3VudCAtbyBsb29wIGNmLmlt
ZyBtbnQKPiAgIG1rZGlyIG1udC9kICYmIGNoYXR0ciArRiBtbnQvZCAmJiB0b3VjaCAibW50L2Qv
JE5BTUUiCj4gICB1bW91bnQgbW50Cj4gICBmc2NrLmYyZnMgLWYgLXkgY2YuaW1nCj4gICBtb3Vu
dCAtbyBsb29wLHJvIGNmLmltZyBtbnQKPiAgIHN0YXQgIm1udC9kLyROQU1FIgo+Cj4gQmVmb3Jl
IHRoaXMgcGF0Y2gsIGZzY2suZjJmcyB3cm9uZ2Z1bGx5IG1vZGlmaWVzIHRoZSBoYXNoIGFuZCBi
cmVha3MKPiBrZXJuZWwgbG9va3VwOgo+Cj4gICBzdGF0OiBjYW5ub3Qgc3RhdHggJ21udC9kL+qw
gOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqw
gOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqwgOqw
gOqwgOqwgOqwgOqwgCc6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKPgo+IFVzZSBhbiBGMkZT
X05BTUVfTEVOIGJ1ZmZlciwgYXMgdGhlIGtlcm5lbCBkb2VzLiB1dGY4X2Nhc2Vmb2xkKCkgYWxy
ZWFkeQo+IHJldHVybnMgLUVOQU1FVE9PTE9ORyBvbiBvdmVyZmxvdywgd2hpY2ggZmFsbHMgYmFj
ayB0byB0aGUgcmF3LW5hbWUgaGFzaC4KPiBXaXRoIHRoaXMsIGZzY2suZjJmcyBsZWF2ZXMgdGhl
IHJlcHJvZHVjZXIgaW1hZ2UgdW50b3VjaGVkLCBhbmQgaXQgYWxzbwo+IHJlcGFpcnMgdGhlIGhh
c2hlcyB0aGF0IHRoZSBidWdneSB2ZXJzaW9uIHByZXZpb3VzbHkgcmV3cm90ZS4KPgo+IEZpeGVz
OiBjZTY0ZWEwODE1YmYgKCJmMmZzLXRvb2xzOiBBZGQgc3VwcG9ydCBmb3IgQ2FzZWZvbGRpbmci
KQo+IFNpZ25lZC1vZmYtYnk6IEp1aHl1bmcgUGFyayA8cWtyd25ndWQ4MjVAZ21haWwuY29tPgo+
IC0tLQo+ICBsaWIvbGliZjJmcy5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGliL2xpYmYyZnMuYyBi
L2xpYi9saWJmMmZzLmMKPiBpbmRleCA5M2YzNmNhNmEzMGMuLjc1YjdlMWE3Mzc2ZiAxMDA2NDQK
PiAtLS0gYS9saWIvbGliZjJmcy5jCj4gKysrIGIvbGliL2xpYmYyZnMuYwo+IEBAIC00OTksMTAg
KzQ5OSwxMCBAQCBmMmZzX2hhc2hfdCBmMmZzX2RlbnRyeV9oYXNoKGludCBlbmNvZGluZywgaW50
IGNhc2Vmb2xkZWQsCj4gICAgICAgICB1bnNpZ25lZCBjaGFyICpidWZmOwo+Cj4gICAgICAgICBp
ZiAobGVuICYmIGNhc2Vmb2xkZWQpIHsKPiAtICAgICAgICAgICAgICAgYnVmZiA9IG1hbGxvYyhz
aXplb2YoY2hhcikgKiBQQVRIX01BWCk7Cj4gKyAgICAgICAgICAgICAgIGJ1ZmYgPSBtYWxsb2Mo
c2l6ZW9mKGNoYXIpICogRjJGU19OQU1FX0xFTik7Cj4gICAgICAgICAgICAgICAgIEFTU0VSVChi
dWZmKTsKPgo+IC0gICAgICAgICAgICAgICBkbGVuID0gdGFibGUtPm9wcy0+Y2FzZWZvbGQodGFi
bGUsIG5hbWUsIGxlbiwgYnVmZiwgUEFUSF9NQVgpOwo+ICsgICAgICAgICAgICAgICBkbGVuID0g
dGFibGUtPm9wcy0+Y2FzZWZvbGQodGFibGUsIG5hbWUsIGxlbiwgYnVmZiwgRjJGU19OQU1FX0xF
Tik7Cj4gICAgICAgICAgICAgICAgIGlmIChkbGVuIDwgMCkgewo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGZyZWUoYnVmZik7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvcGFxdWVf
c2VxOwo+IC0tCj4gMi41NS4wCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
