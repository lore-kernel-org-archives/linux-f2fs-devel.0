From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
Date: Wed, 06 Jan 2016 09:21:29 +0800
Message-ID: <010101d14820$ad098290$071c87b0$@samsung.com>
References: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
 <00a101d1479c$02ae9080$080bb180$@samsung.com> <20160105174830.GA2618@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20160105174830.GA2618@jaegeuk>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, January 06, 2016 1:49 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
> 
> Hi Chao,
> 
> On Tue, Jan 05, 2016 at 05:31:51PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Sunday, January 03, 2016 9:26 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 1/3] f2fs: check the page status filled from disk
> > >
> > > After reading a page, we need to check whether there is any error.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/data.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 89a978c..11b2111 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -448,6 +448,14 @@ repeat:
> > >
> > >  		/* wait for read completion */
> > >  		lock_page(page);
> > > +		if (unlikely(!PageUptodate(page))) {
> > > +			f2fs_put_page(page, 1);
> > > +			return ERR_PTR(-EIO);
> >
> > There is a convention in get_new_data_page, anyway we should release ipage
> > if there is any error occurs, but I think it will be ok to return directly
> > since it seems impossible the new dentry page has its real block address.
> 
> Makes sense, but definitely ipage should be put. :)

Alright. :)

> 
> >
> > To avoid any bug here or wrong usage, how about add bug_on as following patch?
> >
> > >From d92f0f34493b27ef28da67c446d552ce721b5d6f Mon Sep 17 00:00:00 2001
> > From: Chao Yu <chao2.yu@samsung.com>
> > Date: Tue, 5 Jan 2016 15:28:56 +0800
> > Subject: [PATCH] f2fs: add f2fs_bug_on in get_new_data_page
> >
> > In get_new_data_page, locked inode page should not be hold before
> > get_read_data_page, this patch adds f2fs_bug_on to detect this
> > condition.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/data.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 48f0bd3..2c5e3f6 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -440,6 +440,8 @@ repeat:
> >  		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> >  		SetPageUptodate(page);
> >  	} else {
> > +		f2fs_bug_on(F2FS_I_SB(inode), ipage);
> > +
> >  		f2fs_put_page(page, 1);
> >
> >  		page = get_read_data_page(inode, index, READ_SYNC, true);
> > --
> > 2.6.3
> >
> >
> > > +		}
> > > +		if (unlikely(page->mapping != mapping)) {
> > > +			f2fs_put_page(page, 1);
> > > +			goto repeat;
> > > +		}
> >
> > How about use get_lock_data_page to avoid duplicated code?
> 
> Agreed.
> 
> How about this?
> 
> From fef77fb244a706491e8e4c46cb245e99e22003c3 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 1 Jan 2016 22:03:47 -0800
> Subject: [PATCH] f2fs: check the page status filled from disk
> 
> After reading a page, we need to check whether there is any error.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 89a978c..89d633a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -442,12 +442,16 @@ repeat:
>  	} else {
>  		f2fs_put_page(page, 1);
> 
> -		page = get_read_data_page(inode, index, READ_SYNC, true);
> -		if (IS_ERR(page))
> -			goto repeat;
> +		f2fs_bug_on(F2FS_I_SB(inode), ipage);
> 
> -		/* wait for read completion */
> -		lock_page(page);
> +		page = get_lock_data_page(inode, index, true);
> +		if (IS_ERR(page)) {
> +			if (PTR_ERR(page) == -EIO) {
> +				f2fs_put_page(ipage, 1);
> +				return page;
> +			}
> +			goto repeat;

Seems if get_lock_data_page always return -EFAULT, we may run into an
infinite loop. IMO, it's not a bad thing to tolerate other error more
than EIO returned from get_lock_data_page. How about return directly
when error is returned? And add a bug_on for ENOENT which seems not
impossible here?

Thanks,

> +		}
>  	}
>  got_it:
>  	if (new_i_size && i_size_read(inode) <
> --
> 2.6.3


