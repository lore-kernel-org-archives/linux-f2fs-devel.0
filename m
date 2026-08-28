Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A582C61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5Ey6UEIhoENVD5mILMolHbwLDmDLUfIKP7sqFAzIGY=; b=WguqweT1tCwaR9QKIqXUpC5Jzs
	AD2H7KdZSyywz1ddKqI9VjUafkv/DZldgn9wJjGmQMcQ6e7ZJHQwLft6U/j6gp1gyOIVNm+cYEGmq
	eHeej/S/UKTWKfD97VEcl8FMBVOwNCg8X8NnidySZeoeikbowOS5vjR0B+t8on+Wtol4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzlWI-0006He-Gk;
	Fri, 28 Aug 2026 01:36:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzlWA-0006HT-Lm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 01:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YKKARV2vN9NQxyou3JfUO6z68mH3Kf/Mg2OcZ94panQ=; b=X5ZBYyRujTAWzKbj8BcifZfha3
 nFgFbH7ELC2FWh2KZ+Iz3b3m2GMprDXWnS6PUEmymApjU/pfiZBp++xsFpsHh58yOEAjjnDragbdf
 YIdtl30+ZbywRihJYapKsayK8s10OiLNZkJBw3enWbxDWWwcFOyj9luSSfQ5/mPthf0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YKKARV2vN9NQxyou3JfUO6z68mH3Kf/Mg2OcZ94panQ=; b=faGe8Uxrf1OVq3jklHXYRY8XmU
 cO6YFCcw6aPc8PkNLgwBRIzUktmLQxzbnkizF4nW2KO7Goi+zMB6n1Zb6NhP/d0E3Hh6xJ1c2oWtT
 yXSGRZflD99nz1mP9YJzdaak8NFqnK8rAuxYIbikd+ntEIivwgWsHU/2P4iIZCDj8x2w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzlW7-0004OO-Q1 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 01:36:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 700EB4092B;
 Fri, 28 Aug 2026 01:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92E1F000E9;
 Fri, 28 Aug 2026 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787880982;
 bh=YKKARV2vN9NQxyou3JfUO6z68mH3Kf/Mg2OcZ94panQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=h6L9NuYfxeoJNMYcS7lrcrZ2Q9C6hEuY7m/T3OjGTILZzl13ryinfc7HhOJb4VuRB
 8nUANpFrn0HHmyJBxfaFaSb3R4/enM9Br7MwDUeP9CTbhxtKVvO51N09zzZXOrIeC8
 PmZEKSfV4C4iYWSItgK7MYnAv7EiYsjLrtPx/kVZfE9jtV9mZQOT+2911eo2nIJIxK
 nf+lk4cEU6aLF+HWU22mVJHtfqqX4UsoC0b82zaHqtdog+yvXFyOGUFSZdepEAHcaN
 G3ZN41OMHdNeKy5Qe51TBLOROkan6UcMhhgcKYJKHzYm3oM575QAUhn6aEH5OdAgBh
 2BHqzVDsXbJSQ==
Message-ID: <e223e7e8-92cb-4264-a39e-08ca1dfb4cce@kernel.org>
Date: Fri, 28 Aug 2026 09:36:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-2-chao@kernel.org>
 <CACOAw_z5fKX2refsnOzUFSXQLVkCetHyzujxEepuja5x+E=mkw@mail.gmail.com>
 <1719b723-988a-4f97-b46f-b74c8d1a94e0@kernel.org>
 <CACOAw_z-QjubNTcodONJoa07qQvvNufBE7sDVegyonJoFPoARQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_z-QjubNTcodONJoa07qQvvNufBE7sDVegyonJoFPoARQ@mail.gmail.com>
X-Headers-End: 1wzlW7-0004OO-Q1
Subject: Re: [f2fs-dev] [PATCH v3 01/12] f2fs: cache: implement metadata
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/28/26 00:56, Daeho Jeong wrote:
> The idea is to drop list_lock completely from f2fs_find_cache() by
> deferring LRU rotation to the shrinker (like page cache's
> PG_referenced / clock algorithm):

Ah, I see, let me implement the logic as you suggested, thanks for the idea!

> 
> In f2fs_find_cache() (no list_lock at all):
> 
> if (entry) {
>     f2fs_cache_get(entry);
>     set_bit(F2FS_BLOCK_REFERENCED, &entry->state);
> }
> 
> In f2fs_do_shrink_cache() Phase 1 (under list_lock):
> 
> list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
>     /* If accessed, give it a second chance and rotate to tail */
>     if (test_and_clear_bit(F2FS_BLOCK_REFERENCED, &entry->state)) {
>         list_move_tail(&entry->list, &cache->lru_list);
>         continue;
>     }
>     ...
>     /* Reclaim cold entry */
> }
> 
> This completely eliminates list_lock overhead from the read lookup
> path while keeping active entries protected from eviction.
Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
