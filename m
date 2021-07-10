Return-Path: <SRS0=5ZV8=MC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD2C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Jul 2021 08:12:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C43613B6;
	Sat, 10 Jul 2021 08:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C43613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m285e-0007mB-4r; Sat, 10 Jul 2021 08:11:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m285c-0007ly-EN
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5NM9n2h0f5QWxhjfOyIiZHStMsZB8CslRHh1lf50xsI=; b=dEvErIcbSXw8uKP3BWYUhHZmvQ
 p7tIRlsqMgEUlnzrblUouPcokMe1l/2PlYj9mSGA8Q19gU/SEEZJYLEBPFZUsYHS4J7K19IfitMRF
 s2t5arXhOscwRH+2efcieklje+HYjw96dREamF0lFZ4EaEqKru0nqSYRLyOgkKXXlJzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5NM9n2h0f5QWxhjfOyIiZHStMsZB8CslRHh1lf50xsI=; b=MYIKlIaxp57ll38pjRkeNT5pOf
 TDvKDFgBf/haThzuXgJHF9OCDWxwuPRZb2JWuQ+HwJ8e0AFIWoviwEpyOTtjOKnhCnyvy+YP+6aj8
 A9g3qywFak62ynkQRm5ZAwnJ8RPUmrxohRMdQXwZPnpoog1uo4oiDyReRB+G1e9kf3yY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m285S-0005qA-7E
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 08:11:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D867613BF;
 Sat, 10 Jul 2021 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625904700;
 bh=80vkX1XEmaWnY9YWGGJrbpCeJVSm+nQLZW7RcdCPUx0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mHbog3l2LduSeGAF3DzD/KSd70LZKz97K4+e0OK+p9Q7A46+y/P74ea+Ih6l2e8tG
 xHTneVNBxZaNZgaDfUrT1O/pC5xe0WiRXJkthCZVXjAIHgvZIhWiGd2WiXJMvBp0U8
 2A78yXIrmqimkTlSxVPVvqvr3jJEKQ+w6ahNdq2c0fF05IX1hJ+Z6Qmdi4hWOmHyoP
 WvFFYTONAY/ql2803JuvGxJyZrgKiUyIBUmOmWruou+sFB4rd8VJpuwx7fe8VMprHK
 5zfwtrgUhZ6/YOEaNUc6EMrEVXOI8zfFCuUegITcLFTzI6efeApaOvDGbYZ/7ZUUdH
 4cLOVQ/LQi6Mg==
To: Mel Gorman <mgorman@techsingularity.net>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org> <YONJpQapR7BRnW/J@google.com>
 <YONTRlrJugeVq6Fj@casper.infradead.org>
 <20210706091211.GR3840@techsingularity.net>
 <85bb893b-0dc4-5f57-23ec-3f84814b7072@kernel.org>
 <20210707095706.GT3840@techsingularity.net>
From: Chao Yu <chao@kernel.org>
Message-ID: <fc0de0c2-a3b6-df91-5b90-524768a85d82@kernel.org>
Date: Sat, 10 Jul 2021 16:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707095706.GT3840@techsingularity.net>
Content-Language: en-US
X-Headers-End: 1m285S-0005qA-7E
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using
 for our internal use
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
Cc: linux-mm@kvack.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/7 17:57, Mel Gorman wrote:
> I think it would work but it would be preferable to find out why the
> tail page has an order set in the first place. I've looked over

Agreed.

> mm/page_alloc.c and mm/compaction.c a few times and did not spot where
> set_private_page(page, 0) is missed when it should be covered by
> clear_page_guard or del_page_from_free_list :(

I didn't enable CONFIG_DEBUG_PAGEALLOC, so we will expect page private
should be cleared by del_page_from_free_list(), but I guess it only clears
the buddy's private field rather than original page's, so I added below
diff and check the dmesg, it looks stall private value in original page
will be left commonly... Let me know if I missed something?

---
  mm/page_alloc.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a06bcfe6f786..1e7031ff548e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1029,6 +1029,7 @@ static inline void __free_one_page(struct page *page,
  	unsigned long combined_pfn;
  	unsigned int max_order;
  	struct page *buddy;
+	struct page *orig_page = page;
  	bool to_tail;

  	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
@@ -1097,6 +1098,10 @@ static inline void __free_one_page(struct page *page,

  done_merging:
  	set_buddy_order(page, order);
+	if (orig_page != page) {
+		if (WARN_ON_ONCE(orig_page->private))
+			pr_info("2order:%x, origpage.private:%x", order, orig_page->private);
+	}

  	if (fpi_flags & FPI_TO_TAIL)
  		to_tail = true;
-- 
2.22.1



> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
