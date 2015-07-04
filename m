From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 08/12] f2fs: introduce a shrinker for mounted
 fs
Date: Fri, 3 Jul 2015 21:51:58 -0700
Message-ID: <20150704045158.GA15817@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-8-git-send-email-jaegeuk@kernel.org>
	<COL402-EAS146FC72F96B6A18319140B5AB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZBFQq-0005iZ-5f
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 04:52:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZBFQp-00043E-0t for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 04:52:04 +0000
Content-Disposition: inline
In-Reply-To: <COL402-EAS146FC72F96B6A18319140B5AB970@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Jul 02, 2015 at 08:32:39PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, June 30, 2015 2:40 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 08/12] f2fs: introduce a shrinker for mounted fs
> > 
> > This patch introduces a shrinker targeting to reduce memory footprint consumed
> > by a number of in-memory f2fs data structures.
> > 
> > In addition, it newly adds:
> >  - sbi->umount_mutex to avoid data races on shrinker and put_super
> >  - sbi->shruinker_run_no to not revisit objects
> > 
> > Noteh that the basic implementation was copied from fs/btrfs/shrinker.c
> 
> This file seems not exist...
> 
> > @@ -1310,6 +1328,7 @@ free_root_inode:
> >  	dput(sb->s_root);
> >  	sb->s_root = NULL;
> >  free_node_inode:
> > +	f2fs_leave_shrinker(sbi);
> 
> We should detach shrinker under sbi->umount_mutex.
> Otherwise we will access freed memory in following call path:
> 
> mount					shrinker
> ->fill_super
>   Failed after f2fs_join_shrinker
>   ->f2fs_leave_shrinker
> 					->f2fs_shrink_scan
> 					  spin_lock
> 					  get sbi pointer
> 					  spin_unlock
>     spin_lock
>     list_del sbi->s_list
>     spin_unlock
>     free sbi
> 					  use-after-free for sbi

Right, confirmed this.

Thanks,

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
