From: Jayashree Mohan <jayashree2912@gmail.com>
Subject: Symlink not persisted even after fsync
Date: Thu, 12 Apr 2018 12:51:55 -0500
Message-ID: <CA+EzBbCbRsZ=2qkBYjGVZQAVmUz34ky8vDOB7HxqRCrgymzysQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-btrfs-owner@vger.kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
To: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

We came across what seems to be a crash consistency bug on btrfs and
f2fs. When we create a symlink for a file and fsync the symlink, on
recovery from crash, the fsync-ed file is missing.

You can reproduce this behaviour using this minimal workload :

1. symlink (foo, bar)
2. open bar
3. fsync bar
----crash here----

When we recover, we find that file bar is missing. This behaviour
seems unexpected as the fsynced file is lost on a crash. ext4 and xfs
correctly recovers file bar. This seems like a bug. If not, could you
explain why?

Do let me know if I am missing some detail here.

Thanks,
Jayashree Mohan
