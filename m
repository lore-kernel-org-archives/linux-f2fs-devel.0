From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs: Add f2fs_balance_fs for direct IO
Date: Wed, 09 Jul 2014 11:06:35 +0800
Message-ID: <006401cf9b22$e658db10$b30a9130$@samsung.com>
References: <1404711988-18264-1-git-send-email-ying.huang@intel.com>
	<20140708075843.GA59558@jmac> <1404807412.13519.46.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X4iEG-000410-Ca
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 03:07:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X4iED-0005Th-6m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 03:07:31 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8F00HR5CO9WB10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Jul 2014 12:07:21 +0900 (KST)
In-reply-to: <1404807412.13519.46.camel@yhuang-dev>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Huang Ying' <ying.huang@intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Huang,

> -----Original Message-----
> From: Huang Ying [mailto:ying.huang@intel.com]
> Sent: Tuesday, July 08, 2014 4:17 PM
> To: Jaegeuk Kim
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] f2fs: Add f2fs_balance_fs for direct IO
> 
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

I think you patch is not conflict to both latest linux's tree and f2fs dev tree.
but conflict to this patch 
"f2fs: introduce f2fs_write_failed to handle error case when write" which
maybe in Jaegeuk's local tree, not update to f2fs dev tree.

If possible, you could wait for Jaegeuk to update f2fs tree, or merge this patch,
then apply your new patch.

Thanks,
Yu

> 
> > Anyway, IMO, it needs to place f2fs_balance_fs somewhere in get_data_block.
> 
> Yes.  I think so too.  So you prefer to add f2fs_balance_fs in both
> f2fs_direct_IO and get_data_block, or just add f2fs_blance_fs in
> get_data_block only?
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
> 
> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
