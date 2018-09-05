From: Chao Yu <chao@kernel.org>
Subject: Re: Out of inodes on my f2fs partition
Date: Wed, 5 Sep 2018 23:49:20 +0800
Message-ID: <7e01fdd5-f39e-793b-97d7-72b93f567579@kernel.org>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
 <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
 <CAF_dkJCgEfdSKM2ibkPezKW0dLN7QawwALX6p=-wYz64ZSe0sw@mail.gmail.com>
 <56d656d8-fc19-2919-488a-b7b3e0df9e43@kernel.org>
 <20180830165845.GB3742@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fxa3k-0002fF-Dg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 15:49:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxa3h-001v8J-Lt
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 15:49:35 +0000
In-Reply-To: <20180830165845.GB3742@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Patrick Doyle <wpdster@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Jaegeuk,

I missed to reply this thread.

On 2018/8/31 0:58, Jaegeuk Kim wrote:
> Chao,
> 
> It seems we may need to consider tune.f2fs for this case.

It may need to expand NAT size, which needs a extra resize operation, or we just
need to consider non-expanding case?

> Could you TAL?
What does TAL mean... I didn't find out the meaning even though via google.

Thanks,

> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
