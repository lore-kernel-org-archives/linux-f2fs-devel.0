From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: support finding extents after isize
Date: Mon, 4 Jan 2016 19:29:53 -0800
Message-ID: <20160105032953.GA863@jaegeuk>
References: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
	<5683DBD5.1050509@kernel.org>
	<001901d1437c$9b4b15d0$d1e14170$@samsung.com>
	<011501d14395$6127a030$2376e090$@samsung.com>
	<002d01d146b4$e27808b0$a7681a10$@samsung.com>
	<20160104065544.GB18606@jaegeuk-2.local>
	<009801d14767$fba23410$f2e69c30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aGIJv-0006VS-9Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 03:30:03 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aGIJu-0005i8-3N for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 03:30:03 +0000
Content-Disposition: inline
In-Reply-To: <009801d14767$fba23410$f2e69c30$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

...

> > > > Nope, what I'm talking about is *correctness* of our ->fiemap interface, but you're trying
> > to avoid it by saying "support more
> > > cases,
> > > > it's an improvement". That doesn't make any sense to me, since correctness issue still not
> > be fixed.
> > >
> > > I'm not sure what you mean by avoiding, I think the comment and reply I written has already
> > stated the issue and
> > > limitation of this patch.
> > > Now there are two suggestions:
> > > 1. support one more scenario, and all old scenarios are dealt like before, but it still can't
> > support discontinuous extent after
> > > isize.
> > > 2. support all scenarios, but sacrifice performance for lots of common scenarios by checking
> > about 10^9 blocks.
> > 
> > IMO, we can think about #2 whether there is an efficient way.
> > 
> > How many cases does this incur?
> > One is fallocate with keeping i_size, ana other?
> 
> AFAIK, no more.
> 
> > 
> > How about adding FADVISE_OVER_ISIZE to represent inode has blocks beyond i_size?
> > Then, we can set this flag in fallocate and reset it in f2fs_truncate.
> 
> Append write in such inode could destroy this convention, right?

Right, but we have another chance to reset the flag, when fiemap checks the end
of allocated space.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >
> > > I think we can all agree both ideas have their flaws.
> > > The only divergence is that I vote the first, and you the second. I think the most important
> > thing is that it works fluently in most
> > > scenarios, and you think is that it works in every scenarios even it's very slow.
> > >
> > > I think my method is more pratical, but balance between performance and utility seems to be
> > an Eternal problem.
> > >
> > > >
> > > > >
> > > > > use max blocks as boundary would get us the precise result, but it
> > > > > also means after we reach the EOF, we still need to look up every
> > > > > block between the EOF and  sb-> s_maxbytes to make sure the EOF is
> > > > > true, that's about 4TB or 10^9 blocks.
> > > > > And it affects all scenarios where the search range covers the last
> > > > > extent in the file, not just extents beyond isize. I think this price
> > > > > is too high to pay.
> > > >
> > > > That's another performance issue.
> > > >
> > > > >
> > > > > I was hoping that I can make f2fs_map_block return an EOF to solve
> > > > > this problem some time later, or anyone have a better idea?
> > > >
> > > > At least we can seek valid dnode block like the way llseek use.
> > > >
> > > > In addition, for most cases, few of i_nid[5] in f2fs_inode will be NULL, we could skip searching
> > all dnode block in such
> > > non-allocated
> > > > indirect node, instead of searching dnode block f2fs_map_block one by one.
> > > >
> > > > Thanks,
> > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Fan li <fanofcode.li@samsung.com>
> > > > > > > ---
> > > > > > >  fs/f2fs/data.c |    7 +------
> > > > > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index
> > > > > > > a9a4d89..f89cf07
> > > > > > > 100644
> > > > > > > --- a/fs/f2fs/data.c
> > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > @@ -798,12 +798,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info
> > *fieinfo,
> > > > > > >  	isize = i_size_read(inode);
> > > > > > >
> > > > > > >  	mutex_lock(&inode->i_mutex);
> > > > > > > -	if (start >= isize)
> > > > > > > -		goto out;
> > > > > > > -
> > > > > > > -	if (start + len > isize)
> > > > > > > -		len = isize - start;
> > > > > > > -
> > > > > > >  	if (logical_to_blk(inode, len) == 0)
> > > > > > >  		len = blk_to_logical(inode, 1);
> > > > > > >
> > > > > > > @@ -829,6 +823,7 @@ next:
> > > > > > >  		 * punch holes beyond isize and keep size unchanged.
> > > > > > >  		 */
> > > > > > >  		flags |= FIEMAP_EXTENT_LAST;
> > > > > > > +		last_blk = start_blk - 1;
> > > > > > >  	}
> > > > > > >
> > > > > > >  	if (size)
> > > > > > >
> > > > >
> > > > >
> > > > > ----------------------------------------------------------------------
> > > > > -------- _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
