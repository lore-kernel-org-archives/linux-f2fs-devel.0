From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue discard commands
 asynchronously
Date: Wed, 8 Feb 2017 14:05:40 -0800
Message-ID: <20170208220540.GA10747@jaegeuk.local>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
 <20170112224407.54026-5-jaegeuk@kernel.org>
 <20170113080159.GB31777@infradead.org>
 <20170113191211.GB1301@jaegeuk.local>
 <20170116173220.GA2199@infradead.org>
 <20170205085947.GA25319@infradead.org>
 <20170207034403.GA24935@jaegeuk.local>
 <20170208160207.GA14621@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170208160207.GA14621@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, axboe@kernel.dk, linux-nvme@lists.infradead.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/08, Christoph Hellwig wrote:
> On Mon, Feb 06, 2017 at 07:44:03PM -0800, Jaegeuk Kim wrote:
> > Sorry for the late response due to the travel.
> > 
> > When doing fstrim with a fresh f2fs image fomatted on Intel NVMe SSD whose
> > model name is SSDPE2MW012T4, I've got the following trace.
> 
> <snip>
> 
> > So, I investigated why block_rq_complete() happened in more detail.
> > 
> > The root-caused call path looks like:
> >  - submit_bio
> >   - generic_make_request
> >    - q->make_request_fn
> >     - blk_mq_make_request
> >      - blk_mq_map_request
> >       - blk_mq_alloc_request
> >        - blk_mq_get_tag
> >         - __blk_mq_get_tag
> >          - bt_get
> >           - blk_mq_run_hw_queue
> >           - finish_wait
> >           --> this waits for pending 8 discard bios!
> 
> You're blocking on tag allocation.  How many tags per queue does
> your device have?, e.g. do a
> 
> cat /sys/block/nvme0n1/mq/0/nr_tags

It shows 1023.

> > It seems the problem comes from the storage processing discard commands too
> > slowly comparing to normal read/write IOs.
> > 
> > Any thoughts?
> 
> Deallocate is always going to be an exception path compared to normal
> read/write… but just how much slower is going to be device
> dependent.
> 
> One option would be to reuse the number of discards, for that can you
> try the series here to support vectored discards:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/vectored-discard-for-axboe

I tried this, but couldn't see any difference.

Thanks,
