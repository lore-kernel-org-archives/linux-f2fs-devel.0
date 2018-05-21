From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 53/63] dax: Rename some functions
Date: Mon, 21 May 2018 03:11:39 -0700
Message-ID: <20180521101139.GA20878@bombadil.infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180414141316.7167-54-willy@infradead.org>
 <20180521044236.GC27043@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fKhna-0004JX-Mu
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 May 2018 10:12:14 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fKhnX-00B0lX-EB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 May 2018 10:12:14 +0000
Content-Disposition: inline
In-Reply-To: <20180521044236.GC27043@linux.intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>

On Sun, May 20, 2018 at 10:42:36PM -0600, Ross Zwisler wrote:
> > -static void *dax_radix_locked_entry(unsigned long pfn, unsigned long flags)
> > +static void *dax_mk_locked(unsigned long pfn, unsigned long flags)
> 
> Let's continue to use whole words in function names instead of abbreviations
> for readability.  Can you please s/dax_mk_locked/dax_make_locked/ ?
> 
> I do realize that the xarray function is xa_mk_value() (which I also think is
> perhaps too brief for readability), but in the rest of DAX we use full words
> everywhere.

I find the current DAX code to be _so_ wordy that it obscures readability.
This particular instance isn't a hill worth dying on; I'll change it.

> > @@ -1519,15 +1517,14 @@ int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_iomap_fault);
> >  
> > -/**
> > +/*
> 
> Let's leave the double ** so that the function is picked up properly by
> the documentation system, and so it's consistent with the rest of the
> functions.

This function is static.  I think it's worth keeping the documentation,
but making it part of the exported kernel API documentation is confusing.

By the way, nothing at all in fs/dax.c is picked up by the documentation
system today.  We should probably fix that ... did you want to look at it
or shall I propose a patch to anchor it somewhere?

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
