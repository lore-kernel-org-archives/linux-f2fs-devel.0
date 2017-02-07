From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue discard commands
 asynchronously
Date: Mon, 6 Feb 2017 19:44:03 -0800
Message-ID: <20170207034403.GA24935@jaegeuk.local>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
 <20170112224407.54026-5-jaegeuk@kernel.org>
 <20170113080159.GB31777@infradead.org>
 <20170113191211.GB1301@jaegeuk.local>
 <20170116173220.GA2199@infradead.org>
 <20170205085947.GA25319@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170205085947.GA25319@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, axboe@kernel.dk
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/05, Christoph Hellwig wrote:
> On Mon, Jan 16, 2017 at 09:32:20AM -0800, Christoph Hellwig wrote:
> > On Fri, Jan 13, 2017 at 11:12:11AM -0800, Jaegeuk Kim wrote:
> > > Previously, I've done to issue discard bios asynchronously. But the problem that
> > > I've got is that was not enough. When testing nvme SSD with noop IO scheduler,
> > > submit_bio() was blocked at every 8 async discard bios, resulting in very slow
> > > checkpoint process which blocks most of other FS operations.
> > 
> > Where does it block?  Are you running out of request?  What driver is
> > this on top of?
> 
> Ping?  I'm currently spending a lot of effort on fs and block dіscard
> code, and I'd like to make sure we get common infrastructure instead
> of local hacks.

Sorry for the late response due to the travel.

When doing fstrim with a fresh f2fs image fomatted on Intel NVMe SSD whose
model name is SSDPE2MW012T4, I've got the following trace.

...
fstrim-12620 [000] .... 334572.907534: f2fs_issue_discard: dev = (259,1), blkstart = 0x902900, blklen = 0x400
fstrim-12620 [000] .... 334572.907535: block_bio_remap: 259,0 D 75583488 + 8192 <- (259,1) 75581440
fstrim-12620 [000] .... 334572.907535: block_bio_queue: 259,0 D 75583488 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.907535: block_getrq: 259,0 D 75583488 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.907536: block_unplug: [fstrim] 1
fstrim-12620 [000] .... 334572.907536: block_rq_insert: 259,0 D 0 () 75583488 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.907536: block_rq_issue: 259,0 D 0 () 75583488 + 8192 [fstrim]
 < repeat 6 times >
fstrim-12620 [000] .... 334572.907620: f2fs_issue_discard: dev = (259,1), blkstart = 0x904500, blklen = 0x400
fstrim-12620 [000] .... 334572.907620: block_bio_remap: 259,0 D 75640832 + 8192 <- (259,1) 75638784
fstrim-12620 [000] .... 334572.907620: block_bio_queue: 259,0 D 75640832 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.907621: block_getrq: 259,0 D 75640832 + 8192 [fstrim]
<idle>-0     [000] d.h. 334572.907723: block_rq_complete: 259,0 D () 67260416 + 8192 [0]
<idle>-0     [000] d.h. 334572.907942: block_rq_complete: 259,0 D () 67268608 + 8192 [0]
<idle>-0     [000] d.h. 334572.908155: block_rq_complete: 259,0 D () 67276800 + 8192 [0]
<idle>-0     [000] d.h. 334572.908374: block_rq_complete: 259,0 D () 67284992 + 8192 [0]
<idle>-0     [000] d.h. 334572.908597: block_rq_complete: 259,0 D () 67293184 + 8192 [0]
<idle>-0     [000] d.h. 334572.908823: block_rq_complete: 259,0 D () 67301376 + 8192 [0]
<idle>-0     [000] d.h. 334572.909033: block_rq_complete: 259,0 D () 67309568 + 8192 [0]
<idle>-0     [000] d.h. 334572.909216: block_rq_complete: 259,0 D () 67317760 + 8192 [0]
fstrim-12620 [000] .... 334572.909222: block_unplug: [fstrim] 1
fstrim-12620 [000] .... 334572.909223: block_rq_insert: 259,0 D 0 () 75640832 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.909224: block_rq_issue: 259,0 D 0 () 75640832 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.909240: f2fs_issue_discard: dev = (259,1), blkstart = 0x904900, blklen = 0x400
fstrim-12620 [000] .... 334572.909241: block_bio_remap: 259,0 D 75649024 + 8192 <- (259,1) 75646976
fstrim-12620 [000] .... 334572.909241: block_bio_queue: 259,0 D 75649024 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.909241: block_getrq: 259,0 D 75649024 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.909242: block_unplug: [fstrim] 1
fstrim-12620 [000] .... 334572.909242: block_rq_insert: 259,0 D 0 () 75649024 + 8192 [fstrim]
fstrim-12620 [000] .... 334572.909242: block_rq_issue: 259,0 D 0 () 75649024 + 8192 [fstrim]
 < repeat >

So, I investigated why block_rq_complete() happened in more detail.

The root-caused call path looks like:
 - submit_bio
  - generic_make_request
   - q->make_request_fn
    - blk_mq_make_request
     - blk_mq_map_request
      - blk_mq_alloc_request
       - blk_mq_get_tag
        - __blk_mq_get_tag
         - bt_get
          - blk_mq_run_hw_queue
          - finish_wait
          --> this waits for pending 8 discard bios!

It seems the problem comes from the storage processing discard commands too
slowly comparing to normal read/write IOs.

Any thoughts?

Thanks,
