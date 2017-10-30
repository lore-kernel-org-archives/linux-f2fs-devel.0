From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: relax EIO injection for quota file
Date: Mon, 30 Oct 2017 02:21:14 -0700
Message-ID: <20171030092114.GA26880@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171019165617.79128-1-jaegeuk@kernel.org>
 <20171019165617.79128-2-jaegeuk@kernel.org>
 <b8e70503-c0e3-22b2-a1fe-089f8fb206a6@kernel.org>
 <20171022165109.GA33676@jaegeuk-macbookpro.roam.corp.google.com>
 <369986d8-18f2-85b6-28cd-64dffea2f7a7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <369986d8-18f2-85b6-28cd-64dffea2f7a7@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/28, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/10/23 0:51, Jaegeuk Kim wrote:
> > On 10/22, Chao Yu wrote:
> >> On 2017/10/20 0:56, Jaegeuk Kim wrote:
> >>> This case is not happening easily.
> >>
> >> Actually it can happen, so why not just keep it?
> > 
> > Okay, so let me keep this patch for local stress tests only.
> 
> May I ask which type and rate of fault injection you are using for
> test now?

I select random value between 3000 and 5000, and 255 for type.

Thanks,

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>  fs/f2fs/f2fs.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index e0ef31cb2cc6..6301ccca8888 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -1544,7 +1544,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >>>  		return ret;
> >>>  
> >>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >>> -	if (time_to_inject(sbi, FAULT_BLOCK)) {
> >>> +	if (!IS_NOQUOTA(inode) && time_to_inject(sbi, FAULT_BLOCK)) {
> >>>  		f2fs_show_injection_info(FAULT_BLOCK);
> >>>  		release = *count;
> >>>  		goto enospc;
> >>>
> > 
> > .
> > 
