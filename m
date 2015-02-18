From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 06/10] f2fs: add core functions for
 rb-tree extent cache
Date: Tue, 17 Feb 2015 22:32:36 -0800
Message-ID: <20150218063236.GA11486@jaegeuk-mac02.mot-mobility.com>
References: <000301d04129$d7546000$85fd2000$@samsung.com>
	<006301d049c0$3c6ed7b0$b54c8710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YNyBj-0005cm-AS
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Feb 2015 06:32:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YNyBi-0002M2-91 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Feb 2015 06:32:47 +0000
Content-Disposition: inline
In-Reply-To: <006301d049c0$3c6ed7b0$b54c8710$@samsung.com>
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

Hi Chao,

On Mon, Feb 16, 2015 at 04:10:54PM +0800, Chao Yu wrote:
> Ping.
> 
> Any comments on this patch now?

Please let me take some time to test them.

Thanks,

> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Thursday, February 05, 2015 5:55 PM
> > To: Jaegeuk Kim; Changman Lee
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH v3 06/10] f2fs: add core functions for rb-tree extent cache
> > 
> > This patch adds core functions including slab cache init function and
> > init/lookup/update/shrink/destroy function for rb-tree based extent cache.
> > 
> > Thank Jaegeuk Kim and Changman Lee as they gave much suggestion about detail
> > design and implementation of extent cache.
> > 
> > Todo:
> >  * register rb-based extent cache shrink with mm shrink interface.
> > 
> > v2:
> >  o move set_extent_info and __is_{extent,back,front}_mergeable into f2fs.h.
> >  o introduce __{attach,detach}_extent_node for code readability.
> >  o add cond_resched() when fail to invoke kmem_cache_alloc/radix_tree_insert.
> >  o fix some coding style and typo issues.
> > 
> > v3:
> >  o fix oops due to using an unassigned pointer.
> >  o use list_del to remove extent node in shrink list.

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
