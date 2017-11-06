From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/3] f2fs: avoid using __GFP_NOFAIL
Date: Tue, 7 Nov 2017 00:08:25 +0800
Message-ID: <1434ded5-74f8-d5bf-1576-cca53a56144d@kernel.org>
References: <20171105135330.15070-1-chao@kernel.org>
 <20171106140853.f3nqwfg75tco67y6@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eBjx6-0007Ud-KK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 16:08:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eBjx2-00051i-SY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Nov 2017 16:08:44 +0000
In-Reply-To: <20171106140853.f3nqwfg75tco67y6@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Michal,

On 2017/11/6 22:08, Michal Hocko wrote:
> On Sun 05-11-17 21:53:28, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> We will keep __add_ino_entry success all the time, for ENOMEM failure
>> case, we have already handled it with an opened loop code, so we don't
>> have to use redundant __GFP_NOFAIL in radix_tree_preload, remove it.
> 
> Why do you think an open coded allocation retry loop is better than
> having the MM do all it can when the nofail is requested explicitly?> E.g. giving it an access to memory reserves to allow forward progress.

Well, just want to remove one redundant implementation. But, as you said
MM has done lots of work to grab free memory including accessing memory
reserves, I think it's not bad for f2fs to use this flag instead of opened
loop code. :)

BTW, I notice the comments of __GFP_NOFAIL, what does this mean?
 *   Using this flag for costly allocations is _highly_ discouraged.

Thanks,

> 
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 98777c1ae70c..43ee9d97fd8f 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -405,10 +405,11 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>>  {
>>  	struct inode_management *im = &sbi->im[type];
>>  	struct ino_entry *e, *tmp;
>> +	bool preloaded;
>>  
>>  	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
>>  retry:
>> -	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
>> +	preloaded = !radix_tree_preload(GFP_NOFS);
>>  
>>  	spin_lock(&im->ino_lock);
>>  	e = radix_tree_lookup(&im->ino_root, ino);
>> @@ -416,7 +417,8 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>>  		e = tmp;
>>  		if (radix_tree_insert(&im->ino_root, ino, e)) {
>>  			spin_unlock(&im->ino_lock);
>> -			radix_tree_preload_end();
>> +			if (preloaded)
>> +				radix_tree_preload_end();
>>  			goto retry;
>>  		}
>>  		memset(e, 0, sizeof(struct ino_entry));
>> @@ -431,7 +433,9 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
>>  		f2fs_set_bit(devidx, (char *)&e->dirty_device);
>>  
>>  	spin_unlock(&im->ino_lock);
>> -	radix_tree_preload_end();
>> +
>> +	if (preloaded)
>> +		radix_tree_preload_end();
>>  
>>  	if (e != tmp)
>>  		kmem_cache_free(ino_entry_slab, tmp);
>> -- 
>> 2.14.1.145.gb3622a4ee
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
