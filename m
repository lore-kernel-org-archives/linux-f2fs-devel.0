From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: check if file namelen exceeds max
 value
Date: Tue, 8 Jan 2019 10:23:53 +0800
Message-ID: <c210a8a8-157e-e454-98de-9c6c53219b02@huawei.com>
References: <20190104115357.831-1-shengyong1@huawei.com>
 <20190107070234.181785-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ggh3u-0003AK-2m
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 02:24:14 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ggh3s-002ZHI-Fw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Jan 2019 02:24:14 +0000
In-Reply-To: <20190107070234.181785-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/7 15:02, Sheng Yong wrote:
> Dentry bitmap is not enough to detect incorrect dentries. So this patch
> also checks the namelen value of a dentry.
> 
> Signed-off-by: Gong Chen <gongchen4@huawei.com>
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
> v2->v1: Sorry, my bad. Fix incorrect brackets.

Sorry for missing this too.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
