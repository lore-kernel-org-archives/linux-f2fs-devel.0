From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: enhance lookup xattr
Date: Tue, 7 Feb 2017 15:26:46 +0800
Message-ID: <2b9eb490-238a-1ad6-5a84-3d6eec96cf6b@huawei.com>
References: <20170124123951.114223-1-yuchao0@huawei.com>
	<20170129035831.GA65555@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cb0DC-0006DC-6R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 07:29:14 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cb0D7-0005ZO-Hi
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 07:29:14 +0000
In-Reply-To: <20170129035831.GA65555@jaegeuk.local>
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

On 2017/1/29 11:58, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 01/24, Chao Yu wrote:
> 
> ...
> 
>>  
>> -	error = read_all_xattrs(inode, ipage, &base_addr);
>> +	error = lookup_all_xattrs(inode, ipage, index, len, name,
>> +				&entry, &base_addr);
>>  	if (error)
>>  		return error;
>>  
>> -	entry = __find_xattr(base_addr, index, len, name);
>> -	if (IS_XATTR_LAST_ENTRY(entry)) {
>> -		error = -ENODATA;
>> -		goto cleanup;
>> -	}
>> -
>> -	size = le16_to_cpu(entry->e_value_size);
>> +	size = __le16_to_cpu(entry->e_value_size);
> 
> Looks good to me, except __le16_to_cpu() here.
> Do we need to use this instead of le16_to_cpu()?

Indeed, no needed. :)

Thanks,

> 
> Thanks,
> 
>>  
>>  	if (buffer && size > buffer_size) {
>>  		error = -ERANGE;
>> -		goto cleanup;
>> +		goto out;
>>  	}
>>  
>> +	pval = entry->e_name + entry->e_name_len;
>> +
>>  	if (buffer) {
>>  		char *pval = entry->e_name + entry->e_name_len;
>>  		memcpy(buffer, pval, size);
>>  	}
>>  	error = size;
>> -
>> -cleanup:
>> +out:
>>  	kzfree(base_addr);
>>  	return error;
>>  }
>> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
>> index f990de20cdcd..d5a94928c116 100644
>> --- a/fs/f2fs/xattr.h
>> +++ b/fs/f2fs/xattr.h
>> @@ -72,9 +72,10 @@ struct f2fs_xattr_entry {
>>  		for (entry = XATTR_FIRST_ENTRY(addr);\
>>  				!IS_XATTR_LAST_ENTRY(entry);\
>>  				entry = XATTR_NEXT_ENTRY(entry))
>> -
>> -#define MIN_OFFSET(i)	XATTR_ALIGN(inline_xattr_size(i) + PAGE_SIZE -	\
>> -				sizeof(struct node_footer) - sizeof(__u32))
>> +#define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
>> +#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
>> +#define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
>> +						VALID_XATTR_BLOCK_SIZE)
>>  
>>  #define MAX_VALUE_LEN(i)	(MIN_OFFSET(i) -			\
>>  				sizeof(struct f2fs_xattr_header) -	\
>> -- 
>> 2.8.2.295.g3f1c1d0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
