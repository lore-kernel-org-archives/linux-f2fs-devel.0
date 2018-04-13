From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: stop issue discard if something
 wrong with f2fs
Date: Fri, 13 Apr 2018 09:31:01 +0800
Message-ID: <bf7fdacf-55e7-f58c-e570-6e3802b724a2@huawei.com>
References: <1523332905-12688-1-git-send-email-heyunlei@huawei.com>
 <d6f29395-c218-d0d2-17ea-bacf59b5b221@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f6nYu-0002dz-0m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:31:36 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6nYp-009Rz0-H3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:31:35 +0000
In-Reply-To: <d6f29395-c218-d0d2-17ea-bacf59b5b221@huawei.com>
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

On 2018/4/10 14:38, Chao Yu wrote:
> On 2018/4/10 12:01, Yunlei He wrote:
>> This patch stop async thread and umount process to issue discard
>> if something wrong with f2fs, which is similar to fstrim.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Sorry, please hold on this patch before we fix the SBI_NEED_FSCK's ambiguity
sematic issue.

Thanks,

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
