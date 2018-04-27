From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 18/63] page cache: Add and replace pages
 using the XArray
Date: Thu, 26 Apr 2018 20:24:23 -0700
Message-ID: <20180427032423.GB14502@bombadil.infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180414141316.7167-19-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fBu07-0007is-Ja
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 03:24:47 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBu06-00DZDy-87
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 03:24:47 +0000
Content-Disposition: inline
In-Reply-To: <20180414141316.7167-19-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

On Sat, Apr 14, 2018 at 07:12:31AM -0700, Matthew Wilcox wrote:
> -	xa_lock_irq(&mapping->i_pages);
> -	error = page_cache_tree_insert(mapping, page, shadowp);
> -	radix_tree_preload_end();
> -	if (unlikely(error))
> -		goto err_insert;
> +	do {
> +		xas_lock_irq(&xas);
> +		old = xas_create(&xas);
> +		if (xas_error(&xas))
> +			goto unlock;
> +		if (xa_is_value(old)) {
> +			mapping->nrexceptional--;
> +			if (shadowp)
> +				*shadowp = old;
> +		} else if (old) {
> +			xas_set_err(&xas, -EEXIST);
> +			goto unlock;
> +		}
> +
> +		xas_store(&xas, page);
> +		mapping->nrpages++;

At LSFMM, I was unable to explain in the moment why I was doing
xas_create() followed by xas_store(), rather than just calling
xas_store().  Looking at this code on my laptop, it was immediately
obvious to me -- the semantics of attempting to insert a page into the
page cache when there's already one there is to return -EEXIST.

We could also write this function this way:

+		old = xas_load(&xas);
+		if (old && !xa_is_value(old))
+			xas_set_err(&xas, -EEXIST);
+		xas_store(&xas, page);
+		if (xas_error(&xas))
+			goto unlock;
+		if (old) {
+			mapping->nrexceptional--;
+			if (shadowp)
+				*shadowp = old;
+		}
+		mapping->nrpages++;

which I think is slightly clearer.  Or for those allergic to gotos, the
entire function could look like (option 3):

+       do {
+               xas_lock_irq(&xas);
+               old = xas_load(&xas);
+		if (old && !xa_is_value(old))
+                       xas_set_err(&xas, -EEXIST);
+               xas_store(&xas, page);
+
+               if (!xas_error(&xas)) {
+               	if (old) {
+                       	mapping->nrexceptional--;
+                       	if (shadowp)
+                               	*shadowp = old;
+               	}
+               	mapping->nrpages++;
+
+               	/*
+               	 * hugetlb pages do not participate in
+               	 * page cache accounting.
+               	 */
+               	if (!huge)
+                       	__inc_node_page_state(page, NR_FILE_PAGES);
+		}
+               xas_unlock_irq(&xas);
+       } while (xas_nomem(&xas, gfp_mask & ~__GFP_HIGHMEM));


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
