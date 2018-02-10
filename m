From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 0/2] f2fs: introduce lost+found feature
Date: Fri, 9 Feb 2018 18:50:06 -0800
Message-ID: <20180210025006.GB6020@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180206043118.134137-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ekLEz-0006h4-5s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Feb 2018 02:50:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekLEy-0007HJ-D6
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Feb 2018 02:50:13 +0000
Content-Disposition: inline
In-Reply-To: <20180206043118.134137-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: heyunlei@huawei.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/06, Sheng Yong wrote:
> This patchset introduces lost+found feature in f2fs. If the feature is
> enabled, f2fs should avoid to encrypting root directory.

In that case, we need to add test_dummy_encryption likewise ext4.

> 
> For more information, please check the mail "f2fs-tools: introduce lost+
> found feature".
> 
> Thanks,
> Sheng
> 
> Sheng Yong (2):
>   f2fs: clean up f2fs_sb_has_xxx functions
>   f2fs: introduce lost+found feature
> 
>  fs/f2fs/data.c    |  2 +-
>  fs/f2fs/f2fs.h    | 53 +++++++++++++++--------------------------------------
>  fs/f2fs/file.c    |  6 +++---
>  fs/f2fs/segment.c |  4 ++--
>  fs/f2fs/super.c   | 26 +++++++++++++++++++-------
>  fs/f2fs/sysfs.c   |  4 ++--
>  6 files changed, 42 insertions(+), 53 deletions(-)
> 
> -- 
> 2.11.0

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
