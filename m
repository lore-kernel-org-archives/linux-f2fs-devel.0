Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081CFC61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AskPiu8TY1lONqzl6KN8Y8x+oSrQuCXdR3s8wEgNl7c=; b=CdA5PIvFiNYJbCvgCQxCY/poYP
	qM41YBvagcxfWkQvKpnTBHnk3Qq+/tQlxo7z9INof3YKxn6FxPc5KtfPcylFexcW+jQKMQnfu9eOz
	QhjDJjPqp08qyAHrIuPq4DeUF8cxzVQiQZjdwhr2bkCUCNOXzGwQioTvrFtgoA0Ya2HQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzvjt-0000Sa-FA;
	Fri, 28 Aug 2026 12:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzvjr-0000SU-VI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l7/bzP+bxXEb9BNwDHXfP5vldKfjbCha8CUQbZjALas=; b=Ix1FJQbVBAfk5M9zT7AjGaCuV4
 gqolnJky5Z36kgJOH8RmxSW+2Z3lTOjNe+ejpV8S8gr4klAClDQQdeE7NLvvFWargfCWauDZp6sIY
 D739is6hLGizGLXkKdbBBztjqPWA9E9mdhzSDjx3oQfrJYRyP+8ZIAUOh4JBvsCoAHqM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l7/bzP+bxXEb9BNwDHXfP5vldKfjbCha8CUQbZjALas=; b=MnqQIfaTarIHBLs/Wbre+RZDiK
 0k4H7CyVgo4Q1uJWNPeglzhslT0VNMvZu5mxFDgavXjwoCnsCyEKAJj6l3mcCbmgcUl+SUmDohPNo
 tJ8tpIoevVk7FNG+bNS+beKdfGI1ykn3TQn9O1+bBI7kytQ74zzMrDZpN8Zax30R+bZk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzvjq-0004li-E8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:31:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF665601F5;
 Fri, 28 Aug 2026 12:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D3B1F000E9;
 Fri, 28 Aug 2026 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787920272;
 bh=l7/bzP+bxXEb9BNwDHXfP5vldKfjbCha8CUQbZjALas=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eMZc++vuXaMpSr/UL+CpZp5HglBIQYv+TQUTJffDcx9vmzwsJhhSRiRlJEXQ6uYnF
 f4F9r24D4b4moot+7VOC3kmzQk3VlpqMcY+bVA+Se999I2exVj4/bVDTRYksmm6sm2
 2AOFa2LlfGFiLRDG5vYY8vj78ELRu1eXfMShpBuoCZyon5G/Q9xaTHy1xFXktiGtyr
 JF7r7hfGa5ldH+Vygag6M9nWcdd3aNk2VbwS+HdjHp+lVTrBW7WKUlVu8YrXjSI9FK
 qDeMpwu9sXROMUW3wMHiICkyqtwtZxeW/To4VBEcsi618M7vGRvyNtwKrmIYuD2jDS
 MD4liZJjMNl6A==
Message-ID: <c4eb34be-628f-45a7-ab5b-9ac55b48f83a@kernel.org>
Date: Fri, 28 Aug 2026 20:31:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
 <70a44f25-f38b-473e-b941-e001229a97c4@gmail.com>
Content-Language: en-US
In-Reply-To: <70a44f25-f38b-473e-b941-e001229a97c4@gmail.com>
X-Headers-End: 1wzvjq-0004li-E8
Subject: Re: [f2fs-dev] [PATCH v2 0/3] f2fs: fix read extent cache merge and
 add debug interface
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Yongpeng,

Sorry, too busy these days, so I have to add this serial and inline extent
into my TODO review list. : P

Let me know if you have urgent fix that needs to upstream.

On 8/25/26 10:46, Yongpeng Yang wrote:
> On 8/15/26 00:49, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> This series fixes a read extent cache merge bug and adds a sysfs-based
>> debug interface for inspecting the in-memory extent tree, which is
>> otherwise invisible to userspace (fsck can only see the on-disk i_ext,
>> never the in-memory rbtree).
>>
>> Changes since v1 (RESEND [1]):
>>
>> - Patch 1 (was 1/5) reuse the result of __is_back_mergeable().
>>
>> - Dropped [PATCH RESEND 2/5] "only initialize largest extent without
>>    extent_node at inode init": no benefit was observed in practice.
>>
>> - Patch 2 (was 3/5) unchanged.
>>
>> - Dropped [PATCH RESEND 4/5] "add extent_access_mode to track extent
>>    cache access patterns": on phones the read extent node memory budget
>>    is small, and no hit-ratio improvement was observed in performance
>>    tests.
>>
>> - Patch 3 (was 5/5) -- replace the ioctl with a write-only per-sb sysfs
>>    entry `extent_cache_debug`. Writing a file descriptor to it resolves
>>    the inode in the writer's context, dumps the largest extent and every
>>    rbtree node (fofs/blk/len) to the kernel log via f2fs_info(); inspect
>>    with "dmesg | grep ino=<ino>". A matching f2fs_io `extent_cache`
>>    subcommand is added in f2fs-tools.
>>
>> [1] https://lore.kernel.org/all/20260612115839.2065903-1-yangyongpeng.storage@gmail.com/
>>
>> Patch 1: fix extent merge failure when largest extent is not in rb-tree.
>>    When the largest extent exists only as a hint with no rbtree node
>>    (e.g. after shrink eviction), a newly inserted extent that is
>>    mergeable with it is not merged, leaving a gap that fiemap reports as
>>    separate extents.  Merge the new extent with the largest before the
>>    normal lookup.
>>
>> Patch 2: punch largest extent instead of dropping it entirely on
>>    overlap.  Keep the larger remaining left/right portion after a
>>    partial overlap instead of discarding the whole largest extent,
>>    preserving cache coverage for truncate/overwrite.
>>
>> Patch 3: dump read extent cache via sysfs for debugging.
>>
>> Yongpeng Yang (3):
>>    f2fs: fix extent merge failure when largest extent is not in rb-tree
>>    f2fs: punch largest extent instead of dropping it entirely on overlap
>>    f2fs: dump read extent cache via sysfs for debugging
>>
>>   fs/f2fs/extent_cache.c | 100 ++++++++++++++++++++++++++++++++++++++---
>>   fs/f2fs/f2fs.h         |   1 +
>>   fs/f2fs/sysfs.c        |  18 +++++++
>>   3 files changed, 112 insertions(+), 7 deletions(-)
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> ping
> 
> Thanks,
> Yongpeng
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
