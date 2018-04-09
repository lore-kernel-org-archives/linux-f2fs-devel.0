From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: introduce new option V to show
 version
Date: Mon, 9 Apr 2018 10:55:03 -0700
Message-ID: <20180409175503.GA17558@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180408021506.26500-1-shengyong1@huawei.com>
 <44a38d89-a101-6dae-9cf8-0d5eba7ed51e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f5b0Z-0003cB-WA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 17:55:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5b0Y-00CqY5-DN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 17:55:11 +0000
Content-Disposition: inline
In-Reply-To: <44a38d89-a101-6dae-9cf8-0d5eba7ed51e@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: ebiggers@google.com, linux-f2fs-devel@lists.sourceforge.net

On 04/08, Chao Yu wrote:
> On 2018/4/8 10:15, Sheng Yong wrote:
> > This patch introduces a new option -V to show the version of mkfs.f2fs
> > and exit after that.
> 
> BTW, should we add -V for other misc tools?

Yes, could you please add this for others?

> 
> > 
> > Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
