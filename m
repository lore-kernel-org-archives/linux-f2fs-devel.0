From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
Date: Tue, 11 Sep 2018 18:25:50 -0700
Message-ID: <20180912012550.GA71953@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
 <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/12, Chao Yu wrote:
> On 2018/9/12 8:27, Jaegeuk Kim wrote:
> > On 09/11, Jaegeuk Kim wrote:
> >> On 09/12, Chao Yu wrote:
> >>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
> >>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
> >>>> can recover it based on previous user information.
> >>>
> >>> I didn't get it, both fsck and kernel recover quota file based all inodes'
> >>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
> >>> same?
> >>
> >> I thought that, but had to add this, since I was encountering quota errors right
> >> after getting some files recovered. And, I thought it'd make it more safe to do
> >> fsck after roll-forward recovery.
> >>
> >> Anyway, let me test again without this patch for a while.
> > 
> > Hmm, I just got a fsck failure right after some files recovered.
> 
> To make sure, do you test with "f2fs: guarantee journalled quota data by
> checkpoint"? if not, I think there is no guarantee that f2fs can recover
> quote info into correct quote file, because, in last checkpoint, quota file
> may was corrupted/inconsistent. Right?

I hit the failure with v8. And, the test scenario is 1) enable fault injection
2) run fsstress, 3) call shutdowon, 4) kill fsstress, 5) unmount, 6) fsck, 7)
mount, 8) fsck, 9) go 1).

So, I'm hitting failure in 8) fsck. I expect 6) fsck should fix any corruption
and 7) recovered some files on clean checkpoint.

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>> ---
> >>>>  fs/f2fs/recovery.c | 3 +++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >>>> index 95511ed11a22..1fde86a2107e 100644
> >>>> --- a/fs/f2fs/recovery.c
> >>>> +++ b/fs/f2fs/recovery.c
> >>>> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >>>>  
> >>>>  	need_writecp = true;
> >>>>  
> >>>> +	/* quota is not fully updated due to the lack of user information. */
> >>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>> +
> >>>>  	/* step #2: recover data */
> >>>>  	err = recover_data(sbi, &inode_list, &dir_list);
> >>>>  	if (!err)
> >>>>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 
