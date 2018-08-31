From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add additional sanity check in
 f2fs_acl_from_disk()
Date: Fri, 31 Aug 2018 20:17:06 +0800
Message-ID: <c8c200bf-3bf3-c571-ba53-61113d3388cd@huawei.com>
References: <20180830133331.5503-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fviMa-0007XF-Ub
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 12:17:20 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fviMV-004ksA-Ci
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 12:17:20 +0000
In-Reply-To: <20180830133331.5503-1-cgxu519@gmx.com>
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

On 2018/8/30 21:33, Chengguang Xu wrote:
> Add additinal sanity check for irregular case(e.g. corruption).
> If size of extended attribution is smaller than size of acl header,
> then return -EINVAL.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
