From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: use atomic variable for
 total_extent_tree
Date: Tue, 22 Dec 2015 16:08:46 +0800
Message-ID: <00bf01d13c90$14e0f7a0$3ea2e6e0$@samsung.com>
References: <1450755521-20015-1-git-send-email-jaegeuk@kernel.org>
 <00be01d13c79$a3db6970$eb923c50$@samsung.com>
 <20151222073453.GA20735@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20151222073453.GA20735@jaegeuk.local>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 22, 2015 3:35 PM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use atomic variable for total_extent_tree
> 
> On Tue, Dec 22, 2015 at 01:28:09PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Tuesday, December 22, 2015 11:39 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 1/2] f2fs: use atomic variable for total_extent_tree
> > >
> > > It would be better to use atomic variable for total_extent_tree.
> >
> > total_extent_tree was protected by extent_tree_lock semaphore, so intention here
> > is to make related calculation in available_free_memory or update_general_status
> > more accurate, right?
> 
> Moreover, another major thing is to specify it is atomic along with other extent
> counts.

Right, :) Please add:

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


