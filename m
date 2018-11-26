From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH] f2fs: fix to allow node segment for GC by ioctl path
Date: Mon, 26 Nov 2018 09:59:03 +0530
Message-ID: <20181126042903.GD9838@codeaurora.org>
References: <1542949942-30275-1-git-send-email-stummala@codeaurora.org>
 <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f94e8b8c-0c20-0668-16ad-4978b0600d36@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Nov 24, 2018 at 06:23:55PM +0800, Chao Yu wrote:
> On 2018/11/23 13:12, Sahitya Tummala wrote:
> > Allow node type segments also to be GC'd via f2fs ioctls
> > F2FS_IOC_GARBAGE_COLLECT and F2FS_IOC_GARBAGE_COLLECT_RANGE.
> 
> IIRC, only F2FS_IOC_GARBAGE_COLLECT_RANGE pass a valid segment number via
> @result parameter in get_victim_by_default(), so in commit message, it
> needs to remove F2FS_IOC_GARBAGE_COLLECT, right?
> 

Yes Chao, my mistake. Thanks for pointing it out. I will update it
and send the patch for review.

> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/gc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index a07241f..e4689c6 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -323,8 +323,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  	p.min_cost = get_max_cost(sbi, &p);
> >  
> >  	if (*result != NULL_SEGNO) {
> > -		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
> > -			get_valid_blocks(sbi, *result, false) &&
> > +		if (get_valid_blocks(sbi, *result, false) &&
> >  			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
> >  			p.min_segno = *result;
> >  		goto out;
> > @@ -404,11 +403,12 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  		}
> >  		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
> >  
> > +	}
> > +out:
> > +	if (p.min_segno != NULL_SEGNO)
> >  		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
> >  				sbi->cur_victim_sec,
> >  				prefree_segments(sbi), free_segments(sbi));
> > -	}
> > -out:
> >  	mutex_unlock(&dirty_i->seglist_lock);
> >  
> >  	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
> > 
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
