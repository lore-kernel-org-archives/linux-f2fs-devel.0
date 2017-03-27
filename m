From: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: Re: f2fs not mountable: CRC validation failed
Date: Mon, 27 Mar 2017 19:37:22 +0200
Message-ID: <20170327173722.GA4954@lazy.lzy>
References: <20170326201203.GA9286@lazy.lzy>
	<20170326234537.GA33346@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <piergiorgio.sartor@nexgo.de>) id 1csYaI-0002w5-NX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 17:37:38 +0000
Received: from vsmx009.vodafonemail.xion.oxcs.net ([153.92.174.87])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1csYaG-00036U-TP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 17:37:38 +0000
Content-Disposition: inline
In-Reply-To: <20170326234537.GA33346@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>, linux-f2fs-devel@lists.sourceforge.net

Hi,

thanks for the answer.

On Sun, Mar 26, 2017 at 04:45:37PM -0700, Jaegeuk Kim wrote:
> Hello,
> 
> On 03/26, Piergiorgio Sartor wrote:
> > Hi all,
> > 
> > I apologize in advance in case this is the
> > wrong place for support (if so, please
> > point me in the right direction).
> > 
> > I've an USB stick formatted with f2fs,
> > used under Linux on a RPi2.
> > To be clear, it is a USB device, not
> > an SD card.
> > 
> > After a crash, the USB stick is not mountable
> > any more.
> > There is no HW error on the stick.
> > 
> > A "fsck" returns, among other information:
> > 
> > [f2fs_crc_valid: 486] CRC validation failed: cal_crc = 3543933224, blk_crc = 719768680 buff_size = 0xffc
> > [f2fs_crc_valid: 486] CRC validation failed: cal_crc = 1071250051, blk_crc = 2385854943 buff_size = 0xffc
> > [f2fs_do_mount:2018] Can't find valid checkpoint
> 
> Wow, this means all the checkpoint blocks were corrupted by USB stick, since we
> always guarantee one of them should be valid, which can be used as trusted root
> index. I'm in doubt whether or not USB stick supports cache_flush reliably tho.

Well, it was quite an hard crash, the Rpi2 was
not reachable via ssh and it was lost by the
DNS server (not any more resolvable).
It seems to me it is possible the crash was
so severe to damage the fs indepedently from
the USB stick capabilities...
BTW, it is plenty of reports of SD card damaged
by crash of RPi2.

> If you have a chance, now f2fs supports multiple devices, so you'd better use
> two paritions: one is very small local storage and the other is an USB stick, so
> that local storage keeps superblock and checkpoint more reliably.

Which kernel version support this?
Furthermore, the "small local storage" would be,
in this case, the SD card, which does not seem
to me reliable (if this is required).

> > And it does not perform any check / repair.
> > 
> > I'm a bit puzzled, I wonder if there is way
> > to force a repair, partially could be OK too.
> > 
> > Clearly, "fsck.f2fs -f" did not work.
> > 
> > Any chance to save some data?
> 
> Hmm, fsck.f2fs always starts from valid checkpoint and superblock, so you can't.
> In order to retrieve some data, it needs to scan whole image to get inodes, but
> it looks like another tool that we need to implement.

OK, well, when it will be ready... :-)

In any case, it would be good to have such a
tool, if the fs can be recovered by it.

I think my only option, right now, is to
re-install the system.

> Thanks,

Thank you,

bye,

pg

> > 
> > f2fs-tools is version 1.8.0 (I guess it's latest).
> > 
> > System is Fedora 25, the tool is self compiled.
> > 
> > Thanks a lot in advance, in case other information
> > are required, please let me know.
> > 
> > bye,
> > 
> > -- 
> > 
> > piergiorgio
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 

piergiorgio

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
