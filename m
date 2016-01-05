From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/3] f2fs: support finding extents after isize
Date: Tue, 05 Jan 2016 11:48:54 +0800
Message-ID: <009901d1476c$174430c0$45cc9240$@samsung.com>
References: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
	<5683DBD5.1050509@kernel.org>
	<001901d1437c$9b4b15d0$d1e14170$@samsung.com>
	<011501d14395$6127a030$2376e090$@samsung.com>
	<002d01d146b4$e27808b0$a7681a10$@samsung.com>
	<006901d146d6$cf279b00$6d76d100$@samsung.com>
	<003f01d146de$7f167fc0$7d437f40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aGIcy-00086R-Lb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 03:49:44 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aGIcv-00051r-UZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 03:49:44 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0G00FRUNYM1360@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 12:49:34 +0900 (KST)
In-reply-to: <003f01d146de$7f167fc0$7d437f40$@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Monday, January 04, 2016 6:55 PM
> To: 'Chao Yu'; 'Jaegeuk Kim'
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents after isize
> 
> 
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Monday, January 04, 2016 6:00 PM
> > To: 'Fan Li'; 'Jaegeuk Kim'
> > Cc: linux-f2fs-devel@lists.sourceforge.net
> > Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents after isize
> >
> > > -----Original Message-----
> > > From: Fan Li [mailto:fanofcode.li@samsung.com]
> > > Sent: Monday, January 04, 2016 1:57 PM
> > > To: 'Chao Yu'; 'Jaegeuk Kim'
> > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents
> > > after isize
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > > > Sent: Thursday, December 31, 2015 2:34 PM
> > > > To: 'Fan Li'; 'Jaegeuk Kim'
> > > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > > Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents
> > > > after isize
> > > >
> > > > > -----Original Message-----
> > > > > From: Fan Li [mailto:fanofcode.li@samsung.com]
> > > > > Sent: Thursday, December 31, 2015 11:37 AM
> > > > > To: 'Chao Yu'; 'Jaegeuk Kim'
> > > > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > > > Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents
> > > > > after isize
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Chao Yu [mailto:chao@kernel.org]
> > > > > > Sent: Wednesday, December 30, 2015 9:28 PM
> > > > > > To: Fan Li; 'Jaegeuk Kim'
> > > > > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > > > > Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: support finding
> > > > > > extents after isize
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On 12/30/15 5:17 PM, Fan Li wrote:
> > > > > > > f2fs allows preallocation beyond isize, but f2fs_fiemap only
> > > > > > > look up extents within isize. Therefore add this support.
> > > > > > >
> > > > > > > Note: It's possible that there are holes after isize, for
> > > > > > > example, fallocate  multiple discontinuous extents after isize
> > > > > > > with FALLOC_FL_KEEP_SIZE set. Since I can tell no differences
> > > > > > > between EOF and holes from return of get_data_block, I'm afaid
> > > > > > > this patch can't support such scenarios.
> > > > > >
> > > > > > As you mentioned, preallocated block beyond isize can be
> > > > > > allocated in f2fs, and we are trying
> > > > > to support mapping extents across
> > > > > > whole data space of inode, so why we treat theses extents inside
> > > > > > i_size and outside i_size
> > > > > separately? IMO, instead using i_size, we
> > > > > > should use max blocks as boundary.
> > > > > >
> > > > > > Most important, this interface still can't support finding all
> > > > > > extents after i_size, which
> > > > > looks buggy for our user.
> > > > >
> > > > > Notice that this issue exists before my patch, by adding this
> > > > > patch, at least now it can support more scenarios such as
> > > > > fallocate a range right after isize. I'd say it's an improvement.
> > > >
> > > > Nope, what I'm talking about is *correctness* of our ->fiemap
> > > > interface, but you're trying
> > > to avoid it by saying "support more
> > > cases,
> > > > it's an improvement". That doesn't make any sense to me, since
> > > > correctness issue still not
> > > be fixed.
> > >
> > > I'm not sure what you mean by avoiding, I think the comment and reply
> > > I written has already stated the issue and limitation of this patch.
> >
> > What I mean here is it's better to stand in user's viewpoint, let the interface return the
> correct result, since user only refer
> the manual
> > of interface, rather than comments in patch or reply in email.
> 
> From viewpoint of users, this patch makes the functionality of fiemap  a little closer to the
> manual,
> it supports one more scenario that manual says, why isn't it an improvement?
> 
> Besides there are a lot of examples in kernel, that is written in comment and different from
> the manual,
> the old version of this function happens to be one of them, are you saying that if we don't
> solve this,
> we shouldn't support this function at all?
> 
> Of course there are solutions at the end, as I said in reply, I have an idea about further
> improvement,
> but what's wrong with improving it one step at a time?

In brief, as we discussed in private, we have reached an agreement that
we will continue to improve on this patch to solve related issue as Jaegeuk
suggested.

Thanks,

> 
> >
> > > Now there are two suggestions:
> > > 1. support one more scenario, and all old scenarios are dealt like
> > > before, but it still can't support discontinuous extent after isize.
> > > 2. support all scenarios, but sacrifice performance for lots of common
> > > scenarios by checking about 10^9 blocks.
> > >
> > > I think we can all agree both ideas have their flaws.
> > > The only divergence is that I vote the first, and you the second.
> >
> > I didn't vote the second, IMO, it's better support all cases firstly, at least, we should
> not let user experience 'sometimes
> success,
> > sometimes fail' in our ->fiemap. Then, if there are performance issue for common cases, we
> could try to do some improvement on it
> > as I mentioned below.
> >
> > I think Jaegeuk has better idea for the performance issue, please refer to his comments.
> >
> > Thanks,
> >
> > > I think the most important
> > > thing is that it works fluently in most scenarios, and you think is
> > > that it works in every scenarios even it's very slow.
> > >
> > > I think my method is more pratical, but balance between performance
> > > and utility seems to be an Eternal problem.
> > >
> > > >
> > > > >
> > > > > use max blocks as boundary would get us the precise result, but it
> > > > > also means after we reach the EOF, we still need to look up every
> > > > > block between the EOF and  sb-> s_maxbytes to make sure the EOF is
> > > > > true, that's about 4TB or 10^9 blocks.
> > > > > And it affects all scenarios where the search range covers the
> > > > > last extent in the file, not just extents beyond isize. I think
> > > > > this price is too high to pay.
> > > >
> > > > That's another performance issue.
> > > >
> > > > >
> > > > > I was hoping that I can make f2fs_map_block return an EOF to solve
> > > > > this problem some time later, or anyone have a better idea?
> > > >
> > > > At least we can seek valid dnode block like the way llseek use.
> > > >
> > > > In addition, for most cases, few of i_nid[5] in f2fs_inode will be
> > > > NULL, we could skip searching
> > > all dnode block in such
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
> > > > > > > @@ -798,12 +798,6 @@ int f2fs_fiemap(struct inode *inode,
> > > > > > > struct fiemap_extent_info
> > > *fieinfo,
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
> > > > > ------------------------------------------------------------------
> > > > > ----
> > > > > -------- _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
