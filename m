From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs stability problems keep me from testing
Date: Thu, 19 Nov 2015 16:04:21 +0800
Message-ID: <00a101d122a0$fb9e6ab0$f2db4010$@samsung.com>
References: <20151117172430.GA6945@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZzKDL-0004xU-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 08:05:07 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzKDK-0004IG-72
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 08:05:07 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NY1034F1YGAXH50@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 17:04:58 +0900 (KST)
In-reply-to: <20151117172430.GA6945@schmorp.de>
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

> 1. ls /cold1, find /cold1 (/cold1 is the f2fs mountpoint) gave empty results
>    here is an strace of find /cold1:
> 
>    openat(AT_FDCWD, "/cold1", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 5
>    fchdir(5)                               = 0
>    getdents(5, /* 0 entries */, 32768)     = 0

I found an issue here.

If the dir entry of '/cold1/var' is removed from dentry page in '/cold1', at
least we should return entries of '.' and '..' for the getdents invoking, but
we didn't. So here it looks like we keep silent about some kind of error (i.e.
ENOMEM/EIO...) when grabing&updating the dentry page of '/cold1', obviously
it's better to report such error to user rather than ignoring it.

I'd like to send a patch to fix this issue, could you include the following
patch in your f2fs module, so when it reproduces we can catch more details
about this problem.

Thanks,


------------------------------------------------------------------------------
