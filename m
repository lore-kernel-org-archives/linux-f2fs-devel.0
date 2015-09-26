From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Sat, 26 Sep 2015 00:48:01 -0700
Message-ID: <20150926074801.GC13619@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfkDL-00049y-Iq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:48:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfkDK-00060H-6D for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:48:11 +0000
Content-Disposition: inline
In-Reply-To: <20150926032218.GA4311@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 26, 2015 at 05:22:18AM +0200, Marc Lehmann wrote:
> On Fri, Sep 25, 2015 at 05:47:12PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > Please revert the commit 7c5e466755ff ("f2fs: readahead cp payload
> > pages when mount") since in this commit we try to access invalid
> > SIT_I(sbi)->sit_base_addr which should be inited later.
> 
> Wow, you are fast. To make it short, the new module loads and mounts. Since
> systemd failed to clear the dmcache again, I need to wait a few hours for it
> to write back before testing. On the plus side, this gives a fairly high
> chance of fragmented memory, so I can test the code that avoids oom on mount
> as well :)
> 
> > > Since whatever speed difference I saw with two logs wasn't big, you
> > > completely sold me on 6 logs, or 4 (especially if it seepds up the gc,
> > > which I haven't much tested yet). Two logs was merely a test anyway (the
> > > same with no_heap, I don't know what it does, but I thought it is worth
> > > a try, as metadata + data nearer together is better than having them at
> > > opposite ends of the log or so).
> > 
> > If the section size is pretty large, no_heap would be enough. The original
> > intention was to provide more contiguous space for data only so that a big
> > file could have a large extent instead of splitting by its metadata.
> 
> Great, so no_heap it is.
> 
> Also, I was thinking a bit more on the active_logs issue.
> 
> The problem with SMR drives and too many logs is not just locality,
> but the fatc that appending data, unlike as with flash, requires a
> read-modify-write cycle. Likewise, I am pretty sure the disk can't keep
> 6 open write fragments in memory - maybe it can only keep one, so every
> metadata write might cause a RMW cycle again, because it's not big enough
> to fill a full zone (17-30MB).
> 
> So, hmm, well, separating the metadata that frequently changes
> (directories) form the rest is necessary for the GC to not have to copy
> almost all data block, but otherwise, it's nice if everything else clumps
> together.
> 
> (likewise, stat information probably changes a lot more often than file
> data, e.g. chown -R user . will change stat data regardless of whether the
> files already belong to a user, and it would be nice if that menas the
> data blocks can be kept untouched. Similar, renames).
> 
> What would you recommend for this case?

Hmm, from the device side, IMO, it's not a big concern for the number of open
zones, since f2fs normally tries to merge data and node IOs separately in order
to submit a big IO at once.
So, in my sense, it is not a big deal to use more logs.

> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
