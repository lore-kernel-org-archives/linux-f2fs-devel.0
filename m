From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: include seq_file.h for sysfs.c
Date: Tue, 18 Jul 2017 09:23:52 +0800
Message-ID: <aeca2d4a-0f4a-a899-a4dd-19a3ae49083a@huawei.com>
References: <20170714010138.68665-1-jaegeuk@kernel.org>
 <8fe6971d-a71b-7641-de71-cd68adff2b74@kernel.org>
 <20170717165504.GA81128@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717165504.GA81128@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/18 0:55, Jaegeuk Kim wrote:
> On 07/17, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/7/14 9:01, Jaegeuk Kim wrote:
>>> This patch includes seq_file.h to avoid compile error.
>>
>> I didn't hit the error, I guess that's because we have included f2fs_fs.h
>> in sysfs.c, the inclusion relation is like this:
>> - sysfs.c
>>  - f2fs_fs.h
>>   - pagemap.h
>>    - fs.h
>>     - struct seq_file
> 
> What about seq ops such as seq_puts?

- sysfs.c
 - segment.h
  - linux/backing-dev.h
   - linux/writeback.h
#ifdef CONFIG_CGROUP_WRITEBACK
    - linux/cgroup.h
     - linux/seq_file.h
#endif

So it looks that there is no compiling error in my environment because
of CONFIG_CGROUP_WRITEBACK was defined.

Anyway, please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/sysfs.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 9adc202fcd6f..71191d89917d 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -11,6 +11,7 @@
>>>   */
>>>  #include <linux/proc_fs.h>
>>>  #include <linux/f2fs_fs.h>
>>> +#include <linux/seq_file.h>
>>>  
>>>  #include "f2fs.h"
>>>  #include "segment.h"
>>>
> 
> .
> 
