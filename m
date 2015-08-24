From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: Re: [PATCH] fs/f2fs: replace open coded nofail
 allocation in __add_ino_entry
Date: Mon, 24 Aug 2015 14:10:22 +0800
Message-ID: <55DAB54E.5000007@huawei.com>
References: <1440386638-40325-1-git-send-email-zhenzhang.zhang@huawei.com>
	<55DA920B.9040706@huawei.com>
	<20150824045625.GB2837@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1ZTky3-0003qP-QQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 06:10:51 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZTky0-0001Sq-9n
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 06:10:51 +0000
In-Reply-To: <20150824045625.GB2837@jaegeuk-mac02.mot-mobility.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2015/8/24 12:56, Jaegeuk Kim wrote:
> Hi Zhang,
> 
> On Mon, Aug 24, 2015 at 11:39:55AM +0800, Zhang Zhen wrote:
>> __add_ino_entry is looping around the allocation request and minics
>> __GFP_NOFAIL behavior without any allocation fallback strategy.
>> Here remove the open coded loop and replace it with __GFP_NOFAIL.
>>
>> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index b70bbe1..d62363b 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -337,12 +337,7 @@ retry:
>>
>>  	e = radix_tree_lookup(&im->ino_root, ino);
>>  	if (!e) {
>> -		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
>> -		if (!e) {
>> -			spin_unlock(&im->ino_lock);
>> -			radix_tree_preload_end();
>> -			goto retry;
>> -		}
>> +		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC|__GFP_NOFAIL);
> 
> I submitted a patch to replace GFP_ATOMIC with GFP_NOFS.
> We can avoid to use GFP_ATOMIC here, right?
> 
Yes, i think so.
> Thanks,
> 
>>  		if (radix_tree_insert(&im->ino_root, ino, e)) {
>>  			spin_unlock(&im->ino_lock);
>>  			kmem_cache_free(ino_entry_slab, e);
>> -- 
>> 1.9.1
>>
>>
>> .
>>
>>
>>
>>
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 



------------------------------------------------------------------------------
