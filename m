From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: relocate chksum_offset for
 large_nat_bitmap feature
Date: Wed, 24 Apr 2019 20:43:29 +0900
Message-ID: <CAD14+f0D9CVmBZGmbMcKB7xAHvBrbGAgVxR4W8Fiu0Vo6czDYQ@mail.gmail.com>
References: <20190422093353.61014-1-yuchao0@huawei.com> <20190422093353.61014-2-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422093353.61014-2-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Mon, Apr 22, 2019 at 6:34 PM Chao Yu <yuchao0@huawei.com> wrote:
> +       if (__is_set_ckpt_flags(*cp_block, CP_LARGE_NAT_BITMAP_FLAG)) {
> +               if (crc_offset != CP_MIN_CHKSUM_OFFSET) {
> +                       f2fs_put_page(*cp_page, 1);
> +                       f2fs_msg(sbi->sb, KERN_WARNING,
> +                               "layout of large_nat_bitmap is deprecated, "
> +                               "run fsck to repair, chksum_offset: %zu",
> +                               crc_offset);
> +                       return -EINVAL;
> +               }
> +       }
> +

I try not to be a Grammar Nazi and a jerk on every patches, but since
this is a message a user would directly encounter, I'd like to see a
bit less ambiguous message.

How about "using deprecated layout of large_nat_bitmap, please run
fsck v1.13.0 or higher to repair, chksum_offset: %zu"?
The original message seems to suggest that large_nat_bitmap is
deprecated outright.

Also, I'd like to suggest to write down an actual version of
f2fs-tools here as we've seen older versions of fsck doing even more
damage and the users might not have the latest f2fs-tools installed.

Btw, what happens if we use the latest fsck to fix the corrupted image
and use the older kernel to mount it?
Would it even mount?

Thanks.
