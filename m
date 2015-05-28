From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs crypto: check encryption for tmpfile
Date: Thu, 28 May 2015 10:01:46 -0700
Message-ID: <20150528170143.GA11631@jaegeuk-mac02.mot.com>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
	<1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
	<007001d0992f$f77f6ba0$e67e42e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Yy1C0-0005EJ-Ao
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 May 2015 17:02:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yy1Bw-0005gu-Ps for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 May 2015 17:02:04 +0000
Content-Disposition: inline
In-Reply-To: <007001d0992f$f77f6ba0$e67e42e0$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, May 28, 2015 at 06:20:05PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, May 20, 2015 8:43 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 3/4] f2fs crypto: check encryption for tmpfile
> > 
> > This patch adds to check encryption for tmpfile in early stage.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/namei.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index dded2b0..47066b0 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -531,6 +531,11 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
> >  	}
> > 
> >  	f2fs_lock_op(sbi);
> > +
> > +	err = f2fs_get_encryption_info(dir);
> > +	if (err)
> > +		goto out;
> > +
> >  	err = acquire_orphan_inode(sbi);
> >  	if (err)
> >  		goto out;
> > --
> > 2.1.1
> 
> I can't find the original thread, so I reply here.
> Merged patch in dev branch shows that our code is modified as below:
> 
> static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
>  {
> +	int err = f2fs_get_encryption_info(dir);
> +	if (err)
> +		return err;
> +
>  	return __f2fs_tmpfile(dir, dentry, mode, NULL);
>  }
> 
> It seems that, if we try to make a temp file in an unencrypted dir, we will
> always fail with -ENODATA in f2fs_get_encryption_info because encryption
> context is not exist in xattr.
> 
> So we should check dir with f2fs_encrypted_inode() before
> f2fs_get_encryption_info() to avoid that.

Indeed.
Will fix it up.

Thanks,

> 
> Thanks,

------------------------------------------------------------------------------
