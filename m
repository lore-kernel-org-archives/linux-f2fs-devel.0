From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 09:58:45 -0700
Message-ID: <20180830165845.GB3742@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
 <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
 <CAF_dkJCgEfdSKM2ibkPezKW0dLN7QawwALX6p=-wYz64ZSe0sw@mail.gmail.com>
 <56d656d8-fc19-2919-488a-b7b3e0df9e43@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fvQHZ-0007E9-3o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 16:58:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvQHX-003TB8-IE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 16:58:57 +0000
Content-Disposition: inline
In-Reply-To: <56d656d8-fc19-2919-488a-b7b3e0df9e43@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: Patrick Doyle <wpdster@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 08/30, Chao Yu wrote:
> On 2018/8/30 23:45, Patrick Doyle wrote:
> > On Thu, Aug 30, 2018 at 11:40 AM Chao Yu <chao@kernel.org> wrote:
> >> Hi Patrick,
> >> On 2018/8/30 23:30, Patrick Doyle wrote:
> >>> On Thu, Aug 30, 2018 at 11:22 AM Chao Yu <chao@kernel.org> wrote:
> >>>>
> >>>> Hi Patrick,
> >>>>
> >>>> Can you try -i option?
> >>
> >> Sorry, I mean mkfs.f2fs -i /dev/xxx;
> > -i isn't an allowable option to mkfs.f2fs:
> > Usage: mkfs.f2fs [options] device [sectors]
> > [options]:
> >   -a heap-based allocation [default:1]
> >   -d debug level [default:0]
> >   -e [extension list] e.g. "mp3,gif,mov"
> >   -l label
> >   -o overprovision ratio [default:5]
> >   -O set feature
> >   -q quiet mode
> >   -s # of segments per section [default:1]
> >   -z # of sections per zone [default:1]
> >   -t 0: nodiscard, 1: discard [default:1]
> 
> Can you upgrade your f2fs tools and kernel to make it getting supported?

Patrick,

Please download the latest f2fs-tools from
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/log/

Chao,

It seems we may need to consider tune.f2fs for this case.
Could you TAL?

Thanks,

> 
> > 
> >>
> >> And you can use stat -f /your_mount_option to see whether largest number of
> >> inode support in new image increased.
> > "stat -f" shows the same information as "df -i".  Both show that I
> > have 9784317 total inodes, and that isn't enough for the builds I am
> 
> That's correct, they are using the same syscall to get the fs statistic info.
> 
> > performing on this partition.  (The free number has gone up a bit as I
> > have deleted results from a previous build).
> > 
> > --wpd
> > 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
