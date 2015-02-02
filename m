From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2 06/10] f2fs: add core functions for rb-tree
 extent cache
Date: Mon, 02 Feb 2015 10:59:28 +0800
Message-ID: <009c01d03e94$685cab90$391602b0$@samsung.com>
References: <006201d0392c$43741650$ca5c42f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <006201d0392c$43741650$ca5c42f0$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi all,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Monday, January 26, 2015 1:52 PM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH v2 06/10] f2fs: add core functions for rb-tree extent cache
> 
> This patch adds core functions including slab cache init function and
> init/lookup/update/shrink/destroy function for rb-tree based extent cache.
> 
> Thank Jaegeuk Kim and Changman Lee as they gave much suggestion about detail
> design and implementation of extent cache.
> 
> Todo:
>  * add a cached_ei into struct extent_tree for a quick recent cache.
>  * register rb-based extent cache shrink with mm shrink interface.
>  * disable dir inode's extent cache.
> 
> v2:
>  o move set_extent_info and __is_{extent,back,front}_mergeable into f2fs.h.
>  o introduce __{attach,detach}_extent_node for code readability.
>  o use f2fs_kmem_cache_alloc/f2fs_radix_tree_insert for code readability.
>  o fix some coding style and typo issues.
>  o get rid of node/tree count stat in f2fs_{shrink,destroy}_extent_tree.
> 

There is an obviously bug in this patch, with it we will encounter an oops easily,
My mistaken, Please ignore this patch set, sorry for the noise. :(

I will send a v3 later.

Thanks,
