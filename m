From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: detect wrong layout
Date: Wed, 7 Dec 2016 14:37:10 -0800
Message-ID: <20161207223710.GA3313@jaegeuk.local>
References: <20161207011625.15591-1-jaegeuk@kernel.org>
 <20161207201650.GA125037@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161207201650.GA125037@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Dec 07, 2016 at 12:16:50PM -0800, Eric Biggers wrote:
> On Tue, Dec 06, 2016 at 05:16:24PM -0800, Jaegeuk Kim wrote:
> > Previous mkfs.f2fs allows small partition inappropriately, so f2fs should detect
> > that as well.
> > 
> > Refer this in f2fs-tools.
> > 
> > mkfs.f2fs: detect small partition by overprovision ratio and # of segments
> > 
> > Reported-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> 
> Hi Jaegeuk, I tested these two patches and they seem to work correctly --- the
> kernel now doesn't allow mounting a 32 MB f2fs filesystem.

Okay, thank you for verifying this.
Let me put Tested-by you. ;)

Thanks,

> 
> Thanks!
> 
> Eric
