From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: turn quota off when error occurs
Date: Mon, 23 Oct 2017 18:12:08 +0800
Message-ID: <46f69cf8-a958-7071-d0a3-e8adc46e12b9@kernel.org>
References: <20171020155337.5354-1-jaegeuk@kernel.org>
 <d150c646-64fd-84a0-4fc7-837b9efcb85e@kernel.org>
 <20171022160138.GA33480@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171022160138.GA33480@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/23 0:01, Jaegeuk Kim wrote:
> On 10/22, Chao Yu wrote:
>> On 2017/10/20 23:53, Jaegeuk Kim wrote:
>>> Before changing readonly, it needs to turn quota off.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/checkpoint.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 201608281681..ff74665d7f2d 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -29,6 +29,7 @@ struct kmem_cache *inode_entry_slab;
>>>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>>>  {
>>>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>> +	f2fs_quota_off_umount(sb);
>>>  	sbi->sb->s_flags |= MS_RDONLY;
>>>  	if (!end_io)
>>
>> Oh, f2fs_stop_checkpoint can be called from end_io, how about adding
>> f2fs_quota_off_umount here?
> 
> Agreed.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/checkpoint.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 201608281681..b38b1ae59124 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -29,9 +29,13 @@ struct kmem_cache *inode_entry_slab;
>  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
>  {
>  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> -	sbi->sb->s_flags |= MS_RDONLY;
> -	if (!end_io)
> +	if (!end_io) {
> +		f2fs_quota_off_umount(sbi->sb);
> +		sbi->sb->s_flags |= MS_RDONLY;
>  		f2fs_flush_merged_writes(sbi);
> +	} else {
> +		sbi->sb->s_flags |= MS_RDONLY;
> +	}
>  }
>  
>  /*
> 
