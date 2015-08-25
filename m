From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 9/9] f2fs: update extent tree in batches
Date: Tue, 25 Aug 2015 15:26:30 -0700
Message-ID: <20150825222630.GB12070@jaegeuk-mac02.mot.com>
References: <017d01d0da71$5780e8d0$0682ba70$@samsung.com>
	<20150820174738.GD42028@jaegeuk-mac02.mot-mobility.com>
	<021801d0dc10$a4d36810$ee7a3830$@samsung.com>
	<000101d0df19$4aa94c90$dffbe5b0$@samsung.com>
	<001001d0df1a$ecc3e7f0$c64bb7d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZUMfv-0005wx-Lk
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 22:26:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZUMfu-00006N-Jj for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Aug 2015 22:26:39 +0000
Content-Disposition: inline
In-Reply-To: <001001d0df1a$ecc3e7f0$c64bb7d0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Aug 25, 2015 at 05:45:53PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Tuesday, August 25, 2015 5:34 PM
> > To: 'Jaegeuk Kim'
> > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
> > 
> > > -----Original Message-----
> > > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > > Sent: Friday, August 21, 2015 8:55 PM
> > > To: 'Jaegeuk Kim'
> > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 9/9] f2fs: update extent tree in batches
> > >
> > > Hi Jaegeuk,
> > >
> > > > -----Original Message-----
> > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > Sent: Friday, August 21, 2015 1:48 AM
> > > > To: Chao Yu
> > > > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 9/9] f2fs: update extent tree in batches
> > > >
> > > > Hi Chao,
> > > >
> > > > On Wed, Aug 19, 2015 at 07:21:48PM +0800, Chao Yu wrote:
> > > > > This patch introduce a new helper f2fs_update_extent_tree_range
> > > > > which can update extent nodes in extent tree in batches.
> > > > >
> > > > > Now, we use the function to invalidate blocks in batches instead of
> > > > > invalidating them one by one when truncating blocks.
> > > >
> > > > IMO, it's not clear the benefit of this patch in terms of performance and code
> > > > readability versus risky code changes.
> > >
> > > This is only used in truncate path, IMO, in theory, we can gain benefit from
> > > this batch mode operation when truncating frequently.
> > >
> > > I will test the patch for numbers.
> > 
> > Since in batched operation is only used in truncation path, I only stat data
> > in that path. And I add below function to test for stating time count.
> > 
> > uint64_t rdtsc(void)
> > {
> > 	uint32_t lo, hi;
> > 	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
> > 	return (uint64_t)hi << 32 | lo;
> > }
> > 
> > My test environment is: ubuntu, intel i7-3770, 16G memory, 256g micron ssd.
> > 
> 
> Sorry, it's out of format.
> 
> a) Removing 128MB file which has one extent node mapping whole range of file:
> 1. dd if=/dev/zero  of=/mnt/f2fs/128M bs=1M count=128
> 2. sync
> 3. rm /mnt/f2fs/128M
> 				count		total		average
> f2fs_update_extent_tree_range	33		3321		100.63
> f2fs_update_extent_cache	32768		7651022		233.49
> 
> b) fsstress:
> fsstress -d /mnt/f2fs -l 5 -n 100 -p 20
> 				count		total		average
> f2fs_update_extent_tree_range	1868		1073762		574.82
> f2fs_update_extent_cache	31518		11495827	364.74

So, the remaining concern is risky big code changes.
Let me take time to review and test this for a while.
Thank you for the work. :)

Thanks,

------------------------------------------------------------------------------
