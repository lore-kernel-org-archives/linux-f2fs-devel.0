From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix wrong return value of
 f2fs_acl_create
Date: Wed, 21 Nov 2018 11:32:22 +0800
Message-ID: <c8d7aace-5b91-e18a-416c-58d7b6019d97@huawei.com>
References: <3ff4ba33.a5b.167336de02f.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gPJFg-0004P2-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Nov 2018 03:32:32 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gPJFe-00Fdzm-Pz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Nov 2018 03:32:32 +0000
In-Reply-To: <3ff4ba33.a5b.167336de02f.Coremail.kernelpatch@126.com>
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
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/11/21 7:21, Tiezhu Yang wrote:
> When call f2fs_acl_create_masq() failed, the caller f2fs_acl_create()
> should return -EIO instead of -ENOMEM, this patch makes it consistent
> with posix_acl_create() which has been fixed in commit beaf226b863a
> ("posix_acl: don't ignore return value of posix_acl_create_masq()").
> 
> Fixes: 83dfe53c185e ("f2fs: fix reference leaks in f2fs_acl_create")
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
