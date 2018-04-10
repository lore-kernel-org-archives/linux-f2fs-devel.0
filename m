From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Date: Mon, 9 Apr 2018 19:41:52 -0700
Message-ID: <20180410024152.GC31282@bombadil.infradead.org>
References: <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
 <20180409144958.GA211679@rodete-laptop-imager.corp.google.com>
 <20180409152032.GB11756@bombadil.infradead.org>
 <20180409230409.GA214542@rodete-desktop-imager.corp.google.com>
 <20180410011211.GA31282@bombadil.infradead.org>
 <20180410023339.GB214542@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410023339.GB214542@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Minchan Kim <minchan@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Christopher Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Apr 10, 2018 at 11:33:39AM +0900, Minchan Kim wrote:
> @@ -522,7 +532,7 @@ EXPORT_SYMBOL(radix_tree_preload);
>   */
>  int radix_tree_maybe_preload(gfp_t gfp_mask)
>  {
> -	if (gfpflags_allow_blocking(gfp_mask))
> +	if (gfpflags_allow_blocking(gfp_mask) && !(gfp_mask & __GFP_ZERO))
>  		return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
>  	/* Preloading doesn't help anything with this gfp mask, skip it */
>  	preempt_disable();

No, you've completely misunderstood what's going on in this function.
