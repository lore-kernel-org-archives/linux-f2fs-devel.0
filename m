From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 14:06:27 -0400
Message-ID: <CAF_dkJB=2PAqes+41xAi74Z3X0dSjQzCd9eMwDjpKmLD9PBq6A@mail.gmail.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
 <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
 <CAF_dkJCgEfdSKM2ibkPezKW0dLN7QawwALX6p=-wYz64ZSe0sw@mail.gmail.com>
 <56d656d8-fc19-2919-488a-b7b3e0df9e43@kernel.org>
 <20180830165845.GB3742@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJC5Z=hLdnkMMGHXw=5a49-HdrYoPwmaaEjcbjz3_Li+xA@mail.gmail.com>
 <20180830175621.GA6491@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fvRLS-0004pJ-4v
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 18:07:02 +0000
Received: from mail-oi0-f51.google.com ([209.85.218.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvRLQ-003ytI-Lg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 18:07:02 +0000
Received: by mail-oi0-f51.google.com with SMTP id k81-v6so10934073oib.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Aug 2018 11:07:00 -0700 (PDT)
In-Reply-To: <20180830175621.GA6491@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Aug 30, 2018 at 1:56 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hi,
> I expect "-i" should give more # of inodes, since without it, F2FS relied on
> relatively small (but enough on smaller capacity) checkpoint blocks to provide
> them. With the option, it expands checkpoint space to allow more nids which will
> be used for inodes and file's index blocks. Let us know, if you are in trouble
> with that option.
>
> The mount options would be set by default. If your files are mostly larger than
> 3.5KB, it'd be better to turn inline_data off. If your directories contain huge
> number of childrens, it'd be better to turn inline_dentry off and tune
> sys/fs/dir_level.
OK.  Thanks for the information.  And thank you especially for the
help.  I was dead in the water, and google searches were turning up
nothing useful.  (Plenty of stuff regarding resizing extN file
systems, and lots of stuff regarding the design of f2fs, but not much
on what to do when it breaks.)

I poked around a bit before I deployed this 1TB drive.  It seemed to
me that f2fs is the right approach for file systems on SSDs.  And,
while it is still fairly new, it's not _that_ new.  That's why I was
so baffled when I ran into this problem.  I had no idea if it was an
issue with the new drive, f2fs, or something else going on with my
computer.

Thanks again.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
