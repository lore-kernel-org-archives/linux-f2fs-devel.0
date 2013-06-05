From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add remount_fs callback support
Date: Wed, 5 Jun 2013 13:34:10 +0900
Message-ID: <CAKYAXd_jFuG00-HWQREKieXdqBGEAs+W0imvYZjCpGAH5S4H9A@mail.gmail.com>
References: <1370071212-7715-1-git-send-email-linkinjeon@gmail.com>
	<51AD698F.3020305@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1Uk5QR-0003J9-Ll
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jun 2013 04:34:19 +0000
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uk5QO-0002K9-KJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jun 2013 04:34:17 +0000
Received: by mail-pb0-f44.google.com with SMTP id wz12so1220932pbc.31
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 04 Jun 2013 21:34:10 -0700 (PDT)
In-Reply-To: <51AD698F.3020305@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

2013/6/4 Gu Zheng <guz.fnst@cn.fujitsu.com>:
> On 06/01/2013 03:20 PM, Namjae Jeon wrote:
>
>> From: Namjae Jeon <namjae.jeon@samsung.com>
>>
>> Add the f2fs_remount function call which will be used
>> during the filesystem remounting. This function
>> will help us to change the mount options specific to
>> f2fs.
>>
>> Also modify the f2fs background_gc mount option, which
>> will allow the user to dynamically trun on/off the
>> garbage collection in f2fs based on the background_gc
>> value. If background_gc=0, Garbage collection will
>> be turned off & if background_gc=1, Garbage collection
>> will be truned on.
>
>
> Hi Namjae,
Hi. Gu.

>   I think splitting these two changes into single ones seems better.
> Refer to the inline comments.
I don't think so. Mount option background_gc is changed to make
remount_fs working in the correct way.

>
> Thanks,
> Gu
>
>
> Though simply option show is enough, but I think the "background_gc=on/off" is more friendly.
Yes, Agree. I will update.

>
>> +
>> +     /**
>> +      * We stop the GC thread if FS is mounted as RO
>> +      * or if background_gc = 0 is passed in mount
>> +      * option. Also sync the filesystem.
>> +      */
>> +     if ((*flags & MS_RDONLY) || !test_opt(sbi, BG_GC)) {
>
>
> Another condition: The old mount is not RO.
I don't think that it is needed. I think current condition check can
be covered about all cases.
Am I missing something ?

>
>> +             stop_gc_thread(sbi);
>> +             f2fs_sync_fs(sb, 1);
>> +     } else if (test_opt(sbi, BG_GC) && !sbi->gc_thread) {
>> +             err = start_gc_thread(sbi);
>> +             if (err)
>> +                     goto restore_opts;
>> +     }
>> +
>> +     /* Update the POSIXACL Flag */
>> +      sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
>> +             (test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
>
>
> Maybe you forget to update the flags with MS_RDONLY or ~MS_RDONLY, if the flags changed.
No, we don't need to check this flags. sb-s_flags will be updated by
MS_REMOUNT of vfs.(do_remount_sb)

>
>> +     return 0;
>> +
>> +restore_opts:
>> +     sb->s_flags = old_sb_flags;
>
>
> There is no need to restore sb->s_flags, parse_options() did not change it.
> no need to store the old sb->s_flags too.
Yes, right, I will update.

>
>>
>> -     /* After POR, we can run background GC thread */
>> -     err = start_gc_thread(sbi);
>> -     if (err)
>> -             goto fail;
>> +     /* After POR, we can run background GC thread.*/
>> +     if (!(sb->s_flags & MS_RDONLY)) {
>> +             /**
>> +              * If filesystem is mounted as read-only then
>> +              * do not start the gc_thread.
>> +              */
>
> It seems that the comment here is against with the logic.
hum.. Okay, I will update comment to avoid some confusion.

Thanks for review :)
I will post v2 patch including your opinion soon.

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
