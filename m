Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEFBC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yq17yvD38kpwJsVG5d9rE20Q5e6rNjLMg3+GP7ruRk8=; b=W9l6kTLBa2FTcUs6E0ydnR23DF
	I3SMXA2GU5mo66GGZ3jGTAKO5c2alx2xn2UNh96fnFV5weYcSrmsiX2w3io+x1pd3oreOpvCPiyB/
	dt4PZBpKo0gE10V/aDc4AWOSRlrdqVzUWBzJZxNisJDYGT7tBQjX3WF7UK6kt041k/C0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqqgA-0004o8-PS;
	Mon, 03 Aug 2026 11:17:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqqg8-0004nz-Kp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:17:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxMHEVZ5lvURQccCytgBzz60+hKdTr7VQ/fMX7z8Nl0=; b=arpTwjjsMPXq6CHn1OvG9mFP++
 cWo12Avm5YxscsBE2zeSaTeIwHBdS/5m5vubQM8kFfaAGub742zhcdyCfO1W89TO0SmRsW5KRyZk9
 rO+nmxhhWahIqZny0HwdhF23gY/W+odOuAfI7qf1FU8YTubAlyhjkh4r/n6SVOWpNqJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dxMHEVZ5lvURQccCytgBzz60+hKdTr7VQ/fMX7z8Nl0=; b=RpclOFop9ntGAJLWRPaj6kfTAU
 WdERiiN7kxDR7suPUXdTvHHkILSwb26zOSoUhpPSfknkAHvVKlYkUMFARdkp5koD6YcYCjZSKsiYw
 l5bXekYbt1bJpQOQ+RNdiF+AXckUdRVuttACxhg6aF+Cz5BIctV7bomzN1Rj+L9lx2fo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqqg8-0007aX-Ls for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:17:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01F6A60A82;
 Mon,  3 Aug 2026 11:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4F1F000E9;
 Mon,  3 Aug 2026 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785755870;
 bh=dxMHEVZ5lvURQccCytgBzz60+hKdTr7VQ/fMX7z8Nl0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bkILrIzgpJ8B4/gwmJ1vUJmKO8vaeVFvaNA7233yvcmyZmalQnHW34+0vwwhM8cmO
 8UzmxRCKcL6avYHS2XfV1YYFEQuenOlT+P+zHt/9nSkQuLpDLM6qsd2OKhL4vJDuSI
 b8B5M+IyF/xYRxkrxJ4XOxadWZ6Y4gbWsrp3jR+POQC7dcFasn0kVcSbpxuHu4+wyu
 HoZjfC16g9h/oBL7wujbvKuqkzIz7ktKYqMYDJFDHP9SmfKqRu6jYhJfdhJFU2ph6Q
 AOrmwZ65JWx4HtizrSpfjHQF7YbewTqVfrdtHavd6PcKKpbXhAWoQvarLikCgMWfNC
 g7cqLP1juO/GQ==
Message-ID: <f27a21cb-42fc-4503-972a-6913312cab20@kernel.org>
Date: Mon, 3 Aug 2026 19:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
 <20260731-remove-pg_private-v1-6-142c97ba3562@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260731-remove-pg_private-v1-6-142c97ba3562@nvidia.com>
X-Headers-End: 1wqqg8-0007aX-Ls
Subject: Re: [f2fs-dev] [PATCH RFC 06/14] fs/f2fs: stop using PG_private
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
Cc: linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/1/26 10:13, Zi Yan wrote:
> f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
> page->private != NULL is equivalent to checking PG_private. Change
> PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
> page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
> but it can cause confusion when PG_private is removed and
> page->private != NULL is used instead. Change it to initialize
> page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
> semantics.
> 
> It prepares for a future commit that removes PG_private.
> 
> No funtional change intended.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org

Acked-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
