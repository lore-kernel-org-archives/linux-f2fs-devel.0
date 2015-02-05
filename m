From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] mkfs.f2fs: support large sector size
Date: Thu, 05 Feb 2015 17:32:11 +0800
Message-ID: <006101d04126$c83e1960$58ba4c20$@samsung.com>
References: <000501d0402b$05d34e50$1179eaf0$@samsung.com>
	<CAB6yy350KAfLDD_nP2nYq=2pC2UtTGaq2gihfY-__ALePetd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YJIos-0007Jd-LW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 09:33:54 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YJIoq-00051x-MP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 09:33:54 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NJA006VOL7RIS20@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 18:33:27 +0900 (KST)
In-reply-to: <CAB6yy350KAfLDD_nP2nYq=2pC2UtTGaq2gihfY-__ALePetd3g@mail.gmail.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Kinglong Mee' <kinglongmee@gmail.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Kinglong,

> -----Original Message-----
> From: Kinglong Mee [mailto:kinglongmee@gmail.com]
> Sent: Wednesday, February 04, 2015 9:43 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; Changman Lee; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/2] mkfs.f2fs: support large sector size
> 
> Hi Chao,
> 
> On Wed, Feb 4, 2015 at 11:30 AM, Chao Yu <chao2.yu@samsung.com> wrote:
> > Since f2fs support large sector size in commit 55cf9cb63f0e "f2fs: support large
> > sector size", block device with sector size of 512/1024/2048/4096 bytes can be
> > supported.
> >
> > But mkfs.f2fs still use default sector size: 512 bytes as sector size, let's fix
> > this issue in this patch.
> >
> > v2:
> >  o remove unneeded printed message when sector size is large than 512 bytes
> >    suggested by Kinglong.
> >  o show correct sector size in printed message.
> >  o use config.sectors_per_blk instead of DEFAULT_SECTORS_PER_BLOCK suggested by
> >    Kinglong.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  lib/libf2fs.c            | 10 +++-------
> >  mkfs/f2fs_format.c       | 12 ++++++------
> >  mkfs/f2fs_format_utils.c |  2 +-
> >  3 files changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> > index 8123528..d2942f0 100644
> > --- a/lib/libf2fs.c
> > +++ b/lib/libf2fs.c
> > @@ -463,10 +463,6 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
> >                         MSG(0, "\tError: Using the default sector size\n");
> >                 } else {
> >                         if (c->sector_size < sector_size) {
> > -                               MSG(0, "\tError: Cannot set the sector size to:"
> > -                                       " %d as the device does not support"
> > -                                       "\nSetting the sector size to : %d\n",
> > -                                       c->sector_size, sector_size);
> >                                 c->sector_size = sector_size;
> >                                 c->sectors_per_blk = PAGE_SIZE / sector_size;
> >                         }
> > @@ -495,8 +491,8 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
> >                 return -1;
> >         }
> >         if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
> > -               MSG(0, "Info: total device sectors = %"PRIu64" (in 512bytes)\n",
> > -                                       c->total_sectors);
> > +               MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
> > +                                       c->total_sectors, c->sector_size);
> >                 c->total_sectors = wanted_total_sectors;
> >
> >         }
> > @@ -504,7 +500,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
> >         MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",
> 
> This "512bytes" should be modified as above too.

Oh my miss, sorry about this. I will resend the patch.

thanks,
Yu
> 
> thanks,
> Kinglong Mee


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
