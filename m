From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: introduce "strict_fsync" for posix
 standard fsync
Date: Fri, 2 Feb 2018 14:31:20 +0800
Message-ID: <6d16fa03-44e8-f110-a787-e35ed7984589@huawei.com>
References: <20180202032824.101460-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ehUt5-0007Z6-RZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Feb 2018 06:31:51 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehUt4-0007kU-6j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Feb 2018 06:31:51 +0000
In-Reply-To: <20180202032824.101460-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/2/2 11:28, Junling Zheng wrote:
> Commit "0a007b97aad6"(f2fs: recover directory operations by fsync)
> fixed xfstest generic/342 case, but it also increased the written
> data and caused the performance degradation. In most cases, there's
> no need to do so heavily fsync actually.
> 
> So we introduce a new mount option "strict_fsync" to control the
> policy of fsync. It's set by default, and means that fsync follows
> POSIX semantics. And "nostrict_fsync" means that the behaviour is
> in line with xfs, ext4 and btrfs, on which generic/342 will be passed.

Need to document {,no}strict_fsync in f2fs.txt.

Otherwise, you can add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
