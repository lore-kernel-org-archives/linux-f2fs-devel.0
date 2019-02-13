From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't allow negative
 ->write_io_size_bits
Date: Wed, 13 Feb 2019 16:49:57 +0800
Message-ID: <05f4eed5-8b71-e97f-464a-72f8c5ae804d@huawei.com>
References: <20190211184514.GA22212@kadam>
 <8f0cfae7-eb14-5e94-ad49-cfae222ce553@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gtqF6-0008BV-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Feb 2019 08:50:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gtqF3-004ZeC-OY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Feb 2019 08:50:08 +0000
In-Reply-To: <8f0cfae7-eb14-5e94-ad49-cfae222ce553@huawei.com>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2019/2/13 11:32, Chao Yu wrote:
> On 2019/2/12 2:45, Dan Carpenter wrote:
>> We put an upper bound on ->write_io_size_bits but we don't have a lower
>> bound.
> 
> Oh, lower bound, I think there are more cases didn't consider that,
> let me check it.

Sorry, one missing case:

Shouldn't it be:

if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
         ^
> 
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
