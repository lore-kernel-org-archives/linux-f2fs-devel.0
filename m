From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH v2] f2fs: introduce "strict_fsync" for posix
 standard fsync
Date: Sun, 11 Feb 2018 10:37:54 +0800
Message-ID: <b41911c9-4ae4-1918-f865-0a49e2a4a9f2@huawei.com>
References: <20180202083333.104786-1-zhengjunling@huawei.com>
 <20180210004457.GA1885@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <zhengjunling@huawei.com>) id 1ekhXW-0002rn-SO
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 02:38:50 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekhXV-0003X0-Ps
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 02:38:50 +0000
In-Reply-To: <20180210004457.GA1885@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi, Jaegeuk

On 2018/2/10 8:44, Jaegeuk Kim wrote:
> On 02/02, Junling Zheng wrote:
>> Commit "0a007b97aad6"(f2fs: recover directory operations by fsync)
>> fixed xfstest generic/342 case, but it also increased the written
>> data and caused the performance degradation. In most cases, there's
>> no need to do so heavily fsync actually.
>>
>> So we introduce a new mount option "strict_fsync" to control the
>> policy of fsync. It's set by default, and means that fsync follows
>> POSIX semantics. And "nostrict_fsync" means that the behaviour is
>> in line with xfs, ext4 and btrfs, where generic/342 will pass.
> 
> How about adding "fsync=%s" to give another chance for fsync policies?
> 

OK, I'll give patch v3 to change to "fsync=%s" format.
BTW, which policy do u think should be the default behavior for f2fs? Posix
or ext4?

Thanks
Junling

> Thanks,
> 
>>
>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  Documentation/filesystems/f2fs.txt |  4 ++++
>>  fs/f2fs/dir.c                      |  3 ++-
>>  fs/f2fs/f2fs.h                     |  1 +
>>  fs/f2fs/file.c                     |  3 ++-
>>  fs/f2fs/namei.c                    |  9 ++++++---
>>  fs/f2fs/super.c                    | 13 +++++++++++++
>>  6 files changed, 28 insertions(+), 5 deletions(-)
>>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
