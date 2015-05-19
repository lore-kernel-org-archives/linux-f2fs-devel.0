From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: support RENAME_WHITEOUT
Date: Tue, 19 May 2015 10:43:44 -0700
Message-ID: <20150519174344.GB42970@jaegeuk-mac02.mot.com>
References: <002e01d0912f$30fc5cc0$92f51640$@samsung.com>
	<20150519055119.GA39478@jaegeuk-mac02.hsd1.ca.comcast.net>
	<005b01d09217$58302e00$08908a00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YulYb-00048T-21
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 17:43:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YulYY-0003rw-QP for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 17:43:57 +0000
Content-Disposition: inline
In-Reply-To: <005b01d09217$58302e00$08908a00$@samsung.com>
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

On Tue, May 19, 2015 at 05:36:11PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, May 19, 2015 1:51 PM
> > To: Chao Yu
> > Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/2] f2fs: support RENAME_WHITEOUT
> > 
> > Hi Chao,
> > 
> > On Mon, May 18, 2015 at 01:54:22PM +0800, Chao Yu wrote:
> > > As the description of rename in manual, RENAME_WHITEOUT is a special operation
> > > that only makes sense for overlay/union type filesystem.
> > >
> > > When performing rename with RENAME_WHITEOUT, dst will be replace with src, and
> > > meanwhile, a 'whiteout' will be create with name of src.
> > >
> > > A "whiteout" is designed to be a char device with 0,0 device number, it has
> > > specially meaning for stackable filesystem. In these filesystems, there are
> > > multiple layers exist, and only top of these can be modified. So a whiteout
> > > in top layer is used to hide a corresponding file in lower layer, as well
> > > removal of whiteout will make the file appear.
> > >
> > > Now in overlayfs, when we rename a file which is exist in lower layer, it
> > > will be copied up to upper if it is not on upper layer yet, and then rename
> > > it on upper layer, source file will be whiteouted to hide corresponding file
> > > in lower layer at the same time.
> > >
> > > So in upper layer filesystem, implementation of RENAME_WHITEOUT provide a
> > > atomic operation for stackable filesystem to support rename operation.
> > >
> > > There are multiple ways to implement RENAME_WHITEOUT in log of this commit:
> > > 7dcf5c3e4527 ("xfs: add RENAME_WHITEOUT support") which pointed out by
> > > Dave Chinner.
> > >
> > > For now, we just try to follow the way that xfs/ext4 use.
> > 
> > Could you merge the two patches into one?
> 
> OK.
> 
> > And, after finishing xfstests, kernel reports missing inode objects.
> 
> Do you mean this?
> 
> BUG f2fs_inode_cache (Tainted: G    B      O   ): 
> Objects remaining in f2fs_inode_cache on kmem_cache_close()
> 
> Whenever rmmod f2fs module after tests/generic/078, system report this.

Right. :)

> 
> > Could you check it out?
> 
> I find that the whiteout file is not be iput() after being linkated to
> an entry. After fixing this issue, no exceptional report appears again.
> 
> So can you please help to test the v2 patch?

Great. Will do.

Thanks,

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
