From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/5] f2fs: use blk_plug in all the possible paths
Date: Thu, 14 Jul 2016 20:05:02 -0700
Message-ID: <20160715030502.GB44979@jaegeuk>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
 <20160715004629.43143-5-jaegeuk@kernel.org>
 <20160715022132.GA1513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160715022132.GA1513@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jul 14, 2016 at 07:21:32PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 14, 2016 at 05:46:29PM -0700, Jaegeuk Kim wrote:
> > The main reason is that blk_start_plug can be used to wake up from low-power
> > mode before submitting further bios.
> 
> Where does that myth come from?

>From kernel guys working on android.
And, I'm in also doubt they may have done something regarding to power mode
change, by the fact that I've seen annoying performance jitters comparing to
ext4's ones all the time in some android products. 

Frankly speaking, I cannot find a concrete reason to remove plugging entirely,
since I can't see big performance differences in all my test results in severs
as well.

Thanks,
