From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v11 54/63] dax: Hash on XArray instead of
 mapping
Date: Tue, 22 May 2018 15:38:22 -0600
Message-ID: <20180522213822.GA12733@linux.intel.com>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180414141316.7167-55-willy@infradead.org>
 <20180521044756.GD27043@linux.intel.com>
 <20180521102524.GB20878@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ross.zwisler@linux.intel.com>) id 1fLEzK-0004Qy-9Q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 May 2018 21:38:34 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fLEzF-00DFSF-KF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 May 2018 21:38:34 +0000
Content-Disposition: inline
In-Reply-To: <20180521102524.GB20878@bombadil.infradead.org>
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
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, linux-mm@kvack.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

On Mon, May 21, 2018 at 03:25:24AM -0700, Matthew Wilcox wrote:
> On Sun, May 20, 2018 at 10:47:56PM -0600, Ross Zwisler wrote:
> > On Sat, Apr 14, 2018 at 07:13:07AM -0700, Matthew Wilcox wrote:
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > Since the XArray is embedded in the struct address_space, this contains
> > > exactly as much entropy as the address of the mapping.
> > 
> > I agree that they both have the same amount of entropy, but what's the
> > benefit?  It doesn't seem like this changes any behavior, fixes any bugs or
> > makes things any simpler?
> 
> This is a preparatory patch for some of the changes later in the series.
> It has no benefit in and of itself; the benefit comes later when we
> switch from dax_wake_mapping_entry() to dax_wake_entry():
> 
> static void dax_wake_entry(struct xa_state *xas, bool wake_all)
> 
> This switch could be left until the end; I can introduce dax_wake_entry()
> without this change:
> 
> +static void dax_wake_entry(struct xa_state *xas, bool wake_all)
> +{
> +	struct address_space *mapping = container_of(xas->xa,
> +			struct address_space, i_pages);
> +       return dax_wake_mapping_entry_waiter(mapping, xas->xa_index, NULL,
> +			wake_all);
> +}
> 
> and then cut everybody over in the final step.
> 
> Or I can just explain in the changelog that it's a preparatory step.

Sure, just a note in the changelog saying that it's a preparatory step would
be good enough for me.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
