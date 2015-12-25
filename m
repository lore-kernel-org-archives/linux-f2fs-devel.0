From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs: avoid f2fs_lock_op in
 f2fs_write_begin
Date: Thu, 24 Dec 2015 17:40:34 -0800
Message-ID: <20151225014034.GA49949@jaegeuk.local>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
	<1450923320-41113-3-git-send-email-jaegeuk@kernel.org>
	<015501d13e0f$1b755180$525ff480$@samsung.com>
	<20151224203350.GB43846@jaegeuk.local>
	<20151224215153.GA47867@jaegeuk.local>
	<017601d13eb2$36b13920$a413ab60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aCHN6-0006y2-3b
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 01:40:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aCHN4-0003ai-SG for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 01:40:44 +0000
Content-Disposition: inline
In-Reply-To: <017601d13eb2$36b13920$a413ab60$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Fri, Dec 25, 2015 at 09:18:06AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Friday, December 25, 2015 5:52 AM
> > To: Chao Yu
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: avoid f2fs_lock_op in f2fs_write_begin
> > 
> > Hi Chao,
> > 
> > On Thu, Dec 24, 2015 at 12:33:50PM -0800, Jaegeuk Kim wrote:
> > > Hi Chao,
> > >
> > > On Thu, Dec 24, 2015 at 01:50:32PM +0800, Chao Yu wrote:
> > > > Hi Jaegeuk,
> > > >
> > > > > -----Original Message-----
> > > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > > Sent: Thursday, December 24, 2015 10:15 AM
> > > > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > > > linux-f2fs-devel@lists.sourceforge.net
> > > > > Cc: Jaegeuk Kim
> > > > > Subject: [f2fs-dev] [PATCH 3/4] f2fs: avoid f2fs_lock_op in f2fs_write_begin
> > > > >
> > > > > If f2fs_write_begin is to update data, we can bypass calling f2fs_lock_op() in
> > > > > order to avoid the checkpoint latency in the write syscall.
> > > > >
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >  fs/f2fs/data.c | 43 ++++++++++++++++++++++++++++++++++---------
> > > > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > index 49092da..d53cf4f 100644
> > > > > --- a/fs/f2fs/data.c
> > > > > +++ b/fs/f2fs/data.c
> > > > > @@ -1418,10 +1418,16 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
> > > > >  	pgoff_t index = page->index;
> > > > >  	struct dnode_of_data dn;
> > > > >  	struct page *ipage;
> > > > > +	bool locked = false;
> > > > > +	struct extent_info ei;
> > > > >  	int err = 0;
> > > > >
> > > > > -	f2fs_lock_op(sbi);
> > > > > -
> > > > > +	if (f2fs_has_inline_data(inode) ||
> > > > > +			(pos & PAGE_CACHE_MASK) >= i_size_read(inode)) {
> > > > > +		f2fs_lock_op(sbi);
> > > > > +		locked = true;
> > > > > +	}
> > > > > +restart:
> > > > >  	/* check inline_data */
> > > > >  	ipage = get_node_page(sbi, inode->i_ino);
> > > > >  	if (IS_ERR(ipage)) {
> > > > > @@ -1436,22 +1442,41 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
> > > > >  			read_inline_data(page, ipage);
> > > > >  			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
> > > > >  			sync_inode_page(&dn);
> > > > > -			goto done;
> > > > >  		} else {
> > > > >  			err = f2fs_convert_inline_page(&dn, page);
> > > > >  			if (err)
> > > > > -				goto err_out;
> > > > > +				goto out;
> > > > > +			err = f2fs_get_block(&dn, index);
> > > >
> > > > Seems after f2fs_convert_inline_page, data_blkaddr and node_changed should
> > > > have been set, so f2fs_get_block could be removed here.
> > >
> > > I don't think so. The inline_data treats with 0'th index only.
> > > In order to handle non-zero index, we should do f2fs_get_block.
> 
> non-zero index page should have been handled before grab_cache_page_write_begin.
> We won't encounter such case here.

Alright.
So, let me go with:
		if (dn.data_blkaddr == NULL_ADDR)
			err = f2fs_get_block();

Thanks,

> 
> > > Oh, if you meant zero index case only, we can do that like this.
> > >
> > > 			if (index)
> > > 				err = f2fs_get_block();
> > 
> > Actually, we need
> > 			if (index || !dn.data_blkaddr)
> > 				err = f2fs_get_block();
> > 
> > Since f2fs_convert_inline_page can return right away, if there is
> > no data in inline_data space.
> 
> Yes, that's the case we should handle. :)
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >
> > > >
> > > > > +		}
> > > > > +	} else if (locked) {
> > > > > +		err = f2fs_get_block(&dn, index);
> > > > > +	} else {
> > > > > +		if (f2fs_lookup_extent_cache(inode, index, &ei)) {
> > > > > +			dn.data_blkaddr = ei.blk + index - ei.fofs;
> > > > > +		} else {
> > > > > +			bool restart = false;
> > > > > +
> > > > > +			/* hole case */
> > > > > +			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
> > > >
> > > > Better to handle error case like -ENOMEM or -EIO.
> > >
> > > I think we can just give another chance at this moment and let f2fs_get_block()
> > > handle that in the next round.
> > >
> > > Thanks,
> > >
> > > >
> > > > Thanks,
> > > >
> > > > > +			if (err || (!err && dn.data_blkaddr == NULL_ADDR))
> > > > > +				restart = true;
> > > > > +			if (restart) {
> > > > > +				f2fs_put_dnode(&dn);
> > > > > +				f2fs_lock_op(sbi);
> > > > > +				locked = true;
> > > > > +				goto restart;
> > > > > +			}
> > > > >  		}
> > > > >  	}
> > > > > -	err = f2fs_get_block(&dn, index);
> > > > > -done:
> > > > > +
> > > > >  	/* convert_inline_page can make node_changed */
> > > > >  	*blk_addr = dn.data_blkaddr;
> > > > >  	*node_changed = dn.node_changed;
> > > > > -err_out:
> > > > > +out:
> > > > >  	f2fs_put_dnode(&dn);
> > > > >  unlock_out:
> > > > > -	f2fs_unlock_op(sbi);
> > > > > +	if (locked)
> > > > > +		f2fs_unlock_op(sbi);
> > > > >  	return err;
> > > > >  }
> > > > >
> > > > > @@ -1488,7 +1513,7 @@ repeat:
> > > > >
> > > > >  	*pagep = page;
> > > > >
> > > > > -	err = prepare_write_begin(sbi, page, pos + len,
> > > > > +	err = prepare_write_begin(sbi, page, pos,  len,
> > > > >  					&blkaddr, &need_balance);
> > > > >  	if (err)
> > > > >  		goto fail;
> > > > > --
> > > > > 2.5.4 (Apple Git-61)
> > > > >
> > > > >
> > > > > ------------------------------------------------------------------------------
> > > > > _______________________________________________
> > > > > Linux-f2fs-devel mailing list
> > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > >
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
