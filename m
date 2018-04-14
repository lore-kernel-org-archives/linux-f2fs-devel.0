From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v5] f2fs: introduce a method to make nat
 journal more fresh
Date: Fri, 13 Apr 2018 17:48:00 -0700
Message-ID: <20180414004800.GA35840@jaegeuk-macbookpro.roam.corp.google.com>
References: <1523344306-16493-1-git-send-email-heyunlei@huawei.com>
 <527e85f8-e407-1897-9929-b9a8be53f557@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f79MT-0004XS-Bt
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 00:48:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f79MR-00GQWp-Jh
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 00:48:13 +0000
Content-Disposition: inline
In-Reply-To: <527e85f8-e407-1897-9929-b9a8be53f557@huawei.com>
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
Cc: zhangdianfang@huawei.com, linux-f2fs-devel@lists.sourceforge.net

I removed this patch in my test branch, since it simply gave a kernel panic.
Please test before sending patches.

repro
1. encrypt a dir
2. dd to create 10MB-sized file in the dir

On 04/12, Chao Yu wrote:
> On 2018/4/10 15:11, Yunlei He wrote:
> > This patch introduce a method to make nat journal more fresh:
> > i.  sort set list using dirty entry number and cp version
> >     average value.
> > ii. if meet with cache hit, update average version valus with
> >     current cp version.
> > 
> > With this patch, newly modified nat set will flush to journal,
> > and flush old nat set with same dirty entry number to nat area.
> > 
> > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
