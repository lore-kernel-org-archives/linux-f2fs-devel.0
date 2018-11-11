From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: Patch "Revert "f2fs: fix to clear PG_checked flag in
 set_page_dirty()"" has been added to the 4.18-stable tree
Date: Sun, 11 Nov 2018 18:14:34 +0900
Message-ID: <CAD14+f3Sxpk01nRmOVG9Zxu4U15GD6=xstuVYevi3m7z7vmXqA@mail.gmail.com>
References: <154190097675163@kroah.com>
 <CAD14+f1scE6Xuurjx+UrBwyrR7x6PG6w6kzoxWoVVUJ5QBJ8Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1gLlpp-0005jI-D0
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Nov 2018 09:15:13 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gLlpa-005oAY-0V
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Nov 2018 09:15:13 +0000
Received: by mail-vs1-f67.google.com with SMTP id 124so3443193vsp.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Nov 2018 01:14:57 -0800 (PST)
In-Reply-To: <CAD14+f1scE6Xuurjx+UrBwyrR7x6PG6w6kzoxWoVVUJ5QBJ8Ow@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: gregkh@linuxfoundation.org, stable-commits@vger.kernel.org

Hi,

This bug was present only in 4.19.
Is it still applicable to older branches?

Thanks.
On Sun, Nov 11, 2018 at 6:13 PM Ju Hyung Park <qkrwngud825@gmail.com> wrote:
>
> Hi,
>
> This bug was present only in 4.19.
> Is it still applicable to older branches?
>
> Thanks.
>
> On Sun, Nov 11, 2018, 12:26 PM <gregkh@linuxfoundation.org wrote:
>>
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
>>
>> to the 4.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      revert-f2fs-fix-to-clear-pg_checked-flag-in-set_page_dirty.patch
>> and it can be found in the queue-4.18 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>> From 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 Mon Sep 17 00:00:00 2001
>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>> Date: Tue, 16 Oct 2018 19:30:13 -0700
>> Subject: Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
>>
>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> commit 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 upstream.
>>
>> This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.
>>
>> If we clear the cold data flag out of the writeback flow, we can miscount
>> -1 by end_io, which incurs a deadlock caused by all I/Os being blocked during
>> heavy GC.
>>
>> Balancing F2FS Async:
>>  - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...
>>
>> GC thread:                              IRQ
>> - move_data_page()
>>  - set_page_dirty()
>>   - clear_cold_data()
>>                                         - f2fs_write_end_io()
>>                                          - type = WB_DATA_TYPE(page);
>>                                            here, we get wrong type
>>                                          - dec_page_count(sbi, type);
>>  - f2fs_wait_on_page_writeback()
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-and-Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> ---
>>  fs/f2fs/data.c |    4 ----
>>  1 file changed, 4 deletions(-)
>>
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2501,10 +2501,6 @@ static int f2fs_set_data_page_dirty(stru
>>         if (!PageUptodate(page))
>>                 SetPageUptodate(page);
>>
>> -       /* don't remain PG_checked flag which was set during GC */
>> -       if (is_cold_data(page))
>> -               clear_cold_data(page);
>> -
>>         if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>>                 if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>>                         f2fs_register_inmem_page(inode, page);
>>
>>
>> Patches currently in stable-queue which might be from jaegeuk@kernel.org are
>>
>> queue-4.18/f2fs-fix-to-recover-inode-s-i_flags-during-por.patch
>> queue-4.18/f2fs-fix-to-recover-inode-s-crtime-during-por.patch
>> queue-4.18/f2fs-fix-to-account-io-correctly-for-cgroup-writeback.patch
>> queue-4.18/f2fs-fix-to-recover-cold-bit-of-inode-block-during-por.patch
>> queue-4.18/revert-f2fs-fix-to-clear-pg_checked-flag-in-set_page_dirty.patch
>> queue-4.18/f2fs-clear-pageerror-on-the-read-path.patch
>> queue-4.18/f2fs-report-error-if-quota-off-error-during-umount.patch
>> queue-4.18/f2fs-fix-to-account-io-correctly.patch
>> queue-4.18/f2fs-avoid-sleeping-under-spin_lock.patch
