From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: enlarge block plug coverage
Date: Thu, 12 Apr 2018 18:06:15 -0700
Message-ID: <20180413010615.GA53401@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180404085404.82184-1-yuchao0@huawei.com>
 <20180405035115.GC50337@jaegeuk-macbookpro.roam.corp.google.com>
 <03c21c2f-cb0e-dbd4-b48a-95c2678964d1@huawei.com>
 <20180409180241.GC17558@jaegeuk-macbookpro.roam.corp.google.com>
 <967b8819-da9a-b609-6a22-db8df5c7ec6c@huawei.com>
 <20180410041033.GE47598@jaegeuk-macbookpro.roam.corp.google.com>
 <ff3990f2-5785-045e-30c5-62a9f8352d74@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f6nAV-0001Bx-K8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:06:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6nAT-004Gbb-RW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:06:23 +0000
Content-Disposition: inline
In-Reply-To: <ff3990f2-5785-045e-30c5-62a9f8352d74@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 04/10, Chao Yu wrote:
> On 2018/4/10 12:10, Jaegeuk Kim wrote:
> > On 04/10, Chao Yu wrote:
> >> On 2018/4/10 2:02, Jaegeuk Kim wrote:
> >>> On 04/08, Chao Yu wrote:
> >>>> On 2018/4/5 11:51, Jaegeuk Kim wrote:
> >>>>> On 04/04, Chao Yu wrote:
> >>>>>> This patch enlarges block plug coverage in __issue_discard_cmd, in
> >>>>>> order to collect more pending bios before issuing them, to avoid
> >>>>>> being disturbed by previous discard I/O in IO aware discard mode.
> >>>>>
> >>>>> Hmm, then we need to wait for huge discard IO for over 10 secs, which
> >>>>
> >>>> We found that total discard latency is rely on total discard number we issued
> >>>> last time instead of range or length discard covered. IMO, if we don't change
> >>>> .max_requests value, we will not suffer longer latency.
> >>>>
> >>>>> will affect following read/write IOs accordingly. In order to avoid that,
> >>>>> we actually need to limit the discard size.
> >>
> >> Do you mean limit discard count or discard length?
> > 
> > Both of them.
> > 
> >>
> >>>>
> >>>> If you are worry about I/O interference in between discard and rw, I suggest to
> >>>> decrease .max_requests value.
> >>>
> >>> What do you mean? This will produce more pending requests in the queue?
> >>
> >> I mean after applying this patch, we can queue more discard IOs in plug inside
> >> task, otherwise, previous issued discard in block layer can make is_idle() be false,
> >> then it can stop IO awared user to issue pending discard command.
> > 
> > Then, unplug will issue lots of discard commands, which affects the following rw
> > latencies. My preference would be issuing discard commands one by one as much as
> > possible.
> 
> Hmm.. for you concern, we can turn down IO priority of discard from background?

That makes much more sense to me. :P

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>>>> ---
> >>>>>>  fs/f2fs/segment.c | 7 +++++--
> >>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>>> index 8f0b5ba46315..4287e208c040 100644
> >>>>>> --- a/fs/f2fs/segment.c
> >>>>>> +++ b/fs/f2fs/segment.c
> >>>>>> @@ -1208,10 +1208,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>>>>>  		pend_list = &dcc->pend_list[i];
> >>>>>>  
> >>>>>>  		mutex_lock(&dcc->cmd_lock);
> >>>>>> +
> >>>>>> +		blk_start_plug(&plug);
> >>>>>> +
> >>>>>>  		if (list_empty(pend_list))
> >>>>>>  			goto next;
> >>>>>>  		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> >>>>>> -		blk_start_plug(&plug);
> >>>>>>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
> >>>>>>  			f2fs_bug_on(sbi, dc->state != D_PREP);
> >>>>>>  
> >>>>>> @@ -1227,8 +1229,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> >>>>>>  			if (++iter >= dpolicy->max_requests)
> >>>>>>  				break;
> >>>>>>  		}
> >>>>>> -		blk_finish_plug(&plug);
> >>>>>>  next:
> >>>>>> +		blk_finish_plug(&plug);
> >>>>>> +
> >>>>>>  		mutex_unlock(&dcc->cmd_lock);
> >>>>>>  
> >>>>>>  		if (iter >= dpolicy->max_requests)
> >>>>>> -- 
> >>>>>> 2.15.0.55.gc2ece9dc4de6
> >>>>>
> >>>>> .
> >>>>>
> >>>
> >>> .
> >>>
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
