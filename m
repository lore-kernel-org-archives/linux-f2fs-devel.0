From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions for f2fs
 encryption feature
Date: Wed, 13 May 2015 12:02:08 +1000
Message-ID: <20150513020208.GK15721@dastard>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 08, 2015 at 09:20:38PM -0700, Jaegeuk Kim wrote:
> This definitions will be used by inode and superblock for encyption.

How much of this crypto stuff is common with or only slightly
modified from the ext4 code?  Is the behaviour and features the
same? Is the user API and management tools the same?

IMO, if there is any amount of overlap, then we should be
implementing this stuff as generic code, not propagating the same
code through multiple filesystems via copy-n-paste-n-modify. This
will simply end up with diverging code, different bugs and feature
sets, and none of the implementations will get the review and
maintenance they really require...

And, FWIW, this is the reason why I originally asked for the ext4
encryption code to be pulled up to the VFS: precisely so we didn't
end up with a rapid proliferation of individual in-filesystem
encryption implementations that are all slightly different...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
