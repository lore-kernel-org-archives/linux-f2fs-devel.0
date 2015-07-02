From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 1/2] f2fs: refactor shrink flow for
	extent	cache
Date: Thu, 2 Jul 2015 20:37:11 +0800
Message-ID: <COL402-EAS125E9214A5E90E6EF1FA7F5AB970@phx.gbl>
References: <00ea01d0b321$854293d0$8fc7bb70$@samsung.com>
	<20150701012536.GD1496@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdk6-00005u-9r
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:37:26 +0000
Received: from col004-omc1s12.hotmail.com ([65.55.34.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdk2-0004LK-G2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:37:26 +0000
In-Reply-To: <20150701012536.GD1496@jaegeuk-mac02.mot.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Chao Yu' <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, July 01, 2015 9:26 AM
> To: Chao Yu; Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: refactor shrink flow for extent cache
> 
> Hi Chao,
> 
> On Tue, Jun 30, 2015 at 06:42:09PM +0800, Chao Yu wrote:
> > For now, in extent cache, we have a global lru list which links all extent
> > node in the cache, and the list is protected by a global spinlock.
> >
> > If we want to shrink extent cache, we will:
> > 1. delete all target extent node from global lru list under spinlock;
> > 2. traverse all per-inode extent tree in global radix tree;
> > 	2.a. traverse all extent node in per-inode extent tree, try to free extent
> >          node if it is not in global lru list already.
> >
> > This method is inefficient when there is huge number of inode extent tree in
> > global extent tree.
> >
> > In this patch we introduce a new method for extent cache shrinking:
> > When we attach a new extent node, we record extent tree pointer in extent node.
> > In shrink flow, we can try to find and lock extent tree of inode directly by
> > this backward pointer, and then detach the extent node from extent tree.
> >
> > This can help to shrink extent cache more efficiently.
> 
> Yes, but as we discussed before, this way will consume 4 bytes per each
> extent_node. Can it be acceptable?

Yes, this method will increase memory overhead obviously.

Maybe there is a better way to reduce lock contention and block time
of shrinker maked. I will rethink about it.

What I think now is I should firstly tests on our new shrinker with
extreme case to see how bad it shows.

> 
> Instead, IMO, we need to focus on how to increase its hit ratio first.
> Actually, I wrote a patch for that.
> Could you check that first?

OK

Thanks,

> 
> Thanks,


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
