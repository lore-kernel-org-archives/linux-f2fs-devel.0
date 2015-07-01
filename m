From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 08/12] f2fs: introduce a shrinker for mounted
 fs
Date: Tue, 30 Jun 2015 18:28:15 -0700
Message-ID: <20150701012815.GE1496@jaegeuk-mac02.mot.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
 <1435603176-63219-8-git-send-email-jaegeuk@kernel.org>
 <00e901d0b2e7$0fa893c0$2ef9bb40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00e901d0b2e7$0fa893c0$2ef9bb40$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jun 30, 2015 at 11:43:29AM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, June 30, 2015 2:40 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 08/12] f2fs: introduce a shrinker for mounted fs
> > 
> > This patch introduces a shrinker targeting to reduce memory footprint consumed
> > by a number of in-memory f2fs data structures.
> > 
> > In addition, it newly adds:
> >  - sbi->umount_mutex to avoid data races on shrinker and put_super
> >  - sbi->shruinker_run_no to not revisit objects
> > 
> > Noteh that the basic implementation was copied from fs/btrfs/shrinker.c
> 
> Great! Good to see it's being implemented in f2fs.
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
> [snip]
> 
> > @@ -1406,6 +1425,9 @@ static int __init init_f2fs_fs(void)
> >  	err = f2fs_init_crypto();
> >  	if (err)
> >  		goto free_kset;
> > +
> > +	register_shrinker(&f2fs_shrinker_info);
> 
> This function can fail due to no memory, please check the return value here.

Agreed, done.

Thanks,

> 
> Thanks,
