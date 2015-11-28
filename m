From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH V3 2/2] mkfs.f2fs: avoid dumplicate
	extensions
Date: Sat, 28 Nov 2015 12:19:24 +0800
Message-ID: <56592B4C.1080100@huawei.com>
References: <1448705988-29484-1-git-send-email-shengyong1@huawei.com>
	<1448705988-29484-2-git-send-email-shengyong1@huawei.com>
	<56591A80.8030709@huawei.com> <565926D0.7050600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1a2WzP-0006yU-5b
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 04:19:59 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a2WzM-0003rf-0Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 04:19:59 +0000
In-Reply-To: <565926D0.7050600@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net



On 11/28/2015 12:00 PM, Chao Yu wrote:
> On 11/28/15 11:07 AM, Sheng Yong wrote:
>> Before copying an user specified extension to extension_list, check if it
>> is already in the list.
>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>  mkfs/f2fs_format.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 176bdea..0a621ae 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -118,6 +118,21 @@ const char *media_ext_lists[] = {
>>  	NULL
>>  };
>>
>> +static bool is_extension_exist(const char *name, const int len)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0; i < F2FS_MAX_EXTENSION; i++) {
> 
> i < last_extension_position_in_list ?
Then we have to define a new global variable or add a new parameter
to pass the last position in the function.
> 
>> +		char *ext = (char *) sb.extension_list[i];
>> +		ret = strcmp(ext, name);
> 
> if (!strcmp(ext, name))
> 	return 1;
> 
>> +
>> +		if (ret == 0)
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static void configure_extension_list(void)
>>  {
>>  	const char **extlist = media_ext_lists;
>> @@ -143,8 +158,14 @@ static void configure_extension_list(void)
>>  	/* add user ext list */
>>  	ue = strtok(ext_str, ",");
>>  	while (ue != NULL) {
>> +		strtrim(&ue);
>>  		name_len = strlen(ue);
>> -		memcpy(sb.extension_list[i++], ue, name_len);
>> +		if (name_len > 7) {
> 
> Shouldn't this be fixed in another patch?
This is much better than what I did :)

thanks,
Sheng
> 
> How about:
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 176bdea..78612e4 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -144,7 +144,12 @@ static void configure_extension_list(void)
>  	ue = strtok(ext_str, ",");
>  	while (ue != NULL) {
>  		name_len = strlen(ue);
> +		if (name_len >= 8) {
> +			MSG(0, "\tWarn: Extension name (%s) is too long\n", ue);
> +			goto next;
> +		}
>  		memcpy(sb.extension_list[i++], ue, name_len);
> +next:
>  		ue = strtok(NULL, ",");
>  		if (i >= F2FS_MAX_EXTENSION)
>  			break;
> 
> Thanks,
> 
>> +			MSG(0, "\tError: Extension '%s' too long\n", ue);
>> +			exit(1);
>> +		}
>> +		if (!is_extension_exist(ue, name_len))
>> +			memcpy(sb.extension_list[i++], ue, name_len);
>>  		ue = strtok(NULL, ",");
>>  		if (i >= F2FS_MAX_EXTENSION)
>>  			break;
>>
> 
> .
> 


------------------------------------------------------------------------------
