From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 5/6] f2fs: enable inline_dentry by default
Date: Mon, 22 Aug 2016 09:49:13 +0800
Message-ID: <0eea4e00-aa6a-8ea0-db9e-3d289c7fb20b@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
 <20160509115635.123946-5-yuchao0@huawei.com>
 <20160509230451.GB7448@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509230451.GB7448@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/5/10 7:04, Jaegeuk Kim wrote:
> On Mon, May 09, 2016 at 07:56:34PM +0800, Chao Yu wrote:
>> Make inline_dentry as default mount option to improve space usage and
>> IO performance in scenario of numerous small directory.
> 
> Hmm, I've not much tested this so far.
> Let me take time to consider this for a while.

IMO, this feature is almost stable since I fixed most of bugs which occurs
during inline conversion. And now I enable this feature by default when I do the
test with fstest suit and fsstress, I didn't find any more bugs reported by
those test tools.

How do you think of enabling inline_dentry by default now?

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
>> index 28c8992..4a4f4bd 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -824,6 +824,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>  
>>  	set_opt(sbi, BG_GC);
>>  	set_opt(sbi, INLINE_DATA);
>> +	set_opt(sbi, INLINE_DENTRY);
>>  	set_opt(sbi, EXTENT_CACHE);
>>  
>>  #ifdef CONFIG_F2FS_FS_XATTR
>> -- 
>> 2.8.2.311.gee88674
> .
> 
