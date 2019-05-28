From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] mm: remove cleancache.c
Date: Tue, 28 May 2019 09:24:45 +0800
Message-ID: <8f69d56d-3fdd-a160-9574-f81bd066e5ac@huawei.com>
References: <20190527103207.13287-1-jgross@suse.com>
 <20190527103207.13287-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527103207.13287-3-jgross@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/27 18:32, Juergen Gross wrote:
> With the removal of tmem and xen-selfballoon the only user of
> cleancache is gone. Remove it, too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  Documentation/vm/cleancache.rst  | 296 ------------------------------------
>  Documentation/vm/frontswap.rst   |  10 +-
>  Documentation/vm/index.rst       |   1 -
>  MAINTAINERS                      |   7 -
>  drivers/staging/erofs/data.c     |   6 -
>  drivers/staging/erofs/internal.h |   1 -
>  fs/block_dev.c                   |   5 -
>  fs/btrfs/extent_io.c             |   9 --
>  fs/btrfs/super.c                 |   2 -
>  fs/ext4/readpage.c               |   6 -
>  fs/ext4/super.c                  |   2 -
>  fs/f2fs/data.c                   |   3 +-

For erofs and f2fs part,

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  fs/mpage.c                       |   7 -
>  fs/ocfs2/super.c                 |   2 -
>  fs/super.c                       |   3 -
>  include/linux/cleancache.h       | 124 ---------------
>  include/linux/fs.h               |   5 -
>  mm/Kconfig                       |  22 ---
>  mm/Makefile                      |   1 -
>  mm/cleancache.c                  | 317 ---------------------------------------
>  mm/filemap.c                     |  11 --
>  mm/truncate.c                    |  15 +-
