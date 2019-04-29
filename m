From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity with enabled features
 in image
Date: Tue, 30 Apr 2019 05:54:02 +0900
Message-ID: <CAD14+f2nDurQ2mTp-temk92zhWQkKNaBA8CwpWJhOZEmzLw=VA@mail.gmail.com>
References: <20190424094850.118323-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424094850.118323-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao and Jaegeuk,

On Wed, Apr 24, 2019 at 6:49 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> This patch fixes to do sanity with enabled features in image, if
> there are features kernel can not recognize, just fail the mount.
>

Surprised to see that this wasn't implemented yet.
I was actually about to suggest this method to prevent mounting of the
new extended bitmap layout images altogether for older kernels(by
renaming the new, fixed layout to v2 or something), but looks like
that isn't an option. :(

Also, something similar should be also done with fsck, if not already.
The results from using older fsck with images with newer features
would be disastrous.

I'm still very busy currently with my other projects.
Sorry for the delays in testing new patchsets for layout fixes.

And I apologize in advance in case I miss the Linux 5.2 merge window
deadline, but I'd like to see it being fixed properly before shipping
those patches to production.

> +       /* check whether kernel supports all features */
> +       if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
> +               f2fs_msg(sb, KERN_INFO,
> +                       "Unsupported feature:%u: supported:%u",
> +                       le32_to_cpu(raw_super->feature),
> +                       F2FS_ALL_FEATURES);
> +               return 1;
> +       }

This should probably be a KERN_ERR instead of KERN_INFO.

Thanks.
