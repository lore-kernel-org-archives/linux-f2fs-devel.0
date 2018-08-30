From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 11:38:17 -0400
Message-ID: <CAF_dkJDQW0_mr5obNcSeQAtuc8mSG+NHq=OgqG6nc-j+OrCo3w@mail.gmail.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fvP23-0001s4-7C
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:38:51 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvP21-003s7G-Mc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:38:51 +0000
Received: by mail-oi0-f52.google.com with SMTP id x197-v6so16219315oix.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Aug 2018 08:38:49 -0700 (PDT)
In-Reply-To: <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
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

On Thu, Aug 30, 2018 at 11:30 AM Patrick Doyle <wpdster@gmail.com> wrote:
\> My f2fs partition is only 33% full, but I can no longer build on it,
> as I keep getting "device out of space" errors.
>
Looking through the man pages (and source code) for mkfs.f2fs, I
wonder if I should try (backing up my partition and) reformatting with
a different value for the "overprovision" ratio.  Do you think that
would help?  Is there a way I can determine what value was used the
first time I formatted the partition?

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
