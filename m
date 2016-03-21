From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Mon, 21 Mar 2016 11:30:38 +0100
Message-ID: <20160321103032.GA2739@schmorp.de>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ahxLQ-00028X-UD
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 10:45:56 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ahxLP-0007TE-0W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Mar 2016 10:45:56 +0000
Content-Disposition: inline
In-Reply-To: <00d401d18320$75f94e80$61ebeb80$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Mon, Mar 21, 2016 at 11:18:35AM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > As you pointed out, it seems there is a bug in sanity check routine, which
> > doesn't cover the large section case.
> 
> Actually, there is a bug in f2fs-tools 1.6.0, it will trigger sanity check failure
> in f2fs kernel module since in mkfs.f2fs we will align segment_count and
> segment_count_main with different size if parameter -s or -z is configured larger
> than 1.
> 
> Following commit in dev branch of f2fs-tools has fixed this issue, could you test this
> patch firstly?
> ("mkfs.f2fs: set segment_count in super block correctly")

Stupid question from my side, does that mean we have to reformat existing
volumes? Because mkfs clearly won't fix existing volumes, so fixing mkfs
will not fix the issue.

A fix in the f2fs or fsck.f2fs would be needed for existing volumes.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
