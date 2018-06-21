From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Date: Thu, 21 Jun 2018 14:10:03 +0800
Message-ID: <f490775d-c56f-e2db-9470-14a04d1b6210@huawei.com>
References: <20180620103953.bxdqzy2izn3elii7@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVso4-0008WT-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 06:10:56 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVso1-004Jfc-J0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 06:10:56 +0000
In-Reply-To: <20180620103953.bxdqzy2izn3elii7@kili.mountain>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Sahitya Tummala <stummala@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/20 18:39, Dan Carpenter wrote:
> "ret" can be uninitialized on the success path when "in ==
> F2FS_GOING_DOWN_FULLSYNC".
> 
> Fixes: 60b2b4ee2bc0 ("f2fs: Fix deadlock in shutdown ioctl")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
