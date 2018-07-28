From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: report error if quota off error
 during umount
Date: Sat, 28 Jul 2018 17:49:27 +0800
Message-ID: <d39bdd51-f5e2-29df-b8ca-73e6c68bc85a@huawei.com>
References: <1529989963-24570-1-git-send-email-heyunlei@huawei.com>
 <18d4965a-7358-c057-32ea-9db6395bd56f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fjLr3-0004S7-Bg
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Jul 2018 09:49:41 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjLr0-000n8L-Pi
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Jul 2018 09:49:41 +0000
In-Reply-To: <18d4965a-7358-c057-32ea-9db6395bd56f@huawei.com>
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
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

Ping,

On 2018/6/26 16:34, Chao Yu wrote:
> On 2018/6/26 13:12, Yunlei He wrote:
>> Now, we depend on fsck to ensure quota file data is ok,
>> so we scan whole partition if checkpoint without umount
>> flag. It's same for quota off error case, which may make
>> quota file data inconsistent.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
