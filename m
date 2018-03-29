From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] mkfs.f2fs: use 512B as the sector size
 criterion
Date: Wed, 28 Mar 2018 19:11:17 -0700
Message-ID: <20180329021117.GA93109@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
 <20180328090429.35291-1-zhengjunling@huawei.com>
 <CAK6vGd9zBAmYRkVn9PObVvdfX6RfEDc+bmD-gg-+9+SvxsueiQ@mail.gmail.com>
 <c6fc7321-8712-da86-4993-d12b8e167f31@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f1NKG-0002c3-IG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 02:30:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1NKD-0023hN-Uy
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 02:30:04 +0000
Content-Disposition: inline
In-Reply-To: <c6fc7321-8712-da86-4993-d12b8e167f31@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>
Cc: katao@xiaomi.com, Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net

On 03/29, Junling Zheng wrote:
> Hi Jaegeuk,
> 
> On 2018/3/29 4:30, Jaegeuk Kim wrote:
> > Hi Junling,
> > 
> > On Wed, Mar 28, 2018 at 2:04 AM, Junling Zheng <zhengjunling@huawei.com <mailto:zhengjunling@huawei.com>> wrote:
> > 
> >     Use 512 bytes as the sector size criterion while specifying the
> >     amount of sectors passed to mkfs.
> > 
> >     Signed-off-by: Junling Zheng <zhengjunling@huawei.com <mailto:zhengjunling@huawei.com>>
> >     ---
> >      lib/libf2fs.c           | 11 ++++++++---
> >      mkfs/f2fs_format_main.c |  2 +-
> >      2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> >     diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> >     index 5f11796..5fdcdde 100644
> >     --- a/lib/libf2fs.c
> >     +++ b/lib/libf2fs.c
> >     @@ -1002,9 +1002,14 @@ int f2fs_get_device_info(void)
> >                     if (get_device_info(i))
> >                             return -1;
> > 
> >     -       if (c.wanted_total_sectors < c.total_sectors) {
> >     -               MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
> >     -                               c.total_sectors, c.sector_size);
> >     +       if (c.wanted_total_sectors > c.total_sectors)
> >     +               MSG(0, "Warning: total sectors = %"PRIu64", "
> >     +                       "wanted sectors = %"PRIu64", in %u bytes\n",
> >     +                       c.total_sectors, c.wanted_total_sectors, c.sector_size);
> > 
> > 
> > This seems not warning message. IMO, it'd be enough to inform just
> > wanted size over device size?
> 
> This warning will not break mkfs, just a warning to inform user, and mkfs will use c.total_sectors
> to format device :)

"Warning:" is warning. :P

> 
> >  
> > 
> >     +       else {
> >     +               MSG(0, "Info: total sectors = %"PRIu64", "
> >     +                       "wanted sectors = %"PRIu64", in %u bytes\n",
> >     +                       c.total_sectors, c.wanted_total_sectors, c.sector_size);
> >                     c.total_sectors = c.wanted_total_sectors;
> >                     c.devices[0].total_sectors = c.total_sectors;
> >             }
> >     diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> >     index f23fd84..71fd7c2 100644
> >     --- a/mkfs/f2fs_format_main.c
> >     +++ b/mkfs/f2fs_format_main.c
> >     @@ -57,7 +57,7 @@ static void mkfs_usage()
> >             MSG(0, "  -S sparse mode\n");
> >             MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
> >             MSG(0, "  -z # of sections per zone [default:1]\n");
> >     -       MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
> >     +       MSG(0, "sectors: number of sectors (in 512 bytes). [default: determined by device size]\n");
> > 
> > 
> > We also need to specify this in man page.
> 
> OK, I'll add it.
> 
> >  
> > 
> >             exit(1);
> >      }
> > 
> >     --
> >     2.16.2
> > 
> > 
> > 
> > 
> > -- 
> > Jaegeuk Kim
> 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
