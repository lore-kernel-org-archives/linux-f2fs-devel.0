From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: handle error cases in
 move_encrypted_block
Date: Wed, 15 Jul 2015 15:42:48 -0700
Message-ID: <20150715224248.GA86133@jaegeuk-mac02.mot.com>
References: <1436901502-78825-1-git-send-email-jaegeuk@kernel.org>
 <012501d0be9f$3ca52dc0$b5ef8940$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <012501d0be9f$3ca52dc0$b5ef8940$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Jul 15, 2015 at 09:39:47AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, July 15, 2015 3:18 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 1/2] f2fs: handle error cases in move_encrypted_block
> > 
> > This patch fixes some missing error handlers.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 11046db..db11861 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -556,27 +556,34 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
> >  	if (!fio.encrypted_page)
> >  		goto put_out;
> > 
> > -	f2fs_submit_page_bio(&fio);
> > -
> > -	/* allocate block address */
> > -	f2fs_wait_on_page_writeback(dn.node_page, NODE);
> > -
> > -	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
> > -					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
> > -	dn.data_blkaddr = fio.blk_addr;
> > +	err = f2fs_submit_page_bio(&fio);
> > +	if (err)
> > +		goto put_page_out;
> 
> f2fs_submit_page_bio will put the page when failed.
> 
> So goto put_out is enough?

Right.
BTW, I realized that this is somewhat wrong, since this function needs to
take care of its page for error cases too.
I wrote a patch dealing with errors of f2fs_submit_page_bio, and submitted
it right ago.

> 
> > 
> >  	/* write page */
> >  	lock_page(fio.encrypted_page);
> > +
> > +	if (unlikely(!PageUptodate(fio.encrypted_page)))
> > +		goto put_page_out;
> > +	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi)))
> > +		goto put_page_out;
> > +
> >  	set_page_writeback(fio.encrypted_page);
> >  	fio.rw = WRITE_SYNC;
> >  	f2fs_submit_page_mbio(&fio);
> > 
> > +	/* allocate block address */
> > +	f2fs_wait_on_page_writeback(dn.node_page, NODE);
> > +	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
> > +					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
> 
> move above f2fs_submit_page_mbio(&fio) to here?

Fixed.

Thanks,
