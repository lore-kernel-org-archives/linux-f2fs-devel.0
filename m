From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 07/11] f2fs: enable in-place-update for
 fdatasync
Date: Tue, 29 Jul 2014 18:08:21 -0700
Message-ID: <20140730010821.GA98706@jaegeuk-mac02>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-7-git-send-email-jaegeuk@kernel.org>
	<20140729004111.GA442@lcm> <20140729122215.GB84378@jaegeuk-mac02>
	<20140729235455.GB442@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XCIPr-0001Gl-Hq
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 01:10:51 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XCIPq-0003Zx-4Y for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 01:10:51 +0000
Content-Disposition: inline
In-Reply-To: <20140729235455.GB442@lcm>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Jul 30, 2014 at 08:54:55AM +0900, Changman Lee wrote:
> On Tue, Jul 29, 2014 at 05:22:15AM -0700, Jaegeuk Kim wrote:
> > Hi Changman,
> > 
> > On Tue, Jul 29, 2014 at 09:41:11AM +0900, Changman Lee wrote:
> > > Hi Jaegeuk,
> > > 
> > > On Fri, Jul 25, 2014 at 03:47:21PM -0700, Jaegeuk Kim wrote:
> > > > This patch enforces in-place-updates only when fdatasync is requested.
> > > > If we adopt this in-place-updates for the fdatasync, we can skip to write the
> > > > recovery information.
> > > 
> > > But, as you know, random write occurs when changing into in-place-updates.
> > > It will degrade write performance. Is there any case in-place-updates is
> > > better, except recovery or high utilization?
> > 
> > As I described, you can easily imagine, if users requested small amount of data
> > writes with fdatasync, we should do data writes + node writes.
> > But, if we can do in-place-update, we don't need to write node blocks.
> > Surely it triggers random writes, however, the amount of data is preety small
> > and the device handles them very fast by its inside cache, so that it can
> > enhance the performance.
> > 
> > Thanks,
> 
> Partially agree. Sometimes, I see that SSR shows lower performance than
> IPU. One of the reasons might be node writes.

What did you mean? That's why I consider IPU eagarly instead of SSR and LFS
under the very strict cases.

> Anyway, if so, we should know total dirty pages for fdatasync and it's very
> tunable according to a random write performance of device.

Agreed. We can do that either by comparing the number of dirty pages,
additional data/node writes, and cost of checkpoint at the same time.
And there is another thing is that we need to consider the number of
waiting time for end_io.
I'll look into this at some time.

Thanks,

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >  fs/f2fs/f2fs.h    | 1 +
> > > >  fs/f2fs/file.c    | 7 +++++++
> > > >  fs/f2fs/segment.h | 4 ++++
> > > >  3 files changed, 12 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index ab36025..8f8685e 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -998,6 +998,7 @@ enum {
> > > >  	FI_INLINE_DATA,		/* used for inline data*/
> > > >  	FI_APPEND_WRITE,	/* inode has appended data */
> > > >  	FI_UPDATE_WRITE,	/* inode has in-place-update data */
> > > > +	FI_NEED_IPU,		/* used fo ipu for fdatasync */
> > > >  };
> > > >  
> > > >  static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 121689a..e339856 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -127,11 +127,18 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > > >  		return 0;
> > > >  
> > > >  	trace_f2fs_sync_file_enter(inode);
> > > > +
> > > > +	/* if fdatasync is triggered, let's do in-place-update */
> > > > +	if (datasync)
> > > > +		set_inode_flag(fi, FI_NEED_IPU);
> > > > +
> > > >  	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
> > > >  	if (ret) {
> > > >  		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
> > > >  		return ret;
> > > >  	}
> > > > +	if (datasync)
> > > > +		clear_inode_flag(fi, FI_NEED_IPU);
> > > >  
> > > >  	/*
> > > >  	 * if there is no written data, don't waste time to write recovery info.
> > > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > > > index ee5c75e..55973f7 100644
> > > > --- a/fs/f2fs/segment.h
> > > > +++ b/fs/f2fs/segment.h
> > > > @@ -486,6 +486,10 @@ static inline bool need_inplace_update(struct inode *inode)
> > > >  	if (S_ISDIR(inode->i_mode))
> > > >  		return false;
> > > >  
> > > > +	/* this is only set during fdatasync */
> > > > +	if (is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU))
> > > > +		return true;
> > > > +
> > > >  	switch (SM_I(sbi)->ipu_policy) {
> > > >  	case F2FS_IPU_FORCE:
> > > >  		return true;
> > > > -- 
> > > > 1.8.5.2 (Apple Git-48)
> > > > 
> > > > 
> > > > ------------------------------------------------------------------------------
> > > > Want fast and easy access to all the code in your enterprise? Index and
> > > > search up to 200,000 lines of code with a free copy of Black Duck
> > > > Code Sight - the same software that powers the world's largest code
> > > > search on Ohloh, the Black Duck Open Hub! Try it now.
> > > > http://p.sf.net/sfu/bds
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
