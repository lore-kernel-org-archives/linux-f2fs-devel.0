From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to redirty page if fail to gc data
	page
Date: Thu, 2 Jun 2016 22:08:58 -0700
Message-ID: <20160603050858.GA24882@jaegeuk>
References: <1463807951-10472-1-git-send-email-chao@kernel.org>
	<20160530023702.GB78763@jaegeuk.hsd1.ca.comcast.net>
	<a09543b8-349e-d2cc-0e15-f2bf82d4dcfa@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8hM4-0000dB-2h
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 05:09:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8hM3-0008BY-6z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 05:09:08 +0000
Content-Disposition: inline
In-Reply-To: <a09543b8-349e-d2cc-0e15-f2bf82d4dcfa@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, May 31, 2016 at 02:10:50PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/5/30 10:37, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On Sat, May 21, 2016 at 01:19:11PM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> If we fail to move data page during foreground GC, we should give another
> >> chance to writeback that page which was set dirty previously by writer.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/gc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 38d56f6..ee213a8 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -653,12 +653,15 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
> >>  			.page = page,
> >>  			.encrypted_page = NULL,
> >>  		};
> >> +		bool is_dirty = PageDirty(page);
> >> +
> >>  		set_page_dirty(page);
> >>  		f2fs_wait_on_page_writeback(page, DATA, true);
> >>  		if (clear_page_dirty_for_io(page))
> >>  			inode_dec_dirty_pages(inode);
> >>  		set_cold_data(page);
> >> -		do_write_data_page(&fio);
> >> +		if (do_write_data_page(&fio) && is_dirty)
> >> +			set_page_dirty(page);
> > 
> > If this page is truncated with -ENOENT, we don't need to set it dirty again.
> 
> Agree
> 
> > I expect that, if we get an error here, do_garbage_collect() would retry FG_GC
> 
> IIRC, you have reworked the FG_GC flows changed from an infinite loop to trying
> do the movement just one time. Here, I think if there are just few of blocks are
> failed to be moved, we can give one more time for retrying. How do you think?

Mostly I expected here -ENOENT caused by race condition.
Do we have another expectation?

Thanks,

> 
> > again.
> > 
> > Thanks,
> > 
> >>  		clear_cold_data(page);
> >>  	}
> >>  out:
> >> -- 
> >> 2.7.2
> > .
> > 

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
