From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH v2] f2fs: fix max orphan inodes calculation
Date: Fri, 06 Mar 2015 11:37:28 +0800
Message-ID: <012301d057bf$029602e0$07c208a0$@samsung.com>
References: <1425029893-24702-1-git-send-email-wanpeng.li@linux.intel.com>
 <20150303014022.GD6541@lcm-devel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150303014022.GD6541@lcm-devel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Tuesday, March 03, 2015 9:40 AM
> To: linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Chao Yu; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] f2fs: fix max orphan inodes calculation
> 
> On Fri, Feb 27, 2015 at 05:38:13PM +0800, Wanpeng Li wrote:
> > cp_payload is introduced for sit bitmap to support large volume, and it is
> > just after the block of f2fs_checkpoint + nat bitmap, so the first segment
> > should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks.
> > However, current max orphan inodes calculation don't consider cp_payload,
> > this patch fix it by reducing the number of cp_payload from total blocks of
> > the first segment when calculate max orphan inodes.
> >
> > Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> > ---
> > v1 -> v2:
> >  * adjust comments above the codes
> >  * fix coding style issue
> >
> >  fs/f2fs/checkpoint.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index db82e09..a914e99 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1103,13 +1103,15 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
> >  	}
> >
> >  	/*
> > -	 * considering 512 blocks in a segment 8 blocks are needed for cp
> > -	 * and log segment summaries. Remaining blocks are used to keep
> > -	 * orphan entries with the limitation one reserved segment
> > -	 * for cp pack we can have max 1020*504 orphan entries
> > +	 * considering 512 blocks in a segment 8+cp_payload blocks are
> > +	 * needed for cp and log segment summaries. Remaining blocks are
> > +	 * used to keep orphan entries with the limitation one reserved
> > +	 * segment for cp pack we can have max 1020*(504-cp_payload)
> > +	 * orphan entries
> >  	 */
> 
> Hi all,
> 
> I think below code give us information enough so it doesn't need to
> describe above comments. And someone could get confused by 1020 constants.
> How do you think about removing comments.

I agree with you.

There are nothing special need to be pay attention for the below statement,
all meaning of statement could be easily readed as each macro in statement
can indicate meaning of itself clearly.

So could you send another patch to remove it?

Thanks,

> 
> Regards,
> Changman
> 
> >  	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
> > -			NR_CURSEG_TYPE) * F2FS_ORPHANS_PER_BLOCK;
> > +			NR_CURSEG_TYPE - __cp_payload(sbi)) *
> > +				F2FS_ORPHANS_PER_BLOCK;
> >  }
> >
> >  int __init create_checkpoint_caches(void)
> > --
> > 1.9.1
