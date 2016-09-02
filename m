From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: merge WRITE bio into previous WRITE_SYNC
Date: Fri, 2 Sep 2016 11:36:58 -0700
Message-ID: <20160902183658.GA917@jaegeuk>
References: <20160827005358.91477-1-jaegeuk@kernel.org>
 <10d2270d-6226-a269-c8a4-75bedfd0364c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10d2270d-6226-a269-c8a4-75bedfd0364c@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Sep 02, 2016 at 03:33:33PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/8/27 8:53, Jaegeuk Kim wrote:
> > This can avoid bio splits due to different op_flags.
> 
> I thought about this, but I think this is not a good idea to increase merging
> ratio of pages in bio. It breaks the rule of SYNC/ASYNC IO defined by system
> which indicate degree of IO emergency, finally, some/more non-emergent IO will
> treated as emergent one by IO scheduler, it will interrupt SYNC IOs in block
> layer, more seriously, it may make real SYNC IO starvation.

I understand your concern.
Originally, I tried to avoid breaking a big WRITE_SYNC by a small number of
WRITE. And, I thought new WRITE can be piggybacked into previous WRITE_SYNC.

IMO, this happens very occassionally since previous pending bio should be
WRITE_SYNC while a new request is WRITE. Even if this happens, the piggybacked
size would not exceed over bio's max pages.
If lots of WRITE come, we won't change at all.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 7c8e219..c7c2022 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -267,6 +267,11 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >  
> >  	down_write(&io->io_rwsem);
> >  
> > +	/* WRITE can be merged into previous WRITE_SYNC */
> > +	if (io->bio && io->last_block_in_bio == fio->new_blkaddr - 1 &&
> > +			io->fio.op == fio->op && io->fio.op_flags == WRITE_SYNC)
> > +		fio->op_flags = WRITE_SYNC;
> > +
> >  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> >  	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags)))
> >  		__submit_merged_bio(io);
> > 
