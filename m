From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix remount problem of option io_bits
Date: Tue, 25 Sep 2018 15:42:11 +0800
Message-ID: <b3b7f158-97ef-ed7f-1287-e0d461be473b@huawei.com>
References: <20180922144309.1969-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g4hzB-0007CZ-Uv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:42:21 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g4hzA-003HQf-Gc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:42:21 +0000
In-Reply-To: <20180922144309.1969-1-cgxu519@gmx.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/9/22 22:43, Chengguang Xu wrote:
> Currently we show mount option "io_bits=%u" as "io_size=%uKB",
> it will cause option parsing problem(unrecognized mount option)
> in remount.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
