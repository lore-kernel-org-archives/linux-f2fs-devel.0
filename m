From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v3 06/10] f2fs: add core functions for rb-tree
	extent cache
Date: Mon, 16 Feb 2015 16:10:54 +0800
Message-ID: <006301d049c0$3c6ed7b0$b54c8710$@samsung.com>
References: <000301d04129$d7546000$85fd2000$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000301d04129$d7546000$85fd2000$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping.

Any comments on this patch now?

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Thursday, February 05, 2015 5:55 PM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH v3 06/10] f2fs: add core functions for rb-tree extent cache
> 
> This patch adds core functions including slab cache init function and
> init/lookup/update/shrink/destroy function for rb-tree based extent cache.
> 
> Thank Jaegeuk Kim and Changman Lee as they gave much suggestion about detail
> design and implementation of extent cache.
> 
> Todo:
>  * register rb-based extent cache shrink with mm shrink interface.
> 
> v2:
>  o move set_extent_info and __is_{extent,back,front}_mergeable into f2fs.h.
>  o introduce __{attach,detach}_extent_node for code readability.
>  o add cond_resched() when fail to invoke kmem_cache_alloc/radix_tree_insert.
>  o fix some coding style and typo issues.
> 
> v3:
>  o fix oops due to using an unassigned pointer.
>  o use list_del to remove extent node in shrink list.
