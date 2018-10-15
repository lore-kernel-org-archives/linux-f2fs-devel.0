From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
Date: Mon, 15 Oct 2018 16:08:07 -0700
Message-ID: <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/15, Chao Yu wrote:
> On 2018/10/11 5:22, Jaegeuk Kim wrote:
> > If we clear the cold data flag out of the writeback flow, we can miscount
> > -1 by end_io.
> 
> I didn't get it, which count do you mean?

It's the number of dirty pages.

Balancing F2FS Async:
  - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 29a9d3b8f709..4102799b5558 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
> >  	if (!PageUptodate(page))
> >  		SetPageUptodate(page);
> >  
> > -	/* don't remain PG_checked flag which was set during GC */
> > -	if (is_cold_data(page))
> > -		clear_cold_data(page);
> > -
> >  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
> >  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
> >  			f2fs_register_inmem_page(inode, page);
> > 
