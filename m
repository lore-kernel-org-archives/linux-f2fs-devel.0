From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: fix to restrict mount condition
 when without CONFIG_QUOTA
Date: Thu, 26 Jul 2018 09:53:26 +0800
Message-ID: <0b69dfb2-098d-c986-9cdf-f6eac08cba76@huawei.com>
References: <20180725231948.18075-1-chao@kernel.org>
 <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sheng Yong <shengyong1@huawei.com>, Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/26 9:41, Sheng Yong wrote:
> Hi, Chao
> 
> On 2018/7/26 7:19, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Like quota_ino feature, we need to reject mounting RDWR with image
>> which enables project_quota feature when there is no CONFIG_QUOTA
>> be set in kernel.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/super.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index dbc1cb53581f..bc7c14a055bb 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>>   			 "without CONFIG_QUOTA");
>>   		return -EINVAL;
>>   	}
> 
> I think the following should be checked within !CONFIG_QUOTA, like patch "f2fs: quota: do
> not mount as RDWR without QUOTA if quota feature enabled" :)

I wrote this patch based on yours, so I think the code actually locates in the
right place. Please check serials on below link:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=f2fs-dev

> 
> thanks
> 
>> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
>> +		f2fs_msg(sb, KERN_ERR,
>> +			"Filesystem with project quota feature cannot be "
>> +			"mounted RDWR without CONFIG_QUOTA");
>> +		return -EINVAL;
>> +	}
>>   #endif
>>   
>>   	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
>>
> 
> 
> .
> 
