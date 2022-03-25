Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDB8C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Mar 2022 16:03:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nXmH1-0004d1-Mf; Fri, 25 Mar 2022 16:02:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mudrunka@spoje.net>) id 1nXmH0-0004cv-PI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 16:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:References:In-Reply-To:Cc:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GFOF11vNGlYNDtFa+3YkmGWRU+t2CysAeYyUahKEOWo=; b=APYCnA3t03yGcppNgQxOuReD+r
 92aaJ2Fgz5awSrbR16lmo0JwWMGKKPnEl7t3zgUZEhR95Soh3mjn3KawRoOO0BLbxFIzu5sQikJ6v
 zJanZllrNMprPzS+WVnvqYknBFQv0u88hk/7ivAIvYisB8AuP6pW8eyCRz0mSFpgqbik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:References:In-Reply-To:Cc:From:Date:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:To:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GFOF11vNGlYNDtFa+3YkmGWRU+t2CysAeYyUahKEOWo=; b=gTFrwLucuVlP3UYw9GgimIAvt8
 SSqUsx4jx0A2Rz0gVG218gaPXFFTf1Vv4ORD6hARgTmhMJF+plYXvczIf9U6J2Dl55DtGp4fDDRiE
 f0wkz44CEfJsN/qophOmGZaghEzLYk69Uvr20ulsqbyPR1XlJRujVXCDMS2uXKW9zOro=;
Received: from mail.spoje.net ([82.100.58.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.94.2)
 id 1nXmOu-00BsQJ-Bk
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 16:02:58 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.spoje.net (Postfix) with ESMTP id 01A38AE9DD1;
 Fri, 25 Mar 2022 17:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
 s=spojemail; t=1648224164;
 bh=FJvBc33cHaFWce9E/FH+FE5Qhhx8wSnCoiC9UwtU7BA=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=j1qedTlzuVAKGuP6wKKX/3mHq0o8uU7Eq5MaesMA0Ip2nPMo4lJl8y1EocPF2MWgF
 2QGbSaYcdCkmmK7orE0aPhloFf8mfJuCNj5WCgXrvK0N6myXIzTt9ziMzas4XC92wa
 Y35gB8rP7A4jdoCGlOs2zp+Bnm9m55wc71Af0FM4=
X-Virus-Scanned: Debian amavisd-new at mail.spoje.net
Authentication-Results: mail.spoje.net (amavisd-new); dkim=pass (1024-bit key)
 header.d=spoje.net
Received: from mail.spoje.net ([127.0.0.1])
 by localhost (mail.spoje.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEwX3-lF6MwH; Fri, 25 Mar 2022 17:02:41 +0100 (CET)
Received: by mail.spoje.net (Postfix, from userid 33)
 id AA22CAE9D4E; Fri, 25 Mar 2022 17:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
 s=spojemail; t=1648224161;
 bh=FJvBc33cHaFWce9E/FH+FE5Qhhx8wSnCoiC9UwtU7BA=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=uxmkV5TBCLHNSoqmjCxaARHRDWxSR4AEFE2bcxAe3451cbv1LAOyF/e36xdv/Dwma
 fXccn5L553PZ/6/+ZB2LvLbfAIPIjwwUb90QtocujFttJeE6aRt5CxlX5L5IyJdIZc
 yAr4nLZ6k8bPDmH5tu40ia0eTiEsCIZOSElBxcdc=
To: Chao Yu <chao@kernel.org>
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Date: Fri, 25 Mar 2022 17:02:41 +0100
From: Tomas Mudrunka <mudrunka@spoje.net>
Organization: SPOJE.NET s.r.o.
In-Reply-To: <b491875c-c6a8-1243-35cf-649be3250b5d@kernel.org>
References: <f4e22b0dff793f75b5c37a170acba03c@spoje.net>
 <b491875c-c6a8-1243-35cf-649be3250b5d@kernel.org>
Message-ID: <7f4d6d15166e4df14a42fa7a3bc7e914@spoje.net>
X-Sender: mudrunka@spoje.net
User-Agent: Roundcube Webmail/1.2.3
X-Headers-End: 1nXmOu-00BsQJ-Bk
Subject: Re: [f2fs-dev] F2FS support in genimage
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RG5lIDIwMjItMDMtMjEgMDc6MDMsIENoYW8gWXUgbmFwc2FsOgo+IEhpIFRvbWFzLAo+IENhbiBz
bG9hZC5mMmZzIHNhdGlzZnkgdGhpcyByZXF1aXJlbWVudD8KPiBUaGFua3MsCgpCVFcgaXQgd29y
a2VkLCBzbyB3ZSd2ZSBhbHJlYWR5IGFkZGVkIEYyRlMgc3VwcG9ydCB0byBnZW5pbWFnZToKCmh0
dHBzOi8vZ2l0aHViLmNvbS9wZW5ndXRyb25peC9nZW5pbWFnZS9wdWxsLzE4NQpodHRwczovL2dp
dGh1Yi5jb20vcGVuZ3V0cm9uaXgvZ2VuaW1hZ2UvCgpTb21lb25lIG1pZ2h0IGZpbmQgdGhhdCBo
ZWxwZnVsCgpDaGVlcnMKCgotLSAKUyBwb3pkcmF2ZW0KQmVzdCByZWdhcmRzCiAgICAgIFRvbcOh
xaEgTXVkcnXFiGthCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbGludXgtZjJmcy1kZXZlbAo=
