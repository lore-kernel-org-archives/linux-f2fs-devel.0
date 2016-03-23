From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Wed, 23 Mar 2016 22:00:10 +0100
Message-ID: <20160323205204.GB4443@schmorp.de>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<56F06067.2060404@davizone.at> <56F07C02.2020106@matthiasprager.de>
	<20160322203613.GA14498@jaegeuk.gateway>
	<56F29214.9040001@davizone.at> <56F2C755.5060402@matthiasprager.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1aipt9-00055N-7i
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 21:00:23 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aipt7-0003SV-F0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 21:00:23 +0000
Content-Disposition: inline
In-Reply-To: <56F2C755.5060402@matthiasprager.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Matthias Prager <linux@matthiasprager.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, David Gnedt <david.gnedt@davizone.at>, linux-f2fs-devel@lists.sourceforge.net

On Wed, Mar 23, 2016 at 05:41:57PM +0100, Matthias Prager <linux@matthiasprager.de> wrote:
> detail. Writing on a read-only fs is a no go! There usually is a reason
> why someone mounts an filesystem read-only and f2fs should not simply
> ignore such a flag.

Hmm, no.

Even an unusual case is enough, such as mounting it read-only for data
recovery because the underlying device dies on writes (quite likely for
ssds, the primary target for f2fs).

However, other linux filesystems either replay their journal on readonly
mounts, or even *require* a replay (most have a flag to prevent that,
but that might not help data recovery). In fact, my example above can
relatively easily worked around using device mapper and a temporary
snapshot volume for writes.

So, the "ro" mount flag in linux does not mean "do not write to the
backing store", and did not have that meaning for a long time, so it's
fine for f2fs to write even for ro mounts.

That means the correct behaviour for f2fs is to write unless "norecovery"
has been specified, which already exists for this purpose on f2fs.

Different behaviour would put f2fs at odds with other existing
filesystems, which write on "ro" mounts to gain integrity.

Even better would be if there was a "force" or similar option which would
allow me to mount filesystems with possibly bad superblock data. This
could even be rolled into the existing "norecovery" switch, which, when
given, could try to mount even if the superblock has (some amount of) bad
data.

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
