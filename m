From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong bfree and bavail
Date: Tue, 5 Sep 2017 15:41:37 -0700
Message-ID: <20170905224137.GA49767@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170905210653.46186-1-jaegeuk@kernel.org>
 <3A56CCE1-34B3-4EBA-9871-DAF175AB89BD@dilger.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3A56CCE1-34B3-4EBA-9871-DAF175AB89BD@dilger.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/05, Andreas Dilger wrote:
> On Sep 5, 2017, at 3:06 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > 
> > This patch fixes bavail and bfree finally.
> > 
> > long    f_bfree;    /* free blocks in fs */
> > long    f_bavail;   /* free blocks avail to non-superuser */
> > 
> > So, bfree represents all the reserved blocks, while bavail does the space only
> > visible to normal user.
> > 
> > Fix: 3e6d0b4d9c1c ("f2fs: fix incorrect f_bfree calculation in ->statfs")
> > Cc: <stable@vger.kernel.org> # 4.8+
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > fs/f2fs/super.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 7e29db227910..17cca4cb93af 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -955,8 +955,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > 	buf->f_bsize = sbi->blocksize;
> > 
> > 	buf->f_blocks = total_count - start_count;
> > -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> > -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> > +	buf->f_bfree = user_block_count - valid_user_blocks(sbi);
> > +	buf->f_bavail = user_block_count - valid_user_blocks(sbi) - ovp_count -
> > 						sbi->reserved_blocks;
> 
> To keep the statfs data more consistent, you could use:
> 
> 	buf->f_bavail = buf->f_bfree - ovp_count - sbi->reserved_blocks;
> 
> That avoids the extra subtraction, and avoids (minor) issues if these values
> change while this syscall is running.

Much better. Thank you so much for correcting me.

> 
> Cheers, Andreas
> 
> 
> 
> 
> 
