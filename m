From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [RFC PATCH] f2fs: add extent cache base on rb-tree
Date: Tue, 23 Dec 2014 13:30:56 +0900
Message-ID: <20141223043056.GC3335@lcm>
References: <001f01d01b79$954f0140$bfed03c0$@samsung.com>
 <20141222020317.GB3335@lcm> <000001d01db6$7d718770$78549650$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <000001d01db6$7d718770$78549650$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Mon, Dec 22, 2014 at 03:10:30PM +0800, Chao Yu wrote:
> Hi Changman,
> 
> > -----Original Message-----
> > From: Changman Lee [mailto:cm224.lee@samsung.com]
> > Sent: Monday, December 22, 2014 10:03 AM
> > To: Chao Yu
> > Cc: Jaegeuk Kim; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH] f2fs: add extent cache base on rb-tree
> > 
> > Hi Yu,
> > 
> > Good approach.
> 
> Thank you. :)
> 
> > As you know, however, f2fs breaks extent itself due to COW.
> 
> Yes, and sometimes f2fs use IPU when override writing, in this condition,
> by using this approach we can cache more contiguous mapping extent for better
> performance.
> 
> > Unlike other filesystem like btrfs, minimum extent of f2fs could have 4KB granularity.
> > So we would have lots of extents per inode and it could lead to overhead
> > to manage extents.
> 
> Agree, the more number of extents are growing in one inode, the more memory
> pressure and longer latency operating in rb-tree we are facing.
> IMO, to solve this problem, we'd better to add limitation or shrink ability into
> extent cache:
> 1.limit extent number per inode with the value set from sysfs and discard extent
> from inode's extent lru list if we touch the limitation; (e.g. in FAT, max number
> of mapping extent per inode is fixed: 8)
> 2.add all extents of inodes into a global lru list, we will try to shrink this list
> if we're facing memory pressure.
> 
> How do you think? or any better ideas are welcome. :)
> 

I think both of them are considerable options.
How about adding extent to inode selected by user using ioctl or xattr?
In the case of read most files having large size, user could get a benefit
surely although they are seperated some pieces.

Thanks,

> > 
> > Anyway, mount option could be alternative for this patch.
> 
> Yes, will do.
> 
> Thanks,
> Yu
> 
> > 
> > On Fri, Dec 19, 2014 at 06:49:29PM +0800, Chao Yu wrote:
> > > Now f2fs have page-block mapping cache which can cache only one extent mapping
> > > between contiguous logical address and physical address.
> > > Normally, this design will work well because f2fs will expand coverage area of
> > > the mapping extent when we write forward sequentially. But when we write data
> > > randomly in Out-Place-Update mode, the extent will be shorten and hardly be
> > > expanded for most time as following reasons:
> > > 1.The short part of extent will be discarded if we break contiguous mapping in
> > > the middle of extent.
> > > 2.The new mapping will be added into mapping cache only at head or tail of the
> > > extent.
> > > 3.We will drop the extent cache when the extent became very fragmented.
> > > 4.We will not update the extent with mapping which we get from readpages or
> > > readpage.
> > >
> > > To solve above problems, this patch adds extent cache base on rb-tree like other
> > > filesystems (e.g.: ext4/btrfs) in f2fs. By this way, f2fs can support another
> > > more effective cache between dnode page cache and disk. It will supply high hit
> > > ratio in the cache with fewer memory when dnode page cache are reclaimed in
> > > environment of low memory.
> > >
> > > Todo:
> > > *introduce mount option for extent cache.
> > > *add shrink ability for extent cache.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> 
