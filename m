Return-Path: <SRS0=actn=GI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE1C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Jan 2021 02:11:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DA722515;
	Tue,  5 Jan 2021 02:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DA722515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kwboj-0003yp-Q8; Tue, 05 Jan 2021 02:11:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kwboi-0003yh-Eu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 02:11:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=; b=CAyXWWxYjn3s0udhZuOa6FVKgk
 oRi49e9aB2AAr6/7A4OO/fW5p5++wjFd7bONuKij7eWTVgfoPsZgDy3pAZfyY4tL3VxB26lHFV/1T
 7Pr2CjMDI2wbUgGC7UCgJDjg7faT7/u3pkmc3jX0Mp4qLgwLzLahihhHx6a8jbL5cwBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=; b=DZAj2bUbjJR2R+C3qQzDuua3EN
 pAjOTr5U1wRpM4AH8ymtNd6wevs9GfQ69oEPsfrSFvzqs+jiWG3tou74f/JB9NAtp+1Tpq6SH6vxp
 BO+yqfgFH18LunqXvsgImGLkb7eHzQFlJtDV9AyVv8fP/MaLWOmWWlI+4iOj2eSTqnPQ=;
Received: from mail-lf1-f45.google.com ([209.85.167.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kwbob-00E7aw-2g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 02:11:24 +0000
Received: by mail-lf1-f45.google.com with SMTP id s26so69067848lfc.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 Jan 2021 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=;
 b=KuiRw5MSAIV5E+dfU2gQh0nJQ/BcNavLGP0fp5zUxbN9wSHOJUh/CK1yjJl7o5Ngi4
 T5YEmBTpaqFXj1yqLONJFiZ3dOuSuwn214NQtvBigLfC77Mvca3wqUCz95jLJxoL8vN6
 cU2T2jKBOeQpUloEHASD3AcGdwSEktv9a8OjmJlMp+kU4sFE/ks+TyDSXmd1vI1dUkd3
 +P128iDhjrXulpKgt1P1Rrk6BQElMmAuVvKhq/pT9CJiBXTMdjBSr56z9NALEEMKzvkk
 vsevEOO6lQjkXtdhCChOZJKcnRDCLH0wI+pJTX9dP0I4AoRwZPxknUJkvdPShTjBoY1v
 oiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fKci/xz7+6EpLcrUh49o1pJib0PXFbl6FrFEVFhmoL4=;
 b=Adkn9VRkdERC8KO5xq+ILaDTGG/MFzCBSbQVASSCB1mDlFlml/14YeAzMCQctKN/Zj
 nXTez8uksrf5TyovjpY5LXGcUgD3lV2HyJr5qANnEhxf1lM6Bq5rE+r7uK79QstvaVGM
 D2177t5rqoFXYrL2q8b+9eUaoDvd/Y1No8VT4jWsRznbPOIsQu2LChG3oD1XQzyHeNZA
 XXzb4rPpP22vOIh7mQbPx8P9NrrUAwURoJLO7nS8tpfYAsOmNr5ZFUI8y7Awru2jUdbT
 2URj9hqAVk4PcIZFhx8/sDMkLuAXFgC3E/rIOoGP2LMMVTZ5PcUCfqhUSB0akT6nfFa2
 +YXA==
X-Gm-Message-State: AOAM53292b/GoGnPgEyeOfPguEumtSYyr+9F5BzepdI40b2pCJDlLlPO
 692B5b7O5ZWWk3wibTzM30PO584bwsLk1txFMq0=
X-Google-Smtp-Source: ABdhPJzWJPWHizgOtsAUHajKlFTA/eA3J1t8aINbOPMSKBLeW58KxBH7kSquVLIIt9111/dxA9sXvdxOZufoiqkkFQo=
X-Received: by 2002:a2e:9bd6:: with SMTP id w22mr35513731ljj.335.1609812670485; 
 Mon, 04 Jan 2021 18:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20210105012826.956800-1-daeho43@gmail.com>
 <904b7677-3655-2e81-52e0-48296cf1c0da@huawei.com>
In-Reply-To: <904b7677-3655-2e81-52e0-48296cf1c0da@huawei.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 5 Jan 2021 11:10:59 +0900
Message-ID: <CACOAw_xf9CFOSvU=s1yP4O74dropdc-ozcDOPhmCpBU3Oif4Bw@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1kwbob-00E7aw-2g
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null page reference in
 redirty_blocks
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
Cc: Colin Ian King <colin.king@canonical.com>,
 Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

WWVzLCBpdCdzIGJldHRlcn4gOikKCjIwMjHrhYQgMeyblCA17J28ICjtmZQpIOyYpOyghCAxMDo0
NCwgQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPuuLmOydtCDsnpHshLE6Cj4KPiBPbiAyMDIx
LzEvNSA5OjI4LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEZyb206IERhZWhvIEplb25nIDxkYWVo
b2plb25nQGdvb2dsZS5jb20+Cj4gPgo+ID4gRml4ZWQgbnVsbCBwYWdlIHJlZmVyZW5jZSB3aGVu
IGZpbmRfbG9ja19wYWdlKCkgZmFpbHMgaW4KPiA+IHJlZGlydHlfYmxvY2tzKCkuCj4gPgo+ID4g
U2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+IFJl
cG9ydGVkLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgo+ID4g
Rml4ZXM6IDVmZGIzMjJmZjJjMiAoImYyZnM6IGFkZCBGMkZTX0lPQ19ERUNPTVBSRVNTX0ZJTEUg
YW5kIEYyRlNfSU9DX0NPTVBSRVNTX0ZJTEUiKQo+ID4gLS0tCj4gPiAgIGZzL2YyZnMvZmlsZS5j
IHwgNCArKystCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUu
Ywo+ID4gaW5kZXggOWU1Mjc1NzE2YmU4Li5iZjY2ODJhNTI0MzMgMTAwNjQ0Cj4gPiAtLS0gYS9m
cy9mMmZzL2ZpbGUuYwo+ID4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiA+IEBAIC00MDYwLDggKzQw
NjAsMTAgQEAgc3RhdGljIGludCByZWRpcnR5X2Jsb2NrcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBw
Z29mZl90IHBhZ2VfaWR4LCBpbnQgbGVuKQo+ID4KPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBw
YWdlX2xlbjsgaSsrLCByZWRpcnR5X2lkeCsrKSB7Cj4gPiAgICAgICAgICAgICAgIHBhZ2UgPSBm
aW5kX2xvY2tfcGFnZShtYXBwaW5nLCByZWRpcnR5X2lkeCk7Cj4gPiAtICAgICAgICAgICAgIGlm
ICghcGFnZSkKPiA+ICsgICAgICAgICAgICAgaWYgKCFwYWdlKSB7Cj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gLUVOT0VOVDsKPgo+IHJldCA9IC1FTk9NRU07Cj4KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKPgo+IEhvdyBhYm91dCBicmVha2luZyB0aGUgbG9vcCBm
b3Igb3V0LW9mLW1lbW9yeSBjYXNlLCBiZWNhdXNlIGluIHN1Y2ggY29uZGl0aW9uCj4gd2UgaGF2
ZSBsZXNzIGNoYW5jZSB0byBkaXJ0eSB3aG9sZSBjbHVzdGVyIGR1ZSB0byBubyBtZW1vcnksIGFu
ZCBjb250aW51ZSB0bwo+IGFsbG9jYXRlIHBhZ2VzIGZvciB0YXJnZXQgZmlsZSB3aWxsIG1ha2Ug
c3lzdGVtIHN1ZmZlciBtb3JlIG1lbW9yeSBwcmVzc3VyZSwKPiBpdCB3aWxsIG1ha2UgbWFueSB0
aGluZyBzbG93ZXIuCj4KPiBUaG5ha3MsCj4KPiA+ICsgICAgICAgICAgICAgfQo+ID4gICAgICAg
ICAgICAgICBzZXRfcGFnZV9kaXJ0eShwYWdlKTsKPiA+ICAgICAgICAgICAgICAgZjJmc19wdXRf
cGFnZShwYWdlLCAxKTsKPiA+ICAgICAgICAgICAgICAgZjJmc19wdXRfcGFnZShwYWdlLCAwKTsK
PiA+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
