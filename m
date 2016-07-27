From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs for 4.8
Date: Wed, 27 Jul 2016 14:24:21 -0700
Message-ID: <20160727212421.GA74234@jaegeuk>
References: <20160727040800.GA69756@jaegeuk>
 <20160727084101.GA11784@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160727084101.GA11784@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Jul 27, 2016 at 01:41:01AM -0700, Christoph Hellwig wrote:
> >  - ioctl to move a range of data between files
> 
> Please run this through the linux-api list first.  We had so many
> problem with random ioctls on random file systems in the past.  Also
> I know Samsung had an xfs (and maybe ext4?) implementation of this
> functionality in the past, so it would be extremtly useful to have
> some discussion on that.
> 
> Also didn't this just show up last week for the first time?

Since I couldn't defend its confident use cases right now, I thought f2fs'd be
good to support it in order for someone to evaluate it; I expected some
kv-stores tho.

Once getting its validation, let me take a look at other file systems to expose
it into a generic one.

Thanks,
