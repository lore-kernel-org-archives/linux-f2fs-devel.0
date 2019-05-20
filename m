From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date: Mon, 20 May 2019 16:24:41 -0700
Message-ID: <20190520232441.GA61195@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <5ee36ad7-9fe9-adcf-0974-5c17fa8d50ee@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ee36ad7-9fe9-adcf-0974-5c17fa8d50ee@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 05/10, Chao Yu wrote:
> On 2019/2/12 10:33, Jaegeuk Kim wrote:
> > If we met this once, let fsck.f2fs clear this only.
> > Note that, this addresses all the subtle fault injection test.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 03fea4efd64b..10a3ada28715 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> >  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> > -	else
> > -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> 
> Jaegeuk,
> 
> Will below commit fix this issue? Not sure, but just want to check that.. :)
> 
> f2fs-tools: fix to check total valid block count before block allocation

I started test again whether we can revert this or not. :)
Let's see.
