From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Date: Wed, 27 Jun 2018 04:05:29 -0700
Message-ID: <20180627110529.GA19606@bombadil.infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
 <20180619031257.GA12527@linux.intel.com>
 <20180619092230.GA1438@bombadil.infradead.org>
 <20180619164037.GA6679@linux.intel.com>
 <20180619171638.GE1438@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fY8Gm-0004uG-58
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 11:05:52 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fY8Gh-00ACab-72
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 11:05:52 +0000
Content-Disposition: inline
In-Reply-To: <20180619171638.GE1438@bombadil.infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

On Tue, Jun 19, 2018 at 10:16:38AM -0700, Matthew Wilcox wrote:
> I think I see a bug.  No idea if it's the one you're hitting ;-)
> 
> I had been intending to not use the 'entry' to decide whether we were
> waiting on a 2MB or 4kB page, but rather the xas.  I shelved that idea,
> but not before dropping the DAX_PMD flag being passed from the PMD
> pagefault caller.  So if I put that back ...

Did you get a chance to test this?

> diff --git a/fs/dax.c b/fs/dax.c
> index 9919b6b545fb..75cc160d2f0b 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -367,13 +367,13 @@ static struct page *dax_busy_page(void *entry)
>   * a VM_FAULT code, encoded as an xarray internal entry.  The ERR_PTR values
>   * overlap with xarray value entries.
>   */
> -static
> -void *grab_mapping_entry(struct xa_state *xas, struct address_space *mapping)
> +static void *grab_mapping_entry(struct xa_state *xas,
> +		struct address_space *mapping, unsigned long size)
>  {
>  	bool pmd_downgrade = false; /* splitting 2MiB entry into 4k entries? */
>  	void *locked = dax_make_entry(pfn_to_pfn_t(0),
> -						DAX_EMPTY | DAX_LOCKED);
> -	void *unlocked = dax_make_entry(pfn_to_pfn_t(0), DAX_EMPTY);
> +						size | DAX_EMPTY | DAX_LOCKED);
> +	void *unlocked = dax_make_entry(pfn_to_pfn_t(0), size | DAX_EMPTY);
>  	void *entry;
>  
>  retry:
> @@ -1163,7 +1163,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	if (write && !vmf->cow_page)
>  		flags |= IOMAP_WRITE;
>  
> -	entry = grab_mapping_entry(&xas, mapping);
> +	entry = grab_mapping_entry(&xas, mapping, 0);
>  	if (xa_is_internal(entry)) {
>  		ret = xa_to_internal(entry);
>  		goto out;
> @@ -1396,7 +1396,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * page is already in the tree, for instance), it will return
>  	 * VM_FAULT_FALLBACK.
>  	 */
> -	entry = grab_mapping_entry(&xas, mapping);
> +	entry = grab_mapping_entry(&xas, mapping, DAX_PMD);
>  	if (xa_is_internal(entry)) {
>  		result = xa_to_internal(entry);
>  		goto fallback;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
