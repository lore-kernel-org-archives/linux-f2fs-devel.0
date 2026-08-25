Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86011C61CE3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpnhicU1IY+O3m/3Q4EXRkd0KVy+iKYGGN05qQjuqHY=; b=Va/iusFr7g5b5nRRAbcO+y0Z3+
	HhYfAQ/M4giOy0M9EDUPuNg8SHnnDPbyRTLxLiE/gH/ZNWeRBbAdtNvbf60pQVcwIDpByuMBwjSSh
	F7LF/6pHVbEwGCqSraxIzfDVZc6u6ZSZ0xqegL8L4XHgWUZgXTwWwLKbelRDyNfM6Vdo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyklB-0002pm-EQ;
	Tue, 25 Aug 2026 06:35:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyklA-0002pg-HS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7T4e1XtewZaaSN4eTuSLlf7noxajHwVsSl6GIgpNduo=; b=ZrzzLGmqBJW9vWUbhS2mrrQkvx
 Kmu163jxMHn2l1x4h/vAo61yrPQtlQTtXcQpyhNwqf3xZGHWTFcBtlsrQXTnMGqwI3dv4LLSm4SFY
 4WoCOM4eRQNZyJmxO0Dxgc8fbm0DBBupKf57JuGmFTM2IitfwnPPzQvsCBcOAdo3+B8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7T4e1XtewZaaSN4eTuSLlf7noxajHwVsSl6GIgpNduo=; b=mYK/InNnB0gkbAvr8Muou6hxcT
 6kjVyca4Ah4tYU2UyTLHtX0DjCD7ydHboyImd59K5GlXJcOs6ZCtXhzaPniNwJoBbffuNFEX7x8j8
 41lZxajJtDcjljI5TpN+ZKxjKCuXP4Y9RZmN7F5T1TFLbZa4CGB/BauNraKnV5vGle5Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykl8-00054s-Uw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:35:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95EC540A34;
 Tue, 25 Aug 2026 06:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8571F000E9;
 Tue, 25 Aug 2026 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639741;
 bh=7T4e1XtewZaaSN4eTuSLlf7noxajHwVsSl6GIgpNduo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=m8+gtRPmqVscM+FfeBkjPw7EX5rMbuvsW1Vuk0h9YNQOzEkfVgx+C9xEs5CKcSmJ8
 cyeqJc732WDZZgC13qw+k67xLhDM50DZzNiHw58ndzr4ZFBNoGJEPNGoNf4idSxjcw
 EBSeDFfF0l/zPBcQp/liSmtkr7VGvB+J6KRyvchKc5KJgdv3co8BcFva/gms5kyTp+
 vm0RlPa3MdertUcx/nq/XzbGNnDBhTkGOWBBQqDkzKULEylUQLWySn66+l6MLv3sTv
 ReFbyFvOC994UQDFPSO+BQNAi9pjJw/E7GhkNvx8GsYAXPzYEM6kxmj9vTsePPiPeb
 /5/OLrnPGUOTQ==
Message-ID: <54d08d5d-297f-4736-bcd5-133b089d093f@kernel.org>
Date: Tue, 25 Aug 2026 14:35:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-2-chao@kernel.org>
 <20260825053959.395465-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825053959.395465-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykl8-00054s-Uw
Subject: Re: [f2fs-dev] [PATCH v2 01/12] f2fs: cache: implement metadata
 cache
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

On 8/25/26 13:39, Wenjie Qi wrote:
> Hi Chao,
> 
>> next:
>> 	spin_lock_irqsave(&cache->tree_lock, flags);
>> 	nr = radix_tree_gang_lookup(&cache->root, (void **)entries, index,
>> 		min((unsigned long)F2FS_ONSTACK_CACHES, end - index));
>> 	...
>> 	spin_unlock_irqrestore(&cache->tree_lock, flags);
>> 	...
>> 	if (index < end)
>> 		goto next;
> 
> `nr` bounds each gang lookup, while the outer loop continues until `index`
> reaches `end`.  Dropping `tree_lock` between batches is not itself a
> scheduling point.
> 
> Is there a scheduling point or another bound on the number of entries that
> this range invalidation can process in one invocation?

Wenjie,

I think it's good to have cond_resched() before "goto next", will fix in below
cases:

- f2fs_cache_wait_on_all_writeback
- f2fs_drop_cache_range
- f2fs_invalidate_compress_pages

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
