From: cgxu519 <cgxu519@gmx.com>
Subject: Re: [PATCH] f2fs: remove default option setting in
 remount
Date: Thu, 20 Sep 2018 07:54:10 +0800
Message-ID: <53b1fc54-5827-1506-b081-328505f15dff@gmx.com>
References: <20180918062344.3102-1-cgxu519@gmx.com>
 <9bc59ef2-01cc-0cf1-1676-4d8a75514aad@kernel.org>
 <a8cdaf63-c5fd-9391-2411-b61c8941351e@gmx.com>
 <13e22905-22e6-2048-c6b7-5f573380f189@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g2mIh-00021s-01
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 23:54:31 +0000
Received: from mout.gmx.net ([212.227.17.22])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g2mIe-006DBL-VI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 23:54:30 +0000
In-Reply-To: <13e22905-22e6-2048-c6b7-5f573380f189@kernel.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 9/19/18 10:02 PM, Chao Yu wrote:
> On 2018/9/18 21:47, cgxu519 wrote:
>> On 09/18/2018 09:20 PM, Chao Yu wrote:
>>> On 2018/9/18 14:23, Chengguang Xu wrote:
>>>> Currently we set default value to options before parsing remount options,
>>>> it will cause unexpected change of options which were specified in first
>>>> mount.
>>> Can you check below commit? It looks w/o it we may lose default option after
>>> remount.
>>>
>>> 498c5e9fcd10 ("f2fs: add default mount options to remount")
>> Hi Chao,
> Hi Chengguang,
>
>> It looks like there was a bug in remount at that time, but I think the fix above
>> is not correct.
>>
>> from the patch '498c5e9fcd10', I think it was caused by clearing
>> sbi->mount_opt.opt before
>>
>> parsing. I think remount should not change the options which were specified by
>> user in
>>
>> previous mount unless user specifies in remount.
> Can you check description in manual of mount.
>
> IIRC, old mount option will be record into /etc/mtab or /proc/mounts (for
> adapting namespace feature), with command of "mount -o remount,rw  /dir", old
> mount options can be loaded from above config file, and merge them with new
> specified options.
>
> Even we kill old mount options by call default_options() in ->remount, user's
> old mount option can still be set through parameters.

Please let me show you different behaviors before/after this patch.


[root@x201 cgxu]# uname -a
Linux x201 4.19.0-rc2+ #51 SMP Wed Sep 19 22:41:20 CST 2018 x86_64 
x86_64 x86_64 GNU/Linux


Before:

[root@x201 cgxu]# mount -o fsync_mode=strict /dev/mapper/test-test1 
/mnt/test/test1
[root@x201 cgxu]# mount | grep test1
/dev/mapper/test-test1 on /mnt/test/test1 type f2fs 
(rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,fsync_mode=strict)

[root@x201 cgxu]# mount -o remount,background_gc=sync 
/dev/mapper/test-test1 /mnt/test/test1
[root@x201 cgxu]# mount | grep test1
/dev/mapper/test-test1 on /mnt/test/test1 type f2fs 
(rw,relatime,background_gc=sync,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,fsync_mode=posix)


I only changed background_gc in ->remount, but fsync_mode is implicitly 
set to default value 'posix'.

After:

[root@x201 linus]# mount -o fsync_mode=strict /dev/mapper/test-test1 
/mnt/test/test1
[root@x201 linus]# mount | grep test1
/dev/mapper/test-test1 on /mnt/test/test1 type f2fs 
(rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,fsync_mode=strict)

[root@x201 linus]# mount -o remount,background_gc=sync 
/dev/mapper/test-test1 /mnt/test/test1
[root@x201 linus]# mount | grep test1
/dev/mapper/test-test1 on /mnt/test/test1 type f2fs 
(rw,relatime,background_gc=sync,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,fsync_mode=strict)

This time fysnc_mode looks fine.

>
> But the problem here is, some old parameter can be configured via sysfs, if we
> reset them in default_options(), we will lose them forever after remount.
>
> If you have no other opinion about this, could you adapt your commit log?
>
