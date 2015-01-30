From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] mkfs.f2fs: support large sector size
Date: Fri, 30 Jan 2015 20:04:29 +0800
Message-ID: <CAB6yy36s8rSCv11_RMVLc1_MX351DZLvcQyW_sAr35+__z7WQw@mail.gmail.com>
References: <006f01d03c61$5b4be860$11e3b920$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1YHAJU-00014U-7m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jan 2015 12:04:40 +0000
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YHAJS-0004zW-B4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jan 2015 12:04:40 +0000
Received: by mail-wi0-f173.google.com with SMTP id r20so2548817wiv.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 30 Jan 2015 04:04:32 -0800 (PST)
In-Reply-To: <006f01d03c61$5b4be860$11e3b920$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Fri, Jan 30, 2015 at 3:49 PM, Chao Yu <chao2.yu@samsung.com> wrote:
> Since f2fs support large sector size in commit 55cf9cb63f0e "f2fs: support large
> sector size", block device with sector size of 512/1024/2048/4096 bytes can be
> supported.
>
> But mkfs.f2fs still use default sector size: 512 bytes as sector size, let's fix
> this issue in this patch.
>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  lib/libf2fs.c            | 2 +-
>  mkfs/f2fs_format.c       | 6 +++---
>  mkfs/f2fs_format_utils.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 8123528..9b9578b 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -504,7 +504,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
>         MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",

Should using c->sector_size instead 512bytes here ?

>                                         c->total_sectors);
>         if (c->total_sectors <
> -                       (F2FS_MIN_VOLUME_SIZE / DEFAULT_SECTOR_SIZE)) {
> +                       (F2FS_MIN_VOLUME_SIZE / c->sector_size)) {
>                 MSG(0, "Error: Min volume size supported is %d\n",
>                                 F2FS_MIN_VOLUME_SIZE);
>                 return -1;
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index a8d2db6..861fe2f 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -198,10 +198,10 @@ static int f2fs_prepare_super_block(void)
>         set_sb(block_count, config.total_sectors >> log_sectors_per_block);
>
>         zone_align_start_offset =
> -               (config.start_sector * DEFAULT_SECTOR_SIZE +
> +               (config.start_sector * config.sector_size +
>                 2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
>                 zone_size_bytes * zone_size_bytes -
> -               config.start_sector * DEFAULT_SECTOR_SIZE;
> +               config.start_sector * config.sector_size;
>
>         if (config.start_sector % DEFAULT_SECTORS_PER_BLOCK) {

and,
DEFAULT_SECTORS_PER_BLOCK should be instead by config.sectors_per_blk
at the same patch ?

thanks,
Kinglong Mee

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
