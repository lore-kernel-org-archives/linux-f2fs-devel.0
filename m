From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when
 truncating inline_data
Date: Thu, 19 Mar 2015 19:19:52 +0800
Message-ID: <009e01d06236$b9823a60$2c86af20$@samsung.com>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
 <1426611461-690-4-git-send-email-jaegeuk@kernel.org>
 <006d01d06118$a3a23390$eae69ab0$@samsung.com>
 <20150318175750.GB7461@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20150318175750.GB7461@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jeageuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, March 19, 2015 1:58 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when truncating inline_data
> 
> Hi,
> 
> On Wed, Mar 18, 2015 at 09:12:00AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Wednesday, March 18, 2015 12:58 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when truncating inline_data
> > >
> > > This patch removes wrong f2fs_bug_on in truncate_inline_inode.
> > >
> > > When there is no space, it can happen a corner case where i_isze is over
> > > MAX_INLINE_SIZE while its inode is still inline_data.
> > >
> > > The scenario is
> > >  1. write small data into file #A.
> > >  2. fill the whole partition to 100%.
> > >  3. truncate 4096 on file #A.
> >
> > If we truncate size over MAX_INLINE_DATA, we will convert inline data in
> > f2fs_truncate rather than write_begin below. isn't it?
> 
> But, it fails to convert that due to -ENOSPC. :)

That makes sense, :)

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Thank,


