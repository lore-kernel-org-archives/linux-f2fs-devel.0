From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: REQ_META and Reliable write in eMMC
Date: Tue, 20 Oct 2015 23:47:13 +0800
Message-ID: <COL402-EAS1804272A1F652DE4AF46CDAB390@phx.gbl>
References: <1f90464d50364f8d8a1be09a672676dc@BOWEX17-E.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZoZ8N-0005Cf-S2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 15:47:31 +0000
Received: from col004-omc1s19.hotmail.com ([65.55.34.29])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZoZ8H-0005hH-S4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Oct 2015 15:47:31 +0000
In-Reply-To: <1f90464d50364f8d8a1be09a672676dc@BOWEX17-E.micron.com>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "'Luca Porzio (lporzio)'" <lporzio@micron.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: alexey.skidanov@sandisk.com, jaegeuk@kernel.org, 'Ulf Hansson' <ulf.hansson@linaro.org>, anton@tuxera.com

Hi,

> -----Original Message-----
> From: Luca Porzio (lporzio) [mailto:lporzio@micron.com]
> Sent: Tuesday, October 20, 2015 4:05 PM
> To: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> Cc: (alexey.skidanov@sandisk.com); jaegeuk@kernel.org; Ulf Hansson (ulf.hansson@linaro.org);
> anton@tuxera.com; (alexey.skidanov@sandisk.com); jaegeuk@kernel.org; Ulf Hansson
> (ulf.hansson@linaro.org); anton@tuxera.com
> Subject: [f2fs-dev] REQ_META and Reliable write in eMMC
> 
> Hi,
> 
> By discussing in the MELS (Mobile & Embedded Linux Storage Forum) we are deciding whether it
> is ok to remove the bonding between REQ_META and "Reliable Write" in eMMC devices.
> We already got a first positive ack from FS developers here
> http://comments.gmane.org/gmane.linux.file-systems/97219
> 
> >This performance impact comes from the existing MMC SW driver solution where each IO request
> marked with
> >REQ_META is handled as a "Reliable Write" operation.
> >Pretty much as a as a FUA write access, a "Reliable write" means that the data will be
written
> to the
> >non-volatile memory.
> >Due to the fact that every REQ_META is immediately bypassing the internal cache of eMMC
device,
> write
> >performance is affected significantly.
> 
> Wanted also to check for side effects on F2FS.
> Please advise how critical is to send REQ_META as "Reliable Write"?

I don't think this kind 'Reliable' optimization should be done in eMMC
for f2fs, since f2fs has already kept the write reliable by using
WRITE_FLUSH | WRITE_FLUSH_FUA.

> Can REQ_META be sent as a regular Write operation?

Yes, I think so.

Thanks,

> 
> Thanks,
>    Luca Porzio
>    Micron
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
