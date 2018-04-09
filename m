From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Date: Mon, 9 Apr 2018 04:14:03 -0700
Message-ID: <20180409111403.GA31652@bombadil.infradead.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Minchan Kim <minchan@kernel.org>
Cc: Christopher Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Apr 09, 2018 at 12:09:30PM +0900, Minchan Kim wrote:
> On Sun, Apr 08, 2018 at 07:49:25PM -0700, Matthew Wilcox wrote:
> > On Mon, Apr 09, 2018 at 10:58:15AM +0900, Minchan Kim wrote:
> > > It assumes shadow entry of radix tree relies on the init state
> > > that node->private_list allocated should be list_empty state.
> > > Currently, it's initailized in SLAB constructor which means
> > > node of radix tree would be initialized only when *slub allocates
> > > new page*, not *new object*. So, if some FS or subsystem pass
> > > gfp_mask to __GFP_ZERO, slub allocator will do memset blindly.
> > 
> > Wait, what?  Who's declaring their radix tree with GFP_ZERO flags?
> > I don't see anyone using INIT_RADIX_TREE or RADIX_TREE or RADIX_TREE_INIT
> > with GFP_ZERO.
> 
> Look at fs/f2fs/inode.c
> mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> 
> __add_to_page_cache_locked
>   radix_tree_maybe_preload
> 
> add_to_page_cache_lru
> 
> What's the wrong with setting __GFP_ZERO with mapping->gfp_mask?

Because it's a stupid thing to do.  Pages are allocated and then filled
from disk.  Zeroing them before DMAing to them is just a waste of time.
