Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F76DF513E9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0jNQXekKDlfz0gvd4+BwtIZUfwkMRGt6fR2nn/7rbI=; b=GdScBbzsd7QhzKBwgN5Gn6/3O6
	CJDQJHUutmUFWfzS514x8crLw3cfObygUaQRSmPX0frH8ufqMNFs+0gzCUgTGYyUbQYCQ8XNNTYiL
	eJaNfbZYrU+pUF5XptVyMV6K/4gJCJ+jgk5QdUbNKizxrZkKrrAanTfO0BIYhUgQTKmg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vyJff-00086h-HH;
	Fri, 06 Mar 2026 01:08:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <21cnbao@gmail.com>) id 1vyJfe-00086U-EA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Mar 2026 01:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5PiYS0CMLEXE7ke4eXYVGUWb4mtA5+xVBrm3wsFpjo0=; b=UQqwXmXUvzoni1KMcIQL11qaDJ
 oz15MbZXFxGwF8ocSVAn0Ew4zB4dxPmgq03jBya8k95nZrGLMr48gj8qpJK0F5cHXNwri9UDrvfXp
 yxfJRySO/qwV31UI+za6fOeyTeex/QaptGRG+kIVn+LiyWRb7Ik6k5mrnKY6LoaBmHYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5PiYS0CMLEXE7ke4eXYVGUWb4mtA5+xVBrm3wsFpjo0=; b=HV8+FXBLtPaBOCaTvP8pvNjGPD
 G/IlzjlNqrv303ydN6up608MeBxAK7qkLYRdTE54OxzEwSjVFdQLCgroFeI7K/kU18Re3JQ+bgjrJ
 ubXBf12tu4rn6DvqmQ7U9bveS4lMG+c4x5AiPX53vFqSOUbrqz8a4sOjuKL0ypiqhRmM=;
Received: from mail-qv1-f54.google.com ([209.85.219.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vyJfe-0002j0-SG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Mar 2026 01:08:03 +0000
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89a09ef1e3aso51830646d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 05 Mar 2026 17:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772759272; cv=none;
 d=google.com; s=arc-20240605;
 b=FNIASqnTKIvLFIT9Wvv4Syn6ieQQ/ksruItDPkPbqfxeSDz597Rz7BN5V+f97pG3yJ
 1/OQxuMpPj6S0sToEl99+JPazlkNdh9bH96LDAGD4wDF2b7yWUWzOf9QafZR+KICb4IA
 RebUSWFQCi6VoIppOje4NZ9EAYl8Q0GDj2eVoq8p5mBLMVrCSziYVQpBx/8xKcS3XUNT
 ea4LQy/KYClboCkQojiGP6RE4ZGtod7fR4536PwImNpzeVC4VO33yym83Tg9qkWcsD3N
 L37JUAxWv8R2l7Qae6+fBfJu0qO3W5RPbMJbOOifUn4JfyaZEBesSB91tbF5DCMrJnNu
 fwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5PiYS0CMLEXE7ke4eXYVGUWb4mtA5+xVBrm3wsFpjo0=;
 fh=o7lCIcOhmluS+mhEZMLSZJIMJ0//vqx6UdQo/yo+49o=;
 b=b3+WxaoAoLznPjWPmnEv2ljvBTBkrUdT7G5orStCt/te6tWw/gHteotcOQDjnl2pkW
 LLnDEV8UFQT5wgVl7VJVEOm6hszMbd4hIQFhvCRMmuah7aD2FWcMrV1KISnQKw78vpDK
 K1HiJBgMpkXN74xnhbOP+tSsaTrlup00ap8dpv8eW0y/TrSgRY3q3R3E0rb2SFsrDLUw
 yoyX592Erk9fN0mNNrymn1/xmPmyow7ytV9YDk9GSwUgknXz3Zp/TDOsqLgbfbhZG4q9
 fO954Dr571NMYL89t0cnXmqTM6PNZbH0PF2cHB6R231QPXU8OmVO4fSl8ikc7q61P/+4
 vOTw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772759272; x=1773364072; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PiYS0CMLEXE7ke4eXYVGUWb4mtA5+xVBrm3wsFpjo0=;
 b=XrdFw/aWQmgm1E3/y7612Rl3yectjUUQpzvITNE+zUUrBt1Ad63cihbYx88W29w3Xg
 HYxPdwfKhsxlhtd9BntN0Lsx1piVa0Gwbgi0Rt3iEmAoVUgvOYh5+6oCVkKwLZl01but
 aySIzR4eOfo7F++3mdwKWwypg9NSixWGYzNRHYaViO2Kb0j4L87qUEEPaQsEKTi83euF
 sgYKYTM2D+jFqEgm39PMQAK7Mox8WmfFJgnuZt/cBznfyQJ6waRs9dSCCCjTFRl5Vggh
 h/GCEw4O9/j/in4RvSJneIi/YFHsn4Zp7+fKO2tU4MnVIJ8Y7m/VJAF+6jxgyjeqgpKH
 oSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772759272; x=1773364072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5PiYS0CMLEXE7ke4eXYVGUWb4mtA5+xVBrm3wsFpjo0=;
 b=Y4veYuTYp8wre9Syom6S8e+rAh38cDA2/2jFNv/t88/dNwIdwWOV7DZoi9BQudNwrM
 nUfpGeZnp4UjnRUqaOs4ensa8y+bIhFm7QBI+h9+LlVLSDXFhJkfjc1E5OlAlYu1tSXW
 x8GifuCnGZH7fAZoU9MbNDuYgudgkftiO6mKMesRvwSx99PjTT9an/vizat0k7R5emvv
 L+v7jqXdOSKCmMl97BSGX3i7rVE/NNrKlA0VGjc9yLE/Ag/NDz1KXLNasx0LhiavGY4S
 Ptg++XjK39vwuUZrfPaTMXFFqJKlRWfhBIDl4nVHoY8xcClIMnMy2xB0OdoSOJXzzeHM
 Vhsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhrW9K5iklMO/mQExJGP4c5IcS/e/gCEi/uiQdzaFezQ62e5Ef2P/maN13nV/j+F6lnM72L0m7Mkj6yI3z7C3S@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5ZbdRoqStYtQgLRpetS4qRScAPd7Uge/XRUagqHzu94P3H+BO
 kMet3B3++deMKGyuiZ9joLP7JOATPWAzCRWTo2c0sQiMbuui8Y77uflr1Ik7GVsdztizbkKh4LO
 YgvBbZj+S90fPa5YO/NY3RdWgJ94Jd3IuT1Kf
X-Gm-Gg: ATEYQzzBPfVYN7FOpnGuBQkirCUf3PqBwZ/gNPI99KXqOVYCyGgt6r8a84Pa44di0lT
 Wx/jeuAPEntcGUbOuhbhSnU6mYY3xu9LK5ieHIEBG7S4icv/ELDLpq7wgnfXUbXRYBIoRomv+3c
 k0okKRePz4Q0cUEJYmqrII49CXikmTmw6ApjY+7vdwchu3b+iiVw8qmbDl55Qpvmhhu9zCY5JKw
 WnhZ76xpKlfSvfp2cZnRkN0FTnANp1A7SPH6vQXP9z5g5wkB2N96raZEw2yyuRTRPTb9YWc6Idx
 O1AaDdNCHf/dK59+
X-Received: by 2002:a05:6214:519e:b0:880:4eac:8689 with SMTP id
 6a1803df08f44-89a30b009e1mr2769626d6.57.1772759271534; Thu, 05 Mar 2026
 17:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20260203091256.854842-1-nzzhao@126.com>
In-Reply-To: <20260203091256.854842-1-nzzhao@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 6 Mar 2026 09:07:40 +0800
X-Gm-Features: AaiRm50i2MynhpJRAnqJX0y7ypwGzgmP2t1pDrLgEaYh5nooB14K9TxUS4c9Q6Y
Message-ID: <CAGsJ_4weNqZ9S05FmPbLe_MgER52DGTd2DYENZzYJorP913UVw@mail.gmail.com>
To: Nanzhe Zhao <nzzhao@126.com>
X-Headers-End: 1vyJfe-0002j0-SG
Subject: Re: [f2fs-dev] [RFC PATCH v1 0/5] Support large folios buffered
 write for regular files
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBGZWIgMywgMjAyNiBhdCA1OjEz4oCvUE0gTmFuemhlIFpoYW8gPG56emhhb0AxMjYu
Y29tPiB3cm90ZToKPgo+IFRoaXMgUkZDIFBBVENIIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGxh
cmdlIGZvbGlvIGJ1ZmZlcmVkIHdyaXRlcwo+IHRvIHJlZ3VsYXIgcmVhZGFibGUgYW5kIHdyaXRh
YmxlIGZpbGVzIGluIGYyZnMgd2l0aCBleGNlcHRpb24gb2YKPiBhdG9taWMvY29tcHJlc3NlZC9p
bmxpbmVkIGZpbGVzLgoKWW91IGFyZSBhY3R1YWxseSBleHRlbmRpbmcgbGFyZ2UgZm9saW8gc3Vw
cG9ydCB0byBub24taW1tdXRhYmxlCmZpbGVzLCBzbyBmb3IgcmVhZHMgeW91IHdvdWxkIGFsc28g
Z2V0IGxhcmdlIGZvbGlvcywgcmlnaHQ/CgpJZiBzbywgSSBmZWVsIHRoZSBwYXRjaHNldCBuYW1l
IG1pZ2h0IGJlIG1pc2xlYWRpbmcuIFBlcmhhcHMgc29tZXRoaW5nCmxpa2UgImYyZnM6IGVuYWJs
ZSBsYXJnZSBmb2xpb3MgZm9yIHJlZ3VsYXIgZmlsZXMiPwoKPiBTaW5jZSBhZGFwdGluZyBwYWdl
IHdyaXRlYmFjayB0byBzdXBwb3J0IGxhcmdlIGZvbGlvcyBpcyByZWxhdGl2ZWx5IGNvbXBsZXgs
Cj4gaXQgaXMgbm90IGluY2x1ZGVkIGluIHRoaXMgc2VyaWVzLgo+Cj4gSSByYW4gc2ltcGxlIGBk
ZGAgdGVzdHMgb24gYSBQaXhlbCA2IGRldmljZS4KPiBEdXJpbmcgdGhlIHRlc3RzLCBkaXJ0eSBw
YWdlIHdyaXRlYmFjayB3YXMgdGVtcG9yYXJpbHkgZGlzYWJsZWQuCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCgpXaGF0IGhhcHBlbnMgaWYgZGlydHlfd3JpdGViYWNrIGlzIHByZXNlbnQ/IFdp
bGwgaXQgY2F1c2UgYSBjcmFzaD8KSSBmZWVsIHRoYXQgZGlydHkgcGFnZSB3cml0ZWJhY2sgaXMg
YWN0dWFsbHkgbW9yZSBpbXBvcnRhbnTigJRpbWFnaW5lCndlIHJlYWQgc29tZSBjb250ZW50IHVz
aW5nIGxhcmdlIGZvbGlvcyBhbmQgZW5kIHVwIGRpcnR5aW5nIHRoZW0uCgpUaGFua3MKQmFycnkK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
