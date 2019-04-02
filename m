From: Hagbard Celine <hagbardcelin@gmail.com>
Subject: Re: BUG: kernel stack overflow when mounting with
 data_flush
Date: Tue, 2 Apr 2019 14:41:12 +0200
Message-ID: <CADoWrG9V7nD4wzj0DFDAKcjcZHhjC0yPetX_Ce6jj2_YNpU9YA@mail.gmail.com>
References: <CADoWrG_NTz29eyaa3fUti2sNBP4xp7-zfhDVkix=Kty4rD=Otw@mail.gmail.com>
 <35b643e5-562c-942d-67ce-4a9dbef66d16@huawei.com>
 <5725124a-95c8-cedb-d3a8-d8be86d260dd@huawei.com>
 <CADoWrG9_5izaUMvB0mNLC7yp_Mnnm7yPrqcOvDL2ERR2YrkF2A@mail.gmail.com>
 <452dad75-a4aa-2366-b704-ee5448a3bd71@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hagbardcelin@gmail.com>) id 1hBIjB-0003fB-Rp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 12:41:21 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hBIjA-009S8M-E3
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 12:41:21 +0000
Received: by mail-lf1-f68.google.com with SMTP id g7so8867552lfh.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 02 Apr 2019 05:41:20 -0700 (PDT)
In-Reply-To: <452dad75-a4aa-2366-b704-ee5448a3bd71@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

That seems to have fixed it. No more errors in syslog after extracting
my stage3 tarball. Also ran a couple of kernel compiles on a partition
mounted with data_flush and system seems stable.

2019-04-01 10:05 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
> On 2019/3/31 2:54, Hagbard Celine wrote:
>> First, yes it is caused by data_flush, this is what I am trying to
>> report. Without that option there is no "stack guard page was hit" and
>> no "kernel stack overflow" and kernel is stable.
>> This time I was using kernel 5.0.3, as can be seen in the log in my first
>> mail.
>> I do not remember exactly what kernel version I tried the first time a
>> saw this bug, but I believe the mount option data_flush was just added
>> when I tried it the first time. The option has always lead to crash
>> here.
>
> Sorry, out of mind at that time, data_flush key words slip out of my eye...
>
> Could you please try below patch?
>
> From 65edbf14a198d0b50765e10340255e2071f7ae75 Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Mon, 1 Apr 2019 15:59:16 +0800
> Subject: [PATCH] f2fs: fix potential recursive call when enabling
> data_flush
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 6 ++----
>  fs/f2fs/data.c       | 3 ++-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a98e1b02279e..935ebdb9cf47 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1009,13 +1009,11 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi,
> enum inode_type type)
>  	if (inode) {
>  		unsigned long cur_ino = inode->i_ino;
>
> -		if (is_dir)
> -			F2FS_I(inode)->cp_task = current;
> +		F2FS_I(inode)->cp_task = current;
>
>  		filemap_fdatawrite(inode->i_mapping);
>
> -		if (is_dir)
> -			F2FS_I(inode)->cp_task = NULL;
> +		F2FS_I(inode)->cp_task = NULL;
>
>  		iput(inode);
>  		/* We need to give cpu to another writers. */
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d87dfa5aa112..9d3c11e09a03 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2038,7 +2038,8 @@ static int __write_data_page(struct page *page, bool
> *submitted,
>  	}
>
>  	unlock_page(page);
> -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
> +					!F2FS_I(inode)->cp_task)
>  		f2fs_balance_fs(sbi, need_balance_fs);
>
>  	if (unlikely(f2fs_cp_error(sbi))) {
> --
> 2.18.0.rc1
>
>
>
>>
>> 2019-03-30 8:29 GMT+01:00, Chao Yu <yuchao0@huawei.com>:
>>> Oh, sorry, it's quite possible that bug is caused by data_flush, could
>>> remove that mount option first?
>>>
>>> Thanks,
>>>
>>> On 2019/3/30 11:25, Chao Yu wrote:
>>>> Hi Hagbard,
>>>>
>>>> Sorry for the delay.
>>>>
>>>> On 2019/3/27 21:59, Hagbard Celine wrote:
>>>>> Hi, this is a long standing bug that I've hit before on older kernels,
>>>>> but I was not able to get the syslog saved because of the nature of
>>>>> the bug. This time I had booted form a pen-drive, and was able to save
>>>>> the log to it's efi-partition.
>>>>
>>>> Now which version of kernel do you use? and do you remember what is
>>>> your
>>>> kernel version when this bug occured at first time?
>>>>
>> .
>>
>
