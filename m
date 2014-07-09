From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: Add f2fs_balance_fs for direct IO
Date: Wed, 9 Jul 2014 06:26:35 -0700
Message-ID: <20140709132635.GA4926@jmac>
References: <1404711988-18264-1-git-send-email-ying.huang@intel.com>
	<20140708075843.GA59558@jmac>
	<1404807412.13519.46.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1X4rtY-0005Gc-Qr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 13:26:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X4rtX-0001Mb-60 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 13:26:48 +0000
Content-Disposition: inline
In-Reply-To: <1404807412.13519.46.camel@yhuang-dev>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huang Ying <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Jul 08, 2014 at 04:16:52PM +0800, Huang Ying wrote:
> Hi, Jaegeuk,
> 
> On Tue, 2014-07-08 at 00:58 -0700, Jaegeuk Kim wrote:
> > Hi Huang,
> > 
> > It occurs a merge conflict.
> > Please check the patch.
> 
> Sorry, my fault.  I think I need to base my patch on f2fs tree instead
> of latest Linus' tree?

My apologies.
As Chao said, it was due to the other patch.
I'll merge them soon.

> 
> > Anyway, IMO, it needs to place f2fs_balance_fs somewhere in get_data_block.
> 
> Yes.  I think so too.  So you prefer to add f2fs_balance_fs in both
> f2fs_direct_IO and get_data_block, or just add f2fs_blance_fs in
> get_data_block only?

I think it should be placed on get_data_block only.
But, at a glance, we need to figure out some conditions when it should be
called.
Since we don't or shouldn't call that in the look-up paths (e.g., read).

Thanks,

> 
> Best Regards,
> Huang, Ying
> 
> > Thanks,
> > 
> > On Mon, Jul 07, 2014 at 01:46:28PM +0800, Huang Ying wrote:
> > > Otherwise, if a large amount of direct IO writes were done, the
> > > segment allocation may be failed because no enough segments are gced.
> > > 
> > > Signed-off-by: Huang, Ying <ying.huang@intel.com>
> > > ---
> > >  fs/f2fs/data.c |    6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1038,6 +1038,7 @@ static ssize_t f2fs_direct_IO(int rw, st
> > >  {
> > >  	struct file *file = iocb->ki_filp;
> > >  	struct inode *inode = file->f_mapping->host;
> > > +	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> > >  
> > >  	/* Let buffer I/O handle the inline data case. */
> > >  	if (f2fs_has_inline_data(inode))
> > > @@ -1046,8 +1047,11 @@ static ssize_t f2fs_direct_IO(int rw, st
> > >  	if (check_direct_IO(inode, rw, iter, offset))
> > >  		return 0;
> > >  
> > > +	if (rw == WRITE)
> > > +		f2fs_balance_fs(sbi);
> > > +
> > >  	/* clear fsync mark to recover these blocks */
> > > -	fsync_mark_clear(F2FS_SB(inode->i_sb), inode->i_ino);
> > > +	fsync_mark_clear(sbi, inode->i_ino);
> > >  
> > >  	return blockdev_direct_IO(rw, iocb, inode, iter, offset,
> > >  				  get_data_block);
> > 

-- 
Jaegeuk Kim

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
