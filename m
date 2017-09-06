From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong bfree and bavail
Date: Tue, 5 Sep 2017 20:10:28 -0700
Message-ID: <20170906031028.GA61332@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170905210653.46186-1-jaegeuk@kernel.org>
 <a6954033-c98a-44e9-69ce-d1416aa64640@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a6954033-c98a-44e9-69ce-d1416aa64640@huawei.com>
Sender: stable-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/06, Chao Yu wrote:
> On 2017/9/6 5:06, Jaegeuk Kim wrote:
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
> >  fs/f2fs/super.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 7e29db227910..17cca4cb93af 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -955,8 +955,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  	buf->f_bsize = sbi->blocksize;
> >  
> >  	buf->f_blocks = total_count - start_count;
> > -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> > -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> > +	buf->f_bfree = user_block_count - valid_user_blocks(sbi);
> > +	buf->f_bavail = user_block_count - valid_user_blocks(sbi) - ovp_count -
> 
> 	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
> 			get_cp(overprov_segment_count)) * c.blks_per_seg));
> 
> As we calculated in mkfs, we have removed ovp_count in user_block_count, so
> shouldn't we add ovp_count for f_bfree here?

Hehe, I already dropped this. :P
It seems like something wrong with df in android.

> 
> Thanks,
> 
> >  						sbi->reserved_blocks;
> >  
> >  	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> > 
