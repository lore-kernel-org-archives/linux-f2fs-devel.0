From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] f2fs: Replace strncpy with memcpy
Date: Sun, 1 Jul 2018 19:16:37 -0700
Message-ID: <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
 <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1fZoOW-00068O-5R
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 02:16:48 +0000
Received: from mail-pl0-f67.google.com ([209.85.160.67])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fZoOT-00EW49-UY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 02:16:48 +0000
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so7158162plo.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Jul 2018 19:16:45 -0700 (PDT)
In-Reply-To: <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/01/2018 06:53 PM, Chao Yu wrote:
> On 2018/7/2 4:57, Guenter Roeck wrote:
>> gcc 8.1.0 complains:
>>
>> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
>> fs/f2fs/namei.c:257:3: warning:
>> 	'strncpy' output truncated before terminating nul copying
>> 	as many bytes from a string as its length
>> fs/f2fs/namei.c:249:3: warning:
>> 	'strncpy' output truncated before terminating nul copying
>> 	as many bytes from a string as its length
>>
>> Using strncpy() is indeed less than perfect since the length of data to
>> be copied has already been determined with strlen(). Replace strncpy()
>> with memcpy() to address the warning and optimize the code a little.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   fs/f2fs/namei.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 231b7f3ea7d3..e75607544f7c 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
>>   		return -EINVAL;
>>   
>>   	if (hot) {
>> -		strncpy(extlist[count], name, strlen(name));
>> +		memcpy(extlist[count], name, strlen(name));
> 
> How about replacing with strcpy(extlist[count], name)? Because name length has
> already been checked before f2fs_update_extension_list, it should be valid, and
> will not cause overflow during copying.
> 

Your call; feel free to submit an alternative. Since it is different files, static
analysis might not know and complain, though. You might want to make sure that this
doesn't happen, and also add a comment explaining the reason for using strcpy().

Thanks,
Guenter

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
