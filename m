Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFC4CA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 07:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRIvvCxOBpFBbGbRo9JAfMIpQFOdlCd+d9vUaWsf+Rg=; b=Gh11KwtFiqiTbOT73mGzCdsbGb
	8AtyLdjs7/13ercykjqEcEp2WLoB3bxS0CUJUWo68tJVb+I9FE/hZzv6v02F52c5v2YqZBKE8F/DZ
	PWTpfYNnclvxWxsPNQJsG7Kc4rO4flf6QQcZYAdUAVMMCGb9MjQtLxdlgr1WB3jCNgOs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFoI2-00062K-GU;
	Sun, 11 Oct 2026 07:48:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <baohua@kernel.org>) id 1xFoHR-00061g-9S
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 07:47:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JlRrshqoncb1nPc1YH8iKssdhdAAi72cR+g7ttfhdUY=; b=a7SCkv/sWW0JwjTemJzt9t1YmN
 5T1FKNHBWpxrzdPZnIJnjUcdv4iINXOCVg9oD4Vv58vexDVpBMtNOYmpVHAdeCQB2MYk3SD8UI014
 omnjWrrYlFk/GxNdYBojFFn1CuZdCIgWf5fT6hrjVyvTtlVuB76ZDVb3IJLACe92eG2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JlRrshqoncb1nPc1YH8iKssdhdAAi72cR+g7ttfhdUY=; b=K4ROSNW2ncQUNxcHbAiVmMJsI3
 uvvr+EzK1OJaBnx041+ZVIhQvEEZJLvNLR6t+QOwcSEOCZ5ESMUylQAx0v/y7DrlB3A3hM2rcGfaa
 u1cz/om8GqQ1EyoOiExyWMyelD2+m0aoAZRnpNoxf3XjivKBxzR3Pr5XrEFnmBSHIbSE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFoHQ-0003sG-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 07:47:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1512840926
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 07:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1CF1F0089E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791704851;
 bh=JlRrshqoncb1nPc1YH8iKssdhdAAi72cR+g7ttfhdUY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=nfNI+E/dTSNIroxxRtO8T9R1PI+d3ZqG6O/vhF5YJFFlA8vS3sI8rSIrCUUwFLpo/
 OiKzrr4WuRmMFc9CbIBqjcskPUbxclMDCtmI8Y8QhawMkuRBOyjHi4dSuhwPk2w/Ex
 7v1Y9+IFdYfmwBAy0fM9pyafPjgW6D9cwy0j8CibQoRbwN2OKweNpIpbUYbUzh/yBd
 Zqj4DguZkzs40dGfx0wCPOfIc+RRK0BHQYs+yac1a+U14sL3SwR1BzL6vYwgrH/yAc
 BNgRJz7GDb2L4AeTPrGQHgzqSegm75Ck2kNpcKwYsXKrPdh0MA58MGZ7V3G+HOefKX
 W47aSiS/5r4IA==
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-53391786e55so18171011cf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 00:47:30 -0700 (PDT)
X-Gm-Message-State: AFq9FYKxLMrhDjr86OQYvai4JlKlNBgOjhv1VgFKEmLf/3bCsx4HOXqj
 uLVulnk/CYTY4aC18X0goiIcLMeu/lfBVov3D/l4nZ0A91bl8MnXZqsBu09BfReO5/Z2vLUNXig
 LUbT0AsYCTVaxNHuwV2NOCPs4kGlrq5E=
X-Received: by 2002:a05:620a:44c1:b0:93e:9927:fd34 with SMTP id
 af79cd13be357-93ebd2244camr1017488585a.28.1791704850198; Sun, 11 Oct 2026
 00:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
Date: Sun, 11 Oct 2026 15:47:18 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
X-Gm-Features: AclHuK9sQwDYiz6jpVGp-nkoQLz8HOVchDFynrkGu0-9gSXFWAXjND2_2qgQY40
Message-ID: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
X-Headers-End: 1xFoHQ-0003sG-Gm
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove mappedtodisk flag usage in
 mmap write path
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
From: Barry Song via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Barry Song <baohua@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBPY3QgMTEsIDIwMjYgYXQgMTI6MDLigK9QTSBOYW56aGUgWmhhbyA8emhhb25hbnpo
ZUB4aWFvbWkuY29tPiB3cm90ZToKPgo+IFBHX21hcHBlZHRvZGlzayB3YXMgaW5oZXJpdGVkIGZy
b20gdGhlIG5vYmgvYnVmZmVyLWhlYWQgZXJhLiAgSG93ZXZlciwKPiBmMmZzIGhhcyBubyBidWZm
ZXIgaGVhZHMgYW5kIHRoZSBmbGFnIGlzIG5vIGxvbmdlciBtZWFuaW5nZnVsLiAgVGhlIG9ubHkK
PiB1c2VyIG9mIHRoZSBmbGFnIGlzIHRoZSAibm8gaG9sZXMiIHNob3J0Y3V0IGluIGYyZnNfdm1f
cGFnZV9ta3dyaXRlKCksCj4gd2hpY2ggbWFrZXMgbW1hcCB3cml0ZSBmYXVsdHMgc2tpcCBtYXJr
aW5nIHRoZSBmb2xpbyBkaXJ0eS4gIENoYW8gWXUKPiBwb2ludGVkIG91dCB0aGF0IHRoaXMgaXMg
bm90IG9ubHkgYSBjbGVhbnVwOiBpdCBjYXVzZXMgdGhlIGZvbGxvd2luZwo+IHJhY2UgY29uZGl0
aW9uIHdpdGggZmlsZXN5c3RlbSBmcmVlemluZzoKClNvbWVob3csIEkgZmVlbCB0aGF0ICJSZW1v
dmUgdGhpcyBzaG9ydGN1dCBpbgpgZjJmc192bV9wYWdlX21rd3JpdGUoKWAgYW5kIHN0b3Agc2V0
dGluZyBpdCBpbgpgZjJmc19yZWFkX3NpbmdsZV9wYWdlKClgIiBzaG91bGQgY29tZSBiZWZvcmUg
IkNoYW8gWXUKcG9pbnRlZCBvdXQgdGhhdCB0aGlzIGlzIG5vdCBvbmx5IGEgY2xlYW51cDogaXQg
Y2F1c2VzCnRoZSBmb2xsb3dpbmciLgoKV2UncmUgc2F5aW5nIHRoYXQgcmVtb3ZpbmcgdGhpcyBz
aG9ydGN1dCBpcyBib3RoIGEgY2xlYW51cAphbmQgYSBmaXggZm9yIHRoZSByYWNlLCByaWdodD8K
Cj4KPiAgQ1BVMCAod3JpdGUgZmF1bHQpICAgICBDUFUxIChmcmVlemVfc3VwZXIpCj4gIC0tLS0g
ICAgICAgICAgICAgICAgICAgLS0tLQo+ICBmMmZzX3ZtX3BhZ2VfbWt3cml0ZSgpCj4gIHNiX3N0
YXJ0X3BhZ2VmYXVsdCgpCj4gIC8qIHNob3J0Y3V0OiBubyBkaXJ0eSAqLwo+ICBzYl9lbmRfcGFn
ZWZhdWx0KCkKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNiX3dhaXRfd3JpdGUoU0JfRlJF
RVpFX1BBR0VGQVVMVCkKPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBubyB3YWl0ZXIsIHBh
c3NlcyAqLwo+ICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmNfZmlsZXN5c3RlbSgpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgLyogZm9saW8gbm90IGRpcnR5LCBza2lwcGVkICovCj4KPiAg
ZmluaXNoX2ZhdWx0KCkKPiAgLyogUFRFIHdyaXRhYmxlICovCj4gIGZhdWx0X2RpcnR5X3NoYXJl
ZF9wYWdlKCkKPiAgZm9saW9fbWFya19kaXJ0eSgpCj4gIC8qIGRpcnR5IGZvbGlvIG9uIGEgZnJv
emVuIGZzICovCj4KPiBJdCB3aWxsIGFsc28gc2tpcCBBUFBfTUFQUEVEX0lPIGlvc3RhdC9SRVFf
VElNRSB1cGRhdGVzIGFuZCBwb3N0LUVPRgo+IGZvbGlvIHplcm9pbmcuCj4KPiBSZW1vdmUgdGhp
cyBzaG9ydGN1dCBpbiBmMmZzX3ZtX3BhZ2VfbWt3cml0ZSgpIGFuZCBzdG9wIHNldHRpbmcgaXQg
aW4KPiBmMmZzX3JlYWRfc2luZ2xlX3BhZ2UoKS4KCkkgbWVhbiwgdGhpcyBzZW50ZW5jZSBzaG91
bGQgYmUgbW92ZWQgZWFybGllciwgb3IgdGhlCnByZWNlZGluZyBzZW50ZW5jZXMgc2hvdWxkIGJl
IHJld29yZGVkLgoKPgo+IFJlcG9ydGVkLWJ5OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJmcy1kZXZlbC80OTZiOTEzYy1l
YjgxLTRmYTgtYmU3Mi1jNmEwNmExMGFiYTJAa2VybmVsLm9yZy8KPiBGaXhlczogZmJmYTJjYzU4
ZDUzICgiZjJmczogYWRkIGZpbGUgb3BlcmF0aW9ucyIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBOYW56aGUgWmhhbyA8emhhb25hbnpoZUB4aWFvbWkuY29t
Pgo+IC0tLQoKUmV2aWV3ZWQtYnk6IEJhcnJ5IFNvbmcgPGJhb2h1YUBrZXJuZWwub3JnPgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
