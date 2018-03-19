From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH v3] f2fs: check blkaddr more accuratly before
 issue a bio
Date: Mon, 19 Mar 2018 01:55:34 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F0565483572B1@DGGEMA503-MBS.china.huawei.com>
References: <1520497753-29066-1-git-send-email-heyunlei@huawei.com>
 <80ab844e-12c4-4e93-3e55-f14bf994d184@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1exk1j-0000CV-2B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 01:55:55 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1exk1g-004Jfx-FO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 01:55:54 +0000
In-Reply-To: <80ab844e-12c4-4e93-3e55-f14bf994d184@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

ping

>-----Original Message-----
>From: Yuchao (T)
>Sent: Thursday, March 08, 2018 5:12 PM
>To: heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
>Cc: Wangbintian
>Subject: Re: [f2fs-dev][PATCH v3] f2fs: check blkaddr more accuratly before issue a bio
>
>On 2018/3/8 16:29, Yunlei He wrote:
>> This patch check blkaddr more accuratly before issue a
>> write or read bio.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>
>Reviewed-by: Chao Yu <yuchao0@huawei.com>
>
>Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
