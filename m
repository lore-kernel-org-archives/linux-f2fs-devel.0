Return-Path: <SRS0=CSNb=KG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECFBC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 May 2021 09:37:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7A261925;
	Tue, 11 May 2021 09:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A261925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgOpj-0005FV-AJ; Tue, 11 May 2021 09:37:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1lgOpi-0005FK-Rm; Tue, 11 May 2021 09:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=djvDkKSIoKYQDOpMM6dWM8Dv5KxPL+Cq6xC784LBsMQ=; b=BCT9PEZ2YElzKt2aXuFPcSyyhS
 rEFOCzIddtRY71/JlCHpbjqLwNQk7CFDA8mZyu/mu96DcqdWPJ09zPaoTjwP/FPXUBHag6Oittb+o
 NMjdKQtdS2Bvl5l6kdJpbzUtDI5UROM9BJY1WtufcTTaQw0dJuDylvj9ziLWayztWKN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=djvDkKSIoKYQDOpMM6dWM8Dv5KxPL+Cq6xC784LBsMQ=; b=cdImLA0P7Iufi/brDCnYiXScwd
 C3KE4zCaw5REozjr4d2899HbC5iD7En52KQT/vIvxXaUDv3eKnPQKIzMzLBwkkOqyUxVYTmFjXReQ
 uCnyV06lQ1qW+kboE6IPzloQtVFZhc9HFNgDi0LqVNn7jPn2LujKw1HBb60AM89L6EYE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lgOpe-003fVW-Oa; Tue, 11 May 2021 09:37:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A14E161925;
 Tue, 11 May 2021 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620725848;
 bh=6o759ShUxJ4M0iPoewavcBs0joP5lvg0/UyuatoupKw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VmShZQzrJkNUYpzDiT8lkPsxOAMSd9Mve7i5gQll5qndGWVpx/umg+CXxAKGpoNMA
 r3FMkUmVknRLOM40Or9NWwNOL92NSwkHrq/d0ndNeQRTu32uCCDHx2IbSd5VG2b4ul
 nosZAixjCj57nhk32NpeqSVxAJnPk2eny4EB88KTc/gQGnVuXNqo0yWlzvNXSmu4ZF
 mRycl9aLbRnBPpCgKOBrtmqpOvb6P16yZBfRn67Vau0A0Tq2FleVuS/QpC4INaUcg7
 P/ifJQg2MpIKloJneBuh4wLQ19EHMgDmJrDBTumwAHsRVeIkB/VjkEIaNgqi+q08au
 3pae3xKzjvu8Q==
Date: Tue, 11 May 2021 11:37:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <20210511113717.5c8b68f7@coco.lan>
In-Reply-To: <YJmH2irxoRsyNudb@mit.edu>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
 <YJmH2irxoRsyNudb@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1lgOpe-003fVW-Oa
Subject: Re: [f2fs-dev] [PATCH 00/53] Get rid of UTF-8 chars that can be
 mapped as ASCII
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
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, keyrings@vger.kernel.org,
 linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
 linux-ext4@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-sgx@vger.kernel.org, coresight@lists.linaro.org, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-integrity@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RW0gTW9uLCAxMCBNYXkgMjAyMSAxNToyMjowMiAtMDQwMAoiVGhlb2RvcmUgVHMnbyIgPHR5dHNv
QG1pdC5lZHU+IGVzY3JldmV1OgoKPiBPbiBNb24sIE1heSAxMCwgMjAyMSBhdCAwMjo0OTo0NFBN
ICswMTAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6Cj4gPiBPbiBNb24sIDIwMjEtMDUtMTAgYXQg
MTM6NTUgKzAyMDAsIE1hdXJvIENhcnZhbGhvIENoZWhhYiB3cm90ZTogIAo+ID4gPiBUaGlzIHBh
dGNoIHNlcmllcyBpcyBkb2luZyBjb252ZXJzaW9uIG9ubHkgd2hlbiB1c2luZyBBU0NJSSBtYWtl
cwo+ID4gPiBtb3JlIHNlbnNlIHRoYW4gdXNpbmcgVVRGLTguIAo+ID4gPiAKPiA+ID4gU2VlLCBh
IG51bWJlciBvZiBjb252ZXJ0ZWQgZG9jdW1lbnRzIGVuZGVkIHdpdGggd2VpcmQgY2hhcmFjdGVy
cwo+ID4gPiBsaWtlIFpFUk8gV0lEVEggTk8tQlJFQUsgU1BBQ0UgKFUrRkVGRikgY2hhcmFjdGVy
LiBUaGlzIHNwZWNpZmljCj4gPiA+IGNoYXJhY3RlciBkb2Vzbid0IGRvIGFueSBnb29kLgo+ID4g
PiAKPiA+ID4gT3RoZXJzIHVzZSBOTy1CUkVBSyBTUEFDRSAoVStBMCkgaW5zdGVhZCBvZiAweDIw
LiBIYXJtbGVzcywgdW50aWwKPiA+ID4gc29tZW9uZSB0cmllcyB0byB1c2UgZ3JlcFsxXS4gIAo+
ID4gCj4gPiBSZXBsYWNpbmcgdGhvc2UgbWFrZXMgc2Vuc2UuIEJ1dCByZXBsYWNpbmcgZW1kYXNo
ZXMg4oCUIHdoaWNoIGFyZSBhCj4gPiBkaXN0aW5jdCBjaGFyYWN0ZXIgdGhhdCBoYXMgbm8gZGly
ZWN0IHJlcGxhY2VtZW50IGluIEFTQ0lJIGFuZCB3aGljaAo+ID4gcGVvcGxlIGRvICpkZWxpYmVy
YXRlbHkqIHVzZSBpbnN0ZWFkIG9mIGh5cGhlbi1taW51cyDigJQgZG9lcyBub3QuICAKPiAKPiBJ
IHJlZ3VsYXJseSB1c2UgLS0tIGZvciBlbS1kYXNoZXMgYW5kIC0tIGZvciBlbi1kYXNoZXMuICBN
YXJrZG93biB3aWxsCj4gYXV0b21hdGljYWxseSB0cmFuc2xhdGUgMyBBU0NJSSBoeXBlbnMgdG8g
ZW0tZGFzaGVzLCBhbmQgMiBBU0NJSQo+IGh5cGhlbnMgdG8gZW4tZGFzaGVzLiAgSXQncyBtdWNo
LCBtdWNoIGVhc2llciBmb3IgbWUgdG8gdHlwZSAyIG9yIDMKPiBoeXBlbnMgaW50byBteSB0ZXh0
IGVkaXRvciBvZiBjaG9pY2UgdGhhbiB0cnlpbmcgdG8gZW50ZXIgdGhlIFVURi04Cj4gY2hhcmFj
dGVycy4gCgpZZWFoLCB0eXBpbmcgdGhvc2UgVVRGLTggY2hhcnMgYXJlIGEgbG90IGhhcmRlciB0
aGFuIHR5cGluZyAtLSBhbmQgLS0tCm9uIHNldmVyYWwgdGV4dCBlZGl0b3JzIDstKQoKSGVyZSwg
SSBvbmx5IHR5cGUgVVRGLTggY2hhcnMgZm9yIGFjY2VudHMgKG15IFVTLWxheW91dCBrZXlib2Fy
ZHMgYXJlIAphbGwgc2V0IHRvIFVTIGludGVybmF0aW9uYWwsIHNvIHR5cGluZyB0aG9zZSBhcmUg
ZWFzeSkuCgo+IElmIHdlIGNhbiBtYWtlIHNwaGlueCBkbyB0aGlzIHRyYW5zbGF0aW9uLCBtYXli
ZSB0aGF0J3MKPiB0aGUgYmVzdCB3YXkgb2YgZGVhbGluZyB3aXRoIHRoZXNlIHR3byBjaGFyYWN0
ZXJzPwoKU3BoaW54IGFscmVhZHkgZG9lcyB0aGF0IGJ5IGRlZmF1bHRbMV0sIHVzaW5nIHNtYXJ0
cXVvdGVzOgoKCWh0dHBzOi8vZG9jdXRpbHMuc291cmNlZm9yZ2UuaW8vZG9jcy91c2VyL3NtYXJ0
cXVvdGVzLmh0bWwKClRob3NlIGFyZSB0aGUgY29udmVyc2lvbnMgdGhhdCBhcmUgZG9uZSB0aGVy
ZToKCiAgICAgIC0gU3RyYWlnaHQgcXVvdGVzICgiIGFuZCAnKSB0dXJuZWQgaW50byAiY3VybHki
IHF1b3RlIGNoYXJhY3RlcnM7CiAgICAgIC0gZGFzaGVzICgtLSBhbmQgLS0tKSB0dXJuZWQgaW50
byBlbi0gYW5kIGVtLWRhc2ggZW50aXRpZXM7CiAgICAgIC0gdGhyZWUgY29uc2VjdXRpdmUgZG90
cyAoLi4uIG9yIC4gLiAuKSB0dXJuZWQgaW50byBhbiBlbGxpcHNpcyBjaGFyLgoKU28sIHdlIGNh
biBzaW1wbHkgdXNlIHNpbmdsZS9kb3VibGUgY29tbWFzLCBoeXBoZW5zIGFuZCBkb3RzIGZvcgpj
dXJseSBjb21tYXMgYW5kIGVsbGlwc2VzLgoKWzFdIFRoZXJlJ3MgYSB3YXkgdG8gZGlzYWJsZSBp
dCBhdCBjb25mLnB5LCBidXQgYXQgdGhlIEtlcm5lbCB0aGlzIGlzCiAgICBrZXB0IG9uIGl0cyBk
ZWZhdWx0OiB0byBhdXRvbWF0aWNhbGx5IGRvIHN1Y2ggY29udmVyc2lvbnMuIAoKVGhhbmtzLApN
YXVybwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
