From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] mkfs.f2fs: support large sector size
Date: Wed, 4 Feb 2015 21:43:15 +0800
Message-ID: <CAB6yy350KAfLDD_nP2nYq=2pC2UtTGaq2gihfY-__ALePetd3g@mail.gmail.com>
References: <000501d0402b$05d34e50$1179eaf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000501d0402b$05d34e50$1179eaf0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Wed, Feb 4, 2015 at 11:30 AM, Chao Yu <chao2.yu@samsung.com> wrote:
> Since f2fs support large sector size in commit 55cf9cb63f0e "f2fs: support large
> sector size", block device with sector size of 512/1024/2048/4096 bytes can be
> supported.
>
> But mkfs.f2fs still use default sector size: 512 bytes as sector size, let's fix
> this issue in this patch.
>
> v2:
>  o remove unneeded printed message when sector size is large than 512 bytes
>    suggested by Kinglong.
>  o show correct sector size in printed message.
>  o use config.sectors_per_blk instead of DEFAULT_SECTORS_PER_BLOCK suggested by
>    Kinglong.
>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  lib/libf2fs.c            | 10 +++-------
>  mkfs/f2fs_format.c       | 12 ++++++------
>  mkfs/f2fs_format_utils.c |  2 +-
>  3 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 8123528..d2942f0 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -463,10 +463,6 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>                         MSG(0, "\tError: Using the default sector size\n");
>                 } else {
>                         if (c->sector_size < sector_size) {
> -                               MSG(0, "\tError: Cannot set the sector size to:"
> -                                       " %d as the device does not support"
> -                                       "\nSetting the sector size to : %d\n",
> -                                       c->sector_size, sector_size);
>                                 c->sector_size = sector_size;
>                                 c->sectors_per_blk = PAGE_SIZE / sector_size;
>                         }
> @@ -495,8 +491,8 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>                 return -1;
>         }
>         if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
> -               MSG(0, "Info: total device sectors = %"PRIu64" (in 512bytes)\n",
> -                                       c->total_sectors);
> +               MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
> +                                       c->total_sectors, c->sector_size);
>                 c->total_sectors = wanted_total_sectors;
>
>         }
> @@ -504,7 +500,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>         MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",

This "512bytes" should be modified as above too.

thanks,
Kinglong Mee
