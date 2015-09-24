From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Thu, 24 Sep 2015 10:51:31 -0700
Message-ID: <20150924175131.GC40291@jaegeuk-mac02>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923212931.GC36564@jaegeuk-mac02.mot.com>
	<20150923232414.GC3463@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfAgI-0002ZH-4S
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 17:51:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfAgG-0001f6-61 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 17:51:42 +0000
Content-Disposition: inline
In-Reply-To: <20150923232414.GC3463@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Sep 24, 2015 at 01:24:14AM +0200, Marc Lehmann wrote:
> On Wed, Sep 23, 2015 at 02:29:31PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > Can you elaborate? I do get a speed improvement with only two logs, but of
> > > course, GC time is an impoprtant factor, so maybe more logs would be a
> > > necessary trade-off.
> > 
> > This will help you to understand more precisely.
> 
> Thanks, will read more thoroughly, but that means I probably do want two logs.
> Regarding your elaboration:
> 
> > One GC needs to move whole valid blocks inside a section, so if the section
> > size is too large, every GC is likely to show very long latency.
> > In addion, we need more overprovision space too.
> 
> That wouldn't increase the overhead in general though, because the
> overhead depends on how much space is free in each section.

Surely, it depends on workloads.

> 
> > And, if the number of logs is small, GC can suffer from moving hot and cold
> > data blocks which represents somewhat temporal locality.
> 
> I am somewhat skeptical of this for (on of my) my usage(s) (archival),
> because there is absolutely no way to know in advance what is hot and what
> is cold. Example: a file might be deleted, but there is no way in advance
> to know which it will be. The only thing I know is that files never get
> modified after written once (but often replaced). In another of of my
> usages, files do get modified, but there is no way to know in advance
> which it will be, and they will only ever be modified once (after initial
> allocation).
> 
> So I am very suspicious of both static and dynamic attempts to seperate
> data into hot/cold. You can't know from file extensions, and you can't
> know from past modification history.

Yes, regarding to userdata, we cannot determine the hotness of every data
actually.

> The only applicability of hot/cold I can see is filesystem metadata and
> directories (files get moved/renamed/added), and afaics, f2fs already does
> that.

It does all the time. But, what I'm curious is the effect of splitting
directories and files explicitly. If we use two logs, f2fs only splits metadata
and their data.
But, if we use 4 logs at least, it splits each of metadata and data according to
their origins, directory or user file.

For example, if I can represent blocks like:

 D : dentry block
 U : user block
 I : directory inode
 F : file inode,
 O : obsolete

1) in 2 logs, each section can consist of
  DDUUUUUDDUUUUU     IFFFFIFFFFFF

2) in 4 logs,
   DDDD     UUUUUUUUUUU     II        FFFFFFFFFF

Then, if we rename files or delete files,
1) in 2 logs,
  OOUUUUUODUUUUDD    IOOOOIFFOOFI

2) in 4 logs,
  OOODDD      OOOOOUUUOUUU      OOIII      OOOOFFOOFFFF

So, I expect, we can reduce the number of valid blocks if we use 4 logs.

Surely, if workloads produce mostly a huge number of data blocks, I think two
logs are enough. Using more logs would not show a big impact.

Thanks,

> 
> > Of course, these numbers highly depend on storage speed and workloads, so
> > it needs to be tuned up.
> 
> From your original comment, I assumed that the gc somehow needs more logs
> to be more efficient for some internal reason, but it seems since it is
> mostly a matter of section size (which I want to have "unreasonably" large),
> which means potentially a lot of valid data has to be moved, and hot/cold
> data, which I am very skeptical about.
> 
> (I think hot/cold works absolutely splendid for normal desktop uses and
> most forms of /home, though).
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
