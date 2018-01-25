From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: rebuild sit page from sit info in mem
Date: Thu, 25 Jan 2018 15:22:54 +0800
Message-ID: <e0e03f59-a3a2-e3f2-a028-efb2ce845939@huawei.com>
References: <1516761560-22917-1-git-send-email-heyunlei@huawei.com>
 <42B685BFA705F94C860C6DD0752F056548315E10@DGGEMA503-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eebsa-0004x7-Ol
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 07:23:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eebsZ-0007B7-15
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 07:23:24 +0000
In-Reply-To: <42B685BFA705F94C860C6DD0752F056548315E10@DGGEMA503-MBX.china.huawei.com>
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
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Jianing (Euler)" <ning.jia@huawei.com>

On 2018/1/24 15:44, heyunlei wrote:
> Most sit flush consume no more than 1ms.

Looks good! Could you add these numbers into this patch?

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
