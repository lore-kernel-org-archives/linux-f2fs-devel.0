From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 6/7] f2fs: flush quota blocks after turnning
 it off
Date: Mon, 4 Feb 2019 08:59:34 -0800
Message-ID: <20190204165934.GB15646@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-6-jaegeuk@kernel.org>
 <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <629f4b34-381e-7860-c717-3fe54ee15694@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/02, Chao Yu wrote:
> On 2019-1-29 7:47, Jaegeuk Kim wrote:
> > After quota_off, we'll get some dirty blocks. If put_super don't have a chance
> > to flush them by checkpoint, it causes NULL pointer exception in end_io after
> > iput(node_inode). (e.g., by checkpoint=disable)
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/super.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 5e1f8573a17f..7694cb350734 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2026,6 +2026,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
> >  			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> >  		}
> >  	}
> > +	/*
> > +	 * In case of checkpoint=disable, we must flush quota blocks.
> 
> checkpoint=disable is one of the cases, right? e.g. IO error can be another case?
> 
> So here I guess we need to change the comments a bit for that.

I didn't test other cases, but checkpoint=disable could give real errors through
some tests. So, basically, I'd like to keep known cases only here.

> 
> Thanks,
> 
> > +	 * This can cause NULL exception for node_inode in end_io, since
> > +	 * put_super already dropped it.
> > +	 */
> > +	sync_filesystem(sb);
> >  }
> >  
> >  static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
> > 
