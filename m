From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to redirty page if fail to gc data page
Date: Thu, 2 Jun 2016 22:17:34 -0700
Message-ID: <20160603051734.GA25068@jaegeuk>
References: <1463807951-10472-1-git-send-email-chao@kernel.org>
 <20160530023702.GB78763@jaegeuk.hsd1.ca.comcast.net>
 <a09543b8-349e-d2cc-0e15-f2bf82d4dcfa@huawei.com>
 <20160603050858.GA24882@jaegeuk>
 <d0222ec2-986a-9d73-d3f5-c98335c0f37a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d0222ec2-986a-9d73-d3f5-c98335c0f37a@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jun 03, 2016 at 01:13:21PM +0800, Chao Yu wrote:
> On 2016/6/3 13:08, Jaegeuk Kim wrote:
> > On Tue, May 31, 2016 at 02:10:50PM +0800, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2016/5/30 10:37, Jaegeuk Kim wrote:
> >>> Hi Chao,
> >>>
> >>> On Sat, May 21, 2016 at 01:19:11PM +0800, Chao Yu wrote:
> >>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>
> >>>> If we fail to move data page during foreground GC, we should give another
> >>>> chance to writeback that page which was set dirty previously by writer.
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/gc.c | 5 ++++-
> >>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>> index 38d56f6..ee213a8 100644
> >>>> --- a/fs/f2fs/gc.c
> >>>> +++ b/fs/f2fs/gc.c
> >>>> @@ -653,12 +653,15 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
> >>>>  			.page = page,
> >>>>  			.encrypted_page = NULL,
> >>>>  		};
> >>>> +		bool is_dirty = PageDirty(page);
> >>>> +
> >>>>  		set_page_dirty(page);
> >>>>  		f2fs_wait_on_page_writeback(page, DATA, true);
> >>>>  		if (clear_page_dirty_for_io(page))
> >>>>  			inode_dec_dirty_pages(inode);
> >>>>  		set_cold_data(page);
> >>>> -		do_write_data_page(&fio);
> >>>> +		if (do_write_data_page(&fio) && is_dirty)
> >>>> +			set_page_dirty(page);
> >>>
> >>> If this page is truncated with -ENOENT, we don't need to set it dirty again.
> >>
> >> Agree
> >>
> >>> I expect that, if we get an error here, do_garbage_collect() would retry FG_GC
> >>
> >> IIRC, you have reworked the FG_GC flows changed from an infinite loop to trying
> >> do the movement just one time. Here, I think if there are just few of blocks are
> >> failed to be moved, we can give one more time for retrying. How do you think?
> > 
> > Mostly I expected here -ENOENT caused by race condition.
> 
> If we hit ENOENT case, we can pass get_valid_blocks check, so we don't need to
> worry about this case, right?
> 
> > Do we have another expectation?
> 
> ENOMEM or EIO?

EIO will stop everything.
ENOMEM would be better to wait for a while from page reclaim?

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >>> again.
> >>>
> >>> Thanks,
> >>>
> >>>>  		clear_cold_data(page);
> >>>>  	}
> >>>>  out:
> >>>> -- 
> >>>> 2.7.2
> >>> .
> >>>
> > .
> > 
