From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: provide more chance for node and data to get
 ssr segment
Date: Fri, 24 Feb 2017 09:58:21 -0800
Message-ID: <20170224175821.GB39009@jaegeuk.local>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
 <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
 <20170223011754.GH4003@jaegeuk.local>
 <3d4b064b-817f-402f-3eb5-df3ec7c06b44@huawei.com>
 <58AFFA91.2030904@huawei.com>
 <3d5479f0-8b52-97df-707b-816d1a7a1a44@huawei.com>
 <58B01BCF.1050207@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58B01BCF.1050207@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/24, Yunlong Song wrote:
> Hi, Chao,
> 
> Not looks good to me, since there is some case your code does not include:
> if type is CURSEG_HOT_DATA, and if get_victim also returns 0 for both CURSEG_HOT_DATA and
> CURSEG_WARM_DATA, then i will be -1 and pass to get_victim in your code.  So I still suggest
> my original patch attached below.

Why does i become -1?

> 
> On 2017/2/24 18:47, Chao Yu wrote:
> > On 2017/2/24 17:19, Yunlong Song wrote:
> >> Hi Jaegeuk and Chao,
> >>
> >>     How about the question I pointed out in last mail:
> >>     Why not take "neighboring temperature" for ssr? For example, if type == CURSEG_COLD_DATA,
> >>     the new patch selects CURSEG_HOT_DATA first, why not select CURSEG_WARM_DATA first?
> >>     The patch I sent ensure this "neighboring temperature" for ssr. This is to reduce the influence of
> >>     mixing different levels of hot/code node types.
> > Agreed, I sent one patch for changing the policy of SSR, how do you think of it?
> >
> > Thanks,
> >
> >> On 2017/2/24 17:05, Chao Yu wrote:
> >>> Hi Jaegeuk,
> >>>
> >>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>>
> >>> For your attached two patches.
> >>>
> >>> Thanks,
> >>>
> >>> On 2017/2/23 9:17, Jaegeuk Kim wrote:
> >>>> Hi Yunlong,
> >>>>
> >>>> I've been testing the similar patches as I attached.
> >>>>
> >>>> Thanks,
> >>>>
> >>>> On 02/22, Yunlong Song wrote:
> >>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> >>>>> ---
> >>>>>  fs/f2fs/segment.c | 9 +++++++++
> >>>>>  1 file changed, 9 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>> index 9d13743..5fe71b9 100644
> >>>>> --- a/fs/f2fs/segment.c
> >>>>> +++ b/fs/f2fs/segment.c
> >>>>> @@ -1540,12 +1540,17 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
> >>>>>  {
> >>>>>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
> >>>>>  	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
> >>>>> +	int old_type = type;
> >>>>>  
> >>>>>  	if (IS_NODESEG(type)) {
> >>>>>  		for (; type >= CURSEG_HOT_NODE; type--)
> >>>>>  			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> >>>>>  							BG_GC, type, SSR))
> >>>>>  				return 1;
> >>>>> +		for (type = old_type + 1; type <= CURSEG_COLD_NODE; type++)
> >>>>> +			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> >>>>> +							BG_GC, type, SSR))
> >>>>> +				return 1;
> >>>>>  		return 0;
> >>>>>  	}
> >>>>>  
> >>>>> @@ -1554,6 +1559,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
> >>>>>  		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> >>>>>  						BG_GC, type, SSR))
> >>>>>  			return 1;
> >>>>> +	for (type = old_type + 1; type <= CURSEG_COLD_DATA; type++)
> >>>>> +		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> >>>>> +						BG_GC, type, SSR))
> >>>>> +			return 1;
> >>>>>  	return 0;
> >>>>>  }
> >>>>>  
> >>>>> -- 
> >>>>> 1.8.5.2
> >>> .
> >>>
> >>
> >
> > .
> >
> 
> 
> -- 
> Thanks,
> Yunlong Song
> 
