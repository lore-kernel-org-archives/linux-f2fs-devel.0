From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] libf2fs: fix to detect stat() failure
Date: Tue, 22 Jan 2019 20:03:53 +0800
Message-ID: <6e72fb81-4eb6-8def-c286-afa18324ee10@huawei.com>
References: <20181210101333.111826-1-yuchao0@huawei.com>
 <20190108234600.GA55897@jaegeuk-macbookpro.roam.corp.google.com>
 <33b6e171-a915-dd7b-b825-84151ca6b608@huawei.com>
 <20190109044206.GC55897@jaegeuk-macbookpro.roam.corp.google.com>
 <a9f4ae37-1b48-1b5a-31a8-e60f642a5200@huawei.com>
 <20190121033702.GA70751@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1glumn-00063Y-W0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Jan 2019 12:04:09 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gluml-004zue-NC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Jan 2019 12:04:09 +0000
In-Reply-To: <20190121033702.GA70751@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/1/21 11:37, Jaegeuk Kim wrote:
> On 01/09, Chao Yu wrote:
>> On 2019/1/9 12:42, Jaegeuk Kim wrote:
>>> On 01/09, Chao Yu wrote:
>>>> On 2019/1/9 7:46, Jaegeuk Kim wrote:
>>>>> On 12/10, Chao Yu wrote:
>>>>>> stat() can fail due to a lot of reasons, let f2fs_dev_is_umounted()
>>>>>> detect such error and handle it correctly.
>>>>>>
>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>> ---
>>>>>>  lib/libf2fs.c | 9 ++++++++-
>>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>>>>>> index c692bf2da635..6a1040feff32 100644
>>>>>> --- a/lib/libf2fs.c
>>>>>> +++ b/lib/libf2fs.c
>>>>>> @@ -713,7 +713,14 @@ int f2fs_dev_is_umounted(char *path)
>>>>>>  	st_buf = malloc(sizeof(struct stat));
>>>>>>  	ASSERT(st_buf);
>>>>>>  
>>>>>> -	if (stat(path, st_buf) == 0 && S_ISBLK(st_buf->st_mode)) {
>>>>>> +	ret = stat(path, st_buf);
>>>>>
>>>>> We have to allow creating non-existing image file to build userdata.img. Can we
>>>>> check its errno?
>>>>
>>>> You mean sload flow? so how about?
>>>
>>> mkfs.f2fs on non-existing image file?
>>
>> That's not allowed as e2fsprogs does?
> 
> I'm not sure it's spec tho, this patch breaks android build which looks like
> regression. Do we have any issue to fix with this patch?

No, I think you can remove this patch to make build passed.

Thanks,

> 
>>
>> mkfs.ext4 /home/image/img
>> mke2fs 1.44.4 (18-Aug-2018)
>> The file /home/image/img does not exist and no size was specified.
>>
>>>
>>>>
>>>> if (ret) {
>>>> 	if (errno == ENOENT && c.func == SLOAD)
>>>> 		return 0;
>>>> 	MSG(0, "\tError: stat %s failed!\n", path);
>>>> 	free(st_buf);
>>>> 	return -1;
>>>> }
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>> +	if (ret) {
>>>>>> +		MSG(0, "\tError: stat %s failed!\n", path);
>>>>>> +		free(st_buf);
>>>>>> +		return -1;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (S_ISBLK(st_buf->st_mode)) {
>>>>>>  		int fd = open(path, O_RDONLY | O_EXCL);
>>>>>>  
>>>>>>  		if (fd >= 0) {
>>>>>> -- 
>>>>>> 2.18.0.rc1
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>
> 
> .
> 
