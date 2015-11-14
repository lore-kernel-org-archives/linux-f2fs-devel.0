From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: blog article about f2fs on smr drives
Date: Sat, 14 Nov 2015 20:21:38 +0100
Message-ID: <20151114192138.GA1553@schmorp.de>
References: <014601d10a5b$173a6660$45af3320$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZxgOR-0006u7-Ni
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 19:21:47 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZxgOP-0002ts-OQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 19:21:47 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZxgOI-0007mb-Ul
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 19:21:39 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZxgOI-0005nT-Qg
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 19:21:38 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZxgOI-0000It-PY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Nov 2015 20:21:38 +0100
Content-Disposition: inline
In-Reply-To: <014601d10a5b$173a6660$45af3320$@samsung.com>
	<20151009004511.GB36104@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

So sorry again for me regular going into hiding, but I am now back on the SMR
drive problems :)

So, first, a question - how many of the changes are now in 4.3 (and
unfortunately, it seems 4.3 is still not stable with these drives, still
leaving only 3.18 as an full option).

Next, I am trying to replicate my tests with faster data, and I get rather
erratic results, e.g. (tar|buffer|tar, average file size 266MB, the source
volume is capable of delivering sustained 200MB/s, so no bottleneck on the
read side):

   summary: 2380.2 GB in 15 h 58 min 30.0 sec - average of 42.4 MB/s

While there are stretches at >>100MB/s, most of the time, this is at less,
and often for long stretches at ~10MB/s, which is the reason the end
result is (relatively) bad.

And lastly, is there a document describing the implementation of
encryption in the fs, and the goals (privacy? integrity? both?)

(If there isn't, I plan to review the encryption design in f2fs myself).

On Thu, Oct 08, 2015 at 05:45:11PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Cool and pretty much interesting topic to me!
> 
> BTW, it might be best to publish this kind of investigation as papers or
> presentation later.

Maybe, I wonder how one would go about that (I never was involved with a
serious paper, I will unlikely give presentations on that, but yes, I think
somebody should :).

On Mon, Oct 19, 2015 at 06:43:36PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> I have tracked your IO trace log, I found an issue which may slow down our
> App, so I wrote the patch to optimize the flow mainly for SMR drive.
> I think we can tune up with /sys/fs/f2fs/(device)/ra_nid_pages to avoid long
> latency of creating node in f2fs.

Maybe that could help with my problem - a git pull of the 3.18 branch seems
to have your changes in it - anything in specific that I should do?

from the Changes, it doesn't quite sound as if it will be a big help, as
there is very little read traffic overall, but I didn't analyze the IO
trace :)

it does sound like something that could be very useful for rotational disks
in general, under normal conditions (reading), though.

> If you want to have a test with the new tunable parameter, last git tree is
> preferred. :)

Sure, will be happy to do that, what should I tune how? And thanks for
working on this!

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
