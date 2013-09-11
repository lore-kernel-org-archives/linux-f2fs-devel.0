From: Jin Xu <jinuxstyle@gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better performance
Date: Thu, 12 Sep 2013 07:55:50 +0800
Message-ID: <52310306.3020909@gmail.com>
References: <04.C0.13361.61DDA225@epcpsbge5.samsung.com> <1378774750.2354.110.camel@kjgkr> <522FE1FF.9010901@cn.fujitsu.com> <CAGfvh63mWMq4-eajOZVXqBDW3judq28DYmnrTCdFRM+N8t_S8w@mail.gmail.com> <CAOtxgyc7QOPERiyWyXO6cSHgvo1d4GxGs4RrCR1NssRcCqi73A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOtxgyc7QOPERiyWyXO6cSHgvo1d4GxGs4RrCR1NssRcCqi73A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Jaegeuk <jaegeuk.kim@gmail.com>
Cc: Russ Knize <Russ.Knize@motorola.com>, Gu Zheng <guz.fnst@cn.fujitsu.com>, =?UTF-8?B?6LCt5aed?= <shu.tan@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On 11/09/2013 21:19, Kim Jaegeuk wrote:
> Hi Russ,
>
> The usage of fs_locks is for the recovery, so it doesn't matter
> with stress-testing.
> Actually what I've concerned is that we should not grab two or
> more fs_locks in the same call path.
> Thanks,
>

I am wondering why we don't use other kind of methods like r/w semaphor=
e
instead of the fs_locks for access control purpose. Is it due to the
little lower performance of r/w semaphore or other reasons?

I think the r/w semaphore can bring more clearer access control over
the current fs_locks, and will not suffer the problems reported here.
It can be used in a way that i/o tasks just acquire read sem while the
checkpoint task takes the write sem.

Or do we have other better method?

Regards,
Jin

> 2013/9/11 Russ Knize <Russ.Knize@motorola.com>:
>> Hi Jaegeuk/Gu,
>>
>> I've removed the lock and have been stress-testing with SELinux and =
some
>> additional xattr torture for 24+ hours.  I have not encountered any =
issues
>> yet.
>>
>> My previous suggestion about moving the lock is probably not a good =
idea
>> without some significant code rework (thanks to the f2fs_balance_fs =
call in
>> f2fs_setxattr).
>>
>> Russ
>>
>> On Tue, Sep 10, 2013 at 10:22 PM, Gu Zheng <guz.fnst@cn.fujitsu.com>=
 wrote:
>>>
>>> Hi Jaegeuk,
>>> On 09/10/2013 08:59 AM, Jaegeuk Kim wrote:
>>>
>>>> Hi,
>>>>
>>>> 2013-09-07 (=ED=86=A0), 08:00 +0000, Chao Yu:
>>>>> Hi Knize,
>>>>>
>>>>>      Thanks for your reply, I think it's actually meaningless tha=
t it's
>>>>> being named after "spin_lock",
>>>>> it's better to rename this spinlock to "round_robin_lock".
>>>>>
>>>>>      This patch can only resolve the issue of unbalanced fs_lock =
usage,
>>>>> it can not fix the deadlock issue.
>>>>> can we fix deadlock issue through this method:
>>>>>
>>>>> - vfs_create()
>>>>>   - f2fs_create() - takes an fs_lock and save current thread info=
 into
>>>>> thread_info[NR_GLOBAL_LOCKS]
>>>>>    - f2fs_add_link()
>>>>>     - __f2fs_add_link()
>>>>>      - init_inode_metadata()
>>>>>       - f2fs_init_security()
>>>>>        - security_inode_init_security()
>>>>>         - f2fs_initxattrs()
>>>>>          - f2fs_setxattr() - get fs_lock only if there is no curr=
ent
>>>>> thread info in thread_info
>>>>>
>>>>> So it keeps one thread can only hold one fs_lock to avoid deadloc=
k.
>>>>> Can we use this solution?
>>>>
>>>> It could be.
>>>> But, I think we can avoid to grab the fs_lock at the f2fs_initxatt=
rs()
>>>
>>> Agree. This fs_lock here is used to protect the xattr from parallel
>>> modification,
>>> but here is in the initxattrs routine, parallel modification can no=
t
>>> happen.
>>> And in the normal setxattr routine the inode->i_mutex (vfs layer) i=
s used
>>> to
>>> avoid parallel modification. So I think this fs_lock is needless.
>>> Am I missing something?
>>>
>>> Regards,
>>> Gu
>>>
>>>> level, since this case only happens when f2fs_initxattrs() is call=
ed.
>>>> Let's think about ut in more detail.
>>>> Thanks,
>>>>
>>>>>
>>>>>
>>>>>
>>>>> thanks again!
>>>>>
>>>>>
>>>>>
>>>>> ------- Original Message -------
>>>>>
>>>>> Sender : Russ Knize<Russ.Knize@motorola.com>
>>>>>
>>>>> Date : =E4=B9=9D=E6=9C=88 07, 2013 04:25 (GMT+09:00)
>>>>>
>>>>> Title : Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better
>>>>> performance
>>>>>
>>>>>
>>>>>
>>>>> I encountered this same issue recently and solved it in much the =
same
>>>>> way.  Can we rename "spin_lock" to something more meaningful?
>>>>>
>>>>>
>>>>> This race actually exposed a potential deadlock between f2fs_crea=
te()
>>>>> and f2fs_initxattrs():
>>>>>
>>>>>
>>>>> - vfs_create()
>>>>>   - f2fs_create() - takes an fs_lock
>>>>>    - f2fs_add_link()
>>>>>     - __f2fs_add_link()
>>>>>      - init_inode_metadata()
>>>>>       - f2fs_init_security()
>>>>>        - security_inode_init_security()
>>>>>         - f2fs_initxattrs()
>>>>>          - f2fs_setxattr() - also takes an fs_lock
>>>>>
>>>>>
>>>>> If another CPU happens to have the same lock that f2fs_setxattr()=
 was
>>>>> trying to take because of the race around next_lock_num, we can g=
et
>>>>> into a deadlock situation if the two threads are also contending =
over
>>>>> another resource (like bdi).
>>>>>
>>>>>
>>>>> Another scenario is if the above happens while another thread is =
in
>>>>> the middle of grabbing all of the locks via mutex_lock_all().
>>>>>   f2fs_create() is holding a lock that mutex_lock_all() is waitin=
g for
>>>>> and mutex_lock_all() is holding a lock that f2fs_setxattr() is wa=
iting
>>>>> for.
>>>>>
>>>>>
>>>>> Russ
>>>>>
>>>>>
>>>>> On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <chao2.yu@samsung.com> wr=
ote:
>>>>>          Hi Kim:
>>>>>
>>>>>               I think there is a performance problem: when all
>>>>>          sbi->fs_lock is holded,
>>>>>
>>>>>          then all other threads may get the same next_lock value =
from
>>>>>          sbi->next_lock_num in function mutex_lock_op,
>>>>>
>>>>>          and wait to get the same lock at position fs_lock[next_l=
ock],
>>>>>          it unbalance the fs_lock usage.
>>>>>
>>>>>          It may lost performance when we do the multithread test.
>>>>>
>>>>>
>>>>>
>>>>>          Here is the patch to fix this problem:
>>>>>
>>>>>
>>>>>
>>>>>          Signed-off-by: Yu Chao <chao2.yu@samsung.com>
>>>>>
>>>>>          diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>
>>>>>          old mode 100644
>>>>>
>>>>>          new mode 100755
>>>>>
>>>>>          index 467d42d..983bb45
>>>>>
>>>>>          --- a/fs/f2fs/f2fs.h
>>>>>
>>>>>          +++ b/fs/f2fs/f2fs.h
>>>>>
>>>>>          @@ -371,6 +371,7 @@ struct f2fs_sb_info {
>>>>>
>>>>>                  struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* block=
ing FS
>>>>>          operations */
>>>>>
>>>>>                  struct mutex node_write;                /* locki=
ng
>>>>>          node writes */
>>>>>
>>>>>                  struct mutex writepages;                /* mutex=
 for
>>>>>          writepages() */
>>>>>
>>>>>          +       spinlock_t spin_lock;                   /* lock =
for
>>>>>          next_lock_num */
>>>>>
>>>>>                  unsigned char next_lock_num;            /* round=
-robin
>>>>>          global locks */
>>>>>
>>>>>                  int por_doing;                          /* recov=
ery is
>>>>>          doing or not */
>>>>>
>>>>>                  int on_build_free_nids;                 /*
>>>>>          build_free_nids is doing */
>>>>>
>>>>>          @@ -533,15 +534,19 @@ static inline void
>>>>>          mutex_unlock_all(struct f2fs_sb_info *sbi)
>>>>>
>>>>>
>>>>>
>>>>>           static inline int mutex_lock_op(struct f2fs_sb_info *sb=
i)
>>>>>
>>>>>           {
>>>>>
>>>>>          -       unsigned char next_lock =3D sbi->next_lock_num %
>>>>>          NR_GLOBAL_LOCKS;
>>>>>
>>>>>          +       unsigned char next_lock;
>>>>>
>>>>>                  int i =3D 0;
>>>>>
>>>>>
>>>>>
>>>>>                  for (; i < NR_GLOBAL_LOCKS; i++)
>>>>>
>>>>>                          if (mutex_trylock(&sbi->fs_lock[i]))
>>>>>
>>>>>                                  return i;
>>>>>
>>>>>
>>>>>
>>>>>          -       mutex_lock(&sbi->fs_lock[next_lock]);
>>>>>
>>>>>          +       spin_lock(&sbi->spin_lock);
>>>>>
>>>>>          +       next_lock =3D sbi->next_lock_num % NR_GLOBAL_LOC=
KS;
>>>>>
>>>>>                  sbi->next_lock_num++;
>>>>>
>>>>>          +       spin_unlock(&sbi->spin_lock);
>>>>>
>>>>>          +
>>>>>
>>>>>          +       mutex_lock(&sbi->fs_lock[next_lock]);
>>>>>
>>>>>                  return next_lock;
>>>>>
>>>>>           }
>>>>>
>>>>>
>>>>>
>>>>>          diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>
>>>>>          old mode 100644
>>>>>
>>>>>          new mode 100755
>>>>>
>>>>>          index 75c7dc3..4f27596
>>>>>
>>>>>          --- a/fs/f2fs/super.c
>>>>>
>>>>>          +++ b/fs/f2fs/super.c
>>>>>
>>>>>          @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct
>>>>>          super_block *sb, void *data, int silent)
>>>>>
>>>>>                  mutex_init(&sbi->cp_mutex);
>>>>>
>>>>>                  for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>>>>>
>>>>>                          mutex_init(&sbi->fs_lock[i]);
>>>>>
>>>>>          +       spin_lock_init(&sbi->spin_lock);
>>>>>
>>>>>                  mutex_init(&sbi->node_write);
>>>>>
>>>>>                  sbi->por_doing =3D 0;
>>>>>
>>>>>                  spin_lock_init(&sbi->stat_lock);
>>>>>
>>>>>          (END)
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> -----------------------------------------------------------------=
-------------
>>>>>          Learn the latest--Visual Studio 2012, SharePoint 2013, S=
QL
>>>>>          2012, more!
>>>>>          Discover the easy way to master current and previous Mic=
rosoft
>>>>>          technologies
>>>>>          and advance your career. Get an incredible 1,500+ hours =
of
>>>>>          step-by-step
>>>>>          tutorial videos with LearnDevNow. Subscribe today and sa=
ve!
>>>>>
>>>>> http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&iu=3D/41=
40/ostg.clktrk
>>>>>          _______________________________________________
>>>>>          Linux-f2fs-devel mailing list
>>>>>          Linux-f2fs-devel@lists.sourceforge.net
>>>>>          https://lists.sourceforge.net/lists/listinfo/linux-f2fs-=
devel
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>>
>> --------------------------------------------------------------------=
----------
>> How ServiceNow helps IT people transform IT departments:
>> 1. Consolidate legacy IT systems to a single system of record for IT
>> 2. Standardize and globalize service processes across IT
>> 3. Implement zero-touch automation to replace manual, redundant task=
s
>> http://pubads.g.doubleclick.net/gampad/clk?id=3D51271111&iu=3D/4140/=
ostg.clktrk
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
