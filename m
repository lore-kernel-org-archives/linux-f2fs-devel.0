From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: relax permission for atomic/volatile
 ioctls
Date: Fri, 7 Jul 2017 08:58:05 +0800
Message-ID: <6929112f-e8f2-8fe2-bb13-7a7ebcdbf7db@kernel.org>
References: <20170706022326.52594-1-jaegeuk@kernel.org>
 <8346aeca-c28b-e5b9-5973-b5648b015c88@kernel.org>
 <20170707001609.GA8300@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707001609.GA8300@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/7 8:16, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> On 2017/7/6 10:23, Jaegeuk Kim wrote:
>>> This patch allows atomic/volatile ioctls for sqlite under sdcardfs.
>>
>> Out of curiosity, we will lose some capable when passing through sdcardfs?
> 
> I don't think so. But, it seems a test applicaion tries to access database from
> difference uid.

Oh, is that really allowed? if the sqlite database is public in sdcard directory,
application needs to apply WRITE_EXTERNAL_STORAGE in order to add itself to
sdcard_rw group, then it can access the database. Right?

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>> ---
>>>  fs/f2fs/file.c | 15 ---------------
>>>  1 file changed, 15 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index f5d6357e8360..dd8f5d2caa48 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1587,9 +1587,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>>  
>>> -	if (!inode_owner_or_capable(inode))
>>> -		return -EACCES;
>>> -
>>>  	if (!S_ISREG(inode->i_mode))
>>>  		return -EINVAL;
>>>  
>>> @@ -1636,9 +1633,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>>  
>>> -	if (!inode_owner_or_capable(inode))
>>> -		return -EACCES;
>>> -
>>>  	ret = mnt_want_write_file(filp);
>>>  	if (ret)
>>>  		return ret;
>>> @@ -1672,9 +1666,6 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>>  
>>> -	if (!inode_owner_or_capable(inode))
>>> -		return -EACCES;
>>> -
>>>  	if (!S_ISREG(inode->i_mode))
>>>  		return -EINVAL;
>>>  
>>> @@ -1707,9 +1698,6 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>>  
>>> -	if (!inode_owner_or_capable(inode))
>>> -		return -EACCES;
>>> -
>>>  	ret = mnt_want_write_file(filp);
>>>  	if (ret)
>>>  		return ret;
>>> @@ -1736,9 +1724,6 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
>>>  	struct inode *inode = file_inode(filp);
>>>  	int ret;
>>>  
>>> -	if (!inode_owner_or_capable(inode))
>>> -		return -EACCES;
>>> -
>>>  	ret = mnt_want_write_file(filp);
>>>  	if (ret)
>>>  		return ret;
>>>
