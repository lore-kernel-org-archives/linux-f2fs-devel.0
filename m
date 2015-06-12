From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: do not trim preallocated blocks
 when truncating after i_size
Date: Thu, 11 Jun 2015 18:30:39 -0700
Message-ID: <20150612013039.GA76743@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <007b01d0a25b$ff2a99d0$fd7fcd70$@samsung.com>
	<00e401d0a4a7$11d8a9d0$3589fd70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z3Do2-0000W8-Jd
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jun 2015 01:30:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z3Do1-0006mR-B4 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jun 2015 01:30:50 +0000
Content-Disposition: inline
In-Reply-To: <00e401d0a4a7$11d8a9d0$3589fd70$@samsung.com>
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

On Fri, Jun 12, 2015 at 08:30:09AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Tuesday, June 09, 2015 10:28 AM
> > To: Jaegeuk Kim; Changman Lee
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH v2] f2fs: do not trim preallocated blocks when truncating after i_size
> > 
> > When we perform generic/092 in xfstests, output is like below:
> > 
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      0: [0..10239]: data
> >      0: [0..10239]: data
> >     -1: [10240..20479]: unwritten
> >     +1: [10240..14335]: unwritten
> > 
> > This is because with this testcase, we redefine the regulation for
> > truncate in perallocated space past i_size as below:
> > 
> > "There was some confused about what the fs was supposed to do when you
> > truncate at i_size with preallocated space past i_size. We decided on the
> > following things.
> > 
> > 1) truncate(i_size) will trim all blocks past i_size.
> > 2) truncate(x) where x > i_size will not trim all blocks past i_size.
> > "
> > 
> > This method is used in xfs, and then ext4/btrfs will follow the rule.
> > 
> > This patch fixes to follow the new rule for f2fs.
> > 
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> > v2:
> >  * adjust code style pointed out by Jaegeuk Kim.
> > 
> >  fs/f2fs/file.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 4d42d66..ec47c4a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -651,16 +651,15 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  				f2fs_get_encryption_info(inode))
> >  			return -EACCES;
> > 
> > -		if (attr->ia_size != i_size_read(inode)) {
> > -			truncate_setsize(inode, attr->ia_size);
> > +		truncate_setsize(inode, attr->ia_size);
> > +
> > +		/*
> > +		 * do not trim all preallocated blocks after i_size if target
> > +		 * size is larger than i_size.
> > +		 */
> > +		if (attr->ia_size <= i_size_read(inode)) {
> 
> It's wrong implementation here, because we have set i_size in inode with
> attr->ia_size, so that we will always go into this "truncate smaller size"
> branch.
> 
> Please ignore this patch, sorry for my mistake.
> 
> Jaegeuk, I'd like to use v1 patch, how do you think?

Oh, I see.
I'll merge v1.

Thank you for pointing out this.

> 
> Thanks,
> 
> >  			f2fs_truncate(inode);
> >  			f2fs_balance_fs(F2FS_I_SB(inode));
> > -		} else {
> > -			/*
> > -			 * giving a chance to truncate blocks past EOF which
> > -			 * are fallocated with FALLOC_FL_KEEP_SIZE.
> > -			 */
> > -			f2fs_truncate(inode);
> >  		}
> >  	}
> > 
> > --
> > 2.4.2
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
