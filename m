From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] resize.f2fs: fix an error in migrate_ssa
Date: Tue, 29 Nov 2016 12:01:00 -0800
Message-ID: <20161129200100.GA30493@jaegeuk>
References: <20161124073315.26936-1-heyunlei@huawei.com>
	<5837B0CD.4020206@huawei.com> <5837B5B8.2070605@huawei.com>
	<583D3F9E.2090107@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cBoaU-000384-U8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 20:01:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cBoaS-0000Ff-OO
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Nov 2016 20:01:10 +0000
Content-Disposition: inline
In-Reply-To: <583D3F9E.2090107@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Could you please resubmit a complete patch?

On Tue, Nov 29, 2016 at 04:43:10PM +0800, Junling Zheng wrote:
> Ping ...
> 
> On 2016/11/25 11:53, Junling Zheng wrote:
> > Sorry, I forget to get the return value of dev_write_block :(
> > Please review the following patch :)
> > 
> > ---
> >  fsck/resize.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fsck/resize.c b/fsck/resize.c
> > index 46aa30e..9f9c7a6 100644
> > --- a/fsck/resize.c
> > +++ b/fsck/resize.c
> > @@ -207,30 +207,33 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
> >  	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
> >  	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
> >  	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
> > +	block_t expand_sum_blkaddr = new_sum_blkaddr +
> > +					TOTAL_SEGS(sbi) - offset;
> >  	block_t blkaddr;
> > +	int ret;
> >  	void *zero_block = calloc(BLOCK_SZ, 1);
> > -
> >  	ASSERT(zero_block);
> > 
> >  	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
> >  		blkaddr = new_sum_blkaddr;
> >  		while (blkaddr < end_sum_blkaddr) {
> > -			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
> > -				move_ssa(sbi, offset, blkaddr);
> > -			else
> > -				dev_write_block(zero_block, blkaddr);
> > -			offset++;
> > -			blkaddr++;
> > +			if (blkaddr < expand_sum_blkaddr)
> > +				move_ssa(sbi, offset++, blkaddr++);
> > +			else {
> > +				ret = dev_write_block(zero_block, blkaddr++);
> > +				ASSERT(ret >=0);
> > +			}
> >  		}
> >  	} else {
> >  		blkaddr = end_sum_blkaddr - 1;
> >  		offset = TOTAL_SEGS(sbi) - 1;
> >  		while (blkaddr >= new_sum_blkaddr) {
> > -			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
> > -				dev_write_block(zero_block, blkaddr);
> > +			if (blkaddr >= expand_sum_blkaddr) {
> > +				ret = dev_write_block(zero_block, blkaddr--);
> > +				ASSERT(ret >=0);
> > +			}
> >  			else
> > -				move_ssa(sbi, offset--, blkaddr);
> > -			blkaddr--;
> > +				move_ssa(sbi, offset--, blkaddr--);
> >  		}
> >  	}
> > 
> > 
> > On 2016/11/25 11:32, Junling Zheng wrote:
> >> How about the following patch, which I think would be a little better :)
> >>
> >> diff --git a/fsck/resize.c b/fsck/resize.c
> >> index 46aa30e..c295a06 100644
> >> --- a/fsck/resize.c
> >> +++ b/fsck/resize.c
> >> @@ -207,30 +207,33 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
> >>  	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
> >>  	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
> >>  	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
> >> +	block_t expand_sum_blkaddr = new_sum_blkaddr +
> >> +					TOTAL_SEGS(sbi) - offset;
> >>  	block_t blkaddr;
> >> +	int ret;
> >>  	void *zero_block = calloc(BLOCK_SZ, 1);
> >> -
> >>  	ASSERT(zero_block);
> >>
> >>  	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
> >>  		blkaddr = new_sum_blkaddr;
> >>  		while (blkaddr < end_sum_blkaddr) {
> >> -			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
> >> -				move_ssa(sbi, offset, blkaddr);
> >> -			else
> >> -				dev_write_block(zero_block, blkaddr);
> >> -			offset++;
> >> -			blkaddr++;
> >> +			if (blkaddr < expand_sum_blkaddr)
> >> +				move_ssa(sbi, offset++, blkaddr++);
> >> +			else {
> >> +				dev_write_block(zero_block, blkaddr++);
> >> +				ASSERT(ret >=0);
> > 
> > forget to get the return value of dev_write_block :(
> > 
> >> +			}
> >>  		}
> >>  	} else {
> >>  		blkaddr = end_sum_blkaddr - 1;
> >>  		offset = TOTAL_SEGS(sbi) - 1;
> >>  		while (blkaddr >= new_sum_blkaddr) {
> >> -			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
> >> -				dev_write_block(zero_block, blkaddr);
> >> +			if (blkaddr >= expand_sum_blkaddr) {
> >> +				dev_write_block(zero_block, blkaddr--);
> >> +				ASSERT(ret >=0);
> >> +			}
> >>  			else
> >> -				move_ssa(sbi, offset--, blkaddr);
> >> -			blkaddr--;
> >> +				move_ssa(sbi, offset--, blkaddr--);
> >>  		}
> >>  	}
> >>
> >>
> >> On 2016/11/24 15:33, Yunlei He wrote:
> >>> This patch fix an error in migrate_ssa when resize with condition
> >>> that offset is not zero && new_sum_blkaddr > old_sum_blkaddr + offset
> >>>
> >>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> >>> ---
> >>>  fsck/resize.c | 37 +++++++++++++++++++++++++++----------
> >>>  1 file changed, 27 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fsck/resize.c b/fsck/resize.c
> >>> index 46aa30e..70dbef5 100644
> >>> --- a/fsck/resize.c
> >>> +++ b/fsck/resize.c
> >>> @@ -208,28 +208,45 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
> >>>  	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
> >>>  	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
> >>>  	block_t blkaddr;
> >>> +	unsigned int offset1 = offset;
> >>> +	int ret = 1;
> >>>  	void *zero_block = calloc(BLOCK_SZ, 1);
> >>>  
> >>>  	ASSERT(zero_block);
> >>>  
> >>> -	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
> >>> -		blkaddr = new_sum_blkaddr;
> >>> -		while (blkaddr < end_sum_blkaddr) {
> >>> -			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
> >>> -				move_ssa(sbi, offset, blkaddr);
> >>> -			else
> >>> -				dev_write_block(zero_block, blkaddr);
> >>> -			offset++;
> >>> -			blkaddr++;
> >>> +	if (offset) {
> >>> +		if (new_sum_blkaddr < old_sum_blkaddr + offset) {
> >>> +			blkaddr = new_sum_blkaddr;
> >>> +			while (blkaddr < end_sum_blkaddr) {
> >>> +				if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi) - offset1)
> >>> +					move_ssa(sbi, offset, blkaddr);
> >>> +				else
> >>> +					ret = dev_write_block(zero_block, blkaddr);
> >>> +				ASSERT(ret >= 0);
> >>> +				offset++;
> >>> +				blkaddr++;
> >>> +			}
> >>> +		} else {
> >>> +			blkaddr = end_sum_blkaddr - 1;
> >>> +			offset = TOTAL_SEGS(sbi)-1;
> >>> +			while (blkaddr >= new_sum_blkaddr) {
> >>> +				if (blkaddr >= TOTAL_SEGS(sbi) - offset1 + new_sum_blkaddr)
> >>> +					ret = dev_write_block(zero_block, blkaddr);
> >>> +				else
> >>> +					move_ssa(sbi, offset--, blkaddr);
> >>> +				ASSERT(ret >= 0);
> >>> +				blkaddr--;
> >>> +			}
> >>>  		}
> >>>  	} else {
> >>>  		blkaddr = end_sum_blkaddr - 1;
> >>>  		offset = TOTAL_SEGS(sbi) - 1;
> >>>  		while (blkaddr >= new_sum_blkaddr) {
> >>>  			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
> >>> -				dev_write_block(zero_block, blkaddr);
> >>> +				ret = dev_write_block(zero_block, blkaddr);
> >>>  			else
> >>>  				move_ssa(sbi, offset--, blkaddr);
> >>> +			ASSERT(ret >= 0);
> >>>  			blkaddr--;
> >>>  		}
> >>>  	}
> >>>
> >>
> >>
> >>
> >> .
> >>
> > 
> 

------------------------------------------------------------------------------
