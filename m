From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
Date: Wed, 24 Apr 2019 20:45:03 +0800
Message-ID: <8919a08e-a548-7bd8-c43e-99596e33ca97@kernel.org>
References: <20190415072219.1613-1-yuchao0@huawei.com>
 <20190424091456.GB38756@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424091456.GB38756@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-4-24 17:14, Jaegeuk Kim wrote:
> On 04/15, Chao Yu wrote:
>> This patch adds tracepoint for f2fs_filemap_fault().
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix wrong type of @ret parameter
>>  fs/f2fs/file.c              |  2 ++
>>  include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 30d49467578e..578486e03427 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -39,6 +39,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>>  	ret = filemap_fault(vmf);
>>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>>  
>> +	trace_f2fs_filemap_fault(inode, vmf->pgoff, ret);
> 
> In order to avoid wrong casting warning, how about this?

Confirmed, I used wrong type in v2, thanks for fixing this.

Thanks,

> 
> ---
>  include/trace/events/f2fs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index abe763cc1d0b..c29dea7ac0fe 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1286,7 +1286,7 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
>  
>  TRACE_EVENT(f2fs_filemap_fault,
>  
> -	TP_PROTO(struct inode *inode, pgoff_t index, enum vm_fault_reason ret),
> +	TP_PROTO(struct inode *inode, pgoff_t index, vm_fault_t ret),
>  
>  	TP_ARGS(inode, index, ret),
>  
> @@ -1294,7 +1294,7 @@ TRACE_EVENT(f2fs_filemap_fault,
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
>  		__field(pgoff_t, index)
> -		__field(enum vm_fault_reason, ret)
> +		__field(vm_fault_t, ret)
>  	),
>  
>  	TP_fast_assign(
> @@ -1304,10 +1304,10 @@ TRACE_EVENT(f2fs_filemap_fault,
>  		__entry->ret	= ret;
>  	),
>  
> -	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %u",
> +	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
> -		ret)
> +		(unsigned long)__entry->ret)
>  );
>  
>  TRACE_EVENT(f2fs_writepages,
> 
