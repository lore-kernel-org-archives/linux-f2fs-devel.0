From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH] fsck.f2fs: fix to set
 CP_LARGE_NAT_BITMAP_FLAG
Date: Thu, 18 Apr 2019 22:14:09 +0900
Message-ID: <CAD14+f3ij7YA2BceZB23jHp=8qGCYTB5znBUJgPvYed7N7AXRg@mail.gmail.com>
References: <20190418074909.11102-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hH6s0-0002RN-2c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 13:14:28 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hH6ry-00ERF6-8A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 13:14:28 +0000
Received: by mail-qk1-f194.google.com with SMTP id c20so1087530qkc.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Apr 2019 06:14:25 -0700 (PDT)
In-Reply-To: <20190418074909.11102-1-yuchao0@huawei.com>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

The output appears to be similar to the one without this patch,
however, it now actually mounts.

[ 2360.127787] F2FS-fs (loop1): Found nat_bits in checkpoint
[ 2360.189038] F2FS-fs (loop1): orphan cleanup on readonly fs
[ 2360.189284] F2FS-fs (loop1): recover fsync data on readonly fs
[ 2360.189297] F2FS-fs (loop1): Mounted with checkpoint version = 761bfa29

Go to here to look at the new fsck output:
http://arter97.com/f2fs/log_2.txt.xz
(previous one is now log_1.txt.xz)

However, something weird goes on.
Without even touching the image after first fsck run, the consecutive
2nd run prints out A LOT of messages:
http://arter97.com/f2fs/log_3.txt.xz

The image seems to mount normally after on both the 1st and the 2nd fsck run.

Thanks.

On Thu, Apr 18, 2019 at 4:49 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> During fixing checkpoint, if large_nat_bitmap feature is on, we need to
> set CP_LARGE_NAT_BITMAP_FLAG flag in checkpoint.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/fsck.c  | 2 ++
>  fsck/mount.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index a17555c..88ed4d7 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2038,6 +2038,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>                 flags |= CP_TRIMMED_FLAG;
>         if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
>                 flags |= CP_DISABLED_FLAG;
> +       if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
> +               flags |= CP_LARGE_NAT_BITMAP_FLAG;
>
>         if (flags & CP_UMOUNT_FLAG)
>                 cp_blocks = 8;
> diff --git a/fsck/mount.c b/fsck/mount.c
> index aa64e93..20ecf07 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -2365,6 +2365,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>                 flags |= CP_TRIMMED_FLAG;
>         if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
>                 flags |= CP_DISABLED_FLAG;
> +       if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
> +               flags |= CP_LARGE_NAT_BITMAP_FLAG;
>
>         set_cp(free_segment_count, get_free_segments(sbi));
>         set_cp(valid_block_count, sbi->total_valid_block_count);
> --
> 2.18.0.rc1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
