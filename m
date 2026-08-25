Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6D4C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vz6UQXbXlpPylK4Zo2yohArj7I/oCISWzEczfCszRE=; b=Vowbp1ek9+PV5oAPok01FUCvwv
	WVXg4QFHhlCBqB0d9Sde3ll8yZt2z7h4sUhZQR7yEYlROspvQwcAkNqtloXNi8IxDGG7T/555nZyG
	1Jtfmb+r/3ZsRHCvqvAmqqdzL8UZVl3Q/p67QlV2VGsmI3fO7lmVt9KUv2Hulc7SWV60=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykn2-0002tp-LE;
	Tue, 25 Aug 2026 06:37:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wykn0-0002tg-Qu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l7Ee1JZBIyLORgFg9NlUUL8nKnpoMSsHscV834uYwoQ=; b=ZVqgBRfaAsxfqnCr+5lNzX3Ip8
 KhCzYQbsR2mzI3T6gzc+b5PQXIrxsh0cv9WMvme0OYcXTtpcZ2Y1lnSoA5CWQWCGkMRe36jhLc9DB
 lM+JJntxphfjUZ7QiFcks2fTCq1/3j7BL0V6uU3D4NZg3ZsGiqKLQMfoeX9WcV5WiEP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l7Ee1JZBIyLORgFg9NlUUL8nKnpoMSsHscV834uYwoQ=; b=D+gKBaz+kw1OeBmHMdbbDnBUYq
 i/XBYnzjJYU0vuZFu0eKAGxw2FMGEcycNgO2sIfbEcyyNMFQqJrVC4Wzn3tPCF5aqCbnS90u6wKRj
 1DxkhO2TaYjH9wzq4zV9J3PNaiVEShVJIH9he/VfySYn5NHrJzqmczosBxVBetZrDbeo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykmz-0006jf-Uw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:37:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65E9B6011F;
 Tue, 25 Aug 2026 06:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD751F000E9;
 Tue, 25 Aug 2026 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639856;
 bh=l7Ee1JZBIyLORgFg9NlUUL8nKnpoMSsHscV834uYwoQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Bs0/2QPFaU34Sfa4ENEzHuF/Qo0HzPHEuY24758V52CHUR7GmGE9cjt0qBpQAg7Pr
 bTXjx5m9Gww0rQK4uNh6rd1sTlqxfOuqc2d/+wNb9AznKN/Z60wuqqPYdPbHW3X9kK
 DyMRas2guM3dDHst8S9PxDuW5Ie4K2q2UJllg4RUDlpcYwRmehBbceZN61eUoUQto8
 GM4lM9QvQTyew4GCnvQ61P/yboRc7TKPv43qzs4pUfUekNH9ndWbfGsXcEIKmzmsf0
 ukmYyDapwa/w7TyJA4XLftL7/mrfN2VI8W5AIQBEVYp12lPSzx4d7AJhaqoBCJ2n+H
 COwh0gbvlMqww==
Message-ID: <970e87b6-23e1-4d34-9a13-68567692294e@kernel.org>
Date: Tue, 25 Aug 2026 14:37:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-6-chao@kernel.org>
 <20260825054248.399693-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054248.399693-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykmz-0006jf-Uw
Subject: Re: [f2fs-dev] [PATCH v2 05/12] f2fs: cache: use meta cache
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

will fix, thanks,

On 8/25/26 13:42, Wenjie Qi wrote:
> Hi Chao,
> 
>> case META:
>> 	nr_to_write = BIO_MAX_VECS;
>> 	break;
> 
> and in `f2fs_sync_meta_caches()`:
> 
>> nwritten += sbi->blocksize;
>> prev = entry->index;
>> if (unlikely(nwritten >= nr_to_write))
>> 	break;
> 
> `adjust_flush_cache_number()` returns `BIO_MAX_VECS` for META, while
> `nwritten` advances by `sbi->blocksize` for each entry before the comparison.
> 
> Are `nr_to_write` and `nwritten` intended to be entry counts or byte counts in
> this path?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
