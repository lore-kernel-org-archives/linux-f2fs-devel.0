Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49729C9830B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjLJZIckciorhLJdoijvwUBdjXuA9pBasivulFVEwkA=; b=ZjBSc7VjcYj3hHgP1wQYiq9KEG
	V0cS4h0CSBTEYD/MTuDMU4/dtkty1Qgp3IcER9GXptsVMtbm0XFxxxg9mv2FdDgpbNCPoghU5ZUjC
	4uPAqoNEeN/SZcRqXJq2GLEuFTOMtp7D+Hs0VXFjgl0TK0TJuGnn2pL+eITlhGRZY8u8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9OGE-0007br-0i;
	Wed, 23 Sep 2026 14:47:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x9OGC-0007bi-Q0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JTv12VjlWd/fM2UOXaeCrJq7LtsXJinUmfk2XRxDwh0=; b=SseYwTsKF2ynckoeA+rsWI+Ke0
 UeZGGNDmIVNqPyNI0ra25H5gvOBs3e8WIf/aIDYVIxnc9YpxMejuXUAA+jnj857b8tWbvYpwyMtca
 NvFSlKwM5TP0dD8Ypf+H6To0ZItVqw61QRx6BZD70h1Nyvq6Adc0PU/bH5+6++M2hCuI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JTv12VjlWd/fM2UOXaeCrJq7LtsXJinUmfk2XRxDwh0=; b=EWy2rMteYIPYPtZ0SO487w1THj
 DMB3v7epaDFYXoI+ELoqAN0hCgZWcSCjlVz01ldppvfi4NwFflUzJ6ZpAWcdWhzwNK+Ma9iT66m87
 Nhba6MzFld2VlQAJni3Tmvuqtn32SP9VG/D0VLSKRMMwt6TQ8pH/rFLFZkCtL/4/F1zc=;
Received: from mail-lj1-f181.google.com ([209.85.208.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9OGB-0003sJ-8t for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:47:48 +0000
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-3a20f06cce6so10338491fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 07:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790174860; cv=none;
 d=google.com; s=arc-20260327;
 b=mMfPtA3Axhj2XrOm6XYUrrkp0iSyFRqXk/OLNakGh6DT7ntv5gMVy1O5wbX3dfltG0
 Au2QgBbwQjHfOZGrTW7srHdMqvu/55mK+RpqWnSOFCnaq9cnh14thV9ZPBm/Np3yn3Zs
 yGkSm5zMBeqbrmcAHqi25FaTJORrChRdtbXYi1jxzQlcPPh9QDy7QnPSEIZ74DLuMUpD
 RuxEH7PZcUDZU8XRnlTSaLPcaE4PWuFp/taJeMmns/FIQ1a5XhW5ec+2tS/MwQC4ijIE
 gAR/c8uAYOIYDCLg+E5kCrqbV96bo3Iu+cOkwtE4JUbbKOyQSuk07edPH+HFwV7/i22A
 h/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JTv12VjlWd/fM2UOXaeCrJq7LtsXJinUmfk2XRxDwh0=;
 fh=hQFEQpep//8tR6kBD6c9MPckDVQTvrMgbveML8q5m60=;
 b=PIAFrVvEhUJqlKWBPtj0MRquYYdOOzmg3thsl6mh5UjWx6SG5Nr7PZ+GHvUaMYQv+i
 3AufMEH59YGzAud8cXcbB/ViDNBCbtlsS+3bEf9qtsiMazhHHRDYhD5VSKrJRWgx3LA/
 +L7o/83VLOlGqVEumc/2Wp/aZleGmAoS2vRyI89uxMDwSxNXFhyVvISYQr0qKfqyD3w5
 2zPCa1/3w0LkNPspWoA5CZdo39k2WxHIie4JVHlxbiflMa1d9xN196XYoKfdnlDF5HGU
 KMjK9pp+yx7A9bveBMqBL7FEtZ2zxMY/CAKMA0KlVuKwWe0+owcDZxbgjzPZE/rL1GMH
 CYrg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790174860; x=1790779660; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JTv12VjlWd/fM2UOXaeCrJq7LtsXJinUmfk2XRxDwh0=;
 b=VZmoYsrEA6eByNctySltbwFBV5pgV+9iS5c5pQiViOp1bymyYvzZXFvHtvqlBsI6GK
 GJChSexhBcORFCpFuLz7TZm1/TS9CMrjdDY1gDVkBaSWm7yvTVD+VOdMydJ/Z6SCTHA4
 nvdeYBI/ue0GegcggrJZlmWSZrSjBDlkxH+sdv53mbPepe3cfYhJUZHiaJWfb3iLBwmi
 YF0VkD9EYnt8LKSPfqbnQmVXSKIjRK3MXJeFxsQ/5IUWzUsUt8LwkGzFeoQPp/hF8n1H
 Kv1TK6YwcwThZxnADdG5pJWAUTABPmSoYMIpn5xfy4ZN5dbaP7AsMOftMgJHKd+jtIvZ
 P80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174860; x=1790779660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JTv12VjlWd/fM2UOXaeCrJq7LtsXJinUmfk2XRxDwh0=;
 b=X9nu39QWOn0s8hBoynvjdozyTiqGMCZnleW3i6k+V+8qX2FHlvLBxj1Rcjft8M8cf0
 w+WE1mQn6dK4dvYdHqlGoRHzNJJI1mpxKLTiTCSIvlJ2umDiXUDYBHYlsfutbMZUENGN
 /jJLzNRlkbqnYRspUcUBo5vFXI+8UeAzzFYmyoqJzibA+vBRP5Cfh2sA7xQjK0uVcorB
 VxC5eIeLj3fU6qQPqJRzraR2yCRJnKQWIdtpN1io3+R6C9QcMGQilwxnW1fF/qlyTiTL
 WoKG/fIhep99pAdVcoopv6SPCEiptVM2wQcgAxkxhMugYrZgfHOEXyMOENasE7LuI236
 bULg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4o3bUPMw5RcJiPi1CYI+Vv5oPgMIVZmATtMIP24Fur00sbCUG70qwaMbQQw7SzJAh/w66RctSKaOIamjsva2C@lists.sourceforge.net
X-Gm-Message-State: AFuF++mU9Rq0uGtb+4i3PWSdMZIs1TdoF60sUpLIu9NHvyJcemFQ1l1a
 PBNBDsI4K5bUKZxIohFQVR0s7U/i0HxepEKTjf9GEbewXugHF9VU3Bq1ldubYbhId8nXqJrKM1X
 M7Oi4iqU39PFZQFjJIU4P3c0ZGeKFKAU=
X-Gm-Gg: AYBFou1soZY+Nnm9fc6LN24RAOAfqsVTSDfCzhXlOKequZBTmIVHKZAcmPseRBYE6vb
 qY9gSxa1Hi8vmpsoXOp0HuINPQ2M4MdqrbCyXZYWbOFW0BOp6F4gKOt/NkWuT+uMkHJ0ysmiNEU
 av7gQabtcSSNykAfaNTy3EIV+HC1wKOF1Y7bc7S/wLL23OKCAs472ca0XxNIOXtmVGVSBBxDRuJ
 KEth3qu32UdJu+7dkGPK+wArq8KNyjG0fiMgwsL/Bu8uGH2HRywz7G59Ezco+HQ23mkEDClgIt1
 61iit3b5L6+L3RZClNZwR94n30Z1w+BpEZNH0gyu4fg4OyC45oqfFJEXVspemVXY1Vacp9hpzot
 AqhCtWxBBeoAt+K5H3ctMAJi185TuwbLApZVmBsgF4W8=
X-Received: by 2002:a05:651c:a152:b0:3a6:32a5:efa5 with SMTP id
 38308e7fff4ca-3a632a6001amr4974541fa.23.1790174860068; Wed, 23 Sep 2026
 07:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260916060610.1098289-1-ke.li11@transsion.com>
 <20260923091913.1152395-1-ke.li11@transsion.com>
 <CACOAw_yuWVYFDktwFdjTVV8ZmspUJ41TVp=YW4Z4Vajj4oMoXQ@mail.gmail.com>
In-Reply-To: <CACOAw_yuWVYFDktwFdjTVV8ZmspUJ41TVp=YW4Z4Vajj4oMoXQ@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 23 Sep 2026 07:47:28 -0700
X-Gm-Features: AclHuK-DuPy-4eDK1-NIyO4R7A_qTPAG-L9R2WVyZ-xqz7MHFTZxQ2BjtJahZjQ
Message-ID: <CACOAw_xP_xNt8km5rxEC1-eiBpm83AK6=m+p_N5GK7H+Djj68A@mail.gmail.com>
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
X-Headers-End: 1x9OGB-0003sJ-8t
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

UGx1cywgeW91IGNhbiBjb25zaWRlciBkeW5hbWljIGRldmljZSBhbGlhc2luZywgdG9vLgoKVGhh
bmtzLAoKT24gV2VkLCBTZXAgMjMsIDIwMjYgYXQgNzo0MuKAr0FNIERhZWhvIEplb25nIDxkYWVo
bzQzQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBLZSBMaSwKPgo+IEluIG15IG9waW5pb24sIGNv
bnRpbnVhbGx5IGFkZGluZyBzaW1pbGFyIHNvbHV0aW9ucyB0byBzb2x2ZSB0aGUgc2FtZQo+IHBy
b2JsZW0gd2l0aGluIGEgc2luZ2xlIGZpbGVzeXN0ZW0gb25seSBpbmNyZWFzZXMgY29tcGxleGl0
eSwgd2hpY2ggSQo+IGRvbid0IHRoaW5rIGlzIGRlc2lyYWJsZS4KPgo+IFRoYW5rcywKPgo+IE9u
IFdlZCwgU2VwIDIzLCAyMDI2IGF0IDI6MjDigK9BTSDmnY7nj4IxMSA8a2UubGkxMUB0cmFuc3Np
b24uY29tPiB3cm90ZToKPiA+Cj4gPiBIaSBEYWVobywKPiA+Cj4gPiBHZW50bGUgcGluZyBvbiBt
eSBwcmV2aW91cyByZXBseSBhYm91dCBkbS1saW5lYXIuCj4gPgo+ID4gV2Ugc3RpbGwgaG9wZSB0
aGlzIHNlcmllcyBjYW4gYmUgcmV2aWV3ZWQgYXMgYSBuYXRpdmUgbXVsdGktZGV2aWNlCj4gPiBj
aGFuZ2UuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgZXh0cmEgZGV0YWlsLgo+
ID4KPiA+IFRoYW5rcywKPiA+IEtlIExpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
