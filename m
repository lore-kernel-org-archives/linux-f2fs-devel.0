From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: introduce nid cache
Date: Wed, 8 Feb 2017 17:28:40 -0800
Message-ID: <20170209012840.GB10747@jaegeuk.local>
References: <20170122095331.58427-1-yuchao0@huawei.com>
	<20170124043500.GC1566@jaegeuk.local>
	<452624a9-8b9a-843c-98df-00187a8f795a@huawei.com>
	<5c8999e9-f405-7e23-0d1a-209b24f040d8@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cbdXW-0000rq-Lx
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Feb 2017 01:28:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cbdXV-0004p9-F7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Feb 2017 01:28:50 +0000
Content-Disposition: inline
In-Reply-To: <5c8999e9-f405-7e23-0d1a-209b24f040d8@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 02/08, Chao Yu wrote:
> On 2017/2/7 15:24, Chao Yu wrote:
> > Hi Jaegeuk,
> > 
> > Happy Chinese New Year! :)
> > 
> > On 2017/1/24 12:35, Jaegeuk Kim wrote:
> >> Hi Chao,
> >>
> >> On 01/22, Chao Yu wrote:
> >>> In scenario of intensively node allocation, free nids will be ran out
> >>> soon, then it needs to stop to load free nids by traversing NAT blocks,
> >>> in worse case, if NAT blocks does not be cached in memory, it generates
> >>> IOs which slows down our foreground operations.
> >>>
> >>> In order to speed up node allocation, in this patch we introduce a new
> >>> option named "nid cache", when turns on this option, it will load all
> >>> nat entries in NAT blocks when doing mount, and organize all free nids
> >>> in a bitmap, for any operations related to free nid, we will query and
> >>> set the new prebuilded bitmap instead of reading and lookuping NAT
> >>> blocks, so performance of node allocation can be improved.
> >>>
> >>
> >> How does this affect mount time and memory consumption?
> > 
> > Sorry for the delay.
> > 
> > Let me figure out some numbers later.
> 
> a. mount time
> 
> I choose slow device (Kingston 16GB SD card) to see how this option affect mount
> time when there is not enough bandwidth in low level,
> 
> Before the test, I change readahead window size of NAT pages from FREE_NID_PAGES
> * 8 to sbi->blocks_per_seg for better ra performance, so the result is:
> 
> time mount -t f2fs -o nid_cache /dev/sde /mnt/f2fs/
> 
> before:
> real	0m0.204s
> user	0m0.004s
> sys	0m0.020s
> 
> after:
> real	0m3.792s

Oops, we can't accept this even only for 16GB, right? :(

> user	0m0.000s
> sys	0m0.140s
> 
> b. memory consumption
> 
> For 16GB size image, there is total 34 NAT pages, so memory footprint is:
> 34 / 2 * 512 * 455 / 8 = 495040 bytes = 483.4 KB
> 
> Increasing of memory footprint is liner with total user valid blocks in image,
> and at most it will eat 3900 * 8 * 455 / 8 = 1774500 bytes = 1732.9 KB

How about adding two bitmaps for whole NAT pages and storing the bitmaps in
checkpoint pack, which needs at most two blocks additionally?

1. full-assigned NAT bitmap, where 1 means there is no free nids.
2. empty NAT bitmap, where 1 means whole there-in nids are free.

With these bitmaps, build_free_nids() can scan from 0'th NAT block by:

	if (full-assigned NAT)
		skip;
	else if (empty NAT)
		add_free_nid(all);
	else
		read NAT page and add_free_nid();

The flush_nat_entries() has to change its bitmaps accordingly.

With this approach, I expect we can reuse nids as much as possible while
getting cached NAT pages more effectively.

Thanks,

> 
> Thanks,
> 
> > 
> >> IMO, if those do not
> >> raise huge concerns, we would be able to consider just replacing current free
> >> nid list with this bitmap.
> > 
> > Yup, I agree with you.
> > 
> > Thanks,
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
