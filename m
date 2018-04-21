From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 10/63] xarray: Add xa_for_each
Date: Fri, 20 Apr 2018 18:34:06 -0700
Message-ID: <20180421013406.GM10788@bombadil.infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180414141316.7167-11-willy@infradead.org>
 <35a3318d-69d7-a10c-1515-98ea6b59fb99@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f9hQD-0000uh-Ol
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 01:34:37 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9hQB-005Uit-Su
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 01:34:37 +0000
Content-Disposition: inline
In-Reply-To: <35a3318d-69d7-a10c-1515-98ea6b59fb99@suse.de>
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

On Fri, Apr 20, 2018 at 07:00:47AM -0500, Goldwyn Rodrigues wrote:
> > +/**
> > + * xas_for_each_tag() - Iterate over a range of an XArray
> > + * @xas: XArray operation state.
> > + * @entry: Entry retrieved from array.
> > + * @max: Maximum index to retrieve from array.
> > + * @tag: Tag to search for.
> > + *
> > + * The loop body will be executed for each tagged entry in the xarray
> > + * between the current xas position and @max.  @entry will be set to
> > + * the entry retrieved from the xarray.  It is safe to delete entries
> > + * from the array in the loop body.  You should hold either the RCU lock
> > + * or the xa_lock while iterating.  If you need to drop the lock, call
> > + * xas_pause() first.
> > + */
> > +#define xas_for_each_tag(xas, entry, max, tag) \
> > +	for (entry = xas_find_tag(xas, max, tag); entry; \
> > +	     entry = xas_next_tag(xas, max, tag))
> > +
> 
> This function name sounds like you are performing the operation for each
> tag.
> 
> Can it be called xas_for_each_tagged() or xas_tag_for_each() instead?

I hadn't thought of that interpretation.  Yes, that makes sense.
Should we also rename xas_find_tag -> xas_find_tagged and xas_next_tag
-> xas_next_tagged?

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
