From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: fix an error return value in
 truncate_partial_data_page
Date: Thu, 2 Mar 2017 10:00:04 +0800
Message-ID: <3446caf6-449f-de05-602b-a3ebed732175@huawei.com>
References: <20170228123241.5070-1-heyunlei@huawei.com>
	<98366c6a-4bcd-44cc-4143-a22a359db63d@huawei.com>
	<20170301193250.GB18600@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cjG2o-0005Bs-4x
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 02:00:38 +0000
Received: from [45.249.212.191] (helo=dggrg05-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cjG2l-0007Kq-PS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 02:00:38 +0000
In-Reply-To: <20170301193250.GB18600@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net


Hi Jaegeuk,
On 2017/3/2 3:32, Jaegeuk Kim wrote:
> On 03/01, Chao Yu wrote:
>> On 2017/2/28 20:32, Yunlei He wrote:
>>> This patch fix a error return value in truncate_partial_data_page
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> ---
>>>  fs/f2fs/file.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index c6ca00c..c186d75 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -529,7 +529,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
>>>
>>>  	page = get_lock_data_page(inode, index, true);
>>>  	if (IS_ERR(page))
>>> -		return 0;
>>> +		return page;
>>
>> return PTR_ERR(page);
>
> Do we need this?

Yes, you are right, we need this if file has holes.

Thanks.

>
> return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
>
> Thanks,
>
>>
>> Thanks,
>>
>>>  truncate_out:
>>>  	f2fs_wait_on_page_writeback(page, DATA, true);
>>>  	zero_user(page, offset, PAGE_SIZE - offset);
>>>
>
> .
>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
