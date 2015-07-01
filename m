From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: refactor shrink flow for extent cache
Date: Tue, 30 Jun 2015 18:25:36 -0700
Message-ID: <20150701012536.GD1496@jaegeuk-mac02.mot.com>
References: <00ea01d0b321$854293d0$8fc7bb70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00ea01d0b321$854293d0$8fc7bb70$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Jun 30, 2015 at 06:42:09PM +0800, Chao Yu wrote:
> For now, in extent cache, we have a global lru list which links all extent
> node in the cache, and the list is protected by a global spinlock.
> 
> If we want to shrink extent cache, we will:
> 1. delete all target extent node from global lru list under spinlock;
> 2. traverse all per-inode extent tree in global radix tree;
> 	2.a. traverse all extent node in per-inode extent tree, try to free extent
>          node if it is not in global lru list already.
> 
> This method is inefficient when there is huge number of inode extent tree in
> global extent tree.
> 
> In this patch we introduce a new method for extent cache shrinking:
> When we attach a new extent node, we record extent tree pointer in extent node.
> In shrink flow, we can try to find and lock extent tree of inode directly by
> this backward pointer, and then detach the extent node from extent tree.
> 
> This can help to shrink extent cache more efficiently.

Yes, but as we discussed before, this way will consume 4 bytes per each
extent_node. Can it be acceptable?

Instead, IMO, we need to focus on how to increase its hit ratio first.
Actually, I wrote a patch for that.
Could you check that first?

Thanks,
