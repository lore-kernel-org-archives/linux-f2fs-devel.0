From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove redundant check in
 f2fs_file_write_iter()
Date: Wed, 24 Apr 2019 11:25:59 +0800
Message-ID: <47f05145-3581-3b0b-d3a4-c953b8354e8f@huawei.com>
References: <20190423050835.4642-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hJ8Xw-0000Hk-EP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 03:26:08 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJ8Xv-009DPB-3G
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 03:26:08 +0000
In-Reply-To: <20190423050835.4642-1-cgxu519@gmx.com>
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

On 2019/4/23 13:08, Chengguang Xu wrote:
> We have already checked flag IOCB_DIRECT in the sanity
> check of flag IOCB_NOWAIT, so don't have to check it
> again here.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
