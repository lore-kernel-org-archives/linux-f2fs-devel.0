From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs stability problems keep me from testing
Date: Thu, 19 Nov 2015 03:23:17 +0100
Message-ID: <20151119022317.GA7115@schmorp.de>
References: <20151117172430.GA6945@schmorp.de>
	<004b01d121e8$10563730$3102a590$@samsung.com>
	<20151119003840.GA5692@schmorp.de>
	<008e01d12269$d210c580$76325080$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZzEsg-00088Y-TK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 02:23:26 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzEse-0005p3-T5
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 02:23:26 +0000
Content-Disposition: inline
In-Reply-To: <008e01d12269$d210c580$76325080$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Nov 19, 2015 at 09:29:29AM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> Thanks for info your sharing.
> 
> If fsck shows nothing problem in the disk, still can't see '/cold1/var' in
> directory '/cold1' now?

Ah, sorry if that might not have been clear - after a reboot, fsck showed
no errors and all files and directories (apparently) were there, i.e. it
looks like a transient problem, not a problem of the on-disk structure.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
