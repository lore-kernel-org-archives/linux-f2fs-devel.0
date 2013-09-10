From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev][PATCH] f2fs: optimize fs_lock for better performance
Date: Tue, 10 Sep 2013 09:52:04 +0900
Message-ID: <1378774324.2354.103.camel@kjgkr>
References: <88.C4.11914.9D4A9225@epcpsbge6.samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <88.C4.11914.9D4A9225@epcpsbge6.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chao2.yu@samsung.com
Cc: shu.tan@samsung.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

At first, thank you for the report and please follow the email writing
rules. :)

Anyway, I agree to the below issue.
One thing that I can think of is that we don't need to use the
spin_lock, since we don't care about the exact lock number, but just
need to get any not-collided number.

So, how about removing the spin_lock?
And how about using a random number?
Thanks,

2013-09-06 (=EA=B8=88), 09:48 +0000, Chao Yu:
> Hi Kim:
>=20
>      I think there is a performance problem: when all sbi->fs_lock is
> holded,=20
>=20
> then all other threads may get the same next_lock value from
> sbi->next_lock_num in function mutex_lock_op,=20
>=20
> and wait to get the same lock at position fs_lock[next_lock], it
> unbalance the fs_lock usage.=20
>=20
> It may lost performance when we do the multithread test.
>=20
> =20
>=20
> Here is the patch to fix this problem:
>=20
> =20
>=20
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>=20
> old mode 100644
>=20
> new mode 100755
>=20
> index 467d42d..983bb45
>=20
> --- a/fs/f2fs/f2fs.h
>=20
> +++ b/fs/f2fs/f2fs.h
>=20
> @@ -371,6 +371,7 @@ struct f2fs_sb_info {
>=20
>         struct mutex fs_lock[NR_GLOBAL_LOCKS];  /* blocking FS
> operations */
>=20
>         struct mutex node_write;                /* locking node write=
s
> */
>=20
>         struct mutex writepages;                /* mutex for
> writepages() */
>=20
> +       spinlock_t spin_lock;                   /* lock for
> next_lock_num */
>=20
>         unsigned char next_lock_num;            /* round-robin global
> locks */
>=20
>         int por_doing;                          /* recovery is doing
> or not */
>=20
>         int on_build_free_nids;                 /* build_free_nids is
> doing */
>=20
> @@ -533,15 +534,19 @@ static inline void mutex_unlock_all(struct
> f2fs_sb_info *sbi)
>=20
> =20
>=20
>  static inline int mutex_lock_op(struct f2fs_sb_info *sbi)
>=20
>  {
>=20
> -       unsigned char next_lock =3D sbi->next_lock_num %
> NR_GLOBAL_LOCKS;
>=20
> +       unsigned char next_lock;
>=20
>         int i =3D 0;
>=20
> =20
>=20
>         for (; i < NR_GLOBAL_LOCKS; i++)
>=20
>                 if (mutex_trylock(&sbi->fs_lock[i]))
>=20
>                         return i;
>=20
> =20
>=20
> -       mutex_lock(&sbi->fs_lock[next_lock]);
>=20
> +       spin_lock(&sbi->spin_lock);
>=20
> +       next_lock =3D sbi->next_lock_num % NR_GLOBAL_LOCKS;
>=20
>         sbi->next_lock_num++;
>=20
> +       spin_unlock(&sbi->spin_lock);
>=20
> +
>=20
> +       mutex_lock(&sbi->fs_lock[next_lock]);
>=20
>         return next_lock;
>=20
>  }
>=20
> =20
>=20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>=20
> old mode 100644
>=20
> new mode 100755
>=20
> index 75c7dc3..4f27596
>=20
> --- a/fs/f2fs/super.c
>=20
> +++ b/fs/f2fs/super.c
>=20
> @@ -657,6 +657,7 @@ static int f2fs_fill_super(struct super_block *sb=
,
> void *data, int silent)
>=20
>         mutex_init(&sbi->cp_mutex);
>=20
>         for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>=20
>                 mutex_init(&sbi->fs_lock[i]);
>=20
> +       spin_lock_init(&sbi->spin_lock);
>=20
>         mutex_init(&sbi->node_write);
>=20
>         sbi->por_doing =3D 0;
>=20
>         spin_lock_init(&sbi->stat_lock);
>=20
> (END)
>=20
> =20
>=20
>=20
>=20
>=20

--=20
Jaegeuk Kim
Samsung
