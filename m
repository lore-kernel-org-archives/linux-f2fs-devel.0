From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: have ioctls changed?
Date: Tue, 17 Nov 2015 10:34:15 +0800
Message-ID: <00e801d120e0$8bff42e0$a3fdc8a0$@samsung.com>
References: <20151117013634.GA4104@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZyW6s-0000bZ-QO
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 02:35:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyW6q-0000P3-UD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 02:35:06 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXX01BI0TU6K400@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 11:34:57 +0900 (KST)
In-reply-to: <20151117013634.GA4104@schmorp.de>
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

Hi,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Tuesday, November 17, 2015 9:37 AM
> To: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] have ioctls changed?
> 
> Hi!
> 
> While trying the new f2fs snapshot (3.18 branch from yesterday), I found that
> my GC script does no longer work:
> 
>    ioctl(0, 0xf506, 0x1741810)             = -1 ENOTTY (Inappropriate ioctl for device)
> 
> fd#0 is from open ("/mountpoint",...). I didn't upgrade kernels or
> anything else - the script works with the module I previously used.

We didn't change the main interface (0xf506) of ioctl for GC, but did change
the usage of parameter passed of it.

So, firstly, could you please check whether below commits exist in your
branch:
- c1c1b58359d4 ("f2fs: add new ioctl F2FS_IOC_GARBAGE_COLLECT")
- d530d4d8e237 ("f2fs: support synchronous gc in ioctl")

Then, if it exists, I think it's better to check the real file opened which
fd#0 points to since I'm not sure this file is belong to f2fs.

Thanks,

> 
> So, have the ioctls changed recently, or some detail about them?
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
