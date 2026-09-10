Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C44C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vIHaCrSUFjiZIhde2qw6NyOfA4/Mcmbz633lY3IuQ+Y=; b=hAyhpKrw4bJj3CXoEKWutt1ZJh
	+06XCgf8AKketvUj9Uu8CRXhsdoWedADtEikgsMHptlC/qUUtqLeOHVtrS6A70V5xOrZ4vwDtAcW5
	J8B3YKRNTQx/SZi8PqmbbSOJuQpM8wByq0e2fN9PRrauFvftliLgvrCdIppekvNEU+1I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4Uny-0006cf-LO;
	Thu, 10 Sep 2026 02:46:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4Uni-0006cM-AF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nfxqFqaG8bjVXDuUPWGc8M/tFuWFhaC9E6+GbBTtmTU=; b=PyJghJKnmKnTdV+dIH5kRho/Ly
 b8W5pncDzMMrtrP+ZkPYjPVtWPlEnujmOzSoq3XKHYFt4FdnYvKNvYug/4IFuisBzRkHb30kGnHnt
 wGgOuo71jNdI8waz0DYlSELXiOfswxwxl0GvWVJpBYrfhkd0/OjKyrMBqHop0P2ycx7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nfxqFqaG8bjVXDuUPWGc8M/tFuWFhaC9E6+GbBTtmTU=; b=dJePLsiZzGl7rUR/UCUHf1jZc7
 N76ovwHuzXQAbbbQLv+COgh/vlCRzLcONqtO8f+HL0Ht7Xgep2OF3f8dmU19GYc3hznItScjYOVa5
 X5OUObnb1W/NeCdwukP82F8ygMl2oIjpK1MrSscZYnpXh4c44U1en69FweehqGzGPrcU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4Uni-00089Q-Ed for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:46:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDE54600D1;
 Thu, 10 Sep 2026 02:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4BE1F000FF;
 Thu, 10 Sep 2026 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789008364;
 bh=nfxqFqaG8bjVXDuUPWGc8M/tFuWFhaC9E6+GbBTtmTU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WzFTfpuMnCNiYqg/8+1C+5K9wTIGLF0J8zyOPFL4g4xlvq1uMRpMAxaTQAYrklBIp
 RjO2C8iWxwI4BqyqWETTWXHwCO/zyy6Mv9U3MjtCHIwF2cjCkMjlGTKS95nzOVEcwp
 cjk1H4lDklOdgCREACVS0aQtOmHIVrA/0au/XZP5aH0qVbZhLpkpD2tAzn3TUyxk/3
 qWZ4B00jTYNlX6sSTpJvau9hSmZ1OXIhGxeWIZEOqBaxm6DQLVAzCqFnmPsYfWG7WB
 O9skZW7D8d+i//bYLACxaNxO57A4y03BkKqfe7zVE0rORCOEUsIpod00boOFB+qB8s
 n7YHtMO+zuD+g==
Message-ID: <41cfe667-115c-4f95-b5c2-ec9344e46519@kernel.org>
Date: Thu, 10 Sep 2026 10:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>,
 Daeho Jeong <daehojeong@google.com>
References: <20260828121816.1463654-1-ke.li11@transsion.com>
 <20260910021502.10024-1-ke.li11@transsion.com>
Content-Language: en-US
In-Reply-To: <20260910021502.10024-1-ke.li11@transsion.com>
X-Headers-End: 1x4Uni-00089Q-Ed
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgS2UgTGksCgpUaGFua3MgZm9yIHRoZSBwYXRjaGVzLgoKQWRkIERhZWhvLCBJIHRoaW5rIGhl
IG1heSBoYXMgc29tZSBleHBlcmltZW50cyBvbiB0aGlzIGFuZCBjYW4gaGVscCB0bwpjb21tZW50
LgoKVGhhbmtzLAoKT24gOS8xMC8yNiAxMDoxNSwg5p2O54+CMTEgd3JvdGU6Cj4gSGkgSmFlZ2V1
aywgQ2hhbywKPiAKPiBHZW50bGUgcGluZy4gVGhpcyBzZXJpZXMgd2FzIHBvc3RlZCBvbiBBdWcg
MjggYW5kIEkgaGF2ZSBub3Qgc2Vlbgo+IHJldmlldyBjb21tZW50cyB5ZXQ6Cj4gCj4gICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1mMmZzLWRldmVsLzIwMjYwODI4MTIxODE2LjE0NjM2
NTQtMS1rZS5saTExQHRyYW5zc2lvbi5jb20vCj4gCj4gICAxLzIgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWYyZnMtZGV2ZWwvMjAyNjA4MjgxMjE4MTYuMTQ2MzY1NC0yLWtlLmxpMTFA
dHJhbnNzaW9uLmNvbS8KPiAgIDIvMiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZjJm
cy1kZXZlbC8yMDI2MDgyODEyMTgxNi4xNDYzNjU0LTMta2UubGkxMUB0cmFuc3Npb24uY29tLwo+
IAo+IE5vIGNvZGUgY2hhbmdlIHNpbmNlIHYxLiBIYXBweSB0byByZXZpc2Ugb3IgYWRkIHRlc3Rz
IGlmIG5lZWRlZC4KPiAKPiBUaGFua3MsCj4ga2UubGkxMQoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
