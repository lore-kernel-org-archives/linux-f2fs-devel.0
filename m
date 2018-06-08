From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] fsck.f2fs: do not print content beyond
 sb->version
Date: Fri, 8 Jun 2018 17:39:43 +0800
Message-ID: <2ae94c7b-4ef7-7257-85cb-1288b33e86b5@huawei.com>
References: <20180606143924.154725-1-zhengjunling@huawei.com>
 <20180608051148.34512-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fRDtS-0007Rs-JM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 09:41:14 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fRDtP-0007z7-TR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 09:41:14 +0000
In-Reply-To: <20180608051148.34512-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/8 13:11, Junling Zheng wrote:
> Currently, versions in f2fs_configuration have one more byte than
> those in sb, so versions in sb may not end with '\0', and then
> print_raw_sb_info() will print something beyond sb->version.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
