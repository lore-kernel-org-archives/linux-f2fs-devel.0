From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 12/12] f2fs: use extent_cache by default
Date: Sat, 4 Jul 2015 14:30:15 +0800
Message-ID: <COL402-EAS29173C752AB35D52DE4243DAB950@phx.gbl>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-12-git-send-email-jaegeuk@kernel.org>
	<COL402-EAS385C99A3E59C61CC6871C57AB970@phx.gbl>
	<20150704051610.GC15817@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZBGy4-0003jX-CA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 06:30:28 +0000
Received: from col004-omc1s14.hotmail.com ([65.55.34.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZBGy3-0006TL-LW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 06:30:28 +0000
In-Reply-To: <20150704051610.GC15817@jaegeuk-mac02.hsd1.ca.comcast.net>
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 04, 2015 1:16 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 12/12] f2fs: use extent_cache by default

[snip]

> > > @@ -237,10 +237,11 @@ void update_inode(struct inode *inode, struct page *node_page)
> > >  	ri->i_size = cpu_to_le64(i_size_read(inode));
> > >  	ri->i_blocks = cpu_to_le64(inode->i_blocks);
> > >
> > > -	read_lock(&F2FS_I(inode)->ext_lock);
> > > -	set_raw_extent(&F2FS_I(inode)->ext, &ri->i_ext);
> > > -	read_unlock(&F2FS_I(inode)->ext_lock);
> > > -
> > > +	if (F2FS_I(inode)->extent_tree)
> >
> > Could extent cache destroy after above check?
> 
> I don't think so.
> 
> The extent_tree is assigned as one way.
> Once it is assigned, it will be deallocated only after evict_inode.

Previously, I suspected that ->write_inode and ->evict will be executed
concurrently.

After checking the code, I find that would not happen, so we are safe.

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
