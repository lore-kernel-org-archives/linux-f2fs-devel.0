From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v6] f2fs: support in-memory inode checksum
 when checking consistency
Date: Fri, 9 Mar 2018 20:32:54 +0800
Message-ID: <a47f103a-4a33-fb1f-e632-51fb5e27643c@kernel.org>
References: <20180309151021.142737-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1euHDC-0008UJ-Ax
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 12:33:26 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1euHDA-00B3Xi-Vm
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 12:33:26 +0000
In-Reply-To: <20180309151021.142737-1-guoweichao@huawei.com>
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
To: Weichao Guo <guoweichao@huawei.com>, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/3/9 23:10, Weichao Guo wrote:
> Enable in-memory inode checksum to protect metadata blocks from
> in-memory scribbles when checking consistency, which has no
> performance requirements.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
