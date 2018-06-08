From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: do not print content beyond
 sb->version
Date: Fri, 8 Jun 2018 13:13:56 +0800
Message-ID: <123a45fd-eb44-85c1-08e0-d5c827c973f0@huawei.com>
References: <20180606143924.154725-1-zhengjunling@huawei.com>
 <70bd1c39-6f90-8afd-84a9-28bfa167e787@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fR9jF-0003y0-NW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 05:14:25 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fR9jD-002NI5-MB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 05:14:25 +0000
In-Reply-To: <70bd1c39-6f90-8afd-84a9-28bfa167e787@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/7 18:53, Chao Yu wrote:
> On 2018/6/6 22:39, Junling Zheng wrote:
>> Currently, versions in f2fs_configuration have one more byte than
>> those in sb, so versions in sb may not end with '\0', and then
>> print_raw_sb_info() will print something beyond sb->version.
>>
>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>> ---
>>  fsck/mount.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fsck/mount.c b/fsck/mount.c
>> index 0a30adb..9def919 100644
>> --- a/fsck/mount.c
>> +++ b/fsck/mount.c
>> @@ -341,7 +341,10 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
>>  	DISP_u32(sb, node_ino);
>>  	DISP_u32(sb, meta_ino);
>>  	DISP_u32(sb, cp_payload);
>> -	DISP("%s", sb, version);
>> +	if (sb->version[255] != '\0')
>> +		DISP("%-.256s", sb, version);
>> +	else
>> +		DISP("%s", sb, version);
> 
> IMO, DISP("%-.256s", sb, version) is enough.
> 

Yeah, it works :)

Thanks,

> Thanks,
> 
>>  	printf("\n");
>>  }
>>  
>>
> 
> 
> .
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
