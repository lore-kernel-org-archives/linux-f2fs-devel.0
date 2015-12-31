From: Fan Li <fanofcode.li@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: avoid calling i_size_read when
 it's unnecessary
Date: Thu, 31 Dec 2015 10:53:32 +0800
Message-ID: <001801d14376$8592b000$90b81000$@samsung.com>
References: <000c01d142df$24fdd450$6ef97cf0$@samsung.com>
	<20151230182739.GC28564@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aETNj-0000SC-SK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 02:54:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aETNh-0006NZ-Ve
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 02:54:27 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0701RLFC296V50@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 11:54:09 +0900 (KST)
In-reply-to: <20151230182739.GC28564@jaegeuk.local>
Content-language: en-us
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
Cc: linux-f2fs-devel@lists.sourceforge.net



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, December 31, 2015 2:28 AM
> To: Fan Li
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: avoid calling i_size_read when it's unnecessary
> 
> Hi Fan,
> 
> On Wed, Dec 30, 2015 at 04:49:56PM +0800, Fan Li wrote:
> > i_size_read does more than reading a value, it's best that we use it
> > only when we need it.
> >
> > Signed-off-by: Fan li <fanofcode.li@samsung.com>
> > ---
> >  fs/f2fs/data.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index d67c599..a9a4d89
> > 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -780,7 +780,7 @@ int f2fs_fiemap(struct inode *inode, struct
> > fiemap_extent_info *fieinfo,  {
> >  	struct buffer_head map_bh;
> >  	sector_t start_blk, last_blk;
> > -	loff_t isize = i_size_read(inode);
> > +	loff_t isize;
> >  	u64 logical = 0, phys = 0, size = 0;
> >  	u32 flags = 0;
> >  	int ret = 0;
> > @@ -795,6 +795,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >  			return ret;
> >  	}
> >
> > +	isize = i_size_read(inode);
> 
> It seems that we need to get isize after grabbing i_mutex below in order to avoid data race.

See if I got this right, isize should remain unchanged during the entire procedure, so we need
to add i_mutex upon it, and since there is already a i_mutex,  we can get inode->i_size
directly instead of calling i_read_size.
Is that right?

> 
> Thanks,
> 
> > +
> >  	mutex_lock(&inode->i_mutex);
> >  	if (start >= isize)
> >  		goto out;
> > --
> > 1.7.9.5
> >


------------------------------------------------------------------------------
