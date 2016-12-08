From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: add f2fs support
Date: Wed, 7 Dec 2016 22:22:10 -0500
Message-ID: <20161208032210.4n2cxasb3lusep2e@thunk.org>
References: <1479412353-35154-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479412353-35154-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Nov 17, 2016 at 11:52:33AM -0800, Eric Biggers wrote:
> Add basic f2fs support to xfstests-bld.  I am using this to verify that
> the encryption tests I am adding to xfstests pass on both ext4 and f2fs.
> It may be useful to f2fs developers too.  For now, only one
> configuration, "f2fs/default", is offered.
> 
> For the f2fs tests to work, it's required to build a kernel with f2fs
> support and build a rootfs with f2fs-tools installed.  For testing
> encryption, f2fs-tools must be v1.5.0 or later.
> 
> It was necessary to remove the /etc/fstab lines for /dev/vd[b-f] because
> they interfered with non-ext4 fsck.  They are not needed for the tests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
