From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 19/63] page cache: Convert page deletion
 to XArray
Date: Thu, 26 Apr 2018 19:58:11 -0700
Message-ID: <20180427025811.GA14502@bombadil.infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180414141316.7167-20-willy@infradead.org>
 <979c1602-42e3-349d-a5e4-d28de14112dd@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fBtar-0006UD-VQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:58:41 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBtap-00BEcF-SW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:58:41 +0000
Content-Disposition: inline
In-Reply-To: <979c1602-42e3-349d-a5e4-d28de14112dd@suse.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, linux-mm@kvack.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Mike Kravetz <mike.kravetz@oracle.com>

On Fri, Apr 20, 2018 at 07:00:57AM -0500, Goldwyn Rodrigues wrote:
> On 04/14/2018 09:12 AM, Matthew Wilcox wrote:
> >  
> > -	for (i = 0; i < nr; i++) {
> > -		struct radix_tree_node *node;
> > -		void **slot;
> > -
> > -		__radix_tree_lookup(&mapping->i_pages, page->index + i,
> > -				    &node, &slot);
> > -
> > -		VM_BUG_ON_PAGE(!node && nr != 1, page);
> > -
> > -		radix_tree_clear_tags(&mapping->i_pages, node, slot);
> > -		__radix_tree_replace(&mapping->i_pages, node, slot, shadow,
> > -				workingset_lookup_update(mapping));
> > +	i = nr;
> > +repeat:
> > +	xas_store(&xas, shadow);
> > +	xas_init_tags(&xas);
> > +	if (--i) {
> > +		xas_next(&xas);
> > +		goto repeat;
> >  	}
> 
> Can this be converted into a do {} while (or even for) loop instead?
> Loops are easier to read and understand in such a situation.

I wish I'd fixed this up earlier because our peers made fun of me at
LSFMM for this loop ;-)

The obvious way to write this loop is:

        for (i = 0; i < nr; i++) {
-               struct radix_tree_node *node;
-               void **slot;
-
-               __radix_tree_lookup(&mapping->i_pages, page->index + i,
-                                   &node, &slot);
-
-               VM_BUG_ON_PAGE(!node && nr != 1, page);
-
-               radix_tree_clear_tags(&mapping->i_pages, node, slot);
-               __radix_tree_replace(&mapping->i_pages, node, slot, shadow,
-                               workingset_lookup_update(mapping));
+               xas_store(&xas, shadow);
+               xas_init_tags(&xas);
+               xas_next(&xas);
        }

But since we're storing the same value to every entry and the range is
a power of two, there's a better way to rewrite this:

 {
-       int i, nr;
+       XA_STATE(xas, &mapping->i_pages, page->index);
+       unsigned int nr = 1;

-       /* hugetlb pages are represented by one entry in the radix tree */
-       nr = PageHuge(page) ? 1 : hpage_nr_pages(page);
+       mapping_set_update(&xas, mapping);
+
+       /* hugetlb pages are represented by a single entry in the xarray */
+       if (!PageHuge(page)) {
+               xas_set_order(&xas, page->index, compound_order(page));
+               nr = 1U << compound_order(page);
+       }

        VM_BUG_ON_PAGE(!PageLocked(page), page);
        VM_BUG_ON_PAGE(PageTail(page), page);
        VM_BUG_ON_PAGE(nr != 1 && shadow, page);

-       for (i = 0; i < nr; i++) {
-               struct radix_tree_node *node;
-               void **slot;
-
-               __radix_tree_lookup(&mapping->i_pages, page->index + i,
-                                   &node, &slot);
-
-               VM_BUG_ON_PAGE(!node && nr != 1, page);
-
-               radix_tree_clear_tags(&mapping->i_pages, node, slot);
-               __radix_tree_replace(&mapping->i_pages, node, slot, shadow,
-                               workingset_lookup_update(mapping));
-       }
+       xas_store(&xas, shadow);
+       xas_init_tags(&xas);



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
