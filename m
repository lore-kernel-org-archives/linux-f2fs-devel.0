From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] dump.f2fs: only dump nat inside the
 specified nid range
Date: Mon, 2 Jul 2018 19:21:30 +0800
Message-ID: <b08a232f-b92f-b830-f825-629f683e57b8@huawei.com>
References: <20180702035934.23560-1-zhengjunling@huawei.com>
 <20180702092241.96520-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fZwuJ-0000Xz-9r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 11:22:11 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fZwuG-00BH2r-R1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 11:22:11 +0000
In-Reply-To: <20180702092241.96520-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, chao@kernel.org, jaegeuk@kernel.org, heyunlei@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/2 17:22, Junling Zheng wrote:
> Only dump nat info of nids inside the specified range.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Looks good to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
