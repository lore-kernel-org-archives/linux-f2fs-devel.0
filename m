Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E068C5B569
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7w/D3gR4kKt+QdrqyfYhHCDt79AMAM8gU5Az+lHoOA=; b=Skm8yEnXf1Gog++08g2hhyoQHW
	h7D9Vns9UWAZymJn0CbmosvGIbbwryGTP0xSJvUDBs24deoV0NSw70m1mD3g1BmhgH3tQiKxUdjD1
	kUc0GDElwatJ+aZ7CfpybewcSuhRIocM8t7a/HACuuQWthmYoJg7oo5lKn5hX9756LnQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtgjq-0008P9-6C;
	Tue, 11 Aug 2026 07:17:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wtgjp-0008Ov-99
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 07:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FTCyUe2MLfpbA+nS8TJTQNm3ZwKVNEPK0hnuLiCdNOg=; b=RLO9kZ03aq6jY5eEqr2iHLRHyR
 zj3kPI7JRNFWNF0fiNANfzlrgji6jQoW3hK+a2K+LESdMLp6wzAUaJMeZgmBHvoRU3ZuFEVLqQKNl
 BMuYO1slGC9APyszpFG5a4MIh/VZpfYJh7dG5E1IkACtN3dMDKqZ1KZwI4dxaQNmglCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FTCyUe2MLfpbA+nS8TJTQNm3ZwKVNEPK0hnuLiCdNOg=; b=LhBU+1XhqLHyjpBqz8uBXkHKAs
 R1ISliFHJSqA5xS6aReQsqHe0g/HRWzOWWvbu2MTqm/VSIaasgtVBeoWJsWMGVA4C1minFbwJkBGT
 8oEaFIeDC3n7ekJFbpETm0z8ru4wqoTzWV07Tgtq3f6hTANvvZBv0CoLJt/eso5dXz9A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtgjp-00026w-IS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 07:17:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9307600AD;
 Tue, 11 Aug 2026 07:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C71F000E9;
 Tue, 11 Aug 2026 07:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786432643;
 bh=FTCyUe2MLfpbA+nS8TJTQNm3ZwKVNEPK0hnuLiCdNOg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=MdFc1/1vOJDdpOjXSJ9naxGBPBfgXOMAHnLHeYjxNemQQlpxX+dWBGl7Y6LIfdZQd
 C5lKdzGux5KkCdpMq5U9p24O891ydubNru573UxVRENDiWaT5qBlOH7dUQXfdkIWXj
 jiR9f3/htHtgtVxo1AlI8aut4j8dSBfWEshFz7Hl+xeFwETXj9CkAz2vi7L8ANqs+X
 H1/+HKOkOyYVtF15WIXm8KM+t7Bha0iDDItY8YfdSEHfBV6mC9XtlymyUwXffbl3zh
 3HQ6s6Cg95k3YwKge+PlQfTKxzXOnFJ/84N07Pbd6u1ORJqXR3c0ZAb7ELvuMyfkqD
 4pOvZxxNIuGmA==
Message-ID: <770d2faf-6523-4528-8325-95c9375ec2fd@kernel.org>
Date: Tue, 11 Aug 2026 15:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260809011914.565936-1-chao@kernel.org>
 <20260809011914.565936-2-chao@kernel.org>
 <CAHJ8P3K3pBm4DodRGpWpR3PMURUeq811h1+yvp9MtXVcUZ5b2w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3K3pBm4DodRGpWpR3PMURUeq811h1+yvp9MtXVcUZ5b2w@mail.gmail.com>
X-Headers-End: 1wtgjp-00026w-IS
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix to zero post-EOF data when
 extending file size
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8xMC8yNiAxNjo1MiwgWmhpZ3VvIE5pdSB3cm90ZToKPiBDaGFvIFl1IHZpYSBMaW51eC1m
MmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPj4gV2hl
biBleHRlbmRpbmcgZmlsZSBzaXplIChlLmcuIHZpYSB0cnVuY2F0ZSwgZmFsbG9jYXRlLCBvciB3
cml0ZSkgYWNyb3NzIGFuCj4+IHVuYWxpZ25lZCBFT0YgYm91bmRhcnksIHdlIG5lZWQgdG8gZW5z
dXJlIHRoYXQgcG9zdC1FT0YgZGF0YSBpbiB0aGUgcGFydGlhbAo+PiBwYWdlIGlzIHplcm9lZCBv
dXQgaW4gcGFnZWNhY2hlIGFuZCBtYXJrZWQgZGlydHksIG1lYW53aGlsZSwgdGFnZ2luZyB0aGUg
aW5vZGUKPj4gd2l0aCBGSV9aRVJPX1BPU1RfRU9GLCBzbyB0aGF0IGZvbGxvd2luZyBjaGVja3Bv
aW50KCkgYW5kIGZzeW5jKCkgY2FuIHBlcnNpc3QKPiBIaSBDaGFvLAo+IEl0IGxvb2tzIGxpa2Ug
dGhpcyB2ZXJzaW9uIGRvZXNuJ3QgaGF2ZSB0aGlzIGZsYWcgIkZJX1pFUk9fUE9TVF9FT0Yi77yf
CgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMsIGZpeGVkIGluIHY1LgoKVGhhbmtzLAoKPiB0aGFu
a3MhCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
