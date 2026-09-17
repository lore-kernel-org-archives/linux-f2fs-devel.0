Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22051C982C1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7nJG1cVnMu5cNI+85J7N2tYmNgAHOPTwDqGveEw9DE=; b=iPA3JGbB/IKkr+vY2sW02tTmEY
	rzTc6XfhKp6TaGIgDkjW5ArPMlXH2lnFXy42wUoqnLPAJ/HH94bfjHPfl2WSM4QfjMMTZC/fALB+d
	D74+2eOqD70cHAdx7l9np+sE92xOr8pxaEf3GfE6eTGlL5yFQ00z6kg34oMpGtf6Cg/o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x756R-0003gy-Q2;
	Thu, 17 Sep 2026 05:56:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x756D-0003gb-OD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 05:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2JDpDvxbkVszK8qUg2bwR78mCh70sLOIElXLTKIW20=; b=DfW8suiJ0bYcXtVSa9QlMsorud
 NJBr+b+PxTj1BOyNOMW1azAccXFGWBemJ93ssoQCf0YhpMpybWz95AxuEWvV+fvU8ytyl/qOadujQ
 O8ip8YZX4ayVt85S1dsc71H/sfosDxR9ltTfKx8BBXX4KU83pbYdobKc+ClMV4UpDQLg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C2JDpDvxbkVszK8qUg2bwR78mCh70sLOIElXLTKIW20=; b=PxYSYmkMxEzfqtm8SChx+hjdIc
 FcxotHSbH1DPXojB35PEZilwokQRiAp1ajaOkFCpBuOUFfi6o5ZBdQui0vjz6iGk879H9ME6FZB9X
 hhF1uqvP5fEoBKcnOswrnVLdJEb23LZSaDhRB192Lb8WvL6gbUWT42qs84iwbxGhjdDM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x756C-0005dM-D8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 05:55:57 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485843116d2so58148f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 22:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789624550; cv=none;
 d=google.com; s=arc-20260327;
 b=EOQo09upOGnipXAEdgNN/oFYfXKNQRLGSGduh66nT+egMBTihWnFYbNC/x+WMv6t9W
 xnFcfRgn/KtoiD0p3Kq6XSUpApOg5D0fqM4BEYY8ssf+OqrXNAdskDY2k7IZnJBoFSDV
 pPobyvi6GBVq5P5rcEwucFMMd/Q/tXo9feIfp2pYxzHxxcuNrwQoEy4ZDXts+PSdgXEe
 qCttOTN7y55N5gJjcGmTidqpm543I1SRBTxgcUkcXkXmtW5hHS7PKl409knoKXkETim5
 Qm1KwaFPa34xA4wNgMP5F3GUQ7DubrtirtBQBiY94W6TvRVr43CkXE4spxUtfVW0kr/E
 pqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C2JDpDvxbkVszK8qUg2bwR78mCh70sLOIElXLTKIW20=;
 fh=daDYseHvSBFxvRwn05+cATqs2jeGouAs1C4/3r8SgTQ=;
 b=QsGsqi0bidtGhXaX9F/0C3uwQtQGVQ5vVTzXhlHTGKncb/CRSfNwv4N472L8U/fm71
 gzKwxUvUGZ/g04nyh/+ZKOjz9f7nnPLfZRhgui0DYF0VFiT7L/gXVZMb07bpDG6JYfR5
 cShhUlEDpgs8dp5roeP9RFjyp2wdBPbhL/HTWDiQW96SYS+h0/unM5SCq/fOgWSsH1Py
 5kMSJgc1faUPvJwBCBuJVsJGghZ5EvTNC4Je8bW57Zf3to8XUZ4KGSzAmpVp9B/z6tIK
 CJdvlDNziGAfgFq74fSgzjx4W1O/okNdOeuQLL1hnpcqpvd2Dk/XO04A4BFMdK6vAiXg
 D/qg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789624550; x=1790229350; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C2JDpDvxbkVszK8qUg2bwR78mCh70sLOIElXLTKIW20=;
 b=GgLHq3D54KtNKGiiS6iJ33Jj38VJIV1TQoYux+GIePNzZ00f09/c+SZj0K+hnrS3Wa
 IAX2j4+hqvSzotYpu0IsAKHpCTapppg1h+d0zpXXlXDdsTisae8XMqjuurxOcZv7W7No
 MJ8m6Z/fiu0pe7YFm/vxapB6cIaH+GGkQRX6pd1zfPtdFzZSp7O1Sr+vW15TxhnSuiB6
 gwGg5INwFVb1XE+xsrP+STr/i9VI0gA2IU4S/h9QSKnTc634KQELCwf1IDmRgXRkksXM
 yGEe5p/GSG6aHEFXVpVrlmaLjSZZ1hUV7i7WemCA6yCc9tB5JoOCNtIyqiMrk5kHNfAf
 bb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789624550; x=1790229350;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C2JDpDvxbkVszK8qUg2bwR78mCh70sLOIElXLTKIW20=;
 b=kAuvt10TDwTiAEXbrTpUlW27E41+GlXO7jfZ4wVX/XbMfNBTaxYg0KnFQ1lccBNbId
 C+AXfG3+8w8AlxPU88otkbvDGcxSxb7Z3Ocm0JahbqEGPN9atQ+h8HiK9a5lggmJp+oq
 53NafJey+M66Gpqj/5VoJO2TpuXUHnqaG0oPNI3kIQAhfgZ/l23rj2nLdOlJkN46KC4m
 oZVYCzv5YWWOg9KQ3SRa3DwQd/2zmrU2OUBApPxK93cGuBSsrBosbKNzXwkcG/vTn4bm
 +2QAqjRaEzt4q7yD/78F2L93BZDm8/oa/LKrG9MlsGOVem8hl4JQrhCHP1bJT7OQHyRq
 5bQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByAYEIe6Us98cWRK1s9fq4M8Na42QjqSF8GRHCr/49aMZeI4dWbyCN6o2b/wGHhA12JJi0zDQW5HPLjrcHF3/jY@lists.sourceforge.net
X-Gm-Message-State: AFuF++kDQzoV1Vty3k0VIkoPqw673mPTQhqExdo4D1PkvSLLEdK0r8O0
 czWK3XbHzi6El2/OsrQJtRPQhgoETpMG6rQIxHr/M+PRHeS7N0bBWH+9BJyhIZwi8e+15787QuO
 PCA1iuZFanV5+xf9qseFeJdheSTlO7JBJGA==
X-Gm-Gg: AYBFou0zyWyrwA2QLcyp9cLRPPHtfSHqDEF9aqbPVHLeJCP7jjNGWAbYMcvbEiihpa1
 bfZlJtKUGguAUOY0Bs2g2r3DskulrbrclBgkOyoUTLahILblRNQ0qKTNRrDHPNlk77RFh6Z76h3
 WJRoNZqLj7856u1cPXBBZBOrpladOiTh4vPMdmUNV+Ty2PzOLCaBBBqI7mAN8IXJQa9Xg8C1WD7
 qGLOgwbQrFOYBdrCHOfgMTsvCtNhLp3x3lQVTd7hPKoyfELK94PghpAObWG/TBL4/2uve8jFkMn
 qN78FWtS2r57wJJF4UvnpIdAtf5TS6AZodtWQCk5/rUj/MBxsak95Ho6
X-Received: by 2002:a05:6000:480b:b0:486:e596:1253 with SMTP id
 ffacd0b85a97d-4870d0541dcmr6003777f8f.3.1789624549699; Wed, 16 Sep 2026
 22:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260916015440.2232938-1-chao@kernel.org>
 <20260916015440.2232938-8-chao@kernel.org>
 <CAHJ8P3+0jVMFp3YTse8fbUTSp+jjW+2czxp0NuD__sHG_7UNXQ@mail.gmail.com>
 <94731ef5-4c1b-4aed-9a03-ab63a4fc8a7c@kernel.org>
In-Reply-To: <94731ef5-4c1b-4aed-9a03-ab63a4fc8a7c@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 17 Sep 2026 13:55:13 +0800
X-Gm-Features: AcwNN1VguL-2228RZ6OpwQGLHkDRN7vvPudMJHrjoULo_3Tj7FNh3X8HxFnEdVo
Message-ID: <CAHJ8P3JTqtxKOr90B0fR6dFyNgPA6dAgPOxFNYtKpFP=nVWJNg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x756C-0005dM-D8
Subject: Re: [f2fs-dev] [PATCH v8 07/12] f2fs: cache: use node cache
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

Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiDkuo4yMDI25bm0OeaciDE35pel5ZGo5ZubIDEwOjU1
5YaZ6YGT77yaCj4KPiBPbiA5LzE2LzI2IDE3OjE1LCBaaGlndW8gTml1IHdyb3RlOgo+ID4+ICBz
dGF0aWMgdm9pZCBfX3N1Ym1pdF9tZXJnZWRfd3JpdGVfY29uZChzdHJ1Y3QgZjJmc19zYl9pbmZv
ICpzYmksCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3QgZm9saW8gKmZvbGlvLAo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbmlkX3QgaW5vLCBlbnVtIHBhZ2VfdHlwZSB0eXBlLCBib29sIHdyaXRlYmFjaykK
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgd3JpdGViYWNrKQo+ID4g
SGkgQ2hhbywKPiA+IHNlZW1zIHRoaXMgZnVuY3Rpb24ganVzdCBvbmx5IGhhbmRsZSBEQVRBIHR5
cGUgbm93LCBzbyBjYW4gd2UgcmVuYW1lCj4gPiBpdCB4eHhfZGF0YV94eHggZm9yIGVhc3kgcmVh
ZGluZz8KPgo+IFpoaWd1bywKPgo+IEkgcmVuYW1lIGl0IHRvIF9fc3VibWl0X21lcmdlZF9kYXRh
X3dyaXRlX2NvbmQoKSBmb3IgcmVhZGFiaWxpdHkuCkhpIENoYW8sCkl0IGlzIGdvb2QgdG8gbWUu
ClRoYW5rcyEKPgo+IFRoYW5rcywKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
