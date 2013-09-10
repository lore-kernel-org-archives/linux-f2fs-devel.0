From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] f2fs: optimize fs_lock for better performance
Date: Mon, 9 Sep 2013 23:17:11 -0500
Message-ID: <CAGfvh63Kd0qtoJDzdCwY6V=8FRmoaFiDM6zQbK_h5pRAicGHtQ@mail.gmail.com>
References: <04.C0.13361.61DDA225@epcpsbge5.samsung.com>
	<1378774750.2354.110.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6456360154466884907=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rknize2@motorola.com>) id 1VJFOZ-0007m9-VN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Sep 2013 04:17:44 +0000
Received: from exprod5og104.obsmtp.com ([64.18.0.178])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VJFOX-0000Af-Sn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Sep 2013 04:17:43 +0000
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id
	r8A4EetB008872 for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 00:14:40 -0400 (EDT)
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id
	r8A4EdUa008859
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 10 Sep 2013 00:14:40 -0400 (EDT)
Received: by mail-wg0-f43.google.com with SMTP id z12so5949482wgg.34
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 09 Sep 2013 21:17:33 -0700 (PDT)
In-Reply-To: <1378774750.2354.110.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk.kim" <jaegeuk.kim@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?6LCt5aed?= <shu.tan@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

--===============6456360154466884907==
Content-Type: multipart/alternative; boundary=f46d043c7eeeac3a3a04e5ffc896

--f46d043c7eeeac3a3a04e5ffc896
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I wasn't sure if f2fs_setxattr() needed the lock or not, since the call
path from f2fs_xattr_set_acl() doesn't take one anywhere.  My first thought
was to move the lock over to the acl code and remove it from here.

Russ

On Mon, Sep 9, 2013 at 7:59 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com> wrote=
:

> Hi,
>
> 2013-09-07 (=ED=86=A0), 08:00 +0000, Chao Yu:
> > Hi Knize,
> >
> >     Thanks for your reply, I think it's actually meaningless that it's
> > being named after "spin_lock",
> > it's better to rename this spinlock to "round_robin_lock".
> >
> >     This patch can only resolve the issue of unbalanced fs_lock usage,
> > it can not fix the deadlock issue.
> > can we fix deadlock issue through this method:
> >
> > - vfs_create()
> >  - f2fs_create() - takes an fs_lock and save current thread info into
> > thread_info[NR_GLOBAL_LOCKS]
> >   - f2fs_add_link()
> >    - __f2fs_add_link()
> >     - init_inode_metadata()
> >      - f2fs_init_security()
> >       - security_inode_init_security()
> >        - f2fs_initxattrs()
> >         - f2fs_setxattr() - get fs_lock only if there is no current
> > thread info in thread_info
> >
> > So it keeps one thread can only hold one fs_lock to avoid deadlock.
> > Can we use this solution?
>
> It could be.
> But, I think we can avoid to grab the fs_lock at the f2fs_initxattrs()
> level, since this case only happens when f2fs_initxattrs() is called.
> Let's think about ut in more detail.
> Thanks,
>
> >
> >
> >
> > thanks again!
> >
> >
> >
> > ------- Original Message -------
> >
> > Sender : Russ Knize<Russ.Knize@motorola.com>
> >
> > Date : =E4=B9=9D=E6=9C=88 07, 2013 04:25 (GMT+09:00)
> >
> > Title : Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better
> > performance
> >
> >
> >
> > I encountered this same issue recently and solved it in much the same
> > way.  Can we rename "spin_lock" to something more meaningful?
> >
> >
> > This race actually exposed a potential deadlock between f2fs_create()
> > and f2fs_initxattrs():
> >
> >
> > - vfs_create()
> >  - f2fs_create() - takes an fs_lock
> >   - f2fs_add_link()
> >    - __f2fs_add_link()
> >     - init_inode_metadata()
> >      - f2fs_init_security()
> >       - security_inode_init_security()
> >        - f2fs_initxattrs()
> >         - f2fs_setxattr() - also takes an fs_lock
> >
> >
> > If another CPU happens to have the same lock that f2fs_setxattr() was
> > trying to take because of the race around next_lock_num, we can get
> > into a deadlock situation if the two threads are also contending over
> > another resource (like bdi).
> >
> >
> > Another scenario is if the above happens while another thread is in
> > the middle of grabbing all of the locks via mutex_lock_all().
> >  f2fs_create() is holding a lock that mutex_lock_all() is waiting for
> > and mutex_lock_all() is holding a lock that f2fs_setxattr() is waiting
> > for.
> >
> >
> > Russ
> >
> >
> > On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <chao2.yu@samsung.com> wrote:
> >         Hi Kim:
> >
> >              I think there is a performance problem: when all
> >         sbi->fs_lock is holded,
> >
> >         then all other threads may get the same next_lock value from
> >         sbi->next_lock_num in function mutex_lock_op,
> >
> >         and wait to get the same lock at position fs_lock[next_lock],
> >         it unbalance the fs_lock usage.
> >
> >         It may lost performance when we do the multithread test.
> >
> >
> >
> >         Here is the patch to fix this problem:
> >
> >
> >
> >         Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> >
> >         diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >
> >         old mode 100644
> >
> >         new mode 100755
> >
> >         index 467d42d..983bb45
> >
> >         --- a/fs/f2fs/f2fs.h
> >
> >         +++ b/fs/f2fs/f2fs.h
> >
> >         @@ -371,6 +371,7 @@ struct f2fs_sb_info {
> >
> >                 struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* blocking FS
> >         operations */
> >
> >                 struct mutex node_write;                /* locking
> >         node writes */
> >
> >                 struct mutex writepages;                /* mutex for
> >         writepages() */
> >
> >         +       spinlock_t spin_lock;                   /* lock for
> >         next_lock_num */
> >
> >                 unsigned char next_lock_num;            /* round-robin
> >         global locks */
> >
> >                 int por_doing;                          /* recovery is
> >         doing or not */
> >
> >                 int on_build_free_nids;                 /*
> >         build_free_nids is doing */
> >
> >         @@ -533,15 +534,19 @@ static inline void
> >         mutex_unlock_all(struct f2fs_sb_info *sbi)
> >
> >
> >
> >          static inline int mutex_lock_op(struct f2fs_sb_info *sbi)
> >
> >          {
> >
> >         -       unsigned char next_lock =3D sbi->next_lock_num %
> >         NR_GLOBAL_LOCKS;
> >
> >         +       unsigned char next_lock;
> >
> >                 int i =3D 0;
> >
> >
> >
> >                 for (; i < NR_GLOBAL_LOCKS; i++)
> >
> >                         if (mutex_trylock(&sbi->fs_lock[i]))
> >
> >                                 return i;
> >
> >
> >
> >         -       mutex_lock(&sbi->fs_lock[next_lock]);
> >
> >         +       spin_lock(&sbi->spin_lock);
> >
> >         +       next_lock =3D sbi->next_lock_num % NR_GLOBAL_LOCKS;
> >
> >                 sbi->next_lock_num++;
> >
> >         +       spin_unlock(&sbi->spin_lock);
> >
> >         +
> >
> >         +       mutex_lock(&sbi->fs_lock[next_lock]);
> >
> >                 return next_lock;
> >
> >          }
> >
> >
> >
> >         diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >
> >         old mode 100644
> >
> >         new mode 100755
> >
> >         index 75c7dc3..4f27596
> >
> >         --- a/fs/f2fs/super.c
> >
> >         +++ b/fs/f2fs/super.c
> >
> >         @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct
> >         super_block *sb, void *data, int silent)
> >
> >                 mutex_init(&sbi->cp_mutex);
> >
> >                 for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
> >
> >                         mutex_init(&sbi->fs_lock[i]);
> >
> >         +       spin_lock_init(&sbi->spin_lock);
> >
> >                 mutex_init(&sbi->node_write);
> >
> >                 sbi->por_doing =3D 0;
> >
> >                 spin_lock_init(&sbi->stat_lock);
> >
> >         (END)
> >
> >
> >
> >
> >
> >
> >
> >
> -------------------------------------------------------------------------=
-----
> >         Learn the latest--Visual Studio 2012, SharePoint 2013, SQL
> >         2012, more!
> >         Discover the easy way to master current and previous Microsoft
> >         technologies
> >         and advance your career. Get an incredible 1,500+ hours of
> >         step-by-step
> >         tutorial videos with LearnDevNow. Subscribe today and save!
> >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&iu=3D/4140/ostg.=
clktrk
> >         _______________________________________________
> >         Linux-f2fs-devel mailing list
> >         Linux-f2fs-devel@lists.sourceforge.net
> >         https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
>
> --
> Jaegeuk Kim
> Samsung
>
>

--f46d043c7eeeac3a3a04e5ffc896
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I wasn&#39;t sure if f2fs_setxattr() needed the lock or no=
t, since the call path from f2fs_xattr_set_acl() doesn&#39;t take one anywh=
ere.=C2=A0 My first thought was to move the lock over to the acl code and r=
emove it from here.<br>

<div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Russ<b=
r></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, S=
ep 9, 2013 at 7:59 PM, Jaegeuk Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:=
jaegeuk.kim@samsung.com" target=3D"_blank">jaegeuk.kim@samsung.com</a>&gt;<=
/span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
2013-09-07 (=ED=86=A0), 08:00 +0000, Chao Yu:<br>
<div class=3D"im">&gt; Hi Knize,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Thanks for your reply, I think it&#39;s actually meaning=
less that it&#39;s<br>
&gt; being named after &quot;spin_lock&quot;,<br>
&gt; it&#39;s better to rename this spinlock to &quot;round_robin_lock&quot=
;.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 This patch can only resolve the issue of unbalanced fs_l=
ock usage,<br>
&gt; it can not fix the deadlock issue.<br>
&gt; can we fix deadlock issue through this method:<br>
&gt;<br>
</div>&gt; - vfs_create()<br>
<div class=3D"im">&gt; =C2=A0- f2fs_create() - takes an fs_lock and save cu=
rrent thread info into<br>
&gt; thread_info[NR_GLOBAL_LOCKS]<br>
</div><div class=3D"im">&gt; =C2=A0 - f2fs_add_link()<br>
&gt; =C2=A0 =C2=A0- __f2fs_add_link()<br>
&gt; =C2=A0 =C2=A0 - init_inode_metadata()<br>
&gt; =C2=A0 =C2=A0 =C2=A0- f2fs_init_security()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 - security_inode_init_security()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0- f2fs_initxattrs()<br>
</div><div class=3D"im">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - f2fs_setxattr() =
- get fs_lock only if there is no current<br>
&gt; thread info in thread_info<br>
&gt;<br>
&gt; So it keeps one thread can only hold one fs_lock to avoid deadlock.<br=
>
&gt; Can we use this solution?<br>
<br>
</div>It could be.<br>
But, I think we can avoid to grab the fs_lock at the f2fs_initxattrs()<br>
level, since this case only happens when f2fs_initxattrs() is called.<br>
Let&#39;s think about ut in more detail.<br>
Thanks,<br>
<div class=3D"im HOEnZb"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; thanks again!<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ------- Original Message -------<br>
&gt;<br>
&gt; Sender : Russ Knize&lt;<a href=3D"mailto:Russ.Knize@motorola.com">Russ=
.Knize@motorola.com</a>&gt;<br>
&gt;<br>
&gt; Date : =E4=B9=9D=E6=9C=88 07, 2013 04:25 (GMT+09:00)<br>
&gt;<br>
&gt; Title : Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better<br>
&gt; performance<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">&gt; I encountered this same =
issue recently and solved it in much the same<br>
&gt; way. =C2=A0Can we rename &quot;spin_lock&quot; to something more meani=
ngful?<br>
&gt;<br>
&gt;<br>
&gt; This race actually exposed a potential deadlock between f2fs_create()<=
br>
&gt; and f2fs_initxattrs():<br>
&gt;<br>
&gt;<br>
&gt; - vfs_create()<br>
&gt; =C2=A0- f2fs_create() - takes an fs_lock<br>
&gt; =C2=A0 - f2fs_add_link()<br>
&gt; =C2=A0 =C2=A0- __f2fs_add_link()<br>
&gt; =C2=A0 =C2=A0 - init_inode_metadata()<br>
&gt; =C2=A0 =C2=A0 =C2=A0- f2fs_init_security()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 - security_inode_init_security()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0- f2fs_initxattrs()<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - f2fs_setxattr() - also takes an fs_lock<=
br>
&gt;<br>
&gt;<br>
&gt; If another CPU happens to have the same lock that f2fs_setxattr() was<=
br>
&gt; trying to take because of the race around next_lock_num, we can get<br=
>
&gt; into a deadlock situation if the two threads are also contending over<=
br>
&gt; another resource (like bdi).<br>
&gt;<br>
&gt;<br>
&gt; Another scenario is if the above happens while another thread is in<br=
>
&gt; the middle of grabbing all of the locks via mutex_lock_all().<br>
&gt; =C2=A0f2fs_create() is holding a lock that mutex_lock_all() is waiting=
 for<br>
&gt; and mutex_lock_all() is holding a lock that f2fs_setxattr() is waiting=
<br>
&gt; for.<br>
&gt;<br>
&gt;<br>
&gt; Russ<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu &lt;<a href=3D"mailto:chao2.yu=
@samsung.com">chao2.yu@samsung.com</a>&gt; wrote:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Kim:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I think there is a per=
formance problem: when all<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;fs_lock is holded,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 then all other threads may get the same ne=
xt_lock value from<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;next_lock_num in function mutex_lo=
ck_op,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and wait to get the same lock at position =
fs_lock[next_lock],<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 it unbalance the fs_lock usage.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 It may lost performance when we do the mul=
tithread test.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Here is the patch to fix this problem:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Signed-off-by: Yu Chao &lt;<a href=3D"mail=
to:chao2.yu@samsung.com">chao2.yu@samsung.com</a>&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs=
.h<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 old mode 100644<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 new mode 100755<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 467d42d..983bb45<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/fs/f2fs/f2fs.h<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/fs/f2fs/f2fs.h<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -371,6 +371,7 @@ struct f2fs_sb_info {<=
br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mutex f=
s_lock[NR_GLOBAL_LOCKS]; =C2=A0/* blocking FS<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 operations */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mutex n=
ode_write; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* lockin=
g<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 node writes */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mutex w=
ritepages; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mutex =
for<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 writepages() */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spinlock_t spin_loc=
k; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* lock f=
or<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_lock_num */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char =
next_lock_num; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* round-robin<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 global locks */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int por_doing;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* recovery is<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 doing or not */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int on_build_f=
ree_nids; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_free_nids is doing */<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -533,15 +534,19 @@ static inline void<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock_all(struct f2fs_sb_info *sbi)=
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static inline int mutex_lock_op(stru=
ct f2fs_sb_info *sbi)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 unsigned char next_=
lock =3D sbi-&gt;next_lock_num %<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 NR_GLOBAL_LOCKS;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 unsigned char next_=
lock;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i =3D 0;<b=
r>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; i &lt; =
NR_GLOBAL_LOCKS; i++)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (mutex_trylock(&amp;sbi-&gt;fs_lock[i]))<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return i;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;sbi=
-&gt;fs_lock[next_lock]);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;sbi-=
&gt;spin_lock);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 next_lock =3D sbi-&=
gt;next_lock_num % NR_GLOBAL_LOCKS;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;next_l=
ock_num++;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;sb=
i-&gt;spin_lock);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;sbi=
-&gt;fs_lock[next_lock]);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return next_lo=
ck;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff --git a/fs/f2fs/super.c b/fs/f2fs/sup=
er.c<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 old mode 100644<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 new mode 100755<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 75c7dc3..4f27596<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --- a/fs/f2fs/super.c<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 +++ b/fs/f2fs/super.c<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 @@ -657,6 +657,7 @@ static int f2fs_fill_s=
uper(struct<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 super_block *sb, void *data, int silent)<b=
r>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&am=
p;sbi-&gt;cp_mutex);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; =
i &lt; NR_GLOBAL_LOCKS; i++)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mutex_init(&amp;sbi-&gt;fs_lock[i]);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&amp=
;sbi-&gt;spin_lock);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&am=
p;sbi-&gt;node_write);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi-&gt;por_do=
ing =3D 0;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_init=
(&amp;sbi-&gt;stat_lock);<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (END)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ------------------------------------------=
------------------------------------<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Learn the latest--Visual Studio 2012, Shar=
ePoint 2013, SQL<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 2012, more!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Discover the easy way to master current an=
d previous Microsoft<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 technologies<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and advance your career. Get an incredible=
 1,500+ hours of<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 step-by-step<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 tutorial videos with LearnDevNow. Subscrib=
e today and save!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://pubads.g.doubleclick.net=
/gampad/clk?id=3D58041391&amp;iu=3D/4140/ostg.clktrk" target=3D"_blank">htt=
p://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&amp;iu=3D/4140/ostg.c=
lktrk</a><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 __________________________________________=
_____<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Linux-f2fs-devel mailing list<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:Linux-f2fs-devel@lists.s=
ourceforge.net">Linux-f2fs-devel@lists.sourceforge.net</a><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.sourceforge.net/l=
ists/listinfo/linux-f2fs-devel" target=3D"_blank">https://lists.sourceforge=
.net/lists/listinfo/linux-f2fs-devel</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
--<br>
Jaegeuk Kim<br>
Samsung<br>
<br>
</div></div></blockquote></div><br></div></div></div>

--f46d043c7eeeac3a3a04e5ffc896--


--===============6456360154466884907==
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
--===============6456360154466884907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6456360154466884907==--
