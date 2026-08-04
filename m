Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648AC55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/qJ8TseDcqmjoUqORxHDrtw1tBksaxx4bxRu83sPyU=; b=dz8iTSA++aUYKTSs2YZOydnIiQ
	oIm+dPLZ0PRU3PH2Mooy98tTs5mcUQEtfHSRrLzW4DETxP8JJkGAX/sH0n6/8KWBrJRvw8K7dbrw2
	txmOPl96AvHWyPMfCyj0HLZDBTMuFVD5oyT8WRnZ9szzBLg2ad/EeCaOpRfk0uChm3HM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr7Sz-0002fn-UT;
	Tue, 04 Aug 2026 05:13:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <senozhatsky@chromium.org>) id 1wr7Su-0002fe-JE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 05:13:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=; b=kp/R4C1OFg9v7UJyL4Ot8GIkbJ
 yWsUQgDDs81wwp9jXz/FcTv9ZGZ7sgvKEhZLrTBKPUDLHRJruTLWH5LkrlzFo9dBE1F9xwA7huH4p
 T5RYAYdF0rWmWPYykaaHvLrel1rrfupUyF5miBSYgP1P8/O6nWEyw2A4FFVU1U0KEwVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=; b=PkQDOzSt7K31r/SFBrMGok7MUj
 dk/KnohzDhUsNdsC8EtpOpMQxR/FCuhzmxS1EgCoVVveRvn7i2CwiR2DLHzvhafRR6LpadTJOycCQ
 U2ZzlrUJmwG5Ye6xPIwuoO/SV5kjXt6FMxH6kPlIrbeHiKdN9kXUbUgLkSr6XDij2NlU=;
Received: from mail-yx1-f46.google.com ([74.125.224.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wr7Sr-0001Mp-LO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 05:13:22 +0000
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-6682259cae6so4235853d50.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785820396; x=1786425196;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=;
 b=DvMNPN4FrzmRgfdrfKiIH79t01RR0kRHKkaUeMe2NgkaPX1/O3HXrH2Q9t3oBkzmQ8
 pC/+VJ3zgUTPCK0yXUW97iH4kT/0+7rv839cHYkQo9zcbgoS0FogaSRehLhH30agb9k+
 9vC8wxMFnNXsrgxFSUMNFmNuGMWPa8C7SRCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785820396; x=1786425196;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=;
 b=M3uXPEx43iHk2tjpUO55CjIjZWQ5ZPZRUvsWT+6QRz2EXf8Y6oJ4quw1i0K9jjTOEY
 QGIIt3GlBnpPq5DwRKGnuer+axRzMhAvhZ2jYwMNzNTVwaBfp6cupc3QodsQ/XMgCd01
 tCKWPovYsvMAObt6HzGJruUDFNJpcPoXE3kYBE9C+mqLSuHAK9k0lLjYbBZXzwSB7jCL
 j2KYdp11K+2vY8ZUa7eiIuGZ6w8mW20NHOI96lQbPukfCoa1A8vaKnFzQ4cSqFDXbRcp
 nX+CJfdCBfxhBUekcmfHOtI/v6b6WBVIOMlg/tBG3KWZwBJ+vf6ZrQL30+usiGWqcFKi
 tXDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQ3BZnpaNJ8xIUJUBCC8KDK15oV13rlLUevFg/JnYaGqlOo8lN67+PFOPbMdrXEyDqaFJYgX30FvKW7A/yjdfO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwSN9+llgll78xWbmU/+yfe+Z0Huv+U1tjyabDWNt2fUrz0KmW8
 2sMJAHPwaMzr2PAn0TCJuJNui4L7qpMn0GBYWQ36Cj3e+xuoEYvVgnf2tNb7nZhDAWICT0NXgbn
 hjQA=
X-Gm-Gg: AR+sD12R7KVNQ9dYd2pjMyYLVnn2BHLw66XSz8ZwtPsMOQpUXEt+VaXWGSf7e/ncRCu
 v+wB55kK3I0gkKD3YwYMGCgb6LQ5racN3qQuLI4Des2fEayJyJ4FMZ6hRfwBB6ss71fURM2QS9A
 ZI5HCQp7jko6dRObuvOY8aBYlHW56/ZyPGtefFtFmsv+sYKcQ101SM15QanpQQ7PEWjRgPTVoOK
 JuGP57IcHJRDxq9YsP5eGVnovTwCgxnLnGB5QFWEJjBNJCgsjRFWl1dudQNif1d62FtPSeW3UDC
 ULqR2oT+kQ1GXCbaobJOrgWmcsSW4gD2HZ3ODf9e0IlaDb2GG+KmOp0gSxOoduToLojMuGb/7m0
 7wGdhfeabNB6CTAoqfZgwGqyfPDHogYdXFjOgyNgVCMN8YayxXyD5Q1VM9OTX5TgNwUzdqphjf9
 Y2L4n9uNykb2XBsf3ogspQLkAWphBBjPiYMlqoq0LDQDgXbs4xeSor9MS+euPdZLItFQ2FotD5B
 ywVbza4OZRqkxo7IqsCbIX+q5fefvwPma//J8g=
X-Received: by 2002:a05:6a00:c94:b0:847:770f:da4c with SMTP id
 d2e1a72fcca58-84ee4813951mr12064733b3a.16.1785818548446; 
 Mon, 03 Aug 2026 21:42:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fcb5:533d:198b:8d48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbe564b3sm4629556b3a.14.2026.08.03.21.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:42:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:42:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Message-ID: <anFspPi023HFlwwE@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
 <amr3P_4zxX2w7ZNR@google.com>
 <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
X-Headers-End: 1wr7Sr-0001Mp-LO
Subject: Re: [f2fs-dev] [PATCH v4 3/4] zram: validate parameters in each
 backend's setup_params
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
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Rongwei Wang <zigiwang@tencent.com>, Haoqin Huang <haoqinhuang@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gKDI2LzA4LzAzIDIwOjIwKSwgaGFvcWluIGh1YW5nIHdyb3RlOgo+IE9uIFRodSwgSnVsIDMw
LCAyMDI2IGF0IDM6MjTigK9QTSBTZXJnZXkgU2Vub3poYXRza3kKPiA8c2Vub3poYXRza3lAY2hy
b21pdW0ub3JnPiB3cm90ZToKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svenJhbS9i
YWNrZW5kX2x6NGhjLmMgYi9kcml2ZXJzL2Jsb2NrL3pyYW0vYmFja2VuZF9sejRoYy5jCj4gPiA+
IGluZGV4IGY2YTMzNmFjZmUyMC4uNWQ1NTFkMTY1MjEzIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL2Jsb2NrL3pyYW0vYmFja2VuZF9sejRoYy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvYmxvY2sv
enJhbS9iYWNrZW5kX2x6NGhjLmMKPiA+ID4gQEAgLTIwLDYgKzIwLDExIEBAIHN0YXRpYyBpbnQg
bHo0aGNfc2V0dXBfcGFyYW1zKHN0cnVjdCB6Y29tcF9wYXJhbXMgKnBhcmFtcykKPiA+ID4gIHsK
PiA+ID4gICAgICAgaWYgKHBhcmFtcy0+bGV2ZWwgPT0gWkNPTVBfUEFSQU1fTk9UX1NFVCkKPiA+
ID4gICAgICAgICAgICAgICBwYXJhbXMtPmxldmVsID0gTFo0SENfREVGQVVMVF9DTEVWRUw7Cj4g
PiA+ICsgICAgIGVsc2UgaWYgKHBhcmFtcy0+bGV2ZWwgPCBMWjRIQ19NSU5fQ0xFVkVMIHx8Cj4g
PiA+ICsgICAgICAgICAgICAgIHBhcmFtcy0+bGV2ZWwgPiBMWjRIQ19NQVhfQ0xFVkVMKSB7Cj4g
PiA+ICsgICAgICAgICAgICAgcHJfZXJyKCJsejRoYzogaW52YWxpZCBjb21wcmVzc2lvbiBsZXZl
bCAlZFxuIiwgcGFyYW1zLT5sZXZlbCk7Cj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7Cj4gPiA+ICsgICAgIH0KPiA+Cj4gPiBTby4uLiAgbGliL2x6NC9sejRoY19jb21wcmVzcy5j
IHN1cHBvcnRzIGxldmVscyAxIGFuZCAyLiAgSG93ZXZlciwKPiA+IExaNEhDX01JTl9DTEVWRUwg
aXMgc2V0IHRvIDMsIGJ1dCBjbGVhcmx5IHRoZSBjb21wcmVzc2lvbiBsaWJyYXJ5Cj4gPiBzdXBw
b3J0cyBsZXZlbHMgbG93ZXIgdGhhbiBMWjRIQ19NSU5fQ0xFVkVMLiAgSW4gZmFjdCwgTFo0SENf
TUlOX0NMRVZFTAo+ID4gaXMgbmV2ZXIgdXNlZCBpbiB0aGUgbHo0IGNvZGUuICBNYXliZSBoZXJl
IHdlIG5lZWQgdG8ganVzdCBoYXJkY29kZQo+ID4gIjwgMSIgYW5kIHB1dCBhIGNvbW1lbnQ6Cj4g
Pgo+IAo+IE15IGJhZCwgY29tcGxldGVseSBtaXNzZWQgdGhhdCBMWjRIQ19NSU5fQ0xFVkVMIGlz
IGFkdmlzb3J5IGFuZCB0aGUKPiBsaWJyYXJ5IGFjdHVhbGx5IGFjY2VwdHMgMS0yLiAgV2lsbCBo
YXJkY29kZSA8IDEgaW4gdjUuCgpObyB3b3JyaWVzLCB0aGF0IExaNEhDX01JTl9DTEVWRUwgdGhp
bmcgaXMgZGlmZmljdWx0IHRvIHNwb3QuCgo+IEJ0dywgd291bGQgaXQgbWFrZSBzZW5zZSB0byBm
aXggTFo0SENfTUlOX0NMRVZFTCB0byAxIGluIHRoZSBsejQKPiBoZWFkZXIgYXMgYSBzZXBhcmF0
ZSBjbGVhbnVwPyAgSXQgc2VlbXMgbWlzbGVhZGluZyBhcy1pcy4KCkknbSBhZnJhaWQgd2UgY2Fu
bm90IGRvIHRoYXQuICBmMmZzIHVzZXMgTFo0SENfTUlOX0NMRVZFTCwgSSBhc3N1bWUKY29tcHJl
c3Npb24gbGV2ZWwgaXMgc3RvcmVkIHBlci1pbm9kZT8gIFNvIGlmIHdlIGNoYW5nZSBMWjRIQ19N
SU5fQ0xFVkVMCnRoZW4gbmV3ZXIgZjJmcyB3aWxsIHN0YXJ0IGFjY2VwdGluZyBjb21wcmVzc2lv
biBsZXZlbHMgdGhhdCBvbGRlciBrZXJuZWxzCmRvbid0IHN1cHBvcnQuICBDYy1lZCBKYWVnZXVr
IGFuZCBDaGFvIGp1c3QgZm9yIHZpc2liaWxpdHkuCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
