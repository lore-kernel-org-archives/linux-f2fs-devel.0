From: Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v10 44/62] memfd: Convert shmem_wait_for_pins
 to XArray
Date: Fri, 30 Mar 2018 17:07:34 -0700
Message-ID: <4b70ad17-a176-9510-5525-30da01eba18e@oracle.com>
References: <20180330034245.10462-1-willy@infradead.org>
 <20180330034245.10462-45-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mike.kravetz@oracle.com>) id 1f24DN-00056C-9B
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Mar 2018 00:17:49 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f24DL-006PNM-63
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Mar 2018 00:17:49 +0000
In-Reply-To: <20180330034245.10462-45-willy@infradead.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

On 03/29/2018 08:42 PM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> As with shmem_tag_pins(), hold the lock around the entire loop instead
> of acquiring & dropping it for each entry we're going to untag.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Same comments as with with the previous shmem_tag_pins patch.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/memfd.c | 61 +++++++++++++++++++++++++------------------------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 3b299d72df78..0e0835e63af2 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -64,9 +64,7 @@ static void shmem_tag_pins(struct address_space *mapping)
>   */
>  static int shmem_wait_for_pins(struct address_space *mapping)
>  {
> -	struct radix_tree_iter iter;
> -	void __rcu **slot;
> -	pgoff_t start;
> +	XA_STATE(xas, &mapping->i_pages, 0);
>  	struct page *page;
>  	int error, scan;
>  
> @@ -74,7 +72,9 @@ static int shmem_wait_for_pins(struct address_space *mapping)
>  
>  	error = 0;
>  	for (scan = 0; scan <= LAST_SCAN; scan++) {
> -		if (!radix_tree_tagged(&mapping->i_pages, SHMEM_TAG_PINNED))
> +		unsigned int tagged = 0;
> +
> +		if (!xas_tagged(&xas, SHMEM_TAG_PINNED))
>  			break;
>  
>  		if (!scan)
> @@ -82,45 +82,34 @@ static int shmem_wait_for_pins(struct address_space *mapping)
>  		else if (schedule_timeout_killable((HZ << scan) / 200))
>  			scan = LAST_SCAN;
>  
> -		start = 0;
> -		rcu_read_lock();
> -		radix_tree_for_each_tagged(slot, &mapping->i_pages, &iter,
> -					   start, SHMEM_TAG_PINNED) {
> -
> -			page = radix_tree_deref_slot(slot);
> -			if (radix_tree_exception(page)) {
> -				if (radix_tree_deref_retry(page)) {
> -					slot = radix_tree_iter_retry(&iter);
> -					continue;
> -				}
> -
> -				page = NULL;
> -			}
> -
> -			if (page &&
> -			    page_count(page) - page_mapcount(page) != 1) {
> -				if (scan < LAST_SCAN)
> -					goto continue_resched;
> -
> +		xas_set(&xas, 0);
> +		xas_lock_irq(&xas);
> +		xas_for_each_tag(&xas, page, ULONG_MAX, SHMEM_TAG_PINNED) {
> +			bool clear = true;
> +			if (xa_is_value(page))
> +				continue;
> +			if (page_count(page) - page_mapcount(page) != 1) {
>  				/*
>  				 * On the last scan, we clean up all those tags
>  				 * we inserted; but make a note that we still
>  				 * found pages pinned.
>  				 */
> -				error = -EBUSY;
> -			}
> -
> -			xa_lock_irq(&mapping->i_pages);
> -			radix_tree_tag_clear(&mapping->i_pages,
> -					     iter.index, SHMEM_TAG_PINNED);
> -			xa_unlock_irq(&mapping->i_pages);
> -continue_resched:
> -			if (need_resched()) {
> -				slot = radix_tree_iter_resume(slot, &iter);
> -				cond_resched_rcu();
> +				if (scan == LAST_SCAN)
> +					error = -EBUSY;
> +				else
> +					clear = false;
>  			}
> +			if (clear)
> +				xas_clear_tag(&xas, SHMEM_TAG_PINNED);
> +			if (++tagged % XA_CHECK_SCHED)
> +				continue;
> +
> +			xas_pause(&xas);
> +			xas_unlock_irq(&xas);
> +			cond_resched();
> +			xas_lock_irq(&xas);
>  		}
> -		rcu_read_unlock();
> +		xas_unlock_irq(&xas);
>  	}
>  
>  	return error;
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
