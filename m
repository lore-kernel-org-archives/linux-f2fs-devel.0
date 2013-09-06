From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] f2fs: optimize fs_lock for better performance
Date: Fri, 6 Sep 2013 14:25:22 -0500
Message-ID: <CAGfvh62EGuQfGBRhasNEXAVEvS2BwKCijnAS67f+GL2fHS-fTA@mail.gmail.com>
References: <02.95.21086.AD4A9225@epcpsbgx4.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3478283541911614591=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rknize2@motorola.com>) id 1VI2Dl-0002Pa-DA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Sep 2013 20:01:33 +0000
Received: from exprod5og105.obsmtp.com ([64.18.0.180])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VI2Dj-0000dH-Aj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Sep 2013 20:01:33 +0000
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	r86JPEYx016481 for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 6 Sep 2013 15:25:14 -0400 (EDT)
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	r86JPCc1016466
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 6 Sep 2013 15:25:13 -0400 (EDT)
Received: by mail-wi0-f178.google.com with SMTP id hn9so1333123wib.5
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 06 Sep 2013 12:25:43 -0700 (PDT)
In-Reply-To: <02.95.21086.AD4A9225@epcpsbgx4.samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com
Cc: linux-fsdevel@vger.kernel.org, shu.tan@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============3478283541911614591==
Content-Type: multipart/related; boundary=001a11c38c2e36052404e5bc0116

--001a11c38c2e36052404e5bc0116
Content-Type: multipart/alternative; boundary=001a11c38c2e36052204e5bc0115

--001a11c38c2e36052204e5bc0115
Content-Type: text/plain; charset=ISO-8859-1

I encountered this same issue recently and solved it in much the same way.
 Can we rename "spin_lock" to something more meaningful?

This race actually exposed a potential deadlock between f2fs_create() and
f2fs_initxattrs():

- vfs_create()
 - f2fs_create() - takes an fs_lock
  - f2fs_add_link()
   - __f2fs_add_link()
    - init_inode_metadata()
     - f2fs_init_security()
      - security_inode_init_security()
       - f2fs_initxattrs()
        - f2fs_setxattr() - also takes an fs_lock

If another CPU happens to have the same lock that f2fs_setxattr() was
trying to take because of the race around next_lock_num, we can get into a
deadlock situation if the two threads are also contending over another
resource (like bdi).

Another scenario is if the above happens while another thread is in the
middle of grabbing all of the locks via mutex_lock_all().  f2fs_create() is
holding a lock that mutex_lock_all() is waiting for and mutex_lock_all() is
holding a lock that f2fs_setxattr() is waiting for.

Russ


On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <chao2.yu@samsung.com> wrote:

>  Hi Kim:****
>
> **     **I think there is a performance problem: when all sbi->fs_lock is
> holded,
>
> then all other threads may get the same next_lock value from
> sbi->next_lock_num in function mutex_lock_op,
>
> and wait to get the same lock at position fs_lock[next_lock], it unbalance
> the fs_lock usage.
>
> It may lost performance when we do the multithread test.****
>
> ** **
>
> Here is the patch to fix this problem:****
>
> ** **
>
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>****
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h****
>
> old mode 100644****
>
> new mode 100755****
>
> index 467d42d..983bb45****
>
> --- a/fs/f2fs/f2fs.h****
>
> +++ b/fs/f2fs/f2fs.h****
>
> @@ -371,6 +371,7 @@ struct f2fs_sb_info {****
>
>         struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* blocking FS operations
> */****
>
>         struct mutex node_write;                /* locking node writes */*
> ***
>
>         struct mutex writepages;                /* mutex for writepages()
> */****
>
> +       spinlock_t spin_lock;                   /* lock for next_lock_num
> */****
>
>         unsigned char next_lock_num;            /* round-robin global
> locks */****
>
>         int por_doing;                          /* recovery is doing or
> not */****
>
>         int on_build_free_nids;                 /* build_free_nids is
> doing */****
>
> @@ -533,15 +534,19 @@ static inline void mutex_unlock_all(struct
> f2fs_sb_info *sbi)****
>
>  ****
>
>  static inline int mutex_lock_op(struct f2fs_sb_info *sbi)****
>
>  {****
>
> -       unsigned char next_lock = sbi->next_lock_num % NR_GLOBAL_LOCKS;***
> *
>
> +       unsigned char next_lock;****
>
>         int i = 0;****
>
>  ****
>
>         for (; i < NR_GLOBAL_LOCKS; i++)****
>
>                 if (mutex_trylock(&sbi->fs_lock[i]))****
>
>                         return i;****
>
>  ****
>
> -       mutex_lock(&sbi->fs_lock[next_lock]);****
>
> +       spin_lock(&sbi->spin_lock);****
>
> +       next_lock = sbi->next_lock_num % NR_GLOBAL_LOCKS;****
>
>         sbi->next_lock_num++;****
>
> +       spin_unlock(&sbi->spin_lock);****
>
> +****
>
> +       mutex_lock(&sbi->fs_lock[next_lock]);****
>
>         return next_lock;****
>
>  }****
>
>  ****
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c****
>
> old mode 100644****
>
> new mode 100755****
>
> index 75c7dc3..4f27596****
>
> --- a/fs/f2fs/super.c****
>
> +++ b/fs/f2fs/super.c****
>
> @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct super_block *sb,
> void *data, int silent)****
>
>         mutex_init(&sbi->cp_mutex);****
>
>         for (i = 0; i < NR_GLOBAL_LOCKS; i++)****
>
>                 mutex_init(&sbi->fs_lock[i]);****
>
> +       spin_lock_init(&sbi->spin_lock);****
>
>         mutex_init(&sbi->node_write);****
>
>         sbi->por_doing = 0;****
>
>         spin_lock_init(&sbi->stat_lock);****
>
> (END)****
>
> ** **
>
>
>
> ------------------------------------------------------------------------------
> Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
> Discover the easy way to master current and previous Microsoft technologies
> and advance your career. Get an incredible 1,500+ hours of step-by-step
> tutorial videos with LearnDevNow. Subscribe today and save!
> http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
>

--001a11c38c2e36052204e5bc0115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I encountered this same issue recently and solved it in mu=
ch the same way. =A0Can we rename &quot;spin_lock&quot; to something more m=
eaningful?<div><br></div><div>This race actually exposed a potential deadlo=
ck between f2fs_create() and f2fs_initxattrs():<div>

<br></div><div>- vfs_create()</div><div>=A0- f2fs_create() - takes an fs_lo=
ck</div><div>=A0 - f2fs_add_link()</div><div>=A0 =A0- __f2fs_add_link()</di=
v><div>=A0 =A0 - init_inode_metadata()</div><div>=A0 =A0 =A0- f2fs_init_sec=
urity()</div>
<div>
=A0 =A0 =A0 - security_inode_init_security()</div><div>=A0 =A0 =A0 =A0- f2f=
s_initxattrs()</div><div>=A0 =A0 =A0 =A0 - f2fs_setxattr() - also takes an =
fs_lock</div><div><br></div><div>If another CPU happens to have the same lo=
ck that=A0f2fs_setxattr() was trying to take because of the race around=A0n=
ext_lock_num, we can get into a deadlock situation if the two threads are a=
lso contending over another resource (like bdi).</div>

<div><br></div><div>Another scenario is if the above happens while another =
thread is in the middle of grabbing all of the locks via=A0mutex_lock_all()=
. =A0f2fs_create() is holding a lock that=A0mutex_lock_all() is waiting for=
 and=A0mutex_lock_all() is holding a lock that=A0f2fs_setxattr() is waiting=
 for.</div>

</div><div><br></div><div>Russ</div></div><div class=3D"gmail_extra"><br><b=
r><div class=3D"gmail_quote">On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <span =
dir=3D"ltr">&lt;<a href=3D"mailto:chao2.yu@samsung.com" target=3D"_blank">c=
hao2.yu@samsung.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">




<div><span lang=3D"EN-US">
<p><span lang=3D"EN-US">Hi Kim:<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><u></u>=A0=A0=A0=A0=A0<u></u></span><span lang=3D"E=
N-US">I think there is a performance problem: when all sbi-&gt;fs_lock is h=
olded, </span></p>
<p><span lang=3D"EN-US"></span><span lang=3D"EN-US">then all other threads =
may get the same next_lock value from sbi-&gt;next_lock_num in function mut=
ex_lock_op, </span></p>
<p><span lang=3D"EN-US">and wait to get the same lock at position fs_lock[n=
ext_lock], it unbalance the fs_lock usage. </span></p>
<p><span lang=3D"EN-US">It may lost performance when we do the multithread =
test.<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><u></u>=A0<u></u></span></p>
<p><span lang=3D"EN-US">Here is the patch to fix this problem:<u></u><u></u=
></span></p>
<p><span lang=3D"EN-US"><u></u>=A0<u></u></span></p>
<p><span lang=3D"EN-US">Signed-off-by: Yu Chao &lt;<a href=3D"mailto:chao2.=
yu@samsung.com" target=3D"_blank">chao2.yu@samsung.com</a>&gt;<u></u><u></u=
></span></p>
<p><span lang=3D"EN-US">diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h<u></u>=
<u></u></span></p>
<p><span lang=3D"EN-US">old mode 100644<u></u><u></u></span></p>
<p><span lang=3D"EN-US">new mode 100755<u></u><u></u></span></p>
<p><span lang=3D"EN-US">index 467d42d..983bb45<u></u><u></u></span></p>
<p><span lang=3D"EN-US">--- a/fs/f2fs/f2fs.h<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+++ b/fs/f2fs/f2fs.h<u></u><u></u></span></p>
<p><span lang=3D"EN-US">@@ -371,6 +371,7 @@ struct f2fs_sb_info {<u></u><u>=
</u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>struct mutex fs_=
lock[NR_GLOBAL_LOCKS];<span>=A0 </span>/* blocking FS operations */<u></u><=
u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>struct mutex nod=
e_write;<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>/* locki=
ng node writes */<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>struct mutex wri=
tepages;<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>/* mutex=
 for writepages() */<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>spinlock_t spin_lo=
ck;<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>/* l=
ock for next_lock_num */<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>unsigned char ne=
xt_lock_num;<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>/* round-robin g=
lobal locks */<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>int por_doing;<s=
pan>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 </span>/* recovery is doing or not */<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>int on_build_fre=
e_nids;<span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span>/* bui=
ld_free_nids is doing */<u></u><u></u></span></p>
<p><span lang=3D"EN-US">@@ -533,15 +534,19 @@ static inline void mutex_unlo=
ck_all(struct f2fs_sb_info *sbi)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span><u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span>static inline int mutex_lock_op(str=
uct f2fs_sb_info *sbi)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span>{<u></u><u></u></span></p>
<p><span lang=3D"EN-US">-<span>=A0=A0=A0=A0=A0=A0 </span>unsigned char next=
_lock =3D sbi-&gt;next_lock_num % NR_GLOBAL_LOCKS;<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>unsigned char next=
_lock;<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>int i =3D 0;<u><=
/u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span><u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>for (; i &lt; NR=
_GLOBAL_LOCKS; i++)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 </span>if (mutex_trylock(&amp;sbi-&gt;fs_lock[i]))<u></u><u></u></span></p=
>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0 </span><span>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0</span>return i;<u></u><u></u></span=
></p>
<p><span lang=3D"EN-US"><span>=A0</span><u></u><u></u></span></p>
<p><span lang=3D"EN-US">-<span>=A0=A0=A0=A0=A0=A0 </span>mutex_lock(&amp;sb=
i-&gt;fs_lock[next_lock]);<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>spin_lock(&amp;sbi=
-&gt;spin_lock);<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>next_lock =3D sbi-=
&gt;next_lock_num % NR_GLOBAL_LOCKS;<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>sbi-&gt;next_loc=
k_num++;<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>spin_unlock(&amp;s=
bi-&gt;spin_lock);<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>mutex_lock(&amp;sb=
i-&gt;fs_lock[next_lock]);<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>return next_lock=
;<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span>}<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0</span><u></u><u></u></span></p>
<p><span lang=3D"EN-US">diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c<u></=
u><u></u></span></p>
<p><span lang=3D"EN-US">old mode 100644<u></u><u></u></span></p>
<p><span lang=3D"EN-US">new mode 100755<u></u><u></u></span></p>
<p><span lang=3D"EN-US">index 75c7dc3..4f27596<u></u><u></u></span></p>
<p><span lang=3D"EN-US">--- a/fs/f2fs/super.c<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+++ b/fs/f2fs/super.c<u></u><u></u></span></p>
<p><span lang=3D"EN-US">@@ -657,6 +657,7 @@ static int f2fs_fill_super(stru=
ct super_block *sb, void *data, int silent)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>mutex_init(&amp;=
sbi-&gt;cp_mutex);<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>for (i =3D 0; i =
&lt; NR_GLOBAL_LOCKS; i++)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 </span>mutex_init(&amp;sbi-&gt;fs_lock[i]);<u></u><u></u></span></p>
<p><span lang=3D"EN-US">+<span>=A0=A0=A0=A0=A0=A0 </span>spin_lock_init(&am=
p;sbi-&gt;spin_lock);<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>mutex_init(&amp;=
sbi-&gt;node_write);<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>sbi-&gt;por_doin=
g =3D 0;<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><span>=A0=A0=A0=A0=A0=A0=A0 </span>spin_lock_init(&=
amp;sbi-&gt;stat_lock);<u></u><u></u></span></p>
<p><span lang=3D"EN-US">(END)<u></u><u></u></span></p>
<p><span lang=3D"EN-US"><u></u>=A0<u></u></span></p></span>
<table>
<tbody>
<tr>
<td>
<p><img border=3D"0" src=3D"cid:2XYNX48N0EB5@namo.co.kr" width=3D"520"></p>=
</td></tr></tbody></table></div><img border=3D"0" width=3D"0" height=3D"0">=
<br>-----------------------------------------------------------------------=
-------<br>


Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!<br>
Discover the easy way to master current and previous Microsoft technologies=
<br>
and advance your career. Get an incredible 1,500+ hours of step-by-step<br>
tutorial videos with LearnDevNow. Subscribe today and save!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D58041391&amp;iu=3D/4140/ostg.clktrk</a><br>___________________=
____________________________<br>


Linux-f2fs-devel mailing list<br>
<a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2fs-devel@=
lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel" t=
arget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/linux-f2fs-de=
vel</a><br>
<br></blockquote></div><br></div>

--001a11c38c2e36052204e5bc0115--

--001a11c38c2e36052404e5bc0116
Content-Type: image/gif; name="201309061748313_TIC2ESYT.gif"
Content-Transfer-Encoding: base64
Content-ID: <2XYNX48N0EB5@namo.co.kr>
X-Attachment-Id: ce79e56e6fdf3cc8_0.0.1

R0lGODlhCAKQAMQAAEdHR4yMjLm5uQICAtt0dCoqKumiotTU1PLExMpMTG9vb9RiYvfZ2fvt7eSO
juvr68k6Ov/+/jMzM////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C1hN
UCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtj
OWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUg
WE1QIENvcmUgNS4wLWMwNjAgNjEuMTM0Nzc3LCAyMDEwLzAyLzEyLTE3OjMyOjAwICAgICAgICAi
PiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5
bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0
cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9i
ZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFk
b2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjc5QkEy
RTkxMTJFMUUxMTFCRjA5ODE0RDA4NTQ0MEQyIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjk0
NUI4NzE1RTEyQzExRTFBNzY0RUYwRkU5MUQ4MTBGIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlk
Ojk0NUI4NzE0RTEyQzExRTFBNzY0RUYwRkU5MUQ4MTBGIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2Jl
IFBob3Rvc2hvcCBDUzUgV2luZG93cyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5j
ZUlEPSJ4bXAuaWlkOjdBQkEyRTkxMTJFMUUxMTFCRjA5ODE0RDA4NTQ0MEQyIiBzdFJlZjpkb2N1
bWVudElEPSJ4bXAuZGlkOjc5QkEyRTkxMTJFMUUxMTFCRjA5ODE0RDA4NTQ0MEQyIi8+IDwvcmRm
OkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+
Af/+/fz7+vn49/b19PPy8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnI
x8bFxMPCwcC/vr28u7q5uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCP
jo2Mi4qJiIeGhYSDgoGAf359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdW
VVRTUlFQT05NTEtKSUhHRkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4d
HBsaGRgXFhUUExIREA8ODQwLCgkIBwYFBAMCAQAAIfkEAAAAAAAsAAAAAAgCkAAABf/gI45kaZ5o
qq5s675wLM90bd94ru987/+5iXBILBqPyKRyyWw6n9CodEqtWq/YrHbL7Xq/VhF4TC6bz+i0es1u
u7Hit3xOr9vv+Lw+/Nj7/4CBgoOEdnGFiImKi4yNeodDEkSSSZRKkpYSmpNFmp6WS5mfkUKfmxOg
R6mkrKWnpa6eraimla+ioKu1sJWhRrqRo7y7qLGblKmZs6qdwsW/r8+0ub7Tt1TOzLq7uJydrbmm
0eJTsuDj1UaQvMPO26eY7MrL0sayyd/19JOr7NLzzwAC3Dev3z5wwajZoycumr536Ibl+5dwFD55
vyoiQ4hRYseJB6GRMsiKpD6K/pj/pTxpLVvGXgm9qesDEtjKjcVworyJRGFJc/1I6hzJEaVAfi45
YiLHUuPHozxBBjQn06dLYlTrXdxZVCdWpUVlnmOKM57KjQ1vNgzH1J5Jr2RbwuuKZJ3ZaVVfon3a
LOksagrjigzGCarRsVAKEo350uNOXA7lovPpz2pKw38nDpQnzDBUzBqzBvS2VxtCtnkrbxmaE2nP
sZGFQFKsWe89xiudWP6oOgrtx3wli45VMqzY0cG5NsGMjKpZ1qC19r0GzWrElj+dqxS72+JrpNE9
r1269vvuf9ejy6b5sD1DiSaxHSZd0/c31NmpX/HK0KZn4+l4FBl/0LlzX0jHwfQd/3D21QdWa9Pd
xiB4m1H2RHkMCnQMgOs1GFVpwoWW1F3xiTjgeAouuB2GFG5IHIL0JUeMW37JQaItJZbTVVrVzWhN
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
KnShDG2oQx+K0BAAADs=
--001a11c38c2e36052404e5bc0116--


--===============3478283541911614591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
--===============3478283541911614591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============3478283541911614591==--
