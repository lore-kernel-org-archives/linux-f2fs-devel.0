From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] f2fs: fix 32-bit build
Date: Wed, 23 Nov 2016 22:05:41 +0100
Message-ID: <2253375.qgaJy4NpnU@wuerfel>
References: <20161122142033.1680054-1-arnd@arndb.de>
	<20161123184226.GB24137@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <arnd@arndb.de>) id 1c9ekD-0003Z5-K0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Nov 2016 21:06:17 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1c9ekC-0001Ky-Ev for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Nov 2016 21:06:17 +0000
In-Reply-To: <20161123184226.GB24137@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wednesday, November 23, 2016 10:42:26 AM CET Jaegeuk Kim wrote:
> 
> Unfortunately, the sector number is usually a 64-bit number, and
> we guarantee that bdev_zone_size() returns a power-of-two number.

The sentence no longer makes sense. Maybe

Fortunately, bdev_zone_size() is guaranteed to return a power-of-two
number, so we can replace the % operator with a cheaper bit mask.

> @@ -693,7 +693,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>         }
>         sector = SECTOR_FROM_BLOCK(blkstart);
>  
> -       if (sector % bdev_zone_size(bdev) || nr_sects != bdev_zone_size(bdev)) {
> +       if (sector & (bdev_zone_size(bdev) - 1) ||
> 

looks good, thanks for following up!

	Arnd

------------------------------------------------------------------------------
