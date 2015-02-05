From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/8 v4] common/rc: add _require_bmap
Date: Thu, 5 Feb 2015 13:05:07 +1100
Message-ID: <20150205020507.GC12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423004840-45315-3-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Feb 03, 2015 at 03:07:14PM -0800, Jaegeuk Kim wrote:
> This is to detect whether the filesystem tool supports bmap or not.

xfs_bmap is essentially deprecated. Please convert the tests to use
fiemap rather than requiring new infrastructure to support new block
mapping tools.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
