From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH] mkfs.f2fs: avoid dumplicate extension
Date: Sat, 28 Nov 2015 10:45:51 +0800
Message-ID: <5659155F.1080401@huawei.com>
References: <1448643312-28861-1-git-send-email-shengyong1@huawei.com>
	<56585619.4050709@kernel.org> <5658F7CC.7030402@huawei.com>
	<5659120D.7050007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a2VWx-0006HQ-Gy
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 02:46:31 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a2VWs-0007Xh-Nr
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 02:46:31 +0000
In-Reply-To: <5659120D.7050007@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 11/28/2015 10:31 AM, Chao Yu wrote:
> Hi Sheng Yong,
> 
> On 11/28/15 8:39 AM, Sheng Yong wrote:
>>
>> On 11/27/2015 9:09 PM, Chao Yu wrote:
>>> Hi Sheng Yong,
>>>
>>> On 11/28/15 12:55 AM, Sheng Yong wrote:
>>>> Before copying user specified extension to extension_list, check if it is
>>>> already in the list.
>>>>
>>>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>>>> ---
>>>>  mkfs/f2fs_format.c | 23 ++++++++++++++++++++++-
>>>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>> index 176bdea..b7ea19f 100644
>>>> --- a/mkfs/f2fs_format.c
>>>> +++ b/mkfs/f2fs_format.c
>>>> @@ -118,6 +118,26 @@ const char *media_ext_lists[] = {
>>>>  	NULL
>>>>  };
>>>>  
>>>> +static int extension_exist(const char *name, const int len)
>>>
>>> bool is_extension_exist?
>>>
>>>> +{
>>>> +	const char **extlist = media_ext_lists;
>>>> +	int name_len, min_len;
>>>> +	int ret;
>>>> +
>>>> +
>>>> +	while (*extlist) {
>>>> +		name_len = strlen(*extlist);
>>>> +		min_len = name_len < len ? name_len : len;
>>>> +		ret = strncmp(*extlist, name, min_len);
>>>
>>> How about using strcmp(*extlist, name)? It will return 0 only if the two strings
>>> are the same.
>>>
>> Hi, Chao Yu
>>
>> Thanks for your reply. I was considering strcmp may have security issue.
> 
> Could you share details about the security issue of using strcmp?
I was wrong, please ignore this :(

thanks,
Sheng
> 
> Thanks,
> 
>>>> +
>>>> +		if (ret == 0 && name_len == len)
>>>> +			return 1;
>>>> +		extlist++;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static void configure_extension_list(void)
>>>>  {
>>>>  	const char **extlist = media_ext_lists;
>>>> @@ -144,7 +164,8 @@ static void configure_extension_list(void)
>>>>  	ue = strtok(ext_str, ",");
>>>>  	while (ue != NULL) {
>>>>  		name_len = strlen(ue);
>>>
>>> We should verify the length of extension to avoid memcpy overflow. I will send a
>>> patch for fixing.
>> I agree. And I think we should make sure there is a '\0' at the end of each string
>> in extension_list.
>>>
>>>> -		memcpy(sb.extension_list[i++], ue, name_len);
>>>> +		if (!extension_exist(ue, name_len))
>>>
>>> How do you think of comparing extension user defined with sb.extension_list?
>>> In this way, duplication user defined can be avoided completely.
>> Right. I'll send a v2 latter.
>>
>> thanks,
>> Sheng
>>>
>>> Thanks,
>>>
>>>> +			memcpy(sb.extension_list[i++], ue, name_len);
>>>>  		ue = strtok(NULL, ",");
>>>>  		if (i >= F2FS_MAX_EXTENSION)
>>>>  			break;
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 


------------------------------------------------------------------------------
