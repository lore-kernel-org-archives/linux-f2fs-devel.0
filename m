From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double count on issued discard
 commands
Date: Mon, 11 Sep 2017 21:29:16 -0700
Message-ID: <20170912042916.GA95671@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170911033845.53701-1-jaegeuk@kernel.org>
 <b6550c76-448a-fa48-eef8-3abcc2835b30@huawei.com>
 <6209aa5a-4d45-ac2b-448a-4b405dfb25d1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6209aa5a-4d45-ac2b-448a-4b405dfb25d1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, daehojng@gmail.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/12, Chao Yu wrote:
> On 2017/9/12 9:53, Chao Yu wrote:
> > On 2017/9/11 11:38, Jaegeuk Kim wrote:
> >> If issue_cond is true, it does double count for # of issued commands.
> >>
> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> As Daeho Jeong mentioned, the change makes 'iter > DISCARD_ISSUE_RATE' dead
> code, I just misread iter and issued variable, sorry. :(

Yeah, that's exactly like what I made a mistake before.
I should have mentioned that earlier. :)

> 
> Thanks,
> 
> > 
> >> ---
> >>  fs/f2fs/segment.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 7fd742f747ce..25196ff5d587 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -1087,7 +1087,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
> >>  				issued++;
> >>  				__submit_discard_cmd(sbi, dc);
> >>  			}
> >> -			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
> >> +			if (issue_cond && iter > DISCARD_ISSUE_RATE)
> >>  				goto out;
> >>  		}
> >>  		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
> >>
> > 
> > 
> > 
