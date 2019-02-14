From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: don't allow negative
 ->write_io_size_bits
Date: Fri, 15 Feb 2019 00:09:42 +0800
Message-ID: <a1862cab-ee56-660e-7c7d-664cf7e8c222@kernel.org>
References: <20190211184514.GA22212@kadam>
 <8f0cfae7-eb14-5e94-ad49-cfae222ce553@huawei.com>
 <05f4eed5-8b71-e97f-464a-72f8c5ae804d@huawei.com>
 <20190213094615.GE5458@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1guJaI-0001yh-Oh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Feb 2019 16:09:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1guJaG-0076nj-CY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Feb 2019 16:09:58 +0000
In-Reply-To: <20190213094615.GE5458@kadam>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2019-2-13 17:46, Dan Carpenter wrote:
> On Wed, Feb 13, 2019 at 04:49:57PM +0800, Chao Yu wrote:
>> On 2019/2/13 11:32, Chao Yu wrote:
>>> On 2019/2/12 2:45, Dan Carpenter wrote:
>>>> We put an upper bound on ->write_io_size_bits but we don't have a lower
>>>> bound.
>>>
>>> Oh, lower bound, I think there are more cases didn't consider that,
>>> let me check it.
>>
>> Sorry, one missing case:
>>
>> Shouldn't it be:
>>
>> if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
>>          ^
> 
> It wouldn't be hard for me to redo my patch, but I don't know enough to
> say if zero is invalid and I don't want to get blamed for that...  Can
> you do it, since you're better able to test the change?
> 
> So let's drop this patch, and then could you give me Reported-by credit
> instead?

No problem. :)

Thanks,

> 
> regards,
> dan carpenter
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
