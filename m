From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: prevent waiter encountering incorrect discard
 states
Date: Mon, 3 Apr 2017 10:40:57 -0700
Message-ID: <20170403174057.GB1076@jaegeuk.local>
References: <20170327101406.56028-1-yuchao0@huawei.com>
 <20170327101406.56028-3-yuchao0@huawei.com>
 <20170327235608.GA4984@jaegeuk.local>
 <1040d25a-9cc8-a4c8-7143-a0375ecdeeb5@huawei.com>
 <b435e31f-5413-b392-4fc7-d0bcb1ef2600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b435e31f-5413-b392-4fc7-d0bcb1ef2600@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/01, Chao Yu wrote:
> Ping,
> 
> Any problem here?
> 
> Thanks,
> 
> On 2017/3/28 9:17, Chao Yu wrote:
> > On 2017/3/28 7:56, Jaegeuk Kim wrote:
> >> On 03/27, Chao Yu wrote:
> >>> In f2fs_submit_discard_endio, we will wake up waiter before setting
> >>> discard command states, so waiter may use incorrect states. Change
> >>> the order between complete() and states setting to fix this issue.
> >>>
> >>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>> ---
> >>>  fs/f2fs/segment.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 57a81f9c8c14..9f9542c9fe47 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -717,9 +717,9 @@ static void f2fs_submit_discard_endio(struct bio *bio)
> >>>  {
> >>>  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> >>>  
> >>> -	complete(&dc->wait);
> >>>  	dc->error = bio->bi_error;
> >>>  	dc->state = D_DONE;
> >>> +	complete(&dc->wait);
> >>
> >> If we set D_DONE first, the object can be released by __remove_discard_cmd()?

What I mean was about use-after-free.

Thanks,

> > 
> > Yes, I think so.
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>  	bio_put(bio);
> >>>  }
> >>>  
> >>> -- 
> >>> 2.8.2.295.g3f1c1d0
> >>
> >> .
> >>
