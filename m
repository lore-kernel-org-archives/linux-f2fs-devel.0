From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: no need to lock for
 update_inode_page all the time
Date: Thu, 17 Sep 2015 11:00:22 -0700
Message-ID: <20150917180022.GA8884@jaegeuk-mac02.mot.com>
References: <1442336146-82492-1-git-send-email-jaegeuk@kernel.org>
 <1442336146-82492-2-git-send-email-jaegeuk@kernel.org>
 <009901d0f143$28f593b0$7ae0bb10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <009901d0f143$28f593b0$7ae0bb10$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Sep 17, 2015 at 08:19:06PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, September 16, 2015 12:56 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 2/2] f2fs: no need to lock for update_inode_page all the time
> > 
> > As comment says, we don't need to call f2fs_lock_op in write_inode to prevent
> > from producing dirty node pages all the time.
> > That happens only when there is not enough free sections and we can avoid that
> > by calling balance_fs in prior to that.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/inode.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 35aae65..0fc4d02 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -296,16 +296,12 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >  		return 0;
> > 
> >  	/*
> > -	 * We need to lock here to prevent from producing dirty node pages
> > +	 * We need to balance fs here to prevent from producing dirty node pages
> >  	 * during the urgent cleaning time when runing out of free sections.
> >  	 */
> > -	f2fs_lock_op(sbi);
> > -	update_inode_page(inode);
> > -	f2fs_unlock_op(sbi);
> > -
> > -	if (wbc)
> > -		f2fs_balance_fs(sbi);
> 
> f2fs_balance_fs was moved here intentionally by Jin Xu in commit 92c4342fb72a
> ("f2fs: avoid writing inode redundantly when creating a file") to avoid
> redundantly inode page submitting, I was confused since I didn't know all
> history here. So, should we change the position of f2fs_balance_fs?

Oh, I remained that order. Fixed and merged.

Thanks,

> 
> Thanks,
> 
> > +	f2fs_balance_fs(sbi);
> > 
> > +	update_inode_page(inode);
> >  	return 0;
> >  }
> > 
> > --
> > 2.1.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
