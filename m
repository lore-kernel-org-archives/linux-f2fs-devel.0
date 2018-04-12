From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v5] f2fs: introduce a method to make nat
 journal more fresh
Date: Thu, 12 Apr 2018 17:42:34 +0800
Message-ID: <527e85f8-e407-1897-9929-b9a8be53f557@huawei.com>
References: <1523344306-16493-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f6Yl8-0008LR-EM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Apr 2018 09:43:14 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6Yku-00Cvj4-5Y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Apr 2018 09:43:14 +0000
In-Reply-To: <1523344306-16493-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/10 15:11, Yunlei He wrote:
> This patch introduce a method to make nat journal more fresh:
> i.  sort set list using dirty entry number and cp version
>     average value.
> ii. if meet with cache hit, update average version valus with
>     current cp version.
> 
> With this patch, newly modified nat set will flush to journal,
> and flush old nat set with same dirty entry number to nat area.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
