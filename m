From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: enable inline_xattr by default
Date: Wed, 15 Feb 2017 10:26:36 +0800
Message-ID: <07aa0a06-b637-6588-c0d2-402134921ec0@huawei.com>
References: <20170208093945.24681-1-yuchao0@huawei.com>
	<20170214003502.GB14533@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cdpIu-0003UQ-Ns
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 02:26:48 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cdpIs-0001Ws-Ob
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 02:26:48 +0000
In-Reply-To: <20170214003502.GB14533@jaegeuk.local>
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

Hi Jaegeuk,

On 2017/2/14 8:35, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 02/08, Chao Yu wrote:
>> In android, since SElinux is enable, security policy will be appliedd for
>> each file, it stores in inode as an xattr entry, so it will take one 4k
>> size node block additionally for each file.
>>
>> Let's enable inline_xattr by default in order to save storage space.
> 
> Then, we need to add "noinline_xattr".

OK, let me introduce the new option in another patch.

Thanks,

> 
> Thanks,
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 68a555b014cf..e2f919d3096a 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1026,6 +1026,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>  	sbi->active_logs = NR_CURSEG_TYPE;
>>  
>>  	set_opt(sbi, BG_GC);
>> +	set_opt(sbi, INLINE_XATTR);
>>  	set_opt(sbi, INLINE_DATA);
>>  	set_opt(sbi, INLINE_DENTRY);
>>  	set_opt(sbi, EXTENT_CACHE);
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
