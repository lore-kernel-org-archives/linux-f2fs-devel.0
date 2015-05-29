From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs crypto: check context consistent for
 rename2
Date: Thu, 28 May 2015 19:29:20 -0700
Message-ID: <20150529022920.GA18700@jaegeuk-mac02.mot.com>
References: <00d401d096d2$a58db310$f0a91930$@samsung.com>
 <20150528170726.GB11631@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150528170726.GB11631@jaegeuk-mac02.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, May 28, 2015 at 10:07:26AM -0700, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Mon, May 25, 2015 at 06:07:02PM +0800, Chao Yu wrote:
> > For exchange rename, we should check context consistent of encryption
> > between new_dir and old_inode or old_dir and new_inode. Otherwise
> > inheritance of parent's encryption context will be broken.
> > 
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/namei.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index daed09c..3188464 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -754,6 +754,15 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  	int old_nlink = 0, new_nlink = 0;
> >  	int err = -ENOENT;
> >  
> > +	if ((old_dir != new_dir) &&
> > +		(!f2fs_is_child_context_consistent_with_parent(new_dir,
> > +							old_inode) ||
> > +		!f2fs_is_child_context_consistent_with_parent(old_dir,
> > +							new_inode))) {
> > +		err = -EPERM;
> > +		goto out;
> > +	}
> > +
> 
> Seems like we need this?
> 
> ---
>  fs/f2fs/namei.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 55d0d27..4772c14 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -756,6 +756,21 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	int old_nlink = 0, new_nlink = 0;
>  	int err = -ENOENT;
>  
> +	if (old_dir != new_dir) {
> +		if (f2fs_encrypted_inode(new_dir) &&
> +			!f2fs_is_child_context_consistent_with_parent(new_dir,
> +							old_inode)) {
> +			err = -EPERM;
> +			goto out;
> +		}
> +		if (f2fs_encrypted_inode(old_dir) &&
> +			!f2fs_is_child_context_consistent_with_parent(old_dir,
> +							new_inode)) {
> +			err = -EPERM;
> +			goto out;
> +		}
> +	}

It needs to sync with ext4 patch published by Ted.

Thanks,

> +
>  	f2fs_balance_fs(sbi);
>  
>  	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> -- 
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
