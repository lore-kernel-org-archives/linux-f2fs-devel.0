From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 11:30:47 -0400
Message-ID: <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fvOuo-0005wI-2K
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:31:22 +0000
Received: from mail-oi0-f48.google.com ([209.85.218.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvOum-003rnc-Io
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:31:22 +0000
Received: by mail-oi0-f48.google.com with SMTP id c190-v6so16149408oig.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Aug 2018 08:31:20 -0700 (PDT)
In-Reply-To: <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Aug 30, 2018 at 11:22 AM Chao Yu <chao@kernel.org> wrote:
>
> Hi Patrick,
>
> Can you try -i option?
>
Hello Chao,
Thank you for your reply.  For which command should I try the -i
option?  I presume you mean df:

$ df -i /home/wpd/src/
Filesystem      Inodes   IUsed  IFree IUse% Mounted on
/dev/nvme0n1   9784317 9410039 374278   97% /home/wpd/src

And, for reference:
$ df /home/wpd/src
Filesystem      1K-blocks      Used Available Use% Mounted on
/dev/nvme0n1   1000202584 324990344 671159248  33% /home/wpd/src

My f2fs partition is only 33% full, but I can no longer build on it,
as I keep getting "device out of space" errors.

I don't see any mechanism to tune (dynamically) or fix (at mkfs.f2fs
time) the number of inodes.  I am desperately looking for a clue now
:-)

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
