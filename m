From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Date: Mon, 9 Apr 2018 20:25:14 +0900
Message-ID: <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <minchan.kim@gmail.com>) id 1f5UvT-0002MA-JL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:25:31 +0000
Received: from mail-pl0-f65.google.com ([209.85.160.65])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f5UvS-00CH3j-3y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:25:31 +0000
Received: by mail-pl0-f65.google.com with SMTP id e22-v6so3169246plj.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Apr 2018 04:25:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180409111403.GA31652@bombadil.infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-mm <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, Chris Fries <cfries@google.com>, Christopher Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 09, 2018 at 04:14:03AM -0700, Matthew Wilcox wrote:
> On Mon, Apr 09, 2018 at 12:09:30PM +0900, Minchan Kim wrote:
> > On Sun, Apr 08, 2018 at 07:49:25PM -0700, Matthew Wilcox wrote:
> > > On Mon, Apr 09, 2018 at 10:58:15AM +0900, Minchan Kim wrote:
> > > > It assumes shadow entry of radix tree relies on the init state
> > > > that node->private_list allocated should be list_empty state.
> > > > Currently, it's initailized in SLAB constructor which means
> > > > node of radix tree would be initialized only when *slub allocates
> > > > new page*, not *new object*. So, if some FS or subsystem pass
> > > > gfp_mask to __GFP_ZERO, slub allocator will do memset blindly.
> > > 
> > > Wait, what?  Who's declaring their radix tree with GFP_ZERO flags?
> > > I don't see anyone using INIT_RADIX_TREE or RADIX_TREE or RADIX_TREE_INIT
> > > with GFP_ZERO.
> > 
> > Look at fs/f2fs/inode.c
> > mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> > 
> > __add_to_page_cache_locked
> >   radix_tree_maybe_preload
> > 
> > add_to_page_cache_lru
> > 
> > What's the wrong with setting __GFP_ZERO with mapping->gfp_mask?
> 
> Because it's a stupid thing to do.  Pages are allocated and then filled
> from disk.  Zeroing them before DMAing to them is just a waste of time.

Every FSes do address_space to read pages from storage? I'm not sure.

If you're right, we need to insert WARN_ON to catch up __GFP_ZERO
on mapping_set_gfp_mask at the beginning and remove all of those
stupid thins. 

Jaegeuk, why do you need __GFP_ZERO? Could you explain?

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
