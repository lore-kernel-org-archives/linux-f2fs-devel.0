Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06827CFB44F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:50:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sxqvv-0004Vl-Ox;
	Mon, 07 Oct 2024 16:50:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sxqvu-0004Vf-Hh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Oct 2024 16:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tB1bpNUrJogyAqtBapESn5o6BSN7Fgu1X6AOjaCglv0=; b=CzWGecx7687Z7ZTu8z1iFfD92l
 bwFzp7UfVF7maEPmY9LiYG27HPGF3pUa/8KUncx+09HNuyfAClKDsAQA9UcojVmFuZGlx/rhlDva6
 1jJO3mHaNr5DchVhuXwEPBLiTBJ3p/Mb8eDQzi74InW4VAeNoc0sZru8CyrO9MQdpqzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tB1bpNUrJogyAqtBapESn5o6BSN7Fgu1X6AOjaCglv0=; b=CKBvk5YHvVHE7X6aRqx0m4TVli
 P4I1e6xn+7ZKcb87kvYAFlXX6vNjl8l+iq3QZTNfF/TTD2DghoI3FdEs6lQcesrE6ZKv+orNdUr25
 idsJpMc+tzwvwhsJAaQzIc7yZMssPr4JTbV3BnwG1hdzTL69Ckfmyand+LgXj+adQ/Dk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sxqvu-0000Ns-Ez for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Oct 2024 16:50:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D0D425C24D5;
 Mon,  7 Oct 2024 16:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BB0C4CEC6;
 Mon,  7 Oct 2024 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728319795;
 bh=QSEWGceGF+zqW4Mxm7quS90OIzr3oPTDd3vjuevYd9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PxidwWF5tOsu57/gIOobA09HS9QboVYxvrlD7pq23ZIbz7SUm4c3GAlgi/yljMb8O
 HzJf37CDNJZIUKSBVuN0fc4Y+TyClDXdb1baExy4dU9lrMSV8sZ+09s7SB80MFKS6J
 woWjs9wBvCB9aHDQ16wtZpSYc+KqvlzXkwEBJxbqWQCVJSnUrZwHp0IiT5lfCyLwcT
 iekqIhB+8BAvz5tyU/qfsq4df43HoMVo2EWJ2gSRiu6D2KfXqu1GXFNqCJ1fmn2LC4
 zdrGv3fG0K6jK3Rfa59/Gp1eBTew0bnsIzmW40L3GadWjrQAsk2IIC5G7MVahPHvON
 OekUjVUbduvgQ==
Date: Mon, 7 Oct 2024 16:49:53 +0000
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Message-ID: <ZwQRMe9a6oXKLCq5@google.com>
References: <1726283507-16611-1-git-send-email-zhiguo.niu@unisoc.com>
 <CAHJ8P3+=Ft_LOWHXPDdXQnQA=BsGhDLF0KYWWD6T3KHB-TEgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHJ8P3+=Ft_LOWHXPDdXQnQA=BsGhDLF0KYWWD6T3KHB-TEgWg@mail.gmail.com>
X-Headers-End: 1sxqvu-0000Ns-Ez
Subject: Re: [f2fs-dev] [PATCH] f2fs-toos: use getpagesize() to get default
 blocksize in Android
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: xiuhong.wang@unisoc.com, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMDkvMTksIFpoaWd1byBOaXUgd3JvdGU6Cj4gSGkgYWxsLAo+IHBsZWFzZSBpZ25vcmUgdGhp
cyBwYXRjaCwgIHdlIGNhbiByZXNvdmUgdGhpcyBieSAiLWIiIHBhcmFtZXRlciAuCj4gdGhhbmtz
IQoKT2ssIHRoYW5rcy4KCj4gWmhpZ3VvIE5pdSA8emhpZ3VvLm5pdUB1bmlzb2MuY29tPiDkuo4y
MDI05bm0OeaciDE05pel5ZGo5YWtIDExOjEy5YaZ6YGT77yaCj4gPgo+ID4gV2hlbiAxNksgcGFn
ZS9ibG9jayBzaXplIGlzIGVuYWJsZWQgaW4gQW5kcm9pZCBwbGF0Zm9ybSwKPiA+IGEgZXJyb3Ig
bWF5YmUgZGV0ZWN0ZWQgaW4gbW91bnQgcHJvY2VzcyBpbiBrZXJuZWwgaWYgIi1iIgo+ID4gcGFy
YW1ldGVycyBpcyBub3Qgc3BlY2lmaWVkIGluIG1rZnMuZjJmcy4KPiA+IEp1c3QgYXMgdGhlIGZv
bGxvd2luZyBjaGVjazoKPiA+IGlmIChsZTMyX3RvX2NwdShyYXdfc3VwZXItPmxvZ19ibG9ja3Np
emUpICE9IEYyRlNfQkxLU0laRV9CSVRTKQo+ID4KPiA+IFNvIHVzZSBnZXRwYWdlc2l6ZSgpIHRv
IGdldCBjb3JyZWN0IGRlZmF1bHQgYmxvY2tzaXplLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFpo
aWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29jLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IFhpdWhv
bmcgV2FuZyA8eGl1aG9uZy53YW5nQHVuaXNvYy5jb20+Cj4gPiAtLS0KPiA+ICBsaWIvbGliZjJm
cy5jIHwgOSArKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL2xpYi9saWJmMmZzLmMgYi9saWIvbGliZjJmcy5jCj4gPiBpbmRl
eCBlY2QyMmQ0Li45OGVlMGFlIDEwMDY0NAo+ID4gLS0tIGEvbGliL2xpYmYyZnMuYwo+ID4gKysr
IGIvbGliL2xpYmYyZnMuYwo+ID4gQEAgLTY4NSw4ICs2ODUsMTcgQEAgdm9pZCBmMmZzX2luaXRf
Y29uZmlndXJhdGlvbih2b2lkKQo+ID4KPiA+ICAgICAgICAgbWVtc2V0KCZjLCAwLCBzaXplb2Yo
c3RydWN0IGYyZnNfY29uZmlndXJhdGlvbikpOwo+ID4gICAgICAgICBjLm5kZXZzID0gMTsKPiA+
ICsjaWZkZWYgV0lUSF9BTkRST0lECj4gPiArICAgICAgIGMuYmxrc2l6ZSA9IGdldHBhZ2VzaXpl
KCk7Cj4gPiArICAgICAgIGMuYmxrc2l6ZV9iaXRzID0gbG9nX2Jhc2VfMihjLmJsa3NpemUpOwo+
ID4gKyAgICAgICBpZiAoKDEgPDwgYy5ibGtzaXplX2JpdHMpICE9IGMuYmxrc2l6ZSkgewo+ID4g
KyAgICAgICAgICAgICAgIGMuYmxrc2l6ZSA9IDEgPDwgREVGQVVMVF9CTEtTSVpFX0JJVFM7Cj4g
PiArICAgICAgICAgICAgICAgYy5ibGtzaXplX2JpdHMgPSBERUZBVUxUX0JMS1NJWkVfQklUUzsK
PiA+ICsgICAgICAgfQo+ID4gKyNlbHNlCj4gPiAgICAgICAgIGMuYmxrc2l6ZSA9IDEgPDwgREVG
QVVMVF9CTEtTSVpFX0JJVFM7Cj4gPiAgICAgICAgIGMuYmxrc2l6ZV9iaXRzID0gREVGQVVMVF9C
TEtTSVpFX0JJVFM7Cj4gPiArI2VuZGlmCj4gPiAgICAgICAgIGMuc2VjdG9yc19wZXJfYmxrID0g
REVGQVVMVF9TRUNUT1JTX1BFUl9CTE9DSzsKPiA+ICAgICAgICAgYy5ibGtzX3Blcl9zZWcgPSBE
RUZBVUxUX0JMT0NLU19QRVJfU0VHTUVOVDsKPiA+ICAgICAgICAgYy53YW50ZWRfdG90YWxfc2Vj
dG9ycyA9IC0xOwo+ID4gLS0KPiA+IDEuOS4xCj4gPgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
