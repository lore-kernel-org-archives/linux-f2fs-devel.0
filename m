From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: introduce a method to make nat
 journal more fresh
Date: Mon, 9 Apr 2018 19:07:48 +0800
Message-ID: <d81910c2-8929-73ac-fde9-f52055428b9e@huawei.com>
References: <1521195897-28018-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5Uee-0006ho-Mt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:08:08 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5Ueb-00CF92-TS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:08:08 +0000
In-Reply-To: <1521195897-28018-1-git-send-email-heyunlei@huawei.com>
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

On 2018/3/16 18:24, Yunlei He wrote:
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
