From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: blog article about f2fs on smr drives
Date: Mon, 16 Nov 2015 12:31:06 +0800
Message-ID: <008401d12027$b15cd700$14168500$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZyBSK-0003mv-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 04:31:52 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyBSI-0002eZ-1p
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 04:31:52 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXW00AJ64KU7Z40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 13:31:42 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hi Marc,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Sunday, November 15, 2015 3:22 AM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] blog article about f2fs on smr drives
> 
> So sorry again for me regular going into hiding, but I am now back on the SMR
> drive problems :)
> 
> So, first, a question - how many of the changes are now in 4.3 (and
> unfortunately, it seems 4.3 is still not stable with these drives, still
> leaving only 3.18 as an full option).

I think you could get the change information in below link:

http://sourceforge.net/p/linux-f2fs/mailman/message/34427519/

> 
> Next, I am trying to replicate my tests with faster data, and I get rather
> erratic results, e.g. (tar|buffer|tar, average file size 266MB, the source
> volume is capable of delivering sustained 200MB/s, so no bottleneck on the
> read side):
> 
>    summary: 2380.2 GB in 15 h 58 min 30.0 sec - average of 42.4 MB/s
> 
> While there are stretches at >>100MB/s, most of the time, this is at less,
> and often for long stretches at ~10MB/s, which is the reason the end
> result is (relatively) bad.

Could you please share us IO trace log?

> 
> And lastly, is there a document describing the implementation of
> encryption in the fs, and the goals (privacy? integrity? both?)

The feature was ported from ext4, please refer following article:

https://lwn.net/Articles/639427/

> 
> (If there isn't, I plan to review the encryption design in f2fs myself).
> 
> On Thu, Oct 08, 2015 at 05:45:11PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > Cool and pretty much interesting topic to me!
> >
> > BTW, it might be best to publish this kind of investigation as papers or
> > presentation later.
> 
> Maybe, I wonder how one would go about that (I never was involved with a
> serious paper, I will unlikely give presentations on that, but yes, I think
> somebody should :).
> 
> On Mon, Oct 19, 2015 at 06:43:36PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > I have tracked your IO trace log, I found an issue which may slow down our
> > App, so I wrote the patch to optimize the flow mainly for SMR drive.
> > I think we can tune up with /sys/fs/f2fs/(device)/ra_nid_pages to avoid long
> > latency of creating node in f2fs.
> 
> Maybe that could help with my problem - a git pull of the 3.18 branch seems
> to have your changes in it - anything in specific that I should do?

As I checked, related patches were merged into linux-3.18 branch in Jaegeuk's
git tree. It's OK to use that tree.

> 
> from the Changes, it doesn't quite sound as if it will be a big help, as
> there is very little read traffic overall, but I didn't analyze the IO
> trace :)

Actually, as I test in flash device, it does help to improve performance in
workload of creating nodes aggressively, this is because we add asynchronous
readahead to mitigate small synchronous random read which may block all APPs
sometime. Considering rotational device has worse random synchronous read
performance, I expect better result in SMR.

> 
> it does sound like something that could be very useful for rotational disks
> in general, under normal conditions (reading), though.

I hope it will be useful in workload of nodes allocation storm rather than
in condition of read.

> 
> > If you want to have a test with the new tunable parameter, last git tree is
> > preferred. :)
> 
> Sure, will be happy to do that, what should I tune how? And thanks for
> working on this!

IMO, one way is to do the test with default value and then do geometrically
increasing with the value to see how it affects the IO.

Thanks,

> 
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
