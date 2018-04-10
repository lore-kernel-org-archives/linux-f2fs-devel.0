From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Date: Tue, 10 Apr 2018 22:28:22 +0900
Message-ID: <20180410132822.GA32026@rodete-laptop-imager.corp.google.com>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <20180409183827.GD17558@jaegeuk-macbookpro.roam.corp.google.com>
 <20180409194044.GA15295@bombadil.infradead.org>
 <20180410082643.GX21835@dhcp22.suse.cz>
 <20180410120528.GB22118@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <minchan.kim@gmail.com>) id 1f5tKC-0007XY-RU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 13:28:40 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f5tK8-007S3m-SB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 13:28:40 +0000
Received: by mail-pf0-f194.google.com with SMTP id l27so8297509pfk.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Apr 2018 06:28:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180410120528.GB22118@bombadil.infradead.org>
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
Cc: Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Christopher Lameter <cl@linux.com>, linux-f2fs-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

On Tue, Apr 10, 2018 at 05:05:28AM -0700, Matthew Wilcox wrote:
> On Tue, Apr 10, 2018 at 10:26:43AM +0200, Michal Hocko wrote:
> > On Mon 09-04-18 12:40:44, Matthew Wilcox wrote:
> > > The problem is that the mapping gfp flags are used not only for allocating
> > > pages, but also for allocating the page cache data structures that hold
> > > the pages.  F2FS is the only filesystem that set the __GFP_ZERO bit,
> > > so it's the first time anyone's noticed that the page cache passes the
> > > __GFP_ZERO bit through to the radix tree allocation routines, which
> > > causes the radix tree nodes to be zeroed instead of constructed.
> > > 
> > > I think the right solution to this is:
> > 
> > This just hides the underlying problem that the node is not fully and
> > properly initialized. Relying on the previous released state is just too
> > subtle.
> 
> That's the fundamental design of slab-with-constructors.  The user provides
> a constructor, so all newly allocagted objects are initialised to a known
> state, then the user will restore the object to that state when it frees
> the object to slab.
> 
> > Are you going to blacklist all potential gfp flags that come
> > from the mapping? This is just unmaintainable! If anything this should
> > be an explicit & with the allowed set of allowed flags.
> 
> Oh, I agree that using the set of flags used to allocate the page
> in order to allocate the radix tree nodes is a pretty horrible idea.
> 
> Your suggestion, then, is:
> 
> -	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
> +	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
> 
> correct?
> 

Looks much better.

Finally, it seems everyone agree on this. However, I won't include
warning part of slab allocator because I think it's improve stuff
not bug fix so it could be separted.
If anyone really want to include it in this stable patch,
please discuss with slub maintainers before.

Thanks for the reivew, Matthew, Michal, Jan and Johannes.

>From 652bb75124896fa040df78b98496a354f54fc524 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 10 Apr 2018 22:13:50 +0900
Subject: [PATCH v4] mm: workingset: fix NULL ptr dereference

GFP mask passed to page cache functions (often coming from
mapping->gfp_mask) is used both for allocation of page cache page and for
allocation of radix tree metadata necessary to add the page to the page
cache. When the mask contains __GFP_ZERO (as is the case for some f2fs
metadata mappings), this breaks radix tree code as that code expects
allocated radix tree nodes to be properly initialized by the slab
constructor and not zeroed. In particular node->private_list is failing
list_empty() check and the following list operation in
workingset_update_node() will dereference NULL.

Fix the problem by removing non-reclimable flags by GFP_RECLAIM_MASK
for radix tree allocations.

Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: stable@vger.kernel.org
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Chris Fries <cfries@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab77e19ab09c..5f3311edfea4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -786,7 +786,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -842,7 +842,7 @@ static int __add_to_page_cache_locked(struct page *page,
 			return error;
 	}
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		if (!huge)
 			mem_cgroup_cancel_charge(page, memcg, false);
-- 
2.17.0.484.g0c8726318c-goog



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
