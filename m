From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to show encrypt flag in FS_IOC_GETFLAGS
Date: Tue, 3 Apr 2018 15:14:40 +0800
Message-ID: <3f76800a-8b68-b378-8b03-c14248966be4@huawei.com>
References: <20180402102446.32832-1-yuchao0@huawei.com>
 <20180402202105.GB19195@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402202105.GB19195@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/3 4:21, Jaegeuk Kim wrote:
> On 04/02, Chao Yu wrote:
>> This patch fixes to show encrypt flag in FS_IOC_GETFLAGS like ext4 does.
> 
> Actually, we have to show internal flags owned by f2fs, not generic ones.
> We may need to define all of them separately?

Agreed, I wrote a patch, could check that? and in that patch, do we need to
delete flag definition f2fs don't use?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 8068b015ece5..271fadadaa36 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1584,8 +1584,13 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>>  {
>>  	struct inode *inode = file_inode(filp);
>>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>> -	unsigned int flags = fi->i_flags &
>> -			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
>> +	unsigned int flags = fi->i_flags;
>> +
>> +	if (file_is_encrypt(inode))
>> +		flags |= FS_ENCRYPT_FL;
>> +
>> +	flags &= FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL;
>> +
>>  	return put_user(flags, (int __user *)arg);
>>  }
>>  
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 
