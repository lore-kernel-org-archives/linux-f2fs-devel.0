From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 2/2] f2fs: shrink unreferenced extent_caches
	first
Date: Sat, 11 Jul 2015 09:53:44 +0800
Message-ID: <COL402-EAS2367DE106D57E1468AC10D3AB9E0@phx.gbl>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>	<1435713946-6910-2-git-send-email-jaegeuk@kernel.org>	<COL402-EAS277B75C19DA375A394DDFCEAB970@phx.gbl>	<20150704062917.GD15817@jaegeuk-mac02.hsd1.ca.comcast.net>	<004401d0b7e6$ee859f80$cb90de80$@samsung.com>	<20150706221624.GA26544@jaegeuk-mac02.mot.com>	<00af01d0b962$8682d880$93888980$@samsung.com>
	<20150710235417.GA57109@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZDjzS-0004FT-Qw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 01:54:06 +0000
Received: from col004-omc1s3.hotmail.com ([65.55.34.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDjzQ-00038b-7f
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Jul 2015 01:54:06 +0000
In-Reply-To: <20150710235417.GA57109@jaegeuk-mac02.mot.com>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 11, 2015 7:54 AM
> To: Chao Yu; Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: shrink unreferenced extent_caches first
> 
> On Wed, Jul 08, 2015 at 05:41:57PM +0800, Chao Yu wrote:
> 
> [snip]
> 
> > > > > You're right. We don't need to drop it having the lowest ino first.
> > > > > Actually, I was supposed to add an LRU list for extent_trees.
> > > > > But, do we need to really take care of its order for already evicted inodes?
> > > > >
> > > > > Here, we should think about two types of hit ratios.
> > > > > One is for inodes, and the other is for data.
> > > > > The VFS maintains inode_cache in an LRU order, while its data is cached via
> > > > > page cache also conrolled by LRU. And, whenever inode is evicted, VFS drops
> > > > > all the cached data.
> > > > > So, I believe we should give a higher priority to inodes rather than data.
> > > > >
> > > > > And, in order to increase the hit ratio, we're trying to keep an extent tree
> > > > > and its nodes even if its corresponding inode was evicted.
> > > > > So, I concluded that the dropping order would not be critical especially for
> > > > > the already evicted inodes.
> > > >
> > > > >From perspective of shrinking memory size, I think you're completely right,
> > > > because we can regard extent tree and its nodes as metadata of one inode, if
> > > > VFS evict one inode, all its data and metadata include data in extent cache
> > > > should be evicted.
> > > >
> > > > But from perspective of arising hit ratio of our cache, I'm not sure this is
> > > > the best way.
> > > >
> > > > I guess in this method, we may encounter lower coverage area of dnode + extent
> > > > cache and double caches exist issue, like:
> > > > a) all data of inode is evicted by VFS, and its tree and nodes in extent cache
> > > > is evicted too, resulting lower hit raito of further access.
> > >
> > > Well, f2fs_evict_inode does not destroy whole its extent tree and nodes right
> > > away, but just drops the refcount of the extent tree. So, I expect that this
> > > gives another chance of cache hit for further data access.
> >
> > Agreed.
> >
> > > Moreover, since this only matters with memory pressure, the unreferenced extent
> > > trees and nodes would be kept long enough beyond the normal situation.
> >
> > I'm worry about the 'only matters' thing, I will investigate it if I have time.
> >
> > >
> > > > b) data and node cache of inode is exist in VFS, and its tree and nodes in extent
> > > > cache is exist too.
> > >
> > > We know that this is a separate issue, since there is no such code to check
> > > whether data and node cache exist along with extent cache entries.
> >
> > Well, just thought, for multimedia objects, like a movie file, most time
> > we will just read it, there will no further writes in it. So why not
> > building extent cache for reaccessing, and meanwhile releasing dnode pages
> > for saving memory?
> 
> Hmm, my basic approach is letting mm reclaim caches in an LRU manner as much
> as possible.
> Of course, we can think about many specific conditions, but IMO, it is not
> enough to treat them as general ones.

It's just one thought flash in my mind, I hope this can help even a litter for
memory saving in f2fs. Anyway, I agree with you, and let's stabilize and enhance
'these general ones'.

> 
> >
> > > And, I don't think we should eliminate such the duplicate, since the extent
> > > cache is a supplemenray subset of data and node caches.
> >
> > Right.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > And this step releasing breaks the rule of lru runs.
> > > > > >
> > > > > > Some unreferenced file has high hit ratio and some referenced file may
> > > > > > have low hit ratio. Why not release low hit ratio extent tree at first?
> > > > >
> > > > > But, still user has opened the referenced file to further access, right?
> > > >
> > > > It depends on access model.
> > > >
> > > > What I mean is that if extent cache of one inode can be hit for many times,
> > > > we can assume the access model is re-accessly, that means, we can expect
> > > > this cache can be hit more times. On the contrary, we can release it if it
> > > > is necessary.
> > >
> > > Yes, exactly it depends on user workloads.
> > >
> > > As a counter example,
> > > 1. thread A wrote extents and remained the file as it was opened to use later,
> > > 2. thread B wrote many extents newly and never touched.
> > >
> > > After #2, if shrinker was activated, the extents cached by thread A would
> > > be evicted, resulting in cache misses on further thread A's accesses.
> >
> > I didn't understand, if thread A's file is opened for reusing, from long-term
> > view, it will have high hit ratio in its extent cache than thread B's, Why
> > thread B's extent cache is not be evicted firstly.
> 
> Not long-term view. Like #1 -> #2 -> shrink -> #1 -> ...

That's reasonable, Thanks for your explanation. :)

> 
> >
> > >
> > > IMO, this can happen when a bunch of data blocks were written without updates,
> > > while some opened library/database files will access the data sooner or later.
> >
> > You mean the file with one time written in its life, like lib file or multimedia
> > file?
> >
> > So I guess what you mean is that, some app keeps file opened for long time, and
> > will access it again sooner or later, at least we should keep these referenced
> > extent cache visible rather than evicting them before evicting unreferenced one's.
> 
> Something like that. :)

OK, I can understand completely, so for now, let's do it in your way.
If any further thoughts, I will discuss with you. :)

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> 
> Thanks,
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
