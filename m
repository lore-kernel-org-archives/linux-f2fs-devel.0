From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 06/10] f2fs: add core functions for
 rb-tree extent cache
Date: Mon, 2 Feb 2015 14:50:39 -0800
Message-ID: <20150202225039.GA34575@jaegeuk-mac02.mot.com>
References: <006201d0392c$43741650$ca5c42f0$@samsung.com>
	<009c01d03e94$685cab90$391602b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YIPpU-0005ki-BU
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 22:50:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YIPpQ-0006h2-Ib for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Feb 2015 22:50:52 +0000
Content-Disposition: inline
In-Reply-To: <009c01d03e94$685cab90$391602b0$@samsung.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Feb 02, 2015 at 10:59:28AM +0800, Chao Yu wrote:
> Hi all,
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Monday, January 26, 2015 1:52 PM
> > To: Jaegeuk Kim; Changman Lee
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH v2 06/10] f2fs: add core functions for rb-tree extent cache
> > 
> > This patch adds core functions including slab cache init function and
> > init/lookup/update/shrink/destroy function for rb-tree based extent cache.
> > 
> > Thank Jaegeuk Kim and Changman Lee as they gave much suggestion about detail
> > design and implementation of extent cache.
> > 
> > Todo:
> >  * add a cached_ei into struct extent_tree for a quick recent cache.
> >  * register rb-based extent cache shrink with mm shrink interface.
> >  * disable dir inode's extent cache.
> > 
> > v2:
> >  o move set_extent_info and __is_{extent,back,front}_mergeable into f2fs.h.
> >  o introduce __{attach,detach}_extent_node for code readability.
> >  o use f2fs_kmem_cache_alloc/f2fs_radix_tree_insert for code readability.
> >  o fix some coding style and typo issues.
> >  o get rid of node/tree count stat in f2fs_{shrink,destroy}_extent_tree.
> > 
> 
> There is an obviously bug in this patch, with it we will encounter an oops easily,
> My mistaken, Please ignore this patch set, sorry for the noise. :(
> 
> I will send a v3 later.

Hi Chao,

Okay, then I'll remove all the patches in this series from my testing branch.
Note that, I confirmed the patches till 05/10 have no problem.

Thanks,

> 
> Thanks,

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
