From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 0/8] some cleanup of inline flag checking
Date: Fri, 11 Mar 2016 15:25:49 +0800
Message-ID: <010001d17b67$588e8c40$09aba4c0$@samsung.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
 <00fe01d17b57$30b6e9c0$9224bd40$@samsung.com>
 <56E266F4.4000200@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <56E266F4.4000200@kernel-upstream.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Shawn Lin' <shawn.lin@kernel-upstream.org>, 'Shawn Lin' <shawn.lin@rock-chips.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Shawn,

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@kernel-upstream.org]
> Sent: Friday, March 11, 2016 2:34 PM
> To: Chao Yu; 'Shawn Lin'; 'Jaegeuk Kim'
> Cc: shawn.lin@kernel-upstream.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 0/8] some cleanup of inline flag checking
> 
> Hi Chao Yu,
> 
> On 2016/3/11 13:29, Chao Yu wrote:
> > Hi Shawn,
> >
> >> -----Original Message-----
> >> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> >> Sent: Friday, March 11, 2016 11:28 AM
> >> To: Jaegeuk Kim
> >> Cc: Shawn Lin; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> >> Subject: [f2fs-dev] [PATCH 0/8] some cleanup of inline flag checking
> >>
> >>
> >> This patchset is going to remove some redunant checking
> >> of inline data flag and also going to avoid some unnecessary
> >> cpu waste when doing inline stuff.
> >
> > When we are accessing inline inode, inline inode conversion can happen
> > concurrently, we should check inline flag again under inode page's lock
> > to avoid accessing the wrong inline data which may have been converted.
> >
> 
> that sounds reasonable at first glance, and it more seems like that
> mopst part of this patchset is just puting the checking in the right way.
> 
> If we need to check the inline inode under the protection of inode
> page's lock, it means any callers who calling inline API stuff is
> wasting time on checing the flag outside the API, right?

As you know, inline conversion was designed as one-way operation, which means
inline inode can only be converted to normal inode, but can not be converted
in the opposite way. So here, with original design, it is OK to handle inode
as regular one if we detect that it is a non-inline inode, since it won't be
converted to inline one, otherwise, we should take inode page's lock and check
the flag again.

Thanks,

> 
> So we can just remove the redundant checking of the caller, but not
> change the behaviour of checing inline flag under page's lock?
> 
> Thanks for catching it.
> 
> > Thanks,
> >
> >>
> >> Note:
> >> Sorry for sending previous four patches in separate, let
> >> drop them and make them in this thread for better review.
> >>
> >>
> >>
> >> Shawn Lin (8):
> >>    f2fs: check inline flag ahead for f2fs_write_inline_data
> >>    f2fs: remove checing inline data flag for f2fs_write_data_page
> >>    f2fs: check inline flag ahead for f2fs_read_inline_data
> >>    f2fs: remove redundant checking of inline data flag
> >>    f2fs: f2fs: check inline flag ahead for f2fs_inline_data_fiemap
> >>    f2fs: remove checing inline data flag for f2fs_fiemap
> >>    f2fs: remove unnecessary inline checking for f2fs_convert_inline_inode
> >>    f2fs: check inline flag ahead for get_dnode_of_data
> >>
> >>   fs/f2fs/data.c   | 17 +++++++----------
> >>   fs/f2fs/inline.c | 27 ++++++++++-----------------
> >>   fs/f2fs/node.c   | 12 +++++-------
> >>   3 files changed, 22 insertions(+), 34 deletions(-)
> >>
> >> --
> >> 2.3.7
> >>
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Transform Data into Opportunity.
> >> Accelerate data analysis in your applications with
> >> Intel Data Analytics Acceleration Library.
> >> Click to learn more.
> >> http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
> > ------------------------------------------------------------------------------
> > Transform Data into Opportunity.
> > Accelerate data analysis in your applications with
> > Intel Data Analytics Acceleration Library.
> > Click to learn more.
> > http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
