Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1841C71153
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 23:14:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qalRL-0004qm-JE;
	Mon, 28 Aug 2023 23:14:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drosen@google.com>) id 1qalRJ-0004qf-IC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 23:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HRTiwphd/AylyYMdsDzQTC3Yl+brNhiw27SnUbvJ0Ng=; b=G41sMCq9i8xMMOaEdQaaU7uhXL
 plY/y2jUHLtpJzgGoy3Odk73T2UUiB4YvltSYPEEAVngjc75NkAWYNEir81Jw7hKk89Q/u3hoDZxM
 D4M2Wxbj2Tw666XRm+drDTUKW9xFG0KEmFOo5403oaSO35FjQjslXTFOn7POOuVvck1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HRTiwphd/AylyYMdsDzQTC3Yl+brNhiw27SnUbvJ0Ng=; b=GkWz/ec1J2TELKdtl2qqC1kwal
 14muEyfnjHqj+QuB+XVJzVRdJ6RqvUdfXGdj7jY9i911xElwMTpbFGyreonyGAglJKbTwZ2mElCo3
 7Byf9iR9Gj4EGQmBRRY1NT1QNUzXUEAEJo/NuEk1TmXCu/q2R1o+7Qbf7V6mtVl28HWY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qalRJ-0006BB-96 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 23:14:33 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so3167684f8f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Aug 2023 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693264465; x=1693869265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRTiwphd/AylyYMdsDzQTC3Yl+brNhiw27SnUbvJ0Ng=;
 b=NDwUfyzsiyUhoErIwIPpFrvt7QzZbCKeId07AdZxa5gclUNPPYJ3VhgxQ6KzVko3Vy
 ZSBGdIj7SGeWv4uHGgKJIvZVEZoHZJLEX/T7VNkFPwe4ZRpD0C3G6dGXv408v1ZPFFtk
 7q7qfo4ZEjRAuOSdw5m59cbbDo1xc7oIAxhYtsF5YISWW2tw8e79VlBYW7YAwmmDUFBA
 klVN4BFO1ky3tNnEOgO1z7HnUCz7GYf+mXrd0qFTHsy+NTUedbRhXeS5vmaRRyHuoyvO
 3vV8nFXfjWFpXPlHo0/rGtHtiwOtmrdiWsY6XtjcPHIzYOj+7dIIEUJMamGhP9BypEPj
 03sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693264465; x=1693869265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRTiwphd/AylyYMdsDzQTC3Yl+brNhiw27SnUbvJ0Ng=;
 b=QGEocBRIxkv+MpqS/p4KixbsThdSiIkPQaKNjziWmgR/VVCApBl+ypvoIuIVAsNevW
 0LXfA0buLc7V/bgxLCIQXS3uJr/znKltzD0c+J/vJWmx3pGy4zjqNFKEa2T1NqG2yV4S
 qSz/VBYRLZB9ToE3xWncF1ICULzYrR6awiVVQhrOEQAG4958E1l5j4pnoO3Kf6RJW/Qi
 yYFy0BMv8rL8oWF6BBE4NvDERQarWSMBorCD18R1X3DLN6Oo0CbBV7BjBbb4TTmloezN
 Q1nm1XQI49eHzjvtUBXOQJGOfs5V40zFO8aqQ4wjJ1TWhiWpRmm2VX0f94mp8qRkRDZx
 pdzw==
X-Gm-Message-State: AOJu0YyGKBeNCC+67lQA8QGF9Ivc+wPq28wpp1vK/111YxL6JVbkxKPS
 pw4uyKFByg7urrg+RFr+lK9rmRpxhsC3M5jY8AzH9YxuFo9S4uCPgWk=
X-Google-Smtp-Source: AGHT+IG1eQufk0P69UoThGPb0ZRPsG0AUokvFSh0iH/F3MSvhJeu3Ue+LuDtGfnDzw5wN6eU8AuIqYv46OHSfl/G6kI=
X-Received: by 2002:a5d:5222:0:b0:319:8ce0:4e52 with SMTP id
 i2-20020a5d5222000000b003198ce04e52mr20446049wra.67.1693264465079; Mon, 28
 Aug 2023 16:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230825224400.2206278-1-drosen@google.com>
 <20230825224400.2206278-6-drosen@google.com>
 <ZOzifRuvT2EJh20q@google.com>
In-Reply-To: <ZOzifRuvT2EJh20q@google.com>
Date: Mon, 28 Aug 2023 16:14:13 -0700
Message-ID: <CA+PiJmRjauO33Ycf-N-M-tdvUpO7hDnv81OyDzyBgF+JUYJ4hA@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qalRJ-0006BB-96
Subject: Re: [f2fs-dev] [PATCH v2 5/7] f2fs-tools: Refactor Summary block
 struct and friends
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: kernel-team@android.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBBdWcgMjgsIDIwMjMgYXQgMTE6MDjigK9BTSBKYWVnZXVrIEtpbSA8amFlZ2V1a0Br
ZXJuZWwub3JnPiB3cm90ZToKPgo+IEhpIERhbmllbCwKPgo+IENvdWxkIHlvdSBwbGVhc2UgY2hl
Y2sgdGhpcz8KPgo+IG1vdW50LmM6IEluIGZ1bmN0aW9uIOKAmG1vdmVfb25lX2N1cnNlZ19pbmZv
4oCZOgo+IG1vdW50LmM6MzAzNzo5OiB3YXJuaW5nOiDigJhtZW1jcHnigJkgb2Zmc2V0IFswLCAz
NTgzXSBpcyBvdXQgb2YgdGhlIGJvdW5kcyBbMCwgMF0gb2Ygb2JqZWN0IOKAmGJ1ZuKAmSB3aXRo
IHR5cGUg4oCYc3RydWN0IGYyZnNfc3VtbWFyeV9ibG9ja+KAmSBbLVdhcnJheS1ib3VuZHNdCj4g
IDMwMzcgfCAgICAgICAgIG1lbWNweShjdXJzZWctPnN1bV9ibGssICZidWYsIFNVTV9FTlRSSUVT
X1NJWkUpOwo+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgo+IG1vdW50LmM6Mjk5ODozNTogbm90ZTog4oCYYnVm4oCZIGRlY2xh
cmVkIGhlcmUKPiAgMjk5OCB8ICAgICAgICAgc3RydWN0IGYyZnNfc3VtbWFyeV9ibG9jayBidWY7
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+Cj4KVGhpcyBz
aG91bGQgaGF2ZSBiZWVuIGEgYmxvY2sgc2l6ZWQgYnVmZmVyLCBidXQgd2l0aCB0aGUgcmVmYWN0
b3IgaXQncwphIDAgc2l6ZSBidWZmZXIuLi4gQ2hhbmdpbmcgaXQgdG8gYSBjaGFyW0YyRlNfQkxL
U0laRV0gZm9yIHYzLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
