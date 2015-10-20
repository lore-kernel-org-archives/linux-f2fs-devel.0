From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: REQ_META and Reliable write in eMMC
Date: Tue, 20 Oct 2015 11:05:30 -0700
Message-ID: <20151020180530.GA32128@jaegeuk-mac02.mot.com>
References: <07e832dc4b824783bd202a9095286156@BOWEX17-E.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZobI4-00072T-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 18:05:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZobI2-0006Fd-Sv for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 18:05:40 +0000
Content-Disposition: inline
In-Reply-To: <07e832dc4b824783bd202a9095286156@BOWEX17-E.micron.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: " (alexey.skidanov@sandisk.com)" <alexey.skidanov@sandisk.com>, "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, "anton@tuxera.com" <anton@tuxera.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Luca,

On Tue, Oct 20, 2015 at 08:32:50AM +0000, Luca Porzio (lporzio) wrote:
> +Alex Lemberg
> 
> > -----Original Message-----
> > From: Luca Porzio (lporzio)
> > Sent: Tuesday, 20 October, 2015 10:05
> > To: linux-f2fs-devel@lists.sourceforge.net
> > Cc: Ulf Hansson (ulf.hansson@linaro.org); (alexey.skidanov@sandisk.com);
> > anton@tuxera.com; jaegeuk@kernel.org
> > Subject: REQ_META and Reliable write in eMMC
> > 
> > Hi,
> > 
> > By discussing in the MELS (Mobile & Embedded Linux Storage Forum) we are
> > deciding whether it is ok to remove the bonding between REQ_META and
> > "Reliable Write" in eMMC devices.
> > We already got a first positive ack from FS developers here
> > http://comments.gmane.org/gmane.linux.file-systems/97219
> > 
> > >This performance impact comes from the existing MMC SW driver solution
> > where each IO request marked with
> > >REQ_META is handled as a "Reliable Write" operation.
> > >Pretty much as a as a FUA write access, a "Reliable write" means that the
> > data will be written to the
> > >non-volatile memory.
> > >Due to the fact that every REQ_META is immediately bypassing the internal
> > cache of eMMC device, write
> > >performance is affected significantly.
> > 
> > Wanted also to check for side effects on F2FS.
> > Please advise how critical is to send REQ_META as "Reliable Write"?

As Chao mentioned, it's non-critical.
F2FS sets REQ_META to give a hint where a bio contains FS metadata blocks to
storage, which is not related to FS consistency.

> > Can REQ_META be sent as a regular Write operation?

Yup.

Thanks,

> > 
> > Thanks,
> >    Luca Porzio
> >    Micron

------------------------------------------------------------------------------
