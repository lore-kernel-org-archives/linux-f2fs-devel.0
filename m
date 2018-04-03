From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] mkfs.f2fs: support multiple features with
 one "-O"
Date: Tue, 3 Apr 2018 18:01:01 +0800
Message-ID: <f0e761c3-d9f9-ae9a-78d0-3661a6cfc2eb@huawei.com>
References: <dd1b7eff-3b60-891b-48f4-0f029ef44507@huawei.com>
 <20180403093845.68535-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f3Ikt-0004LJ-7K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 10:01:31 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3Ikp-006m0A-42
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 10:01:31 +0000
In-Reply-To: <20180403093845.68535-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/4/3 17:38, Junling Zheng wrote:
> Now one "-O" option can support multiple features separated
> by a comma or blank, such as:
> feature1,feature2,... or "feature1 feature2 ..."
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
