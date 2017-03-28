From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: prevent waiter encountering
 incorrect discard states
Date: Tue, 28 Mar 2017 09:17:01 +0800
Message-ID: <1040d25a-9cc8-a4c8-7143-a0375ecdeeb5@huawei.com>
References: <20170327101406.56028-1-yuchao0@huawei.com>
	<20170327101406.56028-3-yuchao0@huawei.com>
	<20170327235608.GA4984@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1csflD-0002Yf-M8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Mar 2017 01:17:23 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1csflB-0004ZN-T0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Mar 2017 01:17:23 +0000
In-Reply-To: <20170327235608.GA4984@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/28 7:56, Jaegeuk Kim wrote:
> On 03/27, Chao Yu wrote:
>> In f2fs_submit_discard_endio, we will wake up waiter before setting
>> discard command states, so waiter may use incorrect states. Change
>> the order between complete() and states setting to fix this issue.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 57a81f9c8c14..9f9542c9fe47 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -717,9 +717,9 @@ static void f2fs_submit_discard_endio(struct bio *bio)
>>  {
>>  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
>>  
>> -	complete(&dc->wait);
>>  	dc->error = bio->bi_error;
>>  	dc->state = D_DONE;
>> +	complete(&dc->wait);
> 
> If we set D_DONE first, the object can be released by __remove_discard_cmd()?

Yes, I think so.

Thanks,

> 
> Thanks,
> 
>>  	bio_put(bio);
>>  }
>>  
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
