From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions for f2fs
 encryption feature
Date: Tue, 12 May 2015 23:48:02 -0700
Message-ID: <20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
 <20150513020208.GK15721@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513020208.GK15721@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 13, 2015 at 12:02:08PM +1000, Dave Chinner wrote:
> On Fri, May 08, 2015 at 09:20:38PM -0700, Jaegeuk Kim wrote:
> > This definitions will be used by inode and superblock for encyption.
> 
> How much of this crypto stuff is common with or only slightly
> modified from the ext4 code?  Is the behaviour and features the
> same? Is the user API and management tools the same?
> 
> IMO, if there is any amount of overlap, then we should be
> implementing this stuff as generic code, not propagating the same
> code through multiple filesystems via copy-n-paste-n-modify. This
> will simply end up with diverging code, different bugs and feature
> sets, and none of the implementations will get the review and
> maintenance they really require...
> 
> And, FWIW, this is the reason why I originally asked for the ext4
> encryption code to be pulled up to the VFS: precisely so we didn't
> end up with a rapid proliferation of individual in-filesystem
> encryption implementations that are all slightly different...

Totally agreed!

AFAIK, Ted wants to push the codes as a crypto library into fs/ finally, so
I believe most part of crypto codes are common.

But, in order to realize that quickly, Ted implemented the feature to finalize
on-disk and in-memory design in EXT4 as a first step.
Then, I've been catching up and validating its design by implementing it in
F2FS, which also intends to figure out what crypto codes can be exactly common.

As Ted mentioned before, since next android version tries to use per-file
encryption, F2FS also needs to support it as quick as possible likewise EXT4.

Meanwhile, surely I've been working on writing patches to push them into fs/;
currenlty, I did for cryto.c and will do for crypto_key.c and crypto_fname.c.
But, it needs to think about crypto_policy.c differently, since it may depend
on how each filesystem stores the policy information respectively; we cannot
push all the filesystems should use xattrs, right?

Anyway, let me take a time to work on this and submit RFC patches.

Thanks,
