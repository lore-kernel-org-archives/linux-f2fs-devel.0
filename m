From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: clear cold data flag if IO is not
 counted
Date: Fri, 19 Oct 2018 15:58:13 -0700
Message-ID: <20181019225813.GA11541@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
 <CAD14+f1EsMBiH0vkFPQ3wAa2-xOp+rpGGhmbTd+JfLpCGYh5jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gDdin-0004QS-GO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Oct 2018 22:58:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gDdil-00DliL-UH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Oct 2018 22:58:21 +0000
Content-Disposition: inline
In-Reply-To: <CAD14+f1EsMBiH0vkFPQ3wAa2-xOp+rpGGhmbTd+JfLpCGYh5jA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 10/20, Ju Hyung Park wrote:
> This does seem to fix the problem I've been having.
> 
> I was encountering all I/Os to be blocked on my Android device
> almost on a daily basis, but after this patch I'm rock solid for almost a week.
> 
> I'd appreciate it if you could add the following tags:
> Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
> 
> Also, a little additional note would be helpful
> for those who are unfamiliar with f2fs:
> This fixes a deadlock causing all I/Os to be blocked during heavy GC.

Cool. Please check the below. :P

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=b921ec4e7fb5df13f805bc04375ed529faa095ae

Thanks,

> 
> Thanks,
> On Wed, Oct 17, 2018 at 11:34 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.
> >
> > If we clear the cold data flag out of the writeback flow, we can miscount
> > -1 by end_io.
> >
> > Balancing F2FS Async:
> >  - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...
> >
> > GC thread:                              IRQ
> > - move_data_page()
> >  - set_page_dirty()
> >   - clear_cold_data()
> >                                         - f2fs_write_end_io()
> >                                          - type = WB_DATA_TYPE(page);
> >                                            here, we get wrong type
> >                                          - dec_page_count(sbi, type);
> >  - f2fs_wait_on_page_writeback()
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3f272c18fb61..0d0b4dd55b04 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2650,10 +2650,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
> >         if (!PageUptodate(page))
> >                 SetPageUptodate(page);
> >
> > -       /* don't remain PG_checked flag which was set during GC */
> > -       if (is_cold_data(page))
> > -               clear_cold_data(page);
> > -
> >         if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
> >                 if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
> >                         f2fs_register_inmem_page(inode, page);
> > --
> > 2.19.0.605.g01d371f741-goog
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
