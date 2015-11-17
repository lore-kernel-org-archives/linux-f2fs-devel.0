From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: have ioctls changed?
Date: Tue, 17 Nov 2015 04:45:28 +0100
Message-ID: <20151117034527.GA4511@schmorp.de>
References: <20151117013634.GA4104@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZyXD6-0002Lx-Hx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 03:45:36 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyXD4-0006EP-Jx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 03:45:36 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZyXCy-0006wR-B8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 03:45:28 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZyXCy-00022E-6h
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 03:45:28 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZyXCy-0001CE-68
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 04:45:28 +0100
Content-Disposition: inline
In-Reply-To: <20151117013634.GA4104@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Tue, Nov 17, 2015 at 02:36:35AM +0100, Marc Lehmann <schmorp@schmorp.de> wrote:
> While trying the new f2fs snapshot (3.18 branch from yesterday), I found that
> my GC script does no longer work:
> 
>    ioctl(0, 0xf506, 0x1741810)             = -1 ENOTTY (Inappropriate ioctl for device)

Very strange, after much experimenting I deleted my f2fs checkout again
(I did "git pull" before and git log showed the correct changes, also the
ioctls were defined in the header files) and did a fresh checkout, and
that kernel module works.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
