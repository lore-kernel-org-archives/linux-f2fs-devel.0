From: Luke Dashjr <luke@dashjr.org>
Subject: Re: Corrupt F2FS partition - fsck is useless
Date: Tue, 28 Aug 2018 07:49:27 +0000
Message-ID: <201808280749.28098.luke@dashjr.org>
References: <201808240431.07031.luke@dashjr.org>
 <20180828073735.GD29049@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <luke@dashjr.org>) id 1fuYlH-0001Bm-7j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 07:50:03 +0000
Received: from zinan.dashjr.org ([192.3.11.21])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1fuYlE-000lBe-8Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 07:50:03 +0000
In-Reply-To: <20180828073735.GD29049@jaegeuk-macbookpro.roam.corp.google.com>
Content-Disposition: inline
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Tuesday 28 August 2018 07:37:35 Jaegeuk Kim wrote:
> Are you using dm-crypt under f2fs?

No.

> v3.10 is too much old, and I quit to backport recent patches as well.
> Is there a chance to upgrade the kernel?

The 3.10 was the Android/LineageOS phone that couldn't even boot.
I'm doing all the data recovery attempts on 4.17.11.

Thanks,

Luke

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
