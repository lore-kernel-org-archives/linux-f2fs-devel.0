Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1273FC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 21:55:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rAGub-0000dv-Mb;
	Mon, 04 Dec 2023 21:55:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rAGuY-0000dj-Ss
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 21:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RFIOo+aY5DbYFQEHnkq3VuNDJzyjrDzXbzi8Vu3S/WM=; b=gjPR5JeBgxRSKhK1R+Zz5cPxW+
 qxpz6mZPMBFDeXWAYZxRxfn1ycuRaRCuWXkK9wU34SFcJzrcEYEON2vOjIPzhYJb2BHtIumxxHrEO
 fBgEw5XLLWpUUpYdx7+b79KD6JysJ4zLZi/TT65hXQaUHdynnewo0PhthH2IFmc1w5Wg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RFIOo+aY5DbYFQEHnkq3VuNDJzyjrDzXbzi8Vu3S/WM=; b=Ev0UP9VjsCDLd7kDRcV12xjURN
 Bh7wi2H6TTAkt0SzS+yeifFJMRbrnkfGX0naGdwVuIuOdxcY32iWAPP5TPmOYYMokIknEnDJNDs2A
 FD1bE/byCwHqILnHrH5xU6DCMCmqwr99b7RNQHKNyxGZy31u0VWGL6JVPopbFWLjyUxw=;
Received: from mail-oa1-f50.google.com ([209.85.160.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rAGuT-0006iI-AI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 21:55:27 +0000
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-1fa37df6da8so2662867fac.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 Dec 2023 13:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701726918; x=1702331718; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFIOo+aY5DbYFQEHnkq3VuNDJzyjrDzXbzi8Vu3S/WM=;
 b=Npoq+JkaJO516KvED79BqVoICsNKp+VoPUndkpamMDsrfh8Lb3ti3fWWJxNsFOBj5U
 BPvNN+qTih/OfYIPpwF2V0pzV/F0SvQIph6FyqqyON5zlUGPMxcI6IXKNJgN2Fgn1UJ2
 mSnVLZ4z62FdlxXMi/vapXy4JteVe9x3c/NnTELFj0Sa9Qo7XHsYtQ4KBGNICr2A+PVU
 utwtOF51wKI/mE6spv7RzjnKMeJtvlVSYW9ZcuXEHYdmQILyWbxeBB+D6jbmFM0JyqBE
 lEY6AoLFC1qhl2BdRMf31kAJ8Pi9xlItbsc4Bp+2Ol3MtGHi0ZZaXUqAZEMjMpI4nc8U
 Jn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701726918; x=1702331718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFIOo+aY5DbYFQEHnkq3VuNDJzyjrDzXbzi8Vu3S/WM=;
 b=iHCa06U6GWhe+KAK8EOVowrcYNLQ40tc0QVHGHORr2uZlBTulGQDt/TZMGwwYIg4JN
 jm4I4AxaWlHJ13f/9hR5gRTpA95utFl1UuP0DhhMnhanMwQq+/IgJrhUKP7murZOohGT
 7xk+Yj0sbf6VPOFvJUyb3O2OyGMa5P+dTCBTZPkC+QLG6+NewMbcIXrxSTNtFl1jrfvj
 teZmOJMO6jiDIsTb1MHzUGQbSEn3A9jiOsx49hfZ21oy3sCwdTObewWNGuTYJ4IY+Y5z
 ieRPUVgA+sLWCyWgr9GhfVaUX3v2I2T7v0yZ2XbZf93V8lnVGNe8dMNlO0UMMy2W7hsz
 k8wg==
X-Gm-Message-State: AOJu0Yz/jsoeZvc2WsxI/r9AeaLqikUyD1sggAYyCqPyvIRR0/xWkpii
 fYtvq8Jf1lrhmInMiOGRMpxQyZZ4Kmw1YNGzJpaSYBGj8eo=
X-Google-Smtp-Source: AGHT+IFIZXjWfGtn+LmoYR48ydbAkR0UgoGsXQItozaz7vtYj2vIL+YiiDURVxHmMEimu9WCydwX+7RXorvfEqv2D80=
X-Received: by 2002:a9d:7b4e:0:b0:6d8:8021:5539 with SMTP id
 f14-20020a9d7b4e000000b006d880215539mr3096113oto.46.1701717145523; Mon, 04
 Dec 2023 11:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20231204180551.927014-1-jaegeuk@kernel.org>
In-Reply-To: <20231204180551.927014-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 4 Dec 2023 11:12:13 -0800
Message-ID: <CACOAw_zQ8X=HWbX+oiQUeQ0dM7zYJgwTfqWJ6rMBa8rykctJaw@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rAGuT-0006iI-AI
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: run full scan if checkpoint is
 disabled
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TEdUTQoKT24gTW9uLCBEZWMgNCwgMjAyMyBhdCAxMDowN+KAr0FNIEphZWdldWsgS2ltIDxqYWVn
ZXVrQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gTGV0J3MgZml4IGFueSBpbmNvbnNpc3RlbmN5IHVu
dGlsIGNoZWNrcGludCBiZWluZyBlbmFibGVkIGJhY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYWVn
ZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgo+IC0tLQo+ICBmc2NrL21vdW50LmMgfCAxICsK
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZnNjay9t
b3VudC5jIGIvZnNjay9tb3VudC5jCj4gaW5kZXggZTk1NzkwNDQ5NGVmLi4zMGM2MjI4MGIyODEg
MTAwNjQ0Cj4gLS0tIGEvZnNjay9tb3VudC5jCj4gKysrIGIvZnNjay9tb3VudC5jCj4gQEAgLTE0
MzUsNiArMTQzNSw3IEBAIHN0YXRpYyBpbnQgZjJmc19zaG91bGRfcHJvY2VlZChzdHJ1Y3QgZjJm
c19zdXBlcl9ibG9jayAqc2IsIHUzMiBmbGFnKQo+ICB7Cj4gICAgICAgICBpZiAoIWMuZml4X29u
ICYmIChjLmF1dG9fZml4IHx8IGMucHJlZW5fbW9kZSkpIHsKPiAgICAgICAgICAgICAgICAgaWYg
KGZsYWcgJiBDUF9GU0NLX0ZMQUcgfHwKPiArICAgICAgICAgICAgICAgICAgICAgICBmbGFnICYg
Q1BfRElTQUJMRURfRkxBRyB8fAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZsYWcgJiBDUF9R
VU9UQV9ORUVEX0ZTQ0tfRkxBRyB8fAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGMuYWJub3Jt
YWxfc3RvcCB8fCBjLmZzX2Vycm9ycyB8fAo+ICAgICAgICAgICAgICAgICAgICAgICAgIChleGlz
dF9xZl9pbm8oc2IpICYmIChmbGFnICYgQ1BfRVJST1JfRkxBRykpKSB7Cj4gLS0KPiAyLjQzLjAu
cmMyLjQ1MS5nODYzMWJjNzQ3Mi1nb29nCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+
IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
