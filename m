From: guoweichao <guoweichao@huawei.com>
Subject: Re: [PATCH v2] f2fs: report cp block corrupted
Date: Mon, 5 Feb 2018 15:53:38 +0800
Message-ID: <e0eb1739-2dcf-6303-2b2c-b030e7b4182c@huawei.com>
References: <20180205101816.179878-1-guoweichao@huawei.com>
 <1334a3ac-9775-dd12-1019-0f8c7b3d7cef@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <guoweichao@huawei.com>) id 1eibbK-0004Zt-3x
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 07:54:06 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eibbI-0000uW-4g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Feb 2018 07:54:06 +0000
In-Reply-To: <1334a3ac-9775-dd12-1019-0f8c7b3d7cef@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2018/2/5 15:41, Chao Yu wrote:
> On 2018/2/5 18:18, Weichao Guo wrote:
>> There is a potential inconsistent metadata case due to a cp block
>> crc invalid in the latest checkpoint caused by hardware issues:
>> 1) write nodes into segment x;
>> 2) write checkpoint A;
>> 3) remove nodes in segment x;
>> 4) write checkpoint B;
>> 5) issue discard or write datas into segment x;
>> 6) sudden power-cut;
>> 7) use checkpoint A after reboot as checkpoint B is invalid
>>
>> This inconsistency may be found after several reboots long time later
>> and the kernel log about cp block crc invalid has disappeared. This
>> makes the root cause of the inconsistency is hard to locate. Let us
>> separate such other part issues from f2fs logical bugs in debug version.
> 
> Need a Signed-off here?
My mistake, I've resend another version.

Thanks,
> 
> Anyway,
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
