From: Fan Li <fanofcode.li@samsung.com>
Subject: Re: [PATCH 2/3] f2fs: support finding extents after isize
Date: Tue, 05 Jan 2016 15:22:25 +0800
Message-ID: <000d01d14789$eb83f380$c28bda80$@samsung.com>
References: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
	<5683DBD5.1050509@kernel.org>
	<001901d1437c$9b4b15d0$d1e14170$@samsung.com>
	<011501d14395$6127a030$2376e090$@samsung.com>
	<002d01d146b4$e27808b0$a7681a10$@samsung.com>
	<20160104065544.GB18606@jaegeuk-2.local>
	<004001d146e1$10dc8b50$3295a1f0$@samsung.com>
	<20160104231416.GA22498@jaegeuk-2.local>
	<000401d14762$13b7ba30$3b272e90$@samsung.com>
	<20160105030805.GB23478@jaegeuk-2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aGLxc-0004tJ-A9
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 07:23:16 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aGLxa-0004gZ-8r
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 07:23:16 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0G01AIEXU6FJD0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 16:23:06 +0900 (KST)
In-reply-to: <20160105030805.GB23478@jaegeuk-2.local>
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, ""@jaegeuk-2.local
Cc: linux-f2fs-devel@lists.sourceforge.net



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, January 05, 2016 11:08 AM
> To: Fan Li; ""@jaegeuk-2.local
> Cc: 'Chao Yu'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: support finding extents after isize
> 
> Hi,
> 
> > > > > > > > > On 12/30/15 5:17 PM, Fan Li wrote:
> > > > > > > > > > f2fs allows preallocation beyond isize, but
> > > > > > > > > > f2fs_fiemap only look up extents within isize. Therefore add this support.
> > > > > > > > > >
> > > > > > > > > > Note: It's possible that there are holes after isize,
> > > > > > > > > > for example, fallocate  multiple discontinuous extents
> > > > > > > > > > after isize with FALLOC_FL_KEEP_SIZE set. Since I can
> > > > > > > > > > tell no differences between EOF and holes from return
> > > > > > > > > > of get_data_block, I'm afaid this patch can't support such scenarios.
> > > > > > > > >
> > > > > > > > > As you mentioned, preallocated block beyond isize can be
> > > > > > > > > allocated in f2fs, and we are trying
> > > > > > > > to support mapping extents across
> > > > > > > > > whole data space of inode, so why we treat theses
> > > > > > > > > extents inside i_size and outside i_size
> > > > > > > > separately? IMO, instead using i_size, we
> > > > > > > > > should use max blocks as boundary.
> > > > > > > > >
> > > > > > > > > Most important, this interface still can't support
> > > > > > > > > finding all extents after i_size, which
> > > > > > > > looks buggy for our user.
> > > > > > > >
> > > > > > > > Notice that this issue exists before my patch, by adding
> > > > > > > > this patch, at least now it can support more scenarios
> > > > > > > > such as fallocate a range right after isize. I'd say it's an improvement.
> > > > > > >
> > > > > > > Nope, what I'm talking about is *correctness* of our
> > > > > > > ->fiemap interface, but you're trying to avoid it by saying
> > > > > > > "support more
> > > > > > cases,
> > > > > > > it's an improvement". That doesn't make any sense to me, since correctness issue still not be fixed.
> > > > > >
> > > > > > I'm not sure what you mean by avoiding, I think the comment
> > > > > > and reply I written has already stated the issue and limitation of this patch.
> > > > > > Now there are two suggestions:
> > > > > > 1. support one more scenario, and all old scenarios are dealt
> > > > > > like before, but it still can't support discontinuous extent after isize.
> > > > > > 2. support all scenarios, but sacrifice performance for lots of common scenarios by checking about 10^9 blocks.
> > > > >
> > > > > IMO, we can think about #2 whether there is an efficient way.
> > > > >
> > > > > How many cases does this incur?
> > > > > One is fallocate with keeping i_size, ana other?
> > > > >
> > > > > How about adding FADVISE_OVER_ISIZE to represent inode has blocks beyond i_size?
> > > > > Then, we can set this flag in fallocate and reset it in f2fs_truncate.
> > > >
> > > > I have a similar idea that add an actual size which marks the end
> > > > of last extent, so we can know if the current extent is the last one, even without searching for extents behind.
> > >
> > > Where do you want to store that size in disk?
> >
> > I'm still not very confident about this idea, so I didn't really think
> > that through yet, inode may be a proper place.
> > Or we just write a special function to find it, and call it only when
> > fiemap is called and disk size isn't initiated yet. After all this isn't frequently-used.
> >
> > >
> > > > But there is a problem I still can't figure out,  after truncate
> > > > an extent at the end of file beyond isize , how do I know where
> > > > the new last extent ends or if there are still extents beyond isize? after all, the extents beyond isize could be
discontinuous.
> > >
> > > So, that's why I proposed a flag instead of a kind of i_disksize.
> > > We can just set the flag, only if a file *may* have a extent beyond i_size in fallocate, and unset it through f2fs_truncate.
> > > Moreover, I don't expect that this happens so frequently.
> >
> > if flag could indicate "may", will i_disksize do a better job in the same way?
> > let i_disksize be the end of the last extent that *may* exist beyond
> > i_size, set it also in fallocate,when truncate, if the length is still
> > beyond isize, we set the new length as i_disksize, so in worse scenario we won't have to search up to s_maxbytes.
> 
> My real concern is that there no space for i_disksize.

I see. How about combine both ideas, use flag as you propose, and if fiemap ever needs to 
look up the last extent beyond isize, we calculate i_disksize first and cache it in f2fs_inode_info, 
use it to determine the last extent.

This way we don't have to look up all blocks up to s_maxbytes, and need no extra space in disk.

> 
> Thanks,


------------------------------------------------------------------------------
