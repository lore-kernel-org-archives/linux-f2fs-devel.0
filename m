Return-Path: <SRS0=ksoz=NH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B73C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 04:15:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB68619E2;
	Mon, 16 Aug 2021 04:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECB68619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFU2B-00039M-Mg; Mon, 16 Aug 2021 04:15:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mFU2A-00039E-Bo
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 04:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7OL5hAsq/ETtoLhqtDFvCAbwvf7UGurzSfCVa3JX91k=; b=lLd1Cq5UjYCSrnVCOXiVaJ++/r
 QRb94uRgme7HiqvSO7FSnQbxHxjCYe/miCDI6QewZGSP8UU5TiAOOPQPth+QVSj2XE2WQbJSk8Udp
 a87BFv3XaEoKXpcya2zohqxl1LYK4mE2HCyNopRkTtEJUApmQV6DRd3q6Io2irPcN974=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7OL5hAsq/ETtoLhqtDFvCAbwvf7UGurzSfCVa3JX91k=; b=MezTOxpgJe6rbMJk1uhnsErUmd
 mMe2pyVVKtCjpMbwGgd798wGFwfmKL+KAdgEe+NH/ah24krtaDk0m04bs46jOM+1y4gW3IrIsm6Mr
 G2UTY/n0/mNG6G1/FujXbX/lQhyMbUEgIN3tLVsUKqTHzsgKoG+FcDW1RYWMM0xrfPhQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFU25-007tWu-Ib
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 04:15:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 453AC619E1;
 Mon, 16 Aug 2021 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629087319;
 bh=joQfJDa6jYkYAOeq+GjOycG0LtXj3Zk0aKsaKrbhQjI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aYM6pmMGFwnhaeeZHuZab3dkBpAqqk05BR8yssOf7e/gdEF9N0E428nBFHcxUYMxl
 mIkbi6uDrEvQsoxCDzVJ060AGgwwVSwZebSXQ3O2Syxr92vpvZ9AtnRfjPQWRB5TF1
 vCxZRqZGnMFO/e9PIiqMXA+Iw4QNJMDaUM8aw+B/A59gKY1B+0T53vPl2CuFlw2so8
 kVjC/DQ7e4LDB7N1attrogGPLZ2qP2tRqOOhXy259Rak5XiCtvYc2caFzRjzmmvaTw
 2V+5g7dgUlbx6MzGgm9Jemfp7q/nZ8Olwuc198+bCVypLAEUKXDlR43tAdou5P8law
 fp3eMr8GS0wdg==
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
References: <ACIArwDxD7lffBbq-DPSbarm.3.1629081754403.Hmail.frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <af34f9cd-8972-583b-bae2-f11fe9058e63@kernel.org>
Date: Mon, 16 Aug 2021 12:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ACIArwDxD7lffBbq-DPSbarm.3.1629081754403.Hmail.frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mFU25-007tWu-Ib
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add sysfs nodes to get discard
 information
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS84LzE2IDEwOjQyLCDmnY7miazpn6wgd3JvdGU6Cj4+PiBJJ3ZlIGFkZGVkIG5ldyBz
eXNmcyBub2RlcyB0byBzaG93IGRpc2NhcmQgc3RhdCBzaW5jZSBtb3VudCwgd2hpY2gKPj4+IHdp
bGwgaGVscCB1cyBhbmFseXplIHdoZXRoZXIgdGhlIHBlcmZvcm1hbmNlIHByb2JsZW0gaXMgcmVs
YXRlZCB0bwo+Pj4gZGlzY2FyZC4KPj4+Cj4+PiBpc3N1ZWRfZGlzY2FyZCAgLSBTaG93cyB0aGUg
bnVtYmVyIG9mIGlzc3VlZCBkaXNjYXJkCj4+PiBxdWV1ZWRfZGlzY2FyZCAgLSBTaG93cyB0aGUg
bnVtYmVyIG9mIGNhY2hlZCBkaXNjYXJkIGNtZCBjb3VudAo+Pj4gZGlzY2FyZF9jbWRfY250IC0g
U2hvd3MgdGhlIG51bWJlciBvZiBjYWNoZWQgZGlzY2FyZCBjbWQgY291bnQKPj4+IHVuZGlzY2Fy
ZF9ibGtzICAtIFNob3dzIHRoZSBudW1iZXIgb2YgdW5kaXNjYXJkIGJsb2Nrcwo+Pgo+PiBXZSBo
YXZlIGV4cG9ydGVkIHRoZW0gaW4gZGVidWdmcywgY2FuIHlvdSB1c2UgdGhhdD8KPj4KPj4gVGhh
bmtzLAo+IAo+IEJ1dCBub3cgQW5kcm9pZCBpcyBmb3JiaWRkZW4gdG8gb3BlbiBkZWJ1Z2ZzLCBh
bmQgaW4gZmFjdCB3ZSBoYXZlIG5vdAo+IG9wZW5lZCB0aGlzIGNvbmZpZ3VyYXRpb24gZm9yIGEg
bG9uZyB0aW1lLgoKV2VyZW4ndCB0aGVtIGJlIHVzZWQgZm9yIGRlYnVnIHB1cnBvc2U/IGNhbiB5
b3UgcGxlYXNlIGV4cGxhaW4gbW9yZSBhYm91dAp5b3VyIHVzZSBjYXNlPwoKVGhhbmtzLAoKPiAK
PiBUaHgsCj4gWWFuZ3Rhbwo+IAo+IAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
