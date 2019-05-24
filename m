From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
Date: Fri, 24 May 2019 08:39:58 +0530
Message-ID: <20190524030958.GB10043@codeaurora.org>
References: <20190524015555.12622-1-sunqiuyang@huawei.com>
 <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 24, 2019 at 10:32:07AM +0800, Chao Yu wrote:
> +Cc Sahitya,
> 
> On 2019/5/24 9:55, sunqiuyang wrote:
> > From: Qiuyang Sun <sunqiuyang@huawei.com>
> > 
> > This ioctl shrinks a given length (aligned to sections) from end of the
> > main area. Any cursegs and valid blocks will be moved out before
> > invalidating the range.
> > 
> > This feature can be used for adjusting partition sizes online.
> > --
> > Changlog v1 ==> v2:
> > 
> > Sahitya Tummala:
> >  - Add this ioctl for f2fs_compat_ioctl() as well.
> >  - Fix debugfs status to reflect the online resize changes.
> >  - Fix potential race between online resize path and allocate new data
> >    block path or gc path.
> > 
> > Others:
> >  - Rename some identifiers.
> >  - Add some error handling branches.
> >  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
> > --
> > Changelog v2 ==> v3:
> > Implement this interface as ext4's, and change the parameter from shrunk
> > bytes to new block count of F2FS.
> > --
> > Changelog v3 ==> v4:
> >  - During resizing, force to empty sit_journal and forbid adding new
> >    entries to it, in order to avoid invalid segno in journal after resize.
> >  - Reduce sbi->user_block_count before resize starts.
> >  - Commit the updated superblock first, and then update in-memory metadata
> >    only when the former succeeds.
> >  - Target block count must align to sections.
> > --
> > Changelog v4 ==> v5:
> > Write checkpoint before and after committing the new superblock, w/o
> > CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
> > resize fails after the new superblock is committed.
> > --
> > Changelog v5 ==> v6:
> >  - In free_segment_range(), reduce granularity of gc_mutex.
> >  - Add protection on curseg migration.
> > 
> > Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> 
> Looks good to me now,
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> To Sahitya, is it okay to you merging all your fixes and adding Signed-off in
> original patch? We can still separate them from this patch if you object this,
> let us know.
> 

Hi Chao,

I am okay with merging.

Thanks,
Sahitya.

> Thanks,

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
