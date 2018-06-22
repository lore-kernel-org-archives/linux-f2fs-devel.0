From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v6] f2fs: support in-memory inode checksum
 when checking consistency
Date: Fri, 22 Jun 2018 15:16:32 +0800
Message-ID: <b1c343b0-671e-283d-9f8c-9ac5005a13ff@huawei.com>
References: <20180309151021.142737-1-guoweichao@huawei.com>
 <4a425d34-125d-24a8-83e6-9531d8174de4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fWGKM-0001Fi-E1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 07:17:50 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fWGKK-0038Ho-Vu
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 07:17:50 +0000
In-Reply-To: <4a425d34-125d-24a8-83e6-9531d8174de4@kernel.org>
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
To: Chao Yu <chao@kernel.org>, Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/6/12 22:36, Chao Yu wrote:
> Ping,
> 
> Jaegeuk, sometimes, we suffer data corruption caused by bit-transition of cache,
> we troubleshoot for weeks or months, and finally, find that it is caused by
> hardware. So for this case, maybe in-memory checksum can help to troubleshoot
> more quickly.
> 
> Could you consider this?
> 
> Thanks,
> 
> On 2018/3/9 23:10, Weichao Guo wrote:
>> Enable in-memory inode checksum to protect metadata blocks from
>> in-memory scribbles when checking consistency, which has no
>> performance requirements.
>>
>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
