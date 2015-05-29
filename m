From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/3] f2fs crypto: check context consistent
 for rename2
Date: Fri, 29 May 2015 10:54:14 +0800
Message-ID: <002701d099ba$d7868af0$8693a0d0$@samsung.com>
References: <00d401d096d2$a58db310$f0a91930$@samsung.com>
	<20150528170726.GB11631@jaegeuk-mac02.mot.com>
	<20150529022920.GA18700@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YyARt-0001w0-C3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 May 2015 02:55:05 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YyARr-0007OZ-7P
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 May 2015 02:55:05 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NP300MIUC3J2J60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 May 2015 11:54:55 +0900 (KST)
In-reply-to: <20150529022920.GA18700@jaegeuk-mac02.mot.com>
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, May 29, 2015 10:29 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs crypto: check context consistent for rename2
> 
> On Thu, May 28, 2015 at 10:07:26AM -0700, Jaegeuk Kim wrote:
> > Hi Chao,
> >
> > On Mon, May 25, 2015 at 06:07:02PM +0800, Chao Yu wrote:
> > > For exchange rename, we should check context consistent of encryption
> > > between new_dir and old_inode or old_dir and new_inode. Otherwise
> > > inheritance of parent's encryption context will be broken.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/namei.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > > index daed09c..3188464 100644
> > > --- a/fs/f2fs/namei.c
> > > +++ b/fs/f2fs/namei.c
> > > @@ -754,6 +754,15 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry
> *old_dentry,
> > >  	int old_nlink = 0, new_nlink = 0;
> > >  	int err = -ENOENT;
> > >
> > > +	if ((old_dir != new_dir) &&
> > > +		(!f2fs_is_child_context_consistent_with_parent(new_dir,
> > > +							old_inode) ||
> > > +		!f2fs_is_child_context_consistent_with_parent(old_dir,
> > > +							new_inode))) {
> > > +		err = -EPERM;
> > > +		goto out;
> > > +	}
> > > +
> >
> > Seems like we need this?
> >
> > ---
> >  fs/f2fs/namei.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 55d0d27..4772c14 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -756,6 +756,21 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry
> *old_dentry,
> >  	int old_nlink = 0, new_nlink = 0;
> >  	int err = -ENOENT;
> >
> > +	if (old_dir != new_dir) {
> > +		if (f2fs_encrypted_inode(new_dir) &&
> > +			!f2fs_is_child_context_consistent_with_parent(new_dir,
> > +							old_inode)) {
> > +			err = -EPERM;
> > +			goto out;
> > +		}
> > +		if (f2fs_encrypted_inode(old_dir) &&
> > +			!f2fs_is_child_context_consistent_with_parent(old_dir,
> > +							new_inode)) {
> > +			err = -EPERM;
> > +			goto out;
> > +		}
> > +	}
> 
> It needs to sync with ext4 patch published by Ted.

No objection, please go ahead.

Previously, I remove f2fs_encrypted_inode(parent_inode) condition because in
f2fs_is_child_context_consistent_with_parent we have the same verification.

	/* no restrictions if the parent directory is not encrypted */
	if (!f2fs_encrypted_inode(parent))
		return 1;

Thanks,

> 
> Thanks,
> 
> > +
> >  	f2fs_balance_fs(sbi);
> >
> >  	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> > --
> > 2.1.1
> >
> >
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
