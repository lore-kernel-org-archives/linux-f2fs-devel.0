From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] loop: drop caches if offset or block_size are changed
Date: Wed, 13 Mar 2019 22:07:43 -0700
Message-ID: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
References: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: jaegeuk@kernel.org, linux-block@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Jaegeuk,

We have observed an issue in production with this patch.
(ihttps://bugs.chromium.org/p/chromium/issues/detail?id=938958#c38)
If we mount -o loop,offset=... $file, mount will issue 2 ioctl back to back:
- LOOP_SET_FD
- LOOP_SET_STATUS64 with offset change.

Looking at kill_bdev, it calls truncate_inode_pages(). From its
comment, mapping->nrpages can still be non-zero:
"""
 * Note: When this function returns, there can be a page in the process of
 * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
 * mapping->nrpages can be non-zero when this function returns even after
 * truncation of the whole mapping.
"""
It is therefore possible to have truncated all the pages, but nr_page
still be !0.
We would fail the mount with -EAGAIN while it was perfectly valid.

Is the test for nrpages really necessary in the second part of the patch?

Gwendal.
