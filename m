Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC6FC369D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Apr 2025 00:42:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u9CZh-0002RH-Hd;
	Mon, 28 Apr 2025 00:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1u9CZd-0002R5-4E
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 00:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=253L+dW9y0+QF5H9qTod08othC3elXAsaDjNWZPWCTA=; b=UxaR2vMM8VcgxEym5gExEqMobj
 H4fopVAzSET6xFJjsMxCg8WIZPYwmng4SKCWEvWCrrvYr34h7bznNz50ygGhZ5paNHNHyAr8qKSQ3
 T7VLNkvsWAvGRT9nG0Fq224vCiyqSkavExB6ak4+4TTu9iwnY3jS/gEFMHbLHcbOXWxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=253L+dW9y0+QF5H9qTod08othC3elXAsaDjNWZPWCTA=; b=IpN/wkf4P9x7Fk/zZUOqJnTrnF
 V1b6O2NMgkUb1vQFddRR3nJdJ4PUGw7LG5VScJZDh2Aa6dvp1Qbh3OOTS8QbeBDLxn8MF8nC5SFmi
 4H2boOqwICh+861+c196owfsyG6He87JlTak390V5UMKlflvCpdL6e0QxfGZfsKXz/nk=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u9CZN-0007BW-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 00:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=253L+dW9y0+QF5H9qTod08othC3elXAsaDjNWZPWCTA=; b=Mo3kSFvffHgcBoR6oiqGDtF0P5
 w+d9253RXguB+P2thF+PBLBSLNsf3EkfjJrT3Am+iaMktxc9xCfS5Y+mFc2iJR4Q1bVoBMBYySPoE
 2R5U8HtEtmrCRbvRYzoOMp1H05FKBx1FvZB+9dafCjPzvllYUbvkOh98r5/qc5XwHsbkM0kmg7+y2
 DzTUWZbuliI3fXbJ8isBd9fxtxCQ9R+ZsFY+M8WB7k/9Y4Q5R4dURLgtKHrA5Bd7c72xc4A4e9PeD
 SjQauGX6woHk6tz+TEN5Q8UCyWIaP4FnURJCGDSHKQnNCK/V+k7C+ZkSADMkmZ9zIvuryMQM9g0X4
 z4cJXfNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1u9CYq-00000004j3f-3Jrm;
 Mon, 28 Apr 2025 00:41:28 +0000
Date: Mon, 28 Apr 2025 01:41:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Message-ID: <aA7OuBS___7N4o8f@casper.infradead.org>
References: <20250427185908.90450-1-ryncsn@gmail.com>
 <20250427185908.90450-4-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250427185908.90450-4-ryncsn@gmail.com>
X-Headers-End: 1u9CZN-0007BW-N7
Subject: Re: [f2fs-dev] [PATCH 3/6] f2fs: drop usage of folio_index
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
Cc: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, "Huang,
 Ying" <ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 28, 2025 at 02:59:05AM +0800, Kairui Song wrote:
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` and that is not supported for f2fs.  So just drop it
> and use folio->index instead.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE SYSTEM)
> Cc: Chao Yu <chao@kernel.org> (maintainer:F2FS FILE SYSTEM)
> Cc: linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM)
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -130,7 +130,7 @@ int f2fs_read_inline_data(struct inode *inode, struct folio *folio)
>  		return -EAGAIN;
>  	}
>  
> -	if (folio_index(folio))
> +	if (folio->index)
>  		folio_zero_segment(folio, 0, folio_size(folio));
>  	else
>  		f2fs_do_read_inline_data(folio, ipage);

This hunk is going to conflict with a pair of patches I sent to f2fs-devel
a few weeks ago.  I don't think there's any escaping it, just a heads-up.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
