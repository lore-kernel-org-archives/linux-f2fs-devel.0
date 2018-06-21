From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] fsck.f2fs: introduce fsck_chk_curseg_info
Date: Thu, 21 Jun 2018 14:12:03 +0800
Message-ID: <80330ac5-a70a-e155-194c-d41bf8fd9e4c@huawei.com>
References: <4b799e3b-a5fd-15e4-c50e-3771eb37fb4d@huawei.com>
 <20180620111213.86979-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVspm-00008g-6Z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 06:12:42 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVspk-00GYrO-Qh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 06:12:42 +0000
In-Reply-To: <20180620111213.86979-1-shengyong1@huawei.com>
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/20 19:12, Sheng Yong wrote:
> If curseg is an empty segment, it will not be checked. This patch
> introduces fsck_chk_curseg_info() to check SIT/SSA type of cursegs
> to avoid curseg corruption.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
