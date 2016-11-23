From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix 32-bit build
Date: Wed, 23 Nov 2016 13:18:53 -0800
Message-ID: <20161123211853.GA49619@jaegeuk>
References: <20161122142033.1680054-1-arnd@arndb.de>
 <20161123184226.GB24137@jaegeuk>
 <2253375.qgaJy4NpnU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2253375.qgaJy4NpnU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>, Damien Le Moal <damien.lemoal@wdc.com>, Fan Li <fanofcode.li@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Nov 23, 2016 at 10:05:41PM +0100, Arnd Bergmann wrote:
> On Wednesday, November 23, 2016 10:42:26 AM CET Jaegeuk Kim wrote:
> > 
> > Unfortunately, the sector number is usually a 64-bit number, and
> > we guarantee that bdev_zone_size() returns a power-of-two number.
> 
> The sentence no longer makes sense. Maybe
> 
> Fortunately, bdev_zone_size() is guaranteed to return a power-of-two
> number, so we can replace the % operator with a cheaper bit mask.

Got it.
Added it with modifed version.
Thanks,

> 
> > @@ -693,7 +693,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
> >         }
> >         sector = SECTOR_FROM_BLOCK(blkstart);
> >  
> > -       if (sector % bdev_zone_size(bdev) || nr_sects != bdev_zone_size(bdev)) {
> > +       if (sector & (bdev_zone_size(bdev) - 1) ||
> > 
> 
> looks good, thanks for following up!
> 
> 	Arnd
