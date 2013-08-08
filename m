From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] f2fs: fix a build failure due to missing the
	kobject header
Date: Thu, 8 Aug 2013 16:15:32 +0900
Message-ID: <CAKYAXd8E+Sc9hPXU7_DwRCLnBDCAtcHR4Woy13gL6km27sWJJA@mail.gmail.com>
References: <1375945532-15766-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1V7KRe-0007Cb-L1
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 07:15:38 +0000
Received: from mail-pa0-f49.google.com ([209.85.220.49])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V7KRd-0000Hp-VU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 07:15:38 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi5so3064091pad.22
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 08 Aug 2013 00:15:32 -0700 (PDT)
In-Reply-To: <1375945532-15766-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

2013/8/8, Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> This patch should resolve the following error reported by kbuild test
> robot.
>
> All error/warnings:
>
>    In file included from fs/f2fs/dir.c:13:0:
>    >> fs/f2fs/f2fs.h:435:17: error: field 's_kobj' has incomplete type
>         struct kobject s_kobj;
>
> The failure was caused by missing the kobject header file in dir.c.
> So, this patch move the header file to the right location, f2fs.h.
>
> CC: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Oops.. Looks good :)
Thanks Jaegeuk!

> ---

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
