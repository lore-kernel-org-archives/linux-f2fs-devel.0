From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2 v3] xfs/087: test f2fs selectively
Date: Wed, 21 Jan 2015 14:38:32 +1100
Message-ID: <20150121033832.GB16510@dastard>
References: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420804366-85126-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jan 09, 2015 at 03:52:45AM -0800, Jaegeuk Kim wrote:
> This patch add the f2fs support for xfs/087 with goingdown.
> 

xfs/087 is not really a test that should be made generic/shared;
it's testing a bunch of different XFS specific mount options and log
recovery behaviour which has no relevance to any other filesystem.

If you want to take xfs specific tests that are only XFS specific
because of the shutdowns they use, look at these ones:

	xfs/053		(data exposure)
	xfs/137		(data vs filesize)
	xfs/138		(data vs filesize vs truncate)
	xfs/139		(data vs filesize vs partial truncate)
	xfs/140		(data vs filesize vs extending truncate)
	xfs/179		(data vs filesize w/ fsync)
	xfs/180		(data vs filesize w/ sync)
	xfs/182		(data vs filesize w/ recovery)
	xfs/200		(recovery vs ro-block device)
	xfs/306		(fsstress vs recovery)

These can all be made generic with very little effort -
"_require_shutdown" is probably all that is necessary for most of
them....

Also, we really are trying not to add more "shared" tests - with the
correct "_requires_foo" rules we can just place those tests in
generic/ and filesystems that don't support "foo" will avoid it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
