From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 12/12] f2fs: use extent_cache by default
Date: Fri, 3 Jul 2015 22:16:10 -0700
Message-ID: <20150704051610.GC15817@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-12-git-send-email-jaegeuk@kernel.org>
	<COL402-EAS385C99A3E59C61CC6871C57AB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZBFoJ-0002ya-Ir
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 05:16:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZBFoI-0004cp-BK for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 05:16:19 +0000
Content-Disposition: inline
In-Reply-To: <COL402-EAS385C99A3E59C61CC6871C57AB970@phx.gbl>
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

Hi Chao,

On Thu, Jul 02, 2015 at 08:36:16PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, June 30, 2015 2:40 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 12/12] f2fs: use extent_cache by default
> > 
> > We don't need to handle the duplicate extent infot showrmation.
> 
> information?

Fixed.

> 
> > 
> > The integrated rule is:
> >  - update on-disk extent with largest one tracked by in-memory extent_cache
> >  - destroy extent_tree for the truncation case
> >  - drop per-inode extent_cache by shrinker
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [snip]
> 
> > @@ -538,7 +427,11 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
> >  		}
> >  	}
> > 
> > -	return __attach_extent_node(sbi, et, ei, parent, p);
> > +	en = __attach_extent_node(sbi, et, ei, parent, p);
> > +update_out:
> > +	if (en && en->ei.len > et->largest.len)
> > +		et->largest = en->ei;
> 
> IMO, it's better to update cached_en here if it is invalid in
> __detach_extent_node, then cached_en and largest may point different
> extent info, it can expand our region of first level extent cache.

Agreed.

> 
> [snip]
> 
> > +
> > +	/* free all extent info belong to this extent tree */
> > +	f2fs_destroy_extent_node(inode);
> 
> How about returning number of freed extent node for tracing.
> 
> node_cnt = f2fs_destroy_extent_node(inode);

No problem.

> 
> [snip]
> 
> > @@ -237,10 +237,11 @@ void update_inode(struct inode *inode, struct page *node_page)
> >  	ri->i_size = cpu_to_le64(i_size_read(inode));
> >  	ri->i_blocks = cpu_to_le64(inode->i_blocks);
> > 
> > -	read_lock(&F2FS_I(inode)->ext_lock);
> > -	set_raw_extent(&F2FS_I(inode)->ext, &ri->i_ext);
> > -	read_unlock(&F2FS_I(inode)->ext_lock);
> > -
> > +	if (F2FS_I(inode)->extent_tree)
> 
> Could extent cache destroy after above check?

I don't think so.

The extent_tree is assigned as one way.
Once it is assigned, it will be deallocated only after evict_inode.

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
