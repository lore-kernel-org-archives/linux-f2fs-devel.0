From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] resize.f2fs: fix wrong nat_bits migration
Date: Wed, 20 Jun 2018 10:25:38 +0800
Message-ID: <07b6ac9e-0e9a-ffd9-832a-a9d871a67ef9@huawei.com>
References: <20180618003948.16479-1-jaegeuk@kernel.org>
 <20180618003948.16479-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVSov-0000aW-Fa
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Jun 2018 02:26:05 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVSot-0010kY-7B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Jun 2018 02:26:05 +0000
In-Reply-To: <20180618003948.16479-2-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/18 8:39, Jaegeuk Kim wrote:
> When wring the last nat_bits in new checkpoint, we call write_nat_bits()
> to recover the nat_bits. But, we didn't update nm_i->nat_bitmap which we can
> get the up-to-date nat blocks. After sit migration, old checkpoint has no
> longer valid nat blocks, resulting in wrong free nid allocation at the following
> mount time.
> 
> Let's indicate new nat_blocks by adjusting nat_bitmap in nat migration.
> 
> Reported-by: Lianjun Huang <huanglianjun@vivo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
