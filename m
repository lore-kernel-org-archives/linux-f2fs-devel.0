From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 00/63] Convert page cache to XArray
Date: Thu, 31 May 2018 14:46:12 -0700
Message-ID: <20180531214612.GA12216@bombadil.infradead.org>
References: <20180414141316.7167-1-willy@infradead.org>
 <20180416160133.GA12434@linux.intel.com>
 <20180531213643.GD28256@linux.intel.com>
 <20180531213742.GE28256@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fOVPA-0006Yg-Io
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 May 2018 21:46:44 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fOVP4-00HMjJ-Vl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 May 2018 21:46:44 +0000
Content-Disposition: inline
In-Reply-To: <20180531213742.GE28256@linux.intel.com>
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

On Thu, May 31, 2018 at 03:37:42PM -0600, Ross Zwisler wrote:
> Never mind, just saw your mail from a few weeks ago.  :-/  I'll retest on my
> end.

Don't strain too hard; I found (and fixed) some bugs in the DAX
conversion.  I keep finding new bugs though -- the latest was that
xas_store(xas, NULL); doesn't work properly if xas is multiindex and some
of the covered entries are not NULL.  And in fixing that, I noticed that
xas_store(xas, not-null) doesn't handle tagged entries correctly.

I'd offer to push out the current version for testing but I've pulled
everything apart and nothing works right now ;-)  I always think "it'll
be ready tomorrow", but I don't want to make a promise I can't keep.

Here's my current changelog (may have forgotten a few things; need to
compare a diff once I've put together a decent patch series)

 - Reordered two DAX bugfixes to the head of the queue to allow them to
   be merged independently.
 - Converted apparmor secid to IDR
 - Fixed bug in page cache lookup conversion which could lead to returning
   pages which had been released from the page cache.
 - Fixed several bugs in DAX conversion
 - Re-added conversion of dax_layout_busy_page
 - At Ross's request, renamed dax_mk_foo() to dax_make_foo().
 - Split out the radix tree test suite addition of ubsan.
 - Split out radix tree code deletion.
 - Removed __radix_tree_create from the public API
 - Fixed up a couple of comments in DAX
 - Renamed shmem_xa_replace() to shmem_replace_entry()
 * Undid change of xas_load() behaviour with multislot xa_state
 - Added xas_store_for_each() and use it in DAX
 - Corrected some typos in the XArray kerneldoc.
 - Fixed multi-index xas_store(xas, NULL)
 - Fixed tag handling in multi-index xas_store(xas, not-null)


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
