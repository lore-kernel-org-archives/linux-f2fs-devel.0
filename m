From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 2/9] f2fs: avoid unneeded initializing when converting
 inline dentry
Date: Fri, 21 Aug 2015 20:58:46 +0800
Message-ID: <021901d0dc11$34e67e60$9eb37b20$@samsung.com>
References: <017601d0da6f$bcb555d0$36200170$@samsung.com>
 <20150820171718.GC42028@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150820171718.GC42028@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, August 21, 2015 1:17 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/9] f2fs: avoid unneeded initializing when converting inline dentry
> 
> Hi Chao,
> 
> On Wed, Aug 19, 2015 at 07:10:19PM +0800, Chao Yu wrote:
> > When converting inline dentry, we will zero out target dentry page before
> > duplicating data of inline dentry into target page, it become overhead
> > since inline dentry size is not small.
> >
> > So this patch tries to remove unneeded initializing in the space of target
> > dentry page.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/inline.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index 79d18d5..e4da0d7 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -384,17 +384,30 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
> >  		goto out;
> >
> >  	f2fs_wait_on_page_writeback(page, DATA);
> > -	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> > +	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
> >
> >  	dentry_blk = kmap_atomic(page);
> >
> >  	/* copy data from inline dentry block to new dentry block */
> >  	memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
> >  					INLINE_DENTRY_BITMAP_SIZE);
> > +	memset(dentry_blk->dentry_bitmap + INLINE_DENTRY_BITMAP_SIZE, 0,
> > +			SIZE_OF_DENTRY_BITMAP - INLINE_DENTRY_BITMAP_SIZE);
> 
> Setting zeros for bitmap would be enough.
> It doesn't need to copy or set zeros for reserved, dentries, and filename slots.

Oh, you're right, I will fix it. :)

Thanks
