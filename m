From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 43/62] memfd: Convert shmem_tag_pins to
 XArray
Date: Fri, 30 Mar 2018 19:11:11 -0700
Message-ID: <20180331021111.GB13332@bombadil.infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
 <20180330034245.10462-44-willy@infradead.org>
 <39ea3393-c3d7-07c3-a072-344f3a65cef3@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f25zf-0003da-Kr
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Mar 2018 02:11:47 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f25zc-003mbN-Ho
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Mar 2018 02:11:47 +0000
Content-Disposition: inline
In-Reply-To: <39ea3393-c3d7-07c3-a072-344f3a65cef3@oracle.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, linux-mm@kvack.org, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

On Fri, Mar 30, 2018 at 05:05:05PM -0700, Mike Kravetz wrote:
> On 03/29/2018 08:42 PM, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > Simplify the locking by taking the spinlock while we walk the tree on
> > the assumption that many acquires and releases of the lock will be
> > worse than holding the lock for a (potentially) long time.
> 
> I see this change made in several of the patches and do not have a
> specific issue with it.  As part of the XArray implementation you
> have XA_CHECK_SCHED = 4096.   So, we drop locks and do a cond_resched
> after XA_CHECK_SCHED iterations.  Just curious how you came up with
> that number.  Apologies in advance if this was discussed in a previous
> round of reviews.

It comes from two places, the current implementations of
tag_pages_for_writeback() and find_swap_entry().  I have no idea if it's
the optimal number for anybody, but it's the only number that anyone
was using.  I'll have no problem if somebody suggests we tweak the number
in the future.

> I did not do a detailed review of the XArray implementation.  Only looked
> at the provided interfaces and their intended uses.  If the interfaces work
> as specified, the changes here are fine.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

That is all I can ask for, and it's the most valuable thing.  Thanks,
Mike!

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
