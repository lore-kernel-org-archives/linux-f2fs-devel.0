From: Tom Marshall <tom@cyngn.com>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions for f2fs
 encryption feature
Date: Sat, 16 May 2015 10:13:26 -0700
Message-ID: <20150516171326.GA24795@eden.sea.cyngn.com>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
 <20150513020208.GK15721@dastard>
 <20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150514003721.GN15721@dastard>
 <20150516132403.GA2998@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150516132403.GA2998@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, May 16, 2015 at 09:24:03AM -0400, Theodore Ts'o wrote:
> [...] What's going to be more difficult in the long run is
> when we want to support per-block data integrity, using (for example)
> AES/GCM, which will require 32 bytes of per-block "authentication tag"
> (think Message Authentication Code) that have to be committed
> atomically with the data block write.
> 
> Quite frankly, this is going to be much easier for COW file systems
> like f2fs and btrfs.  I have some ideas about how to do this for
> update-in-place file systems (using either a compression hack and/or
> storing two generations worth of authentication tag per block), but
> it's not pretty.  (Or in the case of ext4 we could use
> data=journalling mode, but that's even less pretty from a performance
> standpoint.)

It seems to me that compression has a similar issue with framing metadata. 
The block map can be stored upfront, which then would require two writes to
update a data block.  Or it can be stored inline, which then would require
scanning through the file sequentially for random access.

The big difference, of course, is that in the case of compression, we have
the luxury of assuming or mandating read-only/read-mostly.
