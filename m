From: Dave Chinner <david@fromorbit.com>
Subject: Re: Symlink not persisted even after fsync
Date: Sat, 14 Apr 2018 00:06:40 +1000
Message-ID: <20180413140640.GE5572@dastard>
References: <CA+EzBbCbRsZ=2qkBYjGVZQAVmUz34ky8vDOB7HxqRCrgymzysQ@mail.gmail.com>
 <CAOQ4uxhK6DQxTdipX2SP2t1960PrRt66+k3FVxQqwTBs-67cQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-btrfs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhK6DQxTdipX2SP2t1960PrRt66+k3FVxQqwTBs-67cQA@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Apr 13, 2018 at 08:52:19AM +0300, Amir Goldstein wrote:
> On Thu, Apr 12, 2018 at 8:51 PM, Jayashree Mohan
> <jayashree2912@gmail.com> wrote:
> > Hi,
> >
> > We came across what seems to be a crash consistency bug on btrfs and
> > f2fs. When we create a symlink for a file and fsync the symlink, on
> > recovery from crash, the fsync-ed file is missing.
> >
> > You can reproduce this behaviour using this minimal workload :
> >
> > 1. symlink (foo, bar)
> > 2. open bar
> > 3. fsync bar
> > ----crash here----
> >
> > When we recover, we find that file bar is missing. This behaviour
> > seems unexpected as the fsynced file is lost on a crash. ext4 and xfs
> > correctly recovers file bar. This seems like a bug. If not, could you
> > explain why?
> >
> 
> Not a bug.

Actually, for a filesystem with strictly ordered metadata recovery
semantics, it is a bug.

> From man 2 fsync:
> 
> "Calling  fsync() does not necessarily ensure that the entry in the
>  directory containing the file has also reached disk.  For that an
>  explicit fsync() on a file descriptor for the directory is also needed."

We've been through this before, many times. This caveat does not
apply to strictly ordered metadata filesystems. If you fsync a file
on an ordered metadata filesystem, then all previous transactions
that are needed to reference the file are also committed.

The behaviour from ext4 and XFS is correct for strictly ordered
filesystems.  This is not a "fsync requirement", nor is it a general
linux filesystem requirement. It is a requirement of the desired
filesystem crash recovery mechanisms....

BTRFS is advertised as having strictly ordered metadata
recovery semantics, so it should behave the same way as ext4 and
XFS in tests like these. If it doesn't, then there's filesystem bugs
that need fixing...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
