From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to restore whint_mode in ->remount_fs
Date: Thu, 1 Mar 2018 10:54:54 +0800
Message-ID: <7b8a2429-974d-e6d0-f5cc-9bd12a09ebf9@huawei.com>
References: <20180228140120.8758-1-chao@kernel.org>
 <20180301024515.GB18665@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301024515.GB18665@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2018/3/1 10:45, Jaegeuk Kim wrote:
> On 02/28, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> If we fail in ->remount_fs, it needs to restore old whint_mode as other
>> mount options.
>>
>> Fixes: e25afe01822f ("f2fs: support passing down write hints given by users to block layer")
> 
> Hi Chao,
> 
> It was not merged, so please allow me to integrate this into the original
> patch.

No problem, please go ahead. ;)

Thanks,

> 
> Thanks,
> 
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/super.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 89abe4087e66..8a93f78efca2 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1512,6 +1512,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>  		sbi->s_qf_names[i] = s_qf_names[i];
>>  	}
>>  #endif
>> +	sbi->whint_mode = old_whint_mode;
>>  	sbi->mount_opt = org_mount_opt;
>>  	sbi->active_logs = active_logs;
>>  	sb->s_flags = old_sb_flags;
>> -- 
>> 2.14.1.145.gb3622a4ee
> 
> .
> 
