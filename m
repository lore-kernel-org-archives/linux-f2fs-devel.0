From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: optimize fs_lock for better performance
Date: Tue, 10 Sep 2013 09:55:03 +0900
Message-ID: <1378774503.2354.106.camel@kjgkr>
References: <02.95.21086.AD4A9225@epcpsbgx4.samsung.com>
 <CAGfvh62EGuQfGBRhasNEXAVEvS2BwKCijnAS67f+GL2fHS-fTA@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <CAGfvh62EGuQfGBRhasNEXAVEvS2BwKCijnAS67f+GL2fHS-fTA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Russ Knize <Russ.Knize@motorola.com>
Cc: chao2.yu@samsung.com, linux-fsdevel@vger.kernel.org, shu.tan@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Nice catch.
This is definitely a bug where one thread grabbed two fs_locks across
the same flow.
Any idea?
Thanks,

2013-09-06 (=EA=B8=88), 14:25 -0500, Russ Knize:
> I encountered this same issue recently and solved it in much the same
> way.  Can we rename "spin_lock" to something more meaningful?
>=20
>=20
> This race actually exposed a potential deadlock between f2fs_create()
> and f2fs_initxattrs():
>=20
>=20
> - vfs_create()
>  - f2fs_create() - takes an fs_lock
>   - f2fs_add_link()
>    - __f2fs_add_link()
>     - init_inode_metadata()
>      - f2fs_init_security()
>       - security_inode_init_security()
>        - f2fs_initxattrs()
>         - f2fs_setxattr() - also takes an fs_lock
>=20
>=20
> If another CPU happens to have the same lock that f2fs_setxattr() was
> trying to take because of the race around next_lock_num, we can get
> into a deadlock situation if the two threads are also contending over
> another resource (like bdi).
>=20
>=20
> Another scenario is if the above happens while another thread is in
> the middle of grabbing all of the locks via mutex_lock_all().
>  f2fs_create() is holding a lock that mutex_lock_all() is waiting for
> and mutex_lock_all() is holding a lock that f2fs_setxattr() is waitin=
g
> for.
>=20
>=20
> Russ
>=20
>=20
> On Fri, Sep 6, 2013 at 4:48 AM, Chao Yu <chao2.yu@samsung.com> wrote:
>         Hi Kim:
>        =20
>              I think there is a performance problem: when all
>         sbi->fs_lock is holded,=20
>        =20
>         then all other threads may get the same next_lock value from
>         sbi->next_lock_num in function mutex_lock_op,=20
>        =20
>         and wait to get the same lock at position fs_lock[next_lock],
>         it unbalance the fs_lock usage.=20
>        =20
>         It may lost performance when we do the multithread test.
>        =20
>         =20
>        =20
>         Here is the patch to fix this problem:
>        =20
>         =20
>        =20
>         Signed-off-by: Yu Chao <chao2.yu@samsung.com>
>        =20
>         diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>        =20
>         old mode 100644
>        =20
>         new mode 100755
>        =20
>         index 467d42d..983bb45
>        =20
>         --- a/fs/f2fs/f2fs.h
>        =20
>         +++ b/fs/f2fs/f2fs.h
>        =20
>         @@ -371,6 +371,7 @@ struct f2fs_sb_info {
>        =20
>                 struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* blocking F=
S
>         operations */
>        =20
>                 struct mutex node_write;                /* locking
>         node writes */
>        =20
>                 struct mutex writepages;                /* mutex for
>         writepages() */
>        =20
>         +       spinlock_t spin_lock;                   /* lock for
>         next_lock_num */
>        =20
>                 unsigned char next_lock_num;            /* round-robi=
n
>         global locks */
>        =20
>                 int por_doing;                          /* recovery i=
s
>         doing or not */
>        =20
>                 int on_build_free_nids;                 /*
>         build_free_nids is doing */
>        =20
>         @@ -533,15 +534,19 @@ static inline void
>         mutex_unlock_all(struct f2fs_sb_info *sbi)
>        =20
>         =20
>        =20
>          static inline int mutex_lock_op(struct f2fs_sb_info *sbi)
>        =20
>          {
>        =20
>         -       unsigned char next_lock =3D sbi->next_lock_num %
>         NR_GLOBAL_LOCKS;
>        =20
>         +       unsigned char next_lock;
>        =20
>                 int i =3D 0;
>        =20
>         =20
>        =20
>                 for (; i < NR_GLOBAL_LOCKS; i++)
>        =20
>                         if (mutex_trylock(&sbi->fs_lock[i]))
>        =20
>                                 return i;
>        =20
>         =20
>        =20
>         -       mutex_lock(&sbi->fs_lock[next_lock]);
>        =20
>         +       spin_lock(&sbi->spin_lock);
>        =20
>         +       next_lock =3D sbi->next_lock_num % NR_GLOBAL_LOCKS;
>        =20
>                 sbi->next_lock_num++;
>        =20
>         +       spin_unlock(&sbi->spin_lock);
>        =20
>         +
>        =20
>         +       mutex_lock(&sbi->fs_lock[next_lock]);
>        =20
>                 return next_lock;
>        =20
>          }
>        =20
>         =20
>        =20
>         diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>        =20
>         old mode 100644
>        =20
>         new mode 100755
>        =20
>         index 75c7dc3..4f27596
>        =20
>         --- a/fs/f2fs/super.c
>        =20
>         +++ b/fs/f2fs/super.c
>        =20
>         @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct
>         super_block *sb, void *data, int silent)
>        =20
>                 mutex_init(&sbi->cp_mutex);
>        =20
>                 for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>        =20
>                         mutex_init(&sbi->fs_lock[i]);
>        =20
>         +       spin_lock_init(&sbi->spin_lock);
>        =20
>                 mutex_init(&sbi->node_write);
>        =20
>                 sbi->por_doing =3D 0;
>        =20
>                 spin_lock_init(&sbi->stat_lock);
>        =20
>         (END)
>        =20
>         =20
>        =20
>        =20
>        =20
>        =20
>        =20
>         -------------------------------------------------------------=
-----------------
>         Learn the latest--Visual Studio 2012, SharePoint 2013, SQL
>         2012, more!
>         Discover the easy way to master current and previous Microsof=
t
>         technologies
>         and advance your career. Get an incredible 1,500+ hours of
>         step-by-step
>         tutorial videos with LearnDevNow. Subscribe today and save!
>         http://pubads.g.doubleclick.net/gampad/clk?id=3D58041391&iu=3D=
/4140/ostg.clktrk
>         _______________________________________________
>         Linux-f2fs-devel mailing list
>         Linux-f2fs-devel@lists.sourceforge.net
>         https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>        =20
>=20
>=20

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
