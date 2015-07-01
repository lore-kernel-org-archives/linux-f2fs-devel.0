From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 04/12] f2fs: remove wrong f2fs_bug_on when
 merging extents
Date: Tue, 30 Jun 2015 18:02:13 -0700
Message-ID: <20150701010213.GB1496@jaegeuk-mac02.mot.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
 <1435603176-63219-4-git-send-email-jaegeuk@kernel.org>
 <00e501d0b2e0$fd65f3c0$f831db40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00e501d0b2e0$fd65f3c0$f831db40$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jun 30, 2015 at 11:00:13AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, June 30, 2015 2:39 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 04/12] f2fs: remove wrong f2fs_bug_on when merging extents
> > 
> > In f2fs_update_extent_tree, if there is existing extent, f2fs tries to split
> > it with two parts.
> > In each trial, __insert_extent_tree checks __is_front/back_mergeable, and then
> > if it hits to go, there is f2fs_bug_on(!den), which triggers a kernel panic.
> > 
> > Actually, we don't need to check this. Instead, we can do __try_back_merge only
> > when there exists a den pointer.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 9bedfa8..7817167 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -519,19 +519,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
> > 
> >  		if (ei->fofs < en->ei.fofs) {
> >  			if (__is_front_mergeable(ei, &en->ei)) {
> > -				f2fs_bug_on(sbi, !den);
> 
> I add a BUG_ON here because we assume that in extent cache there is no such 
> two extents whose mapping address is continuous but without being merged,
> since whenever we add a new extent(not splitted one) into cache, we tries to
> merge it frontward/backward, then all extent with continuous mapping should be
> merged. So when we split one extent to two parts, each part should not be able
> to merge with others. Otherwise it should be a bug.

Oh, I see.
Let me take a look at this one more time.
I'm confusing whether this patch was written before fixing block address
calculation and then change the order of the patches.

Thanks,
