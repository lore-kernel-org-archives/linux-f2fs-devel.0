From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 72/73] xfs: Convert mru cache to XArray
Date: Tue, 12 Dec 2017 10:51:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1712121041240.1358-100000@iolanthe.rowland.org>
References: <1513035963.3036.17.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <stern+5a26ac42@rowland.harvard.edu>)
 id 1eOmqO-0005cu-4e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 15:51:44 +0000
Received: from iolanthe.rowland.org ([192.131.102.54])
 by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.89)
 id 1eOmqN-0008Qe-1g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Dec 2017 15:51:44 +0000
In-Reply-To: <1513035963.3036.17.camel@perches.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Joe Perches <joe@perches.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org, linux-nilfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <mawilcox@microsoft.com>, linux-usb@vger.kernel.org, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net, Byungchul Park <byungchul.park@lge.com>, linux-mm@kvack.org, kernel-team@lge.com, Andy Whitcroft <apw@shadowen.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Rehas Sachdeva <aquannie@gmail.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-btrfs@vger.kernel.org

On Mon, 11 Dec 2017, Joe Perches wrote:

> >  - I don't understand the error for xa_head here:
> > 
> > struct xarray {
> >         spinlock_t      xa_lock;
> >         gfp_t           xa_flags;
> >         void __rcu *    xa_head;
> > };
> > 
> >    Do people really think that:
> > 
> > struct xarray {
> >         spinlock_t      xa_lock;
> >         gfp_t           xa_flags;
> >         void __rcu	*xa_head;
> > };
> > 
> >    is more aesthetically pleasing?  And not just that, but it's an *error*
> >    so the former is *RIGHT* and this is *WRONG*.  And not just a matter

Not sure what was meant here.  Neither one is *WRONG* in the sense of 
being invalid C code.  In the sense of what checkpatch will accept, the 
former is *WRONG* and the latter is *RIGHT* -- the opposite of what 
was written.

> >    of taste?
> 
> No opinion really.
> That's from Andy Whitcroft's original implementation.

This one, at least, is easy to explain.  The original version tends to
lead to bugs, or easily misunderstood code.  Consider if another
variable was added to the declaration; it could easily turn into:

	void __rcu *	xa_head, xa_head2;

(The compiler will reject this, but it wouldn't if the underlying type
had been int instead of void.)

Doing it the other way makes the meaning a lot more clear:

	void __rcu	*xa_head, *xa_head2;

This is an idiom specifically intended to reduce the likelihood of 
errors.  Rather like avoiding assignments inside conditionals.

Alan Stern


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
