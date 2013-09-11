From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] f2fs: optimize fs_lock for better performance
Date: Tue, 10 Sep 2013 22:47:54 -0500
Message-ID: <CAGfvh63mWMq4-eajOZVXqBDW3judq28DYmnrTCdFRM+N8t_S8w@mail.gmail.com>
References: <04.C0.13361.61DDA225@epcpsbge5.samsung.com>
	<1378774750.2354.110.camel@kjgkr> <522FE1FF.9010901@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4177077626772443318=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rknize2@motorola.com>) id 1VJbPq-0005iF-L7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Sep 2013 03:48:30 +0000
Received: from exprod5og112.obsmtp.com ([64.18.0.24])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJbPm-0007TS-V1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 Sep 2013 03:48:30 +0000
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	r8B3lkoD029020 for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 23:47:46 -0400 (EDT)
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	r8B3liUO028983
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 23:47:45 -0400 (EDT)
Received: by mail-we0-f178.google.com with SMTP id u57so6256593wes.23
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 20:48:14 -0700 (PDT)
In-Reply-To: <522FE1FF.9010901@cn.fujitsu.com>
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
Cc: =?UTF-8?B?6LCt5aed?= <shu.tan@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

--===============4177077626772443318==
Content-Type: multipart/alternative; boundary=089e01493c32b86fe604e6137d23

--089e01493c32b86fe604e6137d23
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk/Gu,

I've removed the lock and have been stress-testing with SELinux and some
additional xattr torture for 24+ hours.  I have not encountered any issues
yet.

My previous suggestion about moving the lock is probably not a good idea
without some significant code rework (thanks to the f2fs_balance_fs call in
f2fs_setxattr).

Russ

On Tue, Sep 10, 2013 at 10:22 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:

> Hi Jaegeuk,
> On 09/10/2013 08:59 AM, Jaegeuk Kim wrote:
>
> > Hi,
> >
> > 2013-09-07 (=ED=86=A0), 08:00 +0000, Chao Yu:
> >> Hi Knize,
> >>
> >>     Thanks for your reply, I think it's actually meaningless that it's
> >> being named after "spin_lock",
> >> it's better to rename this spinlock to "round_robin_lock".
> >>
> >>     This patch can only resolve the issue of unbalanced fs_lock usage,
> >> it can not fix the deadlock issue.
> >> can we fix deadlock issue through this method:
> >>
> >> - vfs_create()
> >>  - f2fs_create() - takes an fs_lock and save current thread info into
> >> thread_info[NR_GLOBAL_LOCKS]
> >>   - f2fs_add_link()
> >>    - __f2fs_add_link()
> >>     - init_inode_metadata()
> >>      - f2fs_init_security()
> >>       - security_inode_init_security()
> >>        - f2fs_initxattrs()
> >>         - f2fs_setxattr() - get fs_lock only if there is no current
> >> thread info in thread_info
> >>
> >> So it keeps one thread can only hold one fs_lock to avoid deadlock.
> >> Can we use this solution?
> >
> > It could be.
> > But, I think we can avoid to grab the fs_lock at the f2fs_initxattrs()
>
> Agree. This fs_lock here is used to protect the xattr from parallel
> modification,
> but here is in the initxattrs routine, parallel modification can not
> happen.
> And in the normal setxattr routine the inode->i_mutex (vfs layer) is used
> to
> avoid parallel modification. So I think this fs_lock is needless.
> Am I missing something?
>
> Regards,
> Gu
>
> > level, since this case only happens when f2fs_initxattrs() is called.
> > Let's think about ut in more detail.
> > Thanks,
> >
> >>
> >>
> >>
> >> thanks again!
> >>
> >>
> >>
> >> ------- Original Message -------
> >>
> >> Sender : Russ Knize<Russ.Knize@motorola.com>
> >>
> >> Date : =E4=B9=9D=E6=9C=88 07, 2013 04:25 (GMT+09:00)
> >>
> >> Title : Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better
> >> performance
> >>
> >>
> >>
> >> I encountered this same issue recently and solved it in much the same
> >> way.  Can we rename "spin_lock" to something more meaningful?
> >>
> >>
> >> This race actually exposed a potential deadlock between f2fs_create()
> >> and f2fs_initxattrs():
> >>
> >>
> >> - vfs_create()
> >>  - f2fs_create() - takes an fs_lock
> >>   - f2fs_add_link()
> >>    - __f2fs_add_link()
> >>     - init_inode_metadata()
> >>      - f2fs_init_security()
> >>       - security_inode_init_security()
> >>        - f2fs_initxattrs()
> >>         - f2fs_setxattr() - also takes an fs_lock
> >>
> >>
> >> If another CPU happens to have the same lock that f2fs_setxattr() was
> >> trying to take because of the race around next_lock_num, we can get
> >> into a deadlock situation if the two threads are also contending over
> >> another resource (like bdi).
> >>
> >>
> >> Another scenario is if the above happens while another thread is in
> >> the middle of grabbing all of the locks via mutex_lock_all().
> >>  f2fs_create() is holding a lock that mutex_lock_all() is waiting for
> >> and mutex_lock_all() is holding a lock that f2fs_setxattr() is waiting
> >> for.
> >>
> >>
> >> Russ
> >>
> >>
> >> On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <chao2.yu@samsung.com> wrote:
> >>         Hi Kim:
> >>
> >>              I think there is a performance problem: when all
> >>         sbi->fs_lock is holded,
> >>
> >>         then all other threads may get the same next_lock value from
> >>         sbi->next_lock_num in function mutex_lock_op,
> >>
> >>         and wait to get the same lock at position fs_lock[next_lock],
> >>         it unbalance the fs_lock usage.
> >>
> >>         It may lost performance when we do the multithread test.
> >>
> >>
> >>
> >>         Here is the patch to fix this problem:
> >>
> >>
> >>
> >>         Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> >>
> >>         diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>
> >>         old mode 100644
> >>
> >>         new mode 100755
> >>
> >>         index 467d42d..983bb45
> >>
> >>         --- a/fs/f2fs/f2fs.h
> >>
> >>         +++ b/fs/f2fs/f2fs.h
> >>
> >>         @@ -371,6 +371,7 @@ struct f2fs_sb_info {
> >>
> >>                 struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* blocking FS
> >>         operations */
> >>
> >>                 struct mutex node_write;                /* locking
> >>         node writes */
> >>
> >>                 struct mutex writepages;                /* mutex for
> >>         writepages() */
> >>
> >>         +       spinlock_t spin_lock;                   /* lock for
> >>         next_lock_num */
> >>
> >>                 unsigned char next_lock_num;            /* round-robin
> >>         global locks */
> >>
> >>                 int por_doing;                          /* recovery is
> >>         doing or not */
> >>
> >>                 int on_build_free_nids;                 /*
> >>         build_free_nids is doing */
> >>
> >>         @@ -533,15 +534,19 @@ static inline void
> >>         mutex_unlock_all(struct f2fs_sb_info *sbi)
> >>
> >>
> >>
> >>          static inline int mutex_lock_op(struct f2fs_sb_info *sbi)
> >>
> >>          {
> >>
> >>         -       unsigned char next_lock =3D sbi->next_lock_num %
> >>         NR_GLOBAL_LOCKS;
> >>
> >>         +       unsigned char next_lock;
> >>
> >>                 int i =3D 0;
> >>
> >>
> >>
> >>                 for (; i < NR_GLOBAL_LOCKS; i++)
> >>
> >>                         if (mutex_trylock(&sbi->fs_lock[i]))
> >>
> >>                                 return i;
> >>
> >>
> >>
> >>         -       mutex_lock(&sbi->fs_lock[next_lock]);
> >>
> >>         +       spin_lock(&sbi->spin_lock);
> >>
> >>         +       next_lock =3D sbi->next_lock_num % NR_GLOBAL_LOCKS;
> >>
> >>                 sbi->next_lock_num++;
> >>
> >>         +       spin_unlock(&sbi->spin_lock);
> >>
> >>         +
> >>
> >>         +       mutex_lock(&sbi->fs_lock[next_lock]);
> >>
> >>                 return next_lock;
> >>
> >>          }
> >>
> >>
> >>
> >>         diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>
> >>         old mode 100644
> >>
> >>         new mode 100755
> >>
> >>         index 75c7dc3..4f27596
> >>
> >>         --- a/fs/f2fs/super.c
> >>
> >>         +++ b/fs/f2fs/super.c
> >>
> >>         @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct
> >>         super_block *sb, void *data, int silent)
> >>
> >>                 mutex_init(&sbi->cp_mutex);
> >>
> >>                 for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
> >>
> >>                         mutex_init(&sbi->fs_lock[i]);
> >>
> >>         +       spin_lock_init(&sbi->spin_lock);
> >>
> >>                 mutex_init(&sbi->node_write);
> >>
> >>                 sbi->por_doing =3D 0;
> >>
> >>                 spin_lock_init(&sbi->stat_lock);
> >>
> >>         (END)
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> -------------------------------------------------------------------------=
-----
> >>         Learn the latest--Visual Studio 2012, SharePoint 2013, SQL
> >>         2012, more!
> >>         Discover the easy way to master current and previous Microsoft
> >>         technologies
> >>         and advance your career. Get an incredible 1,500+ hours of
> >>         step-by-step
> >>         tutorial videos with LearnDevNow. Subscribe today and save!
> >>
> http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&iu=3D/4140/ostg.=
clktrk
> >>         _______________________________________________
> >>         Linux-f2fs-devel mailing list
> >>         Linux-f2fs-devel@lists.sourceforge.net
> >>         https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >
>
>
>

--089e01493c32b86fe604e6137d23
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jaegeuk/Gu,<br><div><br>I&#39;ve removed the lock and h=
ave been stress-testing with SELinux and some additional xattr torture for =
24+ hours.=C2=A0 I have not encountered any issues yet.<br><br>My previous =
suggestion about moving the lock is probably not a good idea without some s=
ignificant code rework (thanks to the f2fs_balance_fs call in f2fs_setxattr=
).<br>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Russ<br></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Sep 10=
, 2013 at 10:22 PM, Gu Zheng <span dir=3D"ltr">&lt;<a href=3D"mailto:guz.fn=
st@cn.fujitsu.com" target=3D"_blank">guz.fnst@cn.fujitsu.com</a>&gt;</span>=
 wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Jaegeuk,<br>
<div><div>On 09/10/2013 08:59 AM, Jaegeuk Kim wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; 2013-09-07 (=ED=86=A0), 08:00 +0000, Chao Yu:<br>
&gt;&gt; Hi Knize,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Thanks for your reply, I think it&#39;s actually mea=
ningless that it&#39;s<br>
&gt;&gt; being named after &quot;spin_lock&quot;,<br>
&gt;&gt; it&#39;s better to rename this spinlock to &quot;round_robin_lock&=
quot;.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 This patch can only resolve the issue of unbalanced =
fs_lock usage,<br>
&gt;&gt; it can not fix the deadlock issue.<br>
&gt;&gt; can we fix deadlock issue through this method:<br>
&gt;&gt;<br>
&gt;&gt; - vfs_create()<br>
&gt;&gt; =C2=A0- f2fs_create() - takes an fs_lock and save current thread i=
nfo into<br>
&gt;&gt; thread_info[NR_GLOBAL_LOCKS]<br>
&gt;&gt; =C2=A0 - f2fs_add_link()<br>
&gt;&gt; =C2=A0 =C2=A0- __f2fs_add_link()<br>
&gt;&gt; =C2=A0 =C2=A0 - init_inode_metadata()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0- f2fs_init_security()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 - security_inode_init_security()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0- f2fs_initxattrs()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - f2fs_setxattr() - get fs_lock only i=
f there is no current<br>
&gt;&gt; thread info in thread_info<br>
&gt;&gt;<br>
&gt;&gt; So it keeps one thread can only hold one fs_lock to avoid deadlock=
.<br>
&gt;&gt; Can we use this solution?<br>
&gt;<br>
&gt; It could be.<br>
&gt; But, I think we can avoid to grab the fs_lock at the f2fs_initxattrs()=
<br>
<br>
</div></div>Agree. This fs_lock here is used to protect the xattr from para=
llel modification,<br>
but here is in the initxattrs routine, parallel modification can not happen=
.<br>
And in the normal setxattr routine the inode-&gt;i_mutex (vfs layer) is use=
d to<br>
avoid parallel modification. So I think this fs_lock is needless.<br>
Am I missing something?<br>
<br>
Regards,<br>
Gu<br>
<div><div><br>
&gt; level, since this case only happens when f2fs_initxattrs() is called.<=
br>
&gt; Let&#39;s think about ut in more detail.<br>
&gt; Thanks,<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; thanks again!<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------- Original Message -------<br>
&gt;&gt;<br>
&gt;&gt; Sender : Russ Knize&lt;<a href=3D"mailto:Russ.Knize@motorola.com" =
target=3D"_blank">Russ.Knize@motorola.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Date : =E4=B9=9D=E6=9C=88 07, 2013 04:25 (GMT+09:00)<br>
&gt;&gt;<br>
&gt;&gt; Title : Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better<b=
r>
&gt;&gt; performance<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I encountered this same issue recently and solved it in much the s=
ame<br>
&gt;&gt; way. =C2=A0Can we rename &quot;spin_lock&quot; to something more m=
eaningful?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This race actually exposed a potential deadlock between f2fs_creat=
e()<br>
&gt;&gt; and f2fs_initxattrs():<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; - vfs_create()<br>
&gt;&gt; =C2=A0- f2fs_create() - takes an fs_lock<br>
&gt;&gt; =C2=A0 - f2fs_add_link()<br>
&gt;&gt; =C2=A0 =C2=A0- __f2fs_add_link()<br>
&gt;&gt; =C2=A0 =C2=A0 - init_inode_metadata()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0- f2fs_init_security()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 - security_inode_init_security()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0- f2fs_initxattrs()<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - f2fs_setxattr() - also takes an fs_l=
ock<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; If another CPU happens to have the same lock that f2fs_setxattr() =
was<br>
&gt;&gt; trying to take because of the race around next_lock_num, we can ge=
t<br>
&gt;&gt; into a deadlock situation if the two threads are also contending o=
ver<br>
&gt;&gt; another resource (like bdi).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Another scenario is if the above happens while another thread is i=
n<br>
&gt;&gt; the middle of grabbing all of the locks via mutex_lock_all().<br>
&gt;&gt; =C2=A0f2fs_create() is holding a lock that mutex_lock_all() is wai=
ting for<br>
&gt;&gt; and mutex_lock_all() is holding a lock that f2fs_setxattr() is wai=
ting<br>
&gt;&gt; for.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Russ<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu &lt;<a href=3D"mailto:chao=
2.yu@samsung.com" target=3D"_blank">chao2.yu@samsung.com</a>&gt; wrote:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Kim:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I think there is a=
 performance problem: when all<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;fs_lock is holded,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 then all other threads may get the sam=
e next_lock value from<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;next_lock_num in function mute=
x_lock_op,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and wait to get the same lock at posit=
ion fs_lock[next_lock],<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 it unbalance the fs_lock usage.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 It may lost performance when we do the=
 multithread test.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Here is the patch to fix this problem:=
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Yu Chao &lt;<a href=3D"=
mailto:chao2.yu@samsung.com" target=3D"_blank">chao2.yu@samsung.com</a>&gt;=
<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/=
f2fs.h<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 old mode 100644<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 new mode 100755<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 467d42d..983bb45<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/fs/f2fs/f2fs.h<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/fs/f2fs/f2fs.h<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -371,6 +371,7 @@ struct f2fs_sb_inf=
o {<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mut=
ex fs_lock[NR_GLOBAL_LOCKS]; =C2=A0/* blocking FS<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 operations */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mut=
ex node_write; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* lo=
cking<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 node writes */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mut=
ex writepages; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mu=
tex for<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 writepages() */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spinlock_t spin=
_lock; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* lo=
ck for<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_lock_num */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned c=
har next_lock_num; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* round-robin<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 global locks */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int por_do=
ing; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* recovery is<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 doing or not */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int on_bui=
ld_free_nids; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br=
>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_free_nids is doing */<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -533,15 +534,19 @@ static inline vo=
id<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock_all(struct f2fs_sb_info *=
sbi)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static inline int mutex_lock_op(=
struct f2fs_sb_info *sbi)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 unsigned char n=
ext_lock =3D sbi-&gt;next_lock_num %<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 NR_GLOBAL_LOCKS;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 unsigned char n=
ext_lock;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i =3D =
0;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; i &=
lt; NR_GLOBAL_LOCKS; i++)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (mutex_trylock(&amp;sbi-&gt;fs_lock[i]))<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return i;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp=
;sbi-&gt;fs_lock[next_lock]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;=
sbi-&gt;spin_lock);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 next_lock =3D s=
bi-&gt;next_lock_num % NR_GLOBAL_LOCKS;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;ne=
xt_lock_num++;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&am=
p;sbi-&gt;spin_lock);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp=
;sbi-&gt;fs_lock[next_lock]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return nex=
t_lock;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/fs/f2fs/super.c b/fs/f2fs=
/super.c<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 old mode 100644<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 new mode 100755<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 75c7dc3..4f27596<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/fs/f2fs/super.c<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/fs/f2fs/super.c<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -657,6 +657,7 @@ static int f2fs_fi=
ll_super(struct<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 super_block *sb, void *data, int silen=
t)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init=
(&amp;sbi-&gt;cp_mutex);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D=
 0; i &lt; NR_GLOBAL_LOCKS; i++)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mutex_init(&amp;sbi-&gt;fs_lock[i]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(=
&amp;sbi-&gt;spin_lock);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init=
(&amp;sbi-&gt;node_write);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;po=
r_doing =3D 0;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_=
init(&amp;sbi-&gt;stat_lock);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (END)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --------------------------------------=
----------------------------------------<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Learn the latest--Visual Studio 2012, =
SharePoint 2013, SQL<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 2012, more!<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Discover the easy way to master curren=
t and previous Microsoft<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 technologies<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and advance your career. Get an incred=
ible 1,500+ hours of<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 step-by-step<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 tutorial videos with LearnDevNow. Subs=
cribe today and save!<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://pubads.g.doubleclick=
.net/gampad/clk?id=3D58041391&amp;iu=3D/4140/ostg.clktrk" target=3D"_blank"=
>http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&amp;iu=3D/4140/os=
tg.clktrk</a><br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ______________________________________=
_________<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Linux-f2fs-devel mailing list<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:Linux-f2fs-devel@lis=
ts.sourceforge.net" target=3D"_blank">Linux-f2fs-devel@lists.sourceforge.ne=
t</a><br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.sourceforge.n=
et/lists/listinfo/linux-f2fs-devel" target=3D"_blank">https://lists.sourcef=
orge.net/lists/listinfo/linux-f2fs-devel</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br></div></div></div>

--089e01493c32b86fe604e6137d23--


--===============4177077626772443318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
--===============4177077626772443318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============4177077626772443318==--
