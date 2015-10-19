From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: Reservation amount
Date: Mon, 19 Oct 2015 18:44:40 +0800
Message-ID: <014701d10a5b$43b78f60$cb26ae20$@samsung.com>
References: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
	<906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zo7we-0006AV-22
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 10:45:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zo7wc-0007W3-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 10:45:36 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NWG0177PR7O5XE0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 19:45:26 +0900 (KST)
In-reply-to: <906568999.1957861.1445144285260.JavaMail.yahoo@mail.yahoo.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Josh Dener [mailto:denerjosh@yahoo.com]
> Sent: Sunday, October 18, 2015 12:58 PM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] Reservation amount
> 
> Hi,
> 
> Where does this formula come from?
> 
> 
> config.reserved_segments =
> 
>     (2 * (100 / config.overprovision + 1) + 6)

I'm interest in this too, could you sharing more detail about policy
of overprovision and reserved space calculation?

Thanks,

> 
> 
> Is there a formal justification for it?
> 
> Thanks.
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
