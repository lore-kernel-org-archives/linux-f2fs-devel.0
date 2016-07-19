From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/5] f2fs: use blk_plug in all the possible paths
Date: Mon, 18 Jul 2016 22:49:18 -0700
Message-ID: <20160719054918.GB80986@jaegeuk>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
 <20160715004629.43143-5-jaegeuk@kernel.org>
 <20160715022132.GA1513@infradead.org>
 <20160715030502.GB44979@jaegeuk>
 <20160719035952.GB24437@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160719035952.GB24437@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Jul 18, 2016 at 08:59:52PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 14, 2016 at 08:05:02PM -0700, Jaegeuk Kim wrote:
> > >From kernel guys working on android.
> 
> Well, until it's mainline it simply doesn't matter, so NAK to this
> patch.  Tying power behavior to plugs also sounds pretty broken, so we'd
> probably come up with something better if they bothered to actually
> submit their patches upsteam or at least explaining what they want
> to archive.

Actually, the initial patch which drops plugs is not mainlined as well.
So, at this time, I just want to revert it by this patch, since I recognized
that there might be whatever possible use-cases of plugs in another way someday.
So for now, I lost the reason to eliminate the plugs.

Moreover, since every filesystems use plugs, f2fs doesn't need to be an
exceptional case in terms of that (except hm-smr). So, let me sync f2fs
with other filesystems at this moment.

I totally agree that it'd be best to see their patches upstream, but I've
witnessed that it becomes a quite tough challenge to them.

Thanks,

