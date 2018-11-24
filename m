From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check memory boundary by insane namelen
Date: Sat, 24 Nov 2018 17:59:20 +0800
Message-ID: <1d801acd-ed1e-3593-45e6-ad71b27e4c7a@huawei.com>
References: <20181115075040.83500-1-jaegeuk@kernel.org>
 <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d213d40-a4b0-6e60-87b2-81e66866ac4c@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sheng Yong <shengyong1@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Sheng,

On 2018/11/23 20:11, Sheng Yong wrote:
> Hi, Jaegeuk and Chao,
> 
> On 2018/11/15 15:50, Jaegeuk Kim wrote:
>> If namelen is corrupted to have very long value, fill_dentries can copy
>> wrong memory area.
>>
> Is there any scenario that could hit this corruption? Or this is triggered

I didn't see such issue in my test, I guess it may be caused by fuzzing test.

Thanks,

> by fuzzing injection?
> 
> thanks,
> Sheng Yong
> 
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/dir.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index bacc667950b6..c0c845da12fa 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -808,6 +808,17 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>>   		de_name.name = d->filename[bit_pos];
>>   		de_name.len = le16_to_cpu(de->name_len);
>>   
>> +		/* check memory boundary before moving forward */
>> +		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>> +		if (unlikely(bit_pos > d->max)) {
>> +			f2fs_msg(sbi->sb, KERN_WARNING,
>> +				"%s: corrupted namelen=%d, run fsck to fix.",
>> +				__func__, le16_to_cpu(de->name_len));
>> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>>   		if (f2fs_encrypted_inode(d->inode)) {
>>   			int save_len = fstr->len;
>>   
>> @@ -830,7 +841,6 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>>   		if (readdir_ra)
>>   			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
>>   
>> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>>   		ctx->pos = start_pos + bit_pos;
>>   	}
>>   out:
>>
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
