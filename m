From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 13/13] f2fs: don't recovery orphan inode on
 readonly device
Date: Mon, 15 Apr 2019 19:31:46 +0800
Message-ID: <dea278b4-4419-c7e4-e73e-84537610cc68@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
 <20190415073054.2577-5-yuchao0@huawei.com>
 <CAD14+f2uV6s6hBfQaQaJPBEAPVOFgEZfueuVPQ_43LpiWS9nZg@mail.gmail.com>
 <a77dc50c-01f0-459b-38de-50f97c129f31@huawei.com>
 <CAD14+f2c7yYbc6hu2gWiHfRUrx0SctMZfc0+9HVk+_0UE+Mkug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD14+f2c7yYbc6hu2gWiHfRUrx0SctMZfc0+9HVk+_0UE+Mkug@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/4/15 19:04, Ju Hyung Park wrote:
> Thanks for the explanation.
> 
> And yes, this patch fixed it, the kernel log is now clean.

Thanks for the quick test. :)

Thanks,

> 
> Thanks!
> 
> [   22.506553] F2FS-fs (loop0): write access unavailable, skipping
> orphan cleanup
> [   22.506555] F2FS-fs (loop0): recover fsync data on readonly fs
> [   22.506556] F2FS-fs (loop0): quota file may be corrupted, skip loading it
> [   22.507015] F2FS-fs (loop0): Mounted with checkpoint version = 26e7ba3e
> 
> On Mon, Apr 15, 2019 at 5:57 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> On 2019/4/15 16:10, Ju Hyung Park wrote:
>>> Hi,
>>>
>>> Thanks for the fix. I'll try this sooner than later.
>>>
>>> One minor request though, can you change
>>> "JuHyung Park <qkrwngud825@gmail.com>"
>>> to
>>> "Park Ju Hyung <qkrwngud825@gmail.com>"?
>>>
>>> That's my preference and I'd like to avoid any inconsistencies.
>>
>> Sure, will update it in next version. :)
>>
>>>
>>> One additional question from reviewing the code surrounding it:
>>> does it really makes sense to cleanup orphan inodes even when the "ro"
>>> mount option is passed?
>>> It's an explicit request from the user not to write to the block device/image.
>>
>> Now, f2fs follows the rule that ext4 kept, you can check codes in
>> ext4_orphan_cleanup()
>>
>>         if (bdev_read_only(sb->s_bdev)) {
>>                 ext4_msg(sb, KERN_ERR, "write access "
>>                         "unavailable, skipping orphan cleanup");
>>                 return;
>>         }
>> ...
>>         if (s_flags & SB_RDONLY) {
>>                 ext4_msg(sb, KERN_INFO, "orphan cleanup on readonly fs");
>>                 sb->s_flags &= ~SB_RDONLY;
>>         }
>>
>> There are two points in above codes:
>> - if block device is readonly, filesystem should not execute any recovery flow
>> which can trigger write IO.
>> - if filesystem was mounted as readonly one, and recovery is needed, it will
>> ignore readonly flag and update data in device for journal recovery during mount.
>>
>> So IMO, readonly mountoption sematics is only try to restrict data/meta update
>> behavior that is triggered by user from mountpoint, but filesystem still can do
>> any updates on a writable device if it needs, mostly like recovery flow.
>>
>> Anyway, if you want to limit any updates on block device, making it readonly
>> will be a good choice. :)
>>
>> Thanks,
>>
>>>
>>> Thanks.
>>>
>>> On Mon, Apr 15, 2019 at 4:31 PM Chao Yu <yuchao0@huawei.com> wrote:
>>>>
>>>> As JuHyung Park reported in mailing list:
>>>>
>>>> https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/
>>>>
>>>> generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
>>>> WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630
>>>>
>>>>  generic_make_request+0x46/0x3d0
>>>>  submit_bio+0x30/0x110
>>>>  __submit_merged_bio+0x68/0x390
>>>>  f2fs_submit_page_write+0x1bb/0x7f0
>>>>  f2fs_do_write_meta_page+0x7f/0x160
>>>>  __f2fs_write_meta_page+0x70/0x140
>>>>  f2fs_sync_meta_pages+0x140/0x250
>>>>  f2fs_write_checkpoint+0x5c5/0x17b0
>>>>  f2fs_sync_fs+0x9c/0x110
>>>>  sync_filesystem+0x66/0x80
>>>>  f2fs_recover_fsync_data+0x790/0xa30
>>>>  f2fs_fill_super+0xe4e/0x1980
>>>>  mount_bdev+0x518/0x610
>>>>  mount_fs+0x34/0x13f
>>>>  vfs_kern_mount.part.11+0x4f/0x120
>>>>  do_mount+0x2d1/0xe40
>>>>  __x64_sys_mount+0xbf/0xe0
>>>>  do_syscall_64+0x4a/0xf0
>>>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> print_req_error: I/O error, dev loop0, sector 4096
>>>>
>>>> If block device is readonly, we should never trigger write IO from
>>>> filesystem layer, but previously, orphan recovery didn't consider
>>>> such condition, result in triggering above warning, fix it.
>>>>
>>>> Reported-by: JuHyung Park <qkrwngud825@gmail.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/checkpoint.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index a7ad1b1e5750..90e1bab86269 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>         if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
>>>>                 return 0;
>>>>
>>>> +       if (bdev_read_only(sbi->sb->s_bdev)) {
>>>> +               f2fs_msg(sbi->sb, KERN_INFO, "write access "
>>>> +                       "unavailable, skipping orphan cleanup");
>>>> +               return 0;
>>>> +       }
>>>> +
>>>>         if (s_flags & SB_RDONLY) {
>>>>                 f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
>>>>                 sbi->sb->s_flags &= ~SB_RDONLY;
>>>> --
>>>> 2.18.0.rc1
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>> .
>>>
> .
> 
