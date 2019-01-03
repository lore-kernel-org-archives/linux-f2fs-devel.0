From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: change error code to -ENOMEM from
 -EINVAL
Date: Thu, 3 Jan 2019 14:44:39 +0800
Message-ID: <d8e3fba0-9473-7586-adca-79ead1052676@huawei.com>
References: <20190101133311.18120-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gewkQ-0001WR-NR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 06:44:54 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gewkO-00Cmd8-Ff
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jan 2019 06:44:54 +0000
In-Reply-To: <20190101133311.18120-1-cgxu519@gmx.com>
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
To: Chengguang Xu <cgxu519@gmx.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/1 21:33, Chengguang Xu wrote:
> The error case of failing allocating memory should
> return -ENOMEM.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
