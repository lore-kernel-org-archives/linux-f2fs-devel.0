From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: do not trim preallocated blocks when
 truncating after i_size
Date: Tue, 09 Jun 2015 10:22:49 +0800
Message-ID: <007a01d0a25b$4dbb2b60$e9318220$@samsung.com>
References: <000101d09f7b$4a2559e0$de700da0$@samsung.com>
	<20150608180643.GA59258@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Z29Cj-0004td-UJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Jun 2015 02:23:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z29Ci-0005ks-4l
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Jun 2015 02:23:53 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NPN03175NZKAH20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Jun 2015 11:23:44 +0900 (KST)
In-reply-to: <20150608180643.GA59258@jaegeuk-mac02.mot.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 09, 2015 2:07 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: do not trim preallocated blocks when truncating after i_size
> 
> On Fri, Jun 05, 2015 at 06:34:02PM +0800, Chao Yu wrote:
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
> >  fs/f2fs/file.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 4d42d66..85f97af 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -651,16 +651,16 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
> >  				f2fs_get_encryption_info(inode))
> >  			return -EACCES;
> >
> > -		if (attr->ia_size != i_size_read(inode)) {
> > +		if (attr->ia_size <= i_size_read(inode)) {
> >  			truncate_setsize(inode, attr->ia_size);
> >  			f2fs_truncate(inode);
> >  			f2fs_balance_fs(F2FS_I_SB(inode));
> >  		} else {
> >  			/*
> > -			 * giving a chance to truncate blocks past EOF which
> > -			 * are fallocated with FALLOC_FL_KEEP_SIZE.
> > +			 * do not trim all blocks after i_size if target size is
> > +			 * larger than i_size.
> >  			 */
> > -			f2fs_truncate(inode);
> > +			truncate_setsize(inode, attr->ia_size);
> 
> So, we can do:
> 		truncate_setsize();
> 
> 		if (attr->ia_size <= i_size_read(inode)) {
> 			f2fs_truncate(inode);
> 			f2fs_balance_fs();
> 		}
> 
> Right?

Yes, let me fix and resend the patch.

Thanks,
> 
> >  		}
> >  	}
> >
> > --
> > 2.4.2


------------------------------------------------------------------------------
