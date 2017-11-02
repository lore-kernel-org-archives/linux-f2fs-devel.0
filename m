From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH v2 0/9] f2fs-tools: fix fix_on usage and
 introduce dump/print xattr
Date: Thu, 2 Nov 2017 23:08:51 +0800
Message-ID: <962f25f3-601a-b67e-cd6a-2eecbc517f1e@kernel.org>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eAH89-0008G0-HH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 15:10:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eAH83-0002xK-OH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 15:10:05 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/11/2 11:56, Sheng Yong wrote:
> v1-v2:
> [PATCH 3] print values of USER/SECRUITY xattr as hex instead of plain text.
> [PATCH 4] replace xattr value if it already exists by setting parameter
>           `flags' as 0 of fsetxattr.
> [PATCH 1/7] move message printing modification into a different patch.
> 
> thanks,
> Sheng
> 
> Sheng Yong (9):
>   fsck.f2fs: do not set fix_on directly
>   fsck.f2fs: do not fix corrupted nat entries in build_nat_area_bitmap
>   dump/fsck: introduce print_xattr_entry
>   dump.f2fs: introduce dump_xattr
>   dump.f2fs: do not dump encrypted files
>   fsck.f2fs: introduce new option --dry-run
>   fsck.f2fs: introduce sanity_check_inode
>   f2fs-tools: remove unused list.h
>   fsck.f2fs: format output message of FIX_MSG

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>  fsck/dump.c       |  93 ++++++++++++++++++++++++++++------
>  fsck/fsck.c       |  25 +++++++++-
>  fsck/fsck.h       |   7 ++-
>  fsck/main.c       |  16 +++++-
>  fsck/mount.c      | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  fsck/xattr.c      |   2 +-
>  fsck/xattr.h      |  54 +++++++++++++++++++-
>  include/f2fs_fs.h |   1 +
>  include/list.h    |  88 --------------------------------
>  lib/libf2fs.c     |   1 +
>  lib/libf2fs_io.c  |   3 ++
>  11 files changed, 313 insertions(+), 123 deletions(-)
>  delete mode 100644 include/list.h
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
