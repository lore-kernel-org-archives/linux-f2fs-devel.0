From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: fstrim fails on F2FS device
Date: Sat, 28 Jun 2014 16:36:34 +0800
Message-ID: <004e01cf92ac$2a76e960$7f64bc20$@samsung.com>
References: <53AE641A.8050308@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X0o8S-0000ws-0V
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 08:37:24 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X0o8P-0002Ia-Ui
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 08:37:23 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7V00F22EM2U820@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Jun 2014 17:37:14 +0900 (KST)
In-reply-to: <53AE641A.8050308@westnet.com.au>
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
To: 'Brian Chadwick' <brianchad@westnet.com.au>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Brian,

> -----Original Message-----
> From: Brian Chadwick [mailto:brianchad@westnet.com.au]
> Sent: Saturday, June 28, 2014 2:44 PM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] fstrim fails on F2FS device
> 
> Hi there
> 
> running fstrim on a F2FS partition gives the following output:
> 
> fstrim: /home: discard operation not supported.
> 
> kernel 3.16.0-rc2
> 
> Is this normal?

Now f2fs has not yet supported batch mode discard through ioctl as the way
fstrim used.

Still you could use real-time mode discard by adding a '-o discard' option when
mount, meanwhile /sys/fs/f2fs/<devname>/max_small_discards could be used for
controlling the real-time mode.

Thanks
Yu

> 
> Cheers
> 
> Brian
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
