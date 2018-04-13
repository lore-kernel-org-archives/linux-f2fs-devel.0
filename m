From: Amir Goldstein <amir73il@gmail.com>
Subject: Re: Symlink not persisted even after fsync
Date: Fri, 13 Apr 2018 08:52:19 +0300
Message-ID: <CAOQ4uxhK6DQxTdipX2SP2t1960PrRt66+k3FVxQqwTBs-67cQA@mail.gmail.com>
References: <CA+EzBbCbRsZ=2qkBYjGVZQAVmUz34ky8vDOB7HxqRCrgymzysQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <CA+EzBbCbRsZ=2qkBYjGVZQAVmUz34ky8vDOB7HxqRCrgymzysQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Apr 12, 2018 at 8:51 PM, Jayashree Mohan
<jayashree2912@gmail.com> wrote:
> Hi,
>
> We came across what seems to be a crash consistency bug on btrfs and
> f2fs. When we create a symlink for a file and fsync the symlink, on
> recovery from crash, the fsync-ed file is missing.
>
> You can reproduce this behaviour using this minimal workload :
>
> 1. symlink (foo, bar)
> 2. open bar
> 3. fsync bar
> ----crash here----
>
> When we recover, we find that file bar is missing. This behaviour
> seems unexpected as the fsynced file is lost on a crash. ext4 and xfs
> correctly recovers file bar. This seems like a bug. If not, could you
> explain why?
>

Not a bug.

>From man 2 fsync:

"Calling  fsync() does not necessarily ensure that the entry in the
 directory containing the file has also reached disk.  For that an
 explicit fsync() on a file descriptor for the directory is also needed."

There is a reason why this behavior is not being reproduces in
ext4/xfs, but you should be able to reproduce a similar issue
like this:

1. symlink (foo, bar.tmp)
2. open bar.tmp
3. fsync bar.tmp
4. rename(bar.tmp, bar)
5. fsync bar
----crash here----

Thanks,
Amir.
