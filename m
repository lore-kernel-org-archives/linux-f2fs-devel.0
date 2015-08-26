From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
Date: Wed, 26 Aug 2015 20:33:22 +0800
Message-ID: <001901d0dffb$7d382040$77a860c0$@samsung.com>
References: <017d01d0da71$5780e8d0$0682ba70$@samsung.com>
 <20150820174738.GD42028@jaegeuk-mac02.mot-mobility.com>
 <021801d0dc10$a4d36810$ee7a3830$@samsung.com>
 <000101d0df19$4aa94c90$dffbe5b0$@samsung.com>
 <001001d0df1a$ecc3e7f0$c64bb7d0$@samsung.com>
 <20150825222630.GB12070@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150825222630.GB12070@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 26, 2015 6:27 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
> 
> On Tue, Aug 25, 2015 at 05:45:53PM +0800, Chao Yu wrote:
> > > -----Original Message-----
> > > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > > Sent: Tuesday, August 25, 2015 5:34 PM
> > > To: 'Jaegeuk Kim'
> > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
> > >
> > > > -----Original Message-----
> > > > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > > > Sent: Friday, August 21, 2015 8:55 PM
> > > > To: 'Jaegeuk Kim'
> > > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > > Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
> > > >
> > > > Hi Jaegeuk,
> > > >
> > > > > -----Original Message-----
> > > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > > Sent: Friday, August 21, 2015 1:48 AM
> > > > > To: Chao Yu
> > > > > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH 9/9] f2fs: update extent tree in batches
> > > > >
> > > > > Hi Chao,
> > > > >
> > > > > On Wed, Aug 19, 2015 at 07:21:48PM +0800, Chao Yu wrote:
> > > > > > This patch introduce a new helper f2fs_update_extent_tree_range
> > > > > > which can update extent nodes in extent tree in batches.
> > > > > >
> > > > > > Now, we use the function to invalidate blocks in batches instead of
> > > > > > invalidating them one by one when truncating blocks.
> > > > >
> > > > > IMO, it's not clear the benefit of this patch in terms of performance and code
> > > > > readability versus risky code changes.
> > > >
> > > > This is only used in truncate path, IMO, in theory, we can gain benefit from
> > > > this batch mode operation when truncating frequently.
> > > >
> > > > I will test the patch for numbers.
> > >
> > > Since in batched operation is only used in truncation path, I only stat data
> > > in that path. And I add below function to test for stating time count.
> > >
> > > uint64_t rdtsc(void)
> > > {
> > > 	uint32_t lo, hi;
> > > 	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
> > > 	return (uint64_t)hi << 32 | lo;
> > > }
> > >
> > > My test environment is: ubuntu, intel i7-3770, 16G memory, 256g micron ssd.
> > >
> >
> > Sorry, it's out of format.
> >
> > a) Removing 128MB file which has one extent node mapping whole range of file:
> > 1. dd if=/dev/zero  of=/mnt/f2fs/128M bs=1M count=128
> > 2. sync
> > 3. rm /mnt/f2fs/128M
> > 				count		total		average
> > f2fs_update_extent_tree_range	33		3321		100.63
> > f2fs_update_extent_cache	32768		7651022		233.49
> >
> > b) fsstress:
> > fsstress -d /mnt/f2fs -l 5 -n 100 -p 20
> > 				count		total		average
> > f2fs_update_extent_tree_range	1868		1073762		574.82
> > f2fs_update_extent_cache	31518		11495827	364.74
> 
> So, the remaining concern is risky big code changes.
> Let me take time to review and test this for a while.

Thank you! :)

> Thank you for the work. :)

I wrote a v2 patch, I update performance data newly tested and
description in commit log of that patch.

Thanks,

> 
> Thanks,
