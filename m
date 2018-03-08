From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v5] f2fs: introduce mount option for fsync
 mode
Date: Thu, 8 Mar 2018 11:45:47 +0800
Message-ID: <9d021f64-8977-b2f3-d43f-0ae157226c85@huawei.com>
References: <20180307040749.217513-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1etmVL-0072Gy-9f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 03:46:07 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etmVJ-003Mrk-Jr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Mar 2018 03:46:07 +0000
In-Reply-To: <20180307040749.217513-1-zhengjunling@huawei.com>
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

On 2018/3/7 12:07, Junling Zheng wrote:
> Commit "0a007b97aad6"(f2fs: recover directory operations by fsync)
> fixed xfstest generic/342 case, but it also increased the written
> data and caused the performance degradation. In most cases, there's
> no need to do so heavy fsync actually.
> 
> So we introduce new mount option "fsync_mode={posix,strict}" to
> control the policy of fsync. "fsync_mode=posix" is set by default,
> and means that f2fs uses a light fsync, which follows POSIX semantics.
> And "fsync_mode=strict" means that it's a heavy fsync, which behaves
> in line with xfs, ext4 and btrfs, where generic/342 will pass, but
> the performance will regress.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
