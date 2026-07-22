Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DA5C44536
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ImnfLHf1FsGx7Ip7mqNcVwxH2iEpcYYNVjolkCWDfI=; b=Mo4bKT4sYpedRbX4OGJatSeEED
	yiK0vJpXitcWcWy+Hn25Mb+SMfQj92b9RTMbLs0hnnUz3TWDGDUOgLi5h9CbaGp4VL2wqWAYNY+Ue
	56WZ+hm+C/g7vxCgSNBFPQy1fUG//ZYqcledapfFfB1YSUU/RfHYacbMw4OD8A94+Xgk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmYMx-0001kG-G0;
	Wed, 22 Jul 2026 14:56:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wmYMf-0001jz-5y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6xafIqF+VkvI51u4dGgEssdM4xofw9nczv2FUyitWbk=; b=nBayV8DnwdWEtZWSW/lW+N2Kjp
 NO5i4Ie8EpshSss2bjIE89v3JlCsVSWTyPF78p4/HLAFUIASH77oVc/XsQ1pQOvWsUSI6XDcL24Je
 XS78X9V0PTA4XkkYkldOhM6ivDk/thc/KyUukrc1pC4d0Ht4tsPuCJE2ppw+LzHe2Rmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6xafIqF+VkvI51u4dGgEssdM4xofw9nczv2FUyitWbk=; b=Bl52AeDWqPmHHk5wKy1yMhtunG
 rHLs9DpcgkrdPFb4OXL7EpM0W5OxMTHybOMrUGNLBJ/gPcqiKvJgC9BlhhWXOunpbcrz2SCehrqjv
 HeRtxk7F9zhq/qL2QNqF7GUAl4FPPpcD6yUV3J0zwgiOIgTrVQ0Mk6x6EeWSi8ku/jl0=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmYMe-0003N3-LT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:56:05 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-848761b5897so7047155b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 07:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784732159; cv=none;
 d=google.com; s=arc-20260327;
 b=G4Z8oX5MqNbAGAGbL4DdcB9c6FDpaydmPMRKgtzw2m9Pk3bYghTstcPIs4iAi4Aa/+
 jPX74aBJJBGsKb7YABkur4teqMJdATTkeSGmB1pYeeF2YYvOke98QiyWyuUuiUc7udig
 7znrP5OR0v8vOQKFDZI8m7awboyQXteT8tPs6kZsUwBad92Ph987KL7fY1d//5P5BH1K
 boAD5SThHutwTI8V5dJp9/CQQBlI0Y8kP4g0szoHGwG6+aoi48pF6DXPC6hA2QVXIGzF
 wZ4ZBTpdOViek8ud8TfQDfMsQN/vfAYCpBA3KxsuKcP97/mr5dfFF2648tGnwNTZ+sms
 G28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6xafIqF+VkvI51u4dGgEssdM4xofw9nczv2FUyitWbk=;
 fh=/Wsb9Ejsqv+vA7dn5QT3z99EnRa3/UPthoVUmo7DV3A=;
 b=sk0s/hFraXXxPuh8Ce7ABWiA13LCvffAl8pkqDnLJ+IVo7zJxtImcDNe4vWJA+r7pa
 yUZ58mMMcSARsUaq33jnRv5nZ7fE+zmvoT+8NGvOBzZ5X02mQo4gbO0U3DUd6SpseYnR
 cato21+gDB5/4rlGFkaU94LXkGt/mtTSZwLYG/Kq36pKEz9X6BDckhtIAMog9YV2whwX
 C3XcRcnodisQtMyCbaXA7qDaKTJLaSOICOeGuOBqO+cXCzMvt+IrgFdL5Yjq89J/jgNN
 l4Tbdyf66A1uaGSo84qiDFsNNDcBgHxzw6kc2TNiUpeYFMZ77yuyQcg7Rgdims/M+JUL
 KBmA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784732159; x=1785336959; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6xafIqF+VkvI51u4dGgEssdM4xofw9nczv2FUyitWbk=;
 b=i0efoEcmMKVzHGIm2aWbexuSoiGCsWHf+bsoHLGGO4RtIC3YJaqQYyutDEWycXmady
 g2vU80RB8yu1c2M/CBL8BvRw7XrfM+NgNZoKKvPIUdbPazQ1+tyrnHDjId7ZKT0/CHGt
 7DC4rOLj/9tk/MVwthcjGUW9G+9KiBk37pSW0yudzOeJ5uWHbJLd9l9FSc8J6MtuwlbL
 tB/igFFUWxYFBwFeXWecK4djA6RSyZ10WPv7CPNR9EF68vT8gKI8xbHy/6xakO+7O2A+
 U4982dBbeAUfINl8XIapBn1Rz5G4lKSqqbfyKTCMktK1TujcHoUTDk5I4xmzalIbLlsI
 SerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732159; x=1785336959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6xafIqF+VkvI51u4dGgEssdM4xofw9nczv2FUyitWbk=;
 b=lqQmwN7PRE/7Hr6vXUw1lOFArnEDHoMXskfw7gWCaNo97QmLZIEXH58IlzCErzpiQz
 X6WiQzsysLx87ak5Y70H6Vzc43jfnvMuG+KM5fhGPYKONlsbfbCy5l/WWCW6tXhZX2L+
 wND+f4x63kPaSxZDNVM8+vj+O+zQIMMVTtvqbchdf9RQluuZ3Pk8SHlM2d+YrwonnAPy
 L65zXO0mh/lP2MfaJ35dFAPHvg5HLh1rw62oAa/vuC+tzkVKbTOONcBpZM0VfqFxgbfL
 uf6W0GByXHCAphgsyRW0/mfQsdtqR9gDjvVsQaJAFtQ7MAWAY0X8nKWf92QZ9g0HrnZW
 8yQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLaSZGGQbDvbY7bfVcTA5xAhlSo4T46/7//m34ep+3skiWySCzTIYAm2aTYYI1wE+cdcjdQSvIr91sazq/kmL5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyyL2JPNSIXlKMCrLpr6909zH5hQLBuYkAJJQZyJOHM3/4jkoe3
 SiJknYKJ/hZBpjoD3BqYNQIXh+cYq8cm838AZCl3zlU77kMbP3Guam/7+EzUmwjqdRjgMoVwzgT
 rStMrFNeZzjgDkxFinFjDIqXFRTHSLDRd7Q==
X-Gm-Gg: AR+sD13dEdaDK5mzh5/4B2CBV+ZhPbpW7P+EAN9s1rrjthZOaO5CBj0dAkLJJS7ZuoQ
 FvxkhZDJVdMmssiyUqUF2c19Gkl+G4rC9+L+e2Kx5DylnTJw12uRgL+xej6OFYKWvOe/q/EFM6B
 Fpjqa6CXrEHb7OvnYerMv/nx6dPcUUTVjotH/C//M27bou5fiC0Qy8tBrnU0fmoTr8col+nNStG
 USoDH5sqb8jVArT0UqlHl/iO+FKadIP2dXsmAHXBBNyNUY7Bwk7taVFWTvaERyCgh1XJ9vOTF3C
 9ZB3zXBT1IGo2vsCGbcPEMQUGeIsyhitxOkFiNhsFZsf2kIHo1vFNaK0Lna1
X-Received: by 2002:a05:6a00:4215:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-84c294d135fmr24317696b3a.41.1784732158760; Wed, 22 Jul 2026
 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260721164752.3853201-1-daeho43@gmail.com>
 <c9907593-4521-4ad9-9c11-394b3012998e@acm.org>
In-Reply-To: <c9907593-4521-4ad9-9c11-394b3012998e@acm.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 22 Jul 2026 07:55:44 -0700
X-Gm-Features: AUfX_mzFht96j37X69PN6FtPAvRF51CpEHquyOUI4vPf02k9uV3dfoP1luAryGs
Message-ID: <CACOAw_wVAxNO+p54LhSj473FbNvp3EHuQY2pFz45nTGU5353AA@mail.gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
X-Headers-End: 1wmYMe-0003N3-LT
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: flush device buffer before zone
 transition on zoned storage
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBKdWwgMjIsIDIwMjYgYXQgNjo1MeKAr0FNIEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFz
c2NoZUBhY20ub3JnPiB3cm90ZToKPgo+IE9uIDcvMjEvMjYgOTo0NyBBTSwgRGFlaG8gSmVvbmcg
d3JvdGU6Cj4gPiBPbiB6b25lZCBzdG9yYWdlIGRldmljZXMgKEYyRlNfWk9ORURfSE0pLCBmc2Nr
LmYyZnMgb3BlbnMgYmxvY2sgZGV2aWNlcwo+ID4gd2l0aCBidWZmZXJlZCBJL08gKE9fUkRXUiku
IFdoZW4gYSBjdXJzZWcgZmlsbHMgdXAgaXRzIGN1cnJlbnQgem9uZSBhbmQKPiA+IG1vdmVzIHRv
IGEgbmV3IHpvbmUgaW4gZmluZF9uZXh0X2ZyZWVfYmxvY2soKSwgcGVuZGluZyBidWZmZXJlZCB3
cml0ZXMKPiA+IHRvIHRoZSBwcmV2aW91cyB6b25lIG1heSBzdGlsbCByZXNpZGUgaW4gdGhlIE9T
IHBhZ2UgY2FjaGUgLyBJL08gcXVldWUuCj4gPgo+ID4gQXMgYSByZXN1bHQsIGlzc3VpbmcgYSB3
cml0ZSB0byB0aGUgbmV3bHkgYWxsb2NhdGVkIHpvbmUgY2FuIGhhcHBlbiBiZWZvcmUKPiA+IHRo
ZSBkZXZpY2UgaGFyZHdhcmUgZmluaXNoZXMgY29tbWl0dGluZyBhbGwgYmxvY2tzIG9mIHRoZSBw
cmV2aW91cyB6b25lLAo+ID4gY2F1c2luZyB0aGUgaGFyZHdhcmUgdG8gc2VlIGFuIGFkZGl0aW9u
YWwgb3BlbiB6b25lIHJlcXVlc3QgdGhhdCBleGNlZWRzCj4gPiB0aGUgZGV2aWNlJ3MgbWF4IG9w
ZW4gem9uZSBsaW1pdCAoZS5nLiBvcGVuIHpvbmVzIGV4Y2VlZGVkIGVycm9yKS4KPiA+Cj4gPiBG
aXggdGhpcyBieSBjYWxsaW5nIGYyZnNfZnN5bmNfZGV2aWNlKCkgcmlnaHQgYmVmb3JlIGFsbG9j
YXRpbmcgYSBuZXcgem9uZQo+ID4gd2hlbiBjcm9zc2luZyB6b25lIGJvdW5kYXJpZXMgKCEoc2Vn
bm8gJSBzZWdzX3Blcl96b25lKSkuIFRoaXMgZmx1c2hlcwo+ID4gYWxsIHBlbmRpbmcgd3JpdGVz
IHRvIHBoeXNpY2FsIG1lZGlhLCBlbnN1cmluZyB0aGUgZGV2aWNlIGhhcmR3YXJlCj4gPiBhdXRv
LWNsb3NlcyAoRlVMTCkgdGhlIHByZXZpb3VzIHpvbmUgYmVmb3JlIG9wZW5pbmcgdGhlIG5ldyB6
b25lLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2ds
ZS5jb20+Cj4gPiAtLS0KPiA+ICAgZnNjay9tb3VudC5jIHwgMyArKysKPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mc2NrL21vdW50LmMg
Yi9mc2NrL21vdW50LmMKPiA+IGluZGV4IDZmNjQwYTAuLjNiZDQwZmUgMTAwNjQ0Cj4gPiAtLS0g
YS9mc2NrL21vdW50LmMKPiA+ICsrKyBiL2ZzY2svbW91bnQuYwo+ID4gQEAgLTMwNzMsNiArMzA3
Myw5IEBAIGludCBmaW5kX25leHRfZnJlZV9ibG9jayhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmks
IHU2NCAqdG8sIGludCBsZWZ0LAo+ID4gICAgICAgICAgICAgICAgICAgICAgIGlmICghKHNlZ25v
ICUgc2Vnc19wZXJfem9uZSkpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2
NCBuZXdfYmxrYWRkciA9IFNNX0koc2JpKS0+bWFpbl9ibGthZGRyOwo+ID4KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChjLnpvbmVkX21vZGVsID09IEYyRlNfWk9ORURfSE0p
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYyZnNfZnN5bmNfZGV2
aWNlKCk7Cj4gPiArCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBmaW5k
X25leHRfZnJlZV9ibG9jayhzYmksICZuZXdfYmxrYWRkciwgMCwKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3YW50X3R5cGUsIHRydWUpOwo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkKPgo+IFdpbGwgdGhpcyBjaGFuZ2Ug
bWFrZSBhIGRpZmZlcmVuY2Ugb24gQW5kcm9pZCBiZWNhdXNlIHRoZSBBbmRyb2lkCj4gZjJmcy10
b29scyBhbHJlYWR5IHVzZSBPX0RTWU5DIHdoZW4gb3BlbmluZyBhIHpvbmVkIGJsb2NrIGRldmlj
ZT8KPiAgRnJvbSBsaWIvbGliZjJmcy5jOgo+Cj4gICAgICAgICAgICAgICAgICBpZiAoZGV2LT56
b25lZF9tb2RlbCA9PSBGMkZTX1pPTkVEX0hNKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBm
bGFncyB8PSBPX0RTWU5DOwo+Cj4gU2VlIGFsc28gY29tbWl0IDEwZGFkNWVkN2NlMSAoImYyZnMt
dG9vbHM6IHN1cHBvcnQgem9uZWQgdWZzIGRldmljZXMiKS4KCk9vcHMsIHdlIGFscmVhZHkgaGF2
ZSB0aGlzIHBhdGNoIHVwc3RyZWFtLgpQbHosIGlnbm9yZSB0aGlzIHBhdGNoLgoKQmFydCwgdGhh
bmtzIGZvciBsZXR0aW5nIG1lIGtub3cgdGhpcy4KCj4KPiBUaGFua3MsCj4KPiBCYXJ0Lgo+CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
