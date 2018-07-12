From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix defined but not used build warnings
Date: Wed, 11 Jul 2018 21:15:05 -0700
Message-ID: <20180712041505.GA719@jaegeuk-macbookpro.roam.corp.google.com>
References: <4463b606-3373-2e51-ad8c-3303b1ccc587@infradead.org>
 <b6f9275a-854a-d9e3-271b-b2671acd6041@huawei.com>
 <14890abc-8ba5-5029-8043-6e27fd4c2b37@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fdT0e-0003yN-C5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 04:15:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdT0c-001J03-GN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 04:15:16 +0000
Content-Disposition: inline
In-Reply-To: <14890abc-8ba5-5029-8043-6e27fd4c2b37@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 07/11, Randy Dunlap wrote:
> On 07/09/2018 06:09 PM, Chao Yu wrote:
> > On 2018/7/7 11:50, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build warnings in f2fs when CONFIG_PROC_FS is not enabled
> >> by marking the unused functions as __maybe_unused.
> >>
> >> ../fs/f2fs/sysfs.c:519:12: warning: 'segment_info_seq_show' defined but not used [-Wunused-function]
> >> ../fs/f2fs/sysfs.c:546:12: warning: 'segment_bits_seq_show' defined but not used [-Wunused-function]
> >> ../fs/f2fs/sysfs.c:570:12: warning: 'iostat_info_seq_show' defined but not used [-Wunused-function]
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> >> Cc: Chao Yu <yuchao0@huawei.com>
> >> Cc: linux-f2fs-devel@lists.sourceforge.net
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Hi,
> Who would you like to merge this patch?  or could you do so?

Hi Randy,

I'll merge it in -next for Linus.

Thanks,

> 
> thanks,
> -- 
> ~Randy

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
