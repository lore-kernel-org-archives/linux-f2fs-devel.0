From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 10:56:22 -0700
Message-ID: <20180830175621.GA6491@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
 <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
 <CAF_dkJCgEfdSKM2ibkPezKW0dLN7QawwALX6p=-wYz64ZSe0sw@mail.gmail.com>
 <56d656d8-fc19-2919-488a-b7b3e0df9e43@kernel.org>
 <20180830165845.GB3742@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJC5Z=hLdnkMMGHXw=5a49-HdrYoPwmaaEjcbjz3_Li+xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fvRBF-000896-Ug
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 17:56:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvRBE-003VP8-F6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 17:56:29 +0000
Content-Disposition: inline
In-Reply-To: <CAF_dkJC5Z=hLdnkMMGHXw=5a49-HdrYoPwmaaEjcbjz3_Li+xA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Patrick Doyle <wpdster@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 08/30, Patrick Doyle wrote:
> On Thu, Aug 30, 2018 at 12:58 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > Patrick,
> >
> > Please download the latest f2fs-tools from
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/log/
> >
> > Chao,
> Jaegeuk,
> Thank you very much.  I just cloned that repository and I see that it
> includes a "-i" option for "extended node bitmap".
> (I have also completed my backup of my f2fs partition and stand ready
> to reformat that partition.)
> 
> Can you give me a sense of what the "extended node bitmap" will do for
> me?  Will that address the lack of inodes?
> 
> Also, (although I will answer this by experimentation very shortly),
> should I expect this to be compatible with my 4.15 kernel?
> 
> Finally, I see that there are mount options for various inline_*
> possibilities, should I be turning those options on to address this
> issue?

I expect "-i" should give more # of inodes, since without it, F2FS relied on
relatively small (but enough on smaller capacity) checkpoint blocks to provide
them. With the option, it expands checkpoint space to allow more nids which will
be used for inodes and file's index blocks. Let us know, if you are in trouble
with that option.

The mount options would be set by default. If your files are mostly larger than
3.5KB, it'd be better to turn inline_data off. If your directories contain huge
number of childrens, it'd be better to turn inline_dentry off and tune
sys/fs/dir_level.

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
