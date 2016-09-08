From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge WRITE bio into previous WRITE_SYNC
Date: Wed, 7 Sep 2016 17:26:15 -0700
Message-ID: <20160908002615.GC14665@jaegeuk>
References: <20160827005358.91477-1-jaegeuk@kernel.org>
 <10d2270d-6226-a269-c8a4-75bedfd0364c@huawei.com>
 <20160902183658.GA917@jaegeuk>
 <9c35b994-620f-b633-f3db-4e0622f09cd7@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9c35b994-620f-b633-f3db-4e0622f09cd7@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 07, 2016 at 10:12:17PM +0800, Chao Yu wrote:
> On 2016/9/3 2:36, Jaegeuk Kim wrote:
> > On Fri, Sep 02, 2016 at 03:33:33PM +0800, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2016/8/27 8:53, Jaegeuk Kim wrote:
> >>> This can avoid bio splits due to different op_flags.
> >>
> >> I thought about this, but I think this is not a good idea to increase merging
> >> ratio of pages in bio. It breaks the rule of SYNC/ASYNC IO defined by system
> >> which indicate degree of IO emergency, finally, some/more non-emergent IO will
> >> treated as emergent one by IO scheduler, it will interrupt SYNC IOs in block
> >> layer, more seriously, it may make real SYNC IO starvation.
> > 
> > I understand your concern.
> > Originally, I tried to avoid breaking a big WRITE_SYNC by a small number of
> 
> Hmm.. I'm worry about the opposite case: user triggers small WRITE_SYNC IO
> periodically, meanwhile there are big number of WRITE, with our new approach,
> actually we will increase the number of synchronous WRITE IO obviously because
> we will mix ASYNC/SYNC WRITE into bio cache intensively more than before since
> we drop writepages mutexlock. So I'm afread the result is that it will mislead
> scheduling of block layer.
> 
> > WRITE. And, I thought new WRITE can be piggybacked into previous WRITE_SYNC.
> > 
> > IMO, this happens very occassionally since previous pending bio should be
> > WRITE_SYNC while a new request is WRITE. Even if this happens, the piggybacked
> > size would not exceed over bio's max pages.
> > If lots of WRITE come, we won't change at all.
> 
> I thinks this is related to writeback / blocklayer / cgroup subsystem which use
> this tag frequently, maybe we should Cc their's mailing list for more opinion...

Except cgroup, since we do not support it yet. :P

Anyway, I think we'd better verify the effect of this for a while.
For example, I'm able to write a simple program to measure fsync latency while
a bunch of buffered writes.
Meanwhile, I'll put it back to the end of dev-test repo. :)

Thanks,

> 
> What's your opinion? :)
> 
> thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/data.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 7c8e219..c7c2022 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -267,6 +267,11 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
> >>>  
> >>>  	down_write(&io->io_rwsem);
> >>>  
> >>> +	/* WRITE can be merged into previous WRITE_SYNC */
> >>> +	if (io->bio && io->last_block_in_bio == fio->new_blkaddr - 1 &&
> >>> +			io->fio.op == fio->op && io->fio.op_flags == WRITE_SYNC)
> >>> +		fio->op_flags = WRITE_SYNC;
> >>> +
> >>>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> >>>  	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags)))
> >>>  		__submit_merged_bio(io);
> >>>
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
