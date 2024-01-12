Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70125C4706C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jan 2024 22:20:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rOPsw-0002xq-2K;
	Fri, 12 Jan 2024 22:20:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rOPsu-0002xe-P8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jan 2024 22:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=; b=AEo5pf3K3o0mpj4oSkHv9B4ue7
 FqJVshupynC7jIXiZ9bwVZ2E1svl9wL93jnDrF8hanVxAljjcegHnoLP8J/pmNKykkXGD5cB7HU3y
 7qjBSOOO7CiS96NQuMZxlUfEfhRtGnTxQM7Fgw3liNJgKqZ/txgzZjEH1YYnUVFtFYRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=; b=NoxI1xH37fj7BaJEI2TlF3dty/
 mYRd2YTm5Dwwqnlns6IY5vLJPWR21FCxGzCVD92MjtIjZhS6Wiq3dAv7HI0Cl4CWphlJHAhIUuPgi
 OukyMRokJBbjNrhY+84D1P69YA9+YbGs8Xl6uL7Hxchi5B4tJ2ezh06yAbGOfLKOyDQM=;
Received: from mail-ot1-f43.google.com ([209.85.210.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rOPsp-0008K7-QI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jan 2024 22:20:16 +0000
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-6ddeec84e35so2295853a34.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jan 2024 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705098006; x=1705702806; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=;
 b=AwFeoewao4+KJG7Lh7O25wAJuT/UvltL/6L4S9G1dPQLkmETUU9zvChKzVQOMlDmVZ
 ASCYjYfzKxDXv9KHZD0uCYZKL7OuRrG1/ZdBlj20TTjN9SqPf2pVF+Md7Y9tyVjEQA61
 c+rREbseYqeKGEQtYQpnP/36AApqoX6WosqX2XbgmccR3K4PeEPYlV+oRhwf9RsdtKE1
 ylrUyUgYMJDThRtXry0XcDk1n5etW9xR+Jj3bvqUwz3LtZS/rafvO1EJVZ4/1DKoQiEP
 tJd6v+n7RKOUR+FgQ662VXQ32hgeOySzqJ30RsiFLwBA5/7dez7igiG4XLKYX/nno62z
 1aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705098006; x=1705702806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ1fE0zMIdBTRXTZzC0pYGjjHoVS0GZdkj3k4G9P/8k=;
 b=pZzBCvkSODkWrVXIs/uF1xmCdndKJu98TV9ZMWbnPwD0pdQgByrCw+Ho6mE8LW0vjj
 6PunO9aG0n8ypUhxGeDcTrWcM6NI9+hYtCYeloybzRhWkZqho6WkU2sZScn2SLR2OJdz
 Kst90V0ELRM1GNdYv/p1OuvSSQHeIFWe1LQf/JliiU+qBbNZvvUs988gSw9+GKdjeF8g
 HbPS8h+wVDWXQDTsRPeGGw7shyIKujqinUG3BkE9uSLnNoZSGG9B9HA43WZTPKUF64RP
 AtFzxt3LV7oMRY2lLUmGRoQVG+v5PC8onKyQnaNdj3tqdIAzNtFo2xB++5VyT1xEz1Jc
 b/og==
X-Gm-Message-State: AOJu0Yxbc9U4nH3jbAXlPoSMXCScygzohKmmNF4wOiJEYe8BcrF0FA/i
 jT5SG/HwYWmxLvXwdzTTWZxM6l63kRaoPLceY3xml0b4FwhgUQ==
X-Google-Smtp-Source: AGHT+IF3nLiZdIVfIpj/tS0ArCYtqeD9qYJvdJym55Bt1+GH6gLfy6yhR92PURPrqVl8XlX8IimHnbmfH6hWYE2Nqy4=
X-Received: by 2002:a05:6830:718c:b0:6db:ffa6:6c4d with SMTP id
 el12-20020a056830718c00b006dbffa66c4dmr2586243otb.24.1705098006595; Fri, 12
 Jan 2024 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20240111064208.2969599-1-chao@kernel.org>
 <20240111064208.2969599-5-chao@kernel.org>
In-Reply-To: <20240111064208.2969599-5-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 12 Jan 2024 14:19:55 -0800
Message-ID: <CACOAw_wrktRjueox2FQC129jjVVNVEMpCDM06iQXv1p0gpYvXw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rOPsp-0008K7-QI
Subject: Re: [f2fs-dev] [PATCH v4 5/6] f2fs: fix to remove unnecessary
 f2fs_bug_on() to avoid panic
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

UmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+CgpPbiBXZWQs
IEphbiAxMCwgMjAyNCBhdCAxMDo0M+KAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3Jv
dGU6Cj4KPiB2ZXJpZnlfYmxrYWRkcigpIHdpbGwgdHJpZ2dlciBwYW5pYyBvbmNlIHdlIGluamVj
dCBmYXVsdCBpbnRvCj4gZjJmc19pc192YWxpZF9ibGthZGRyKCksIGZpeCB0byByZW1vdmUgdGhp
cyB1bm5lY2Vzc2FyeSBmMmZzX2J1Z19vbigpLgo+Cj4gRml4ZXM6IDE4NzkyZTY0Yzg2ZCAoImYy
ZnM6IHN1cHBvcnQgZmF1bHQgaW5qZWN0aW9uIGZvciBmMmZzX2lzX3ZhbGlkX2Jsa2FkZHIoKSIp
Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+IC0tLQo+ICBmcy9m
MmZzL2YyZnMuaCB8IDQgKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9mMmZzLmggYi9mcy9mMmZzL2Yy
ZnMuaAo+IGluZGV4IDY5ZTcxNDYwYTk1MC4uYWI3MTBiYjZkOGIzIDEwMDY0NAo+IC0tLSBhL2Zz
L2YyZnMvZjJmcy5oCj4gKysrIGIvZnMvZjJmcy9mMmZzLmgKPiBAQCAtMzQ3MCwxMSArMzQ3MCw5
IEBAIGJvb2wgZjJmc19pc192YWxpZF9ibGthZGRyKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwK
PiAgc3RhdGljIGlubGluZSB2b2lkIHZlcmlmeV9ibGthZGRyKHN0cnVjdCBmMmZzX3NiX2luZm8g
KnNiaSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmxvY2tfdCBi
bGthZGRyLCBpbnQgdHlwZSkKPiAgewo+IC0gICAgICAgaWYgKCFmMmZzX2lzX3ZhbGlkX2Jsa2Fk
ZHIoc2JpLCBibGthZGRyLCB0eXBlKSkgewo+ICsgICAgICAgaWYgKCFmMmZzX2lzX3ZhbGlkX2Js
a2FkZHIoc2JpLCBibGthZGRyLCB0eXBlKSkKPiAgICAgICAgICAgICAgICAgZjJmc19lcnIoc2Jp
LCAiaW52YWxpZCBibGthZGRyOiAldSwgdHlwZTogJWQsIHJ1biBmc2NrIHRvIGZpeC4iLAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBibGthZGRyLCB0eXBlKTsKPiAtICAgICAgICAgICAgICAg
ZjJmc19idWdfb24oc2JpLCAxKTsKPiAtICAgICAgIH0KPiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUg
Ym9vbCBfX2lzX3ZhbGlkX2RhdGFfYmxrYWRkcihibG9ja190IGJsa2FkZHIpCj4gLS0KPiAyLjQw
LjEKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
