From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: shrink blk plug region
Date: Wed, 12 Apr 2017 12:57:16 -0700
Message-ID: <20170412195716.GA12163@jaegeuk.local>
References: <20170327101406.56028-1-yuchao0@huawei.com>
 <20170327101406.56028-2-yuchao0@huawei.com>
 <01ed1c10-f698-8e8c-2f76-f7c61265a844@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01ed1c10-f698-8e8c-2f76-f7c61265a844@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/12, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Just reminding, miss merging this patch? :)

Yup, merged. ;)

> 
> Thanks,
> 
> On 2017/3/27 18:14, Chao Yu wrote:
> > Don't use blk plug covering area where there won't be any IOs being issued.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/segment.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index c1a03b0857f9..57a81f9c8c14 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -848,9 +848,8 @@ static int issue_discard_thread(void *data)
> >  	if (kthread_should_stop())
> >  		return 0;
> >  
> > -	blk_start_plug(&plug);
> > -
> >  	mutex_lock(&dcc->cmd_lock);
> > +	blk_start_plug(&plug);
> >  	list_for_each_entry_safe(dc, tmp, pend_list, list) {
> >  		f2fs_bug_on(sbi, dc->state != D_PREP);
> >  
> > @@ -860,6 +859,7 @@ static int issue_discard_thread(void *data)
> >  		if (iter++ > DISCARD_ISSUE_RATE)
> >  			break;
> >  	}
> > +	blk_finish_plug(&plug);
> >  
> >  	list_for_each_entry_safe(dc, tmp, wait_list, list) {
> >  		if (dc->state == D_DONE)
> > @@ -867,8 +867,6 @@ static int issue_discard_thread(void *data)
> >  	}
> >  	mutex_unlock(&dcc->cmd_lock);
> >  
> > -	blk_finish_plug(&plug);
> > -
> >  	iter = 0;
> >  	congestion_wait(BLK_RW_SYNC, HZ/50);
> >  
> > 
