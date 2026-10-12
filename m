Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B57CA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5MNzHbG6jxxlk3FTQisdzZzInRQ9S8OIshrmPIqPLY4=; b=a4CYxyF3aoTJzUj8zj+TstHjXq
	ZmH1IX8anOpqqSRqLmu4pNx1DN9BeZhq2xBFMRrrO8NZ4W8CaDe5Fx/QhLREA3iKSvMDQQtK5jPHz
	9pmoQ37QdlvL3OGZpjjU3D7yVClWphHbvnl7l7LkJUgGs4dbMlqU9E0kPvXY4oa2Kbrs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGCJx-000385-FN;
	Mon, 12 Oct 2026 09:27:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGCJw-00037z-4o
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mBldAvBr6to/RJszegMJr/9taByx3LmRUjouMSy6F6A=; b=JecptJ32/VFysuoi4+SPWl0XmF
 qVIV/AEnElpkNwarhYFwwuVSa1iUVXMMa8izDA4TgI6dj+18W2NqIoU5vNfXKG4qiOBHfuD5jQvEn
 nBjOnXrCvHEziLKuG6SfPFRcmzhIIgBwbVOJL4FG2uMNgwOOR+mWXtRAeGjNxN0cssWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mBldAvBr6to/RJszegMJr/9taByx3LmRUjouMSy6F6A=; b=eFcxTgvMqWBTs+D6BpyvpTXDmU
 1Ao6sZWw/mYFuoZuhaYA89f5GkG9GkAB5a+tp6T2kbOOCw0Ztu5Gg4KkAgoTkrQwkz2DthK7KZKs9
 IVzsQN9Pag7B9e91V9g/36MeHTvYlRy0qiVcB3us8YJ+ALuQeC4+Kmlp69V14idFTBqc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGCJu-0005g8-Ig for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:27:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C75242A42;
 Mon, 12 Oct 2026 09:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC5D1F0089B;
 Mon, 12 Oct 2026 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791797261;
 bh=mBldAvBr6to/RJszegMJr/9taByx3LmRUjouMSy6F6A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=O4eULovXkyLQaQpvNyqGmQCON4HL0pNWUz+yN5y8IGXHVyhUOdlvsQ8GRVF7GSs4A
 ku2XP/W6ccORr6+xKTYPPV/b/wQ2Ihvx7p81fh7uhHPR+zHXDN/rnH9TaHRyqxQg/D
 Ium2eXHHq5vl5JvD7bFEveaaIr+Cvq3C3vSy56znBPxtcZyA2wYiC1xothkjH5F+WQ
 xDZty1SGNGkdVS0w6aJOuOgephJNT/J4XytC8K2S5ukk+HW4ggEXVekSOtHGu38UHx
 YwP1qp3YlDIkl9H3If6yn8DldrX6qsZhvZbf2kdWsAiXTp06Vx3MW9zVj8S9JgfkYC
 QjveFj91GX8Zg==
Message-ID: <33508315-bf40-4c96-b77f-1a5001099d76@kernel.org>
Date: Mon, 12 Oct 2026 17:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20261009091857.1326197-1-chao@kernel.org>
 <20261009101340.3525944-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009101340.3525944-1-qiwenjie@xiaomi.com>
X-Headers-End: 1xGCJu-0005g8-Ig
Subject: Re: [f2fs-dev] [PATCH v2 3/5] f2fs: cache: wake up f2fs_writeback
 when exceeding threshold
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Wenjie,

Thanks a lot for the review.

On 10/9/26 18:13, Wenjie Qi wrote:
> Hi Chao,
> 
>> +	if (dirty_threshold && nr_dirty < dirty_threshold)
>> +		return false;
>> +
>> +	/* don't wake up f2fs_writeback if both thresholds are zero */
>> +	return total_threshold || dirty_threshold;
> 
> There is a related case with only the total threshold enabled. With
> cache_wb_dirty_threshold=0 and cache_wb_total_threshold=1, clean cached
> entries keep the predicate true even when there are no dirty meta/node
> caches. Writeback does not necessarily evict those entries, so the
> thread can keep looping without sleeping.
> 
> I checked this in QEMU using dev-test plus my both-zero fix, which has
> the same predicate for these fixed threshold values. In a three-second
> idle interval, the writeback thread used about three CPU seconds;
> the total cache count was 22 and the dirty count was zero at both
> sample points.
> 
> Should the thread wait when no dirty caches remain, even if the total
> threshold is still met, or is different behavior intended for this mode?

Thanks for the test, yes, it should wait. In v3, the thread won't be
woken up unless there are enough dirty caches for
f2fs_write_{meta,node}_caches() to gather (i.e. dirty count reaches
nr_caches_to_skip()), regardless of the total threshold. Also, threshold
based wakeup will be throttled once a round fails to write anything.

With your setting (dirty_threshold=0, total_threshold=1), I can see the
writeback thread uses 0.0% cpu in idle state, w/ either few or thousands
of clean cached entries, and w/ dirty caches below the threshold under
checkpoint=disable.

Thanks,

> 
> Best regards,
> Wenjie



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
