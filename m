From: Chao Yu <chao@kernel.org>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 23:20:47 +0800
Message-ID: <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fvOm1-0001Xx-Ib
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:22:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvOlz-003PGq-Me
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:22:17 +0000
In-Reply-To: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Patrick Doyle <wpdster@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Patrick,

Can you try -i option?

On 2018/8/30 22:44, Patrick Doyle wrote:
> I have run out of space on my 1TB SSD formatted with f2fs, but df
> shows it is only 35% full.
> 
> df -i shows 100% of the inodes are in use.
> 
> What can I do?  I don't see any mkfs.f2fs or mount options for
> increasing the number of inodes.
> 
> --wpd
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
