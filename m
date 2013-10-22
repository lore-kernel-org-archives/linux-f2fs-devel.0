From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: Re: [PATCH] f2fs: introduce f2fs_kmem_cache_alloc to
 hide the unfailed kmem cache allocation
Date: Tue, 22 Oct 2013 13:16:36 +0800
Message-ID: <20131022051636.GJ21006@hli22-desktop>
References: <5264D6C7.9000202@cn.fujitsu.com> <5265F5E6.3000604@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <haicheng.li@linux.intel.com>) id 1VYUNk-0007dD-Eg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 05:19:52 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYUNj-00083k-JU for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 05:19:52 +0000
Content-Disposition: inline
In-Reply-To: <5265F5E6.3000604@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gao feng <gaofeng@cn.fujitsu.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

On Tue, Oct 22, 2013 at 11:49:58AM +0800, Gao feng wrote:
> On 10/21/2013 03:24 PM, Gu Zheng wrote:
> > +static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> > +						gfp_t flags)
> > +{
> > +	void *entry = kmem_cache_alloc(cachep, flags);
> > +retry:
> 
> retry after kmem_cache_alloc?

Good catch.

Sorry for the carelessness in my previous review. 
Besides this, I also found another issue as below:
 
> On Mon, Oct 21, 2013 at 03:24:55PM +0800, Gu Zheng wrote: 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c 
> > index ef80f79..fe3cf8e 100644 
> > --- a/fs/f2fs/node.c 
> > +++ b/fs/f2fs/node.c 
> > @@ -1308,11 +1308,7 @@ static int add_free_nid(struct f2fs_nm_info *nm_i, nid_t nid, bool build) 
> >     if (allocated) 
> >             return 0; 
> >  retry: 
-retry?


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
