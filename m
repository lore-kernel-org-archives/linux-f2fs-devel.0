From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do_checkpoint
 for better performance
Date: Fri, 11 Oct 2013 10:16:05 +0800
Message-ID: <52575F65.4050904@cn.fujitsu.com>
References: <30722427.272521381231813403.JavaMail.weblogic@epml26>,<5254D5B9.1040803@cn.fujitsu.com> <BLU175-W48D340F1A4D0966D8895D0B41E0@phx.gbl>,<52566149.1030702@cn.fujitsu.com> <BLU175-W378B020AC54C62046132AAB41E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BLU175-W378B020AC54C62046132AAB41E0@phx.gbl>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jin Xu <jinuxstyle@live.com>
Cc: "yuan.mark.zhong@samsung.com" <yuan.mark.zhong@samsung.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, shu tan <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jin,
On 10/11/2013 07:54 AM, Jin Xu wrote:

>> Date: Thu, 10 Oct 2013 16:11:53 +0800
>> From: guz.fnst@cn.fujitsu.com
>> To: jinuxstyle@live.com
>> CC: yuan.mark.zhong@samsung.com; jaegeuk.kim@samsung.com; linux-f2fs=
-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; linux-fsdev=
el@vger.kernel.org; shu.tan@samsung.com
>> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when =
do_checkpoint for better performance
>>
>> Hi Jin,
>>
>> On 10/10/2013 04:09 PM, Jin Xu wrote:
>>
>> > Hi Gu,
>> >
>> > I have a comment below.
>> >
>> >> Date: Wed, 9 Oct 2013 12:04:09 +0800
>> >> From: guz.fnst@cn.fujitsu.com
>> >> To: yuan.mark.zhong@samsung.com
>> >> CC: jaegeuk.kim@samsung.com; linux-f2fs-devel@lists.sourceforge.n=
et; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; shu.ta=
n@samsung.com
>> >> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait wh=
en do_checkpoint for better performance
>> >>
>> >> Hi Yuan,
>> >> On 10/08/2013 07:30 PM, Yuan Zhong wrote:
>> >>
>> > ...
>> >>
>> >> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> >> ---
>> >> fs/f2fs/checkpoint.c | 11 +++++++++--
>> >> fs/f2fs/f2fs.h | 1 +
>> >> fs/f2fs/segment.c | 4 ++++
>> >> 3 files changed, 14 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> >> index d808827..2a5999d 100644
>> >> --- a/fs/f2fs/checkpoint.c
>> >> +++ b/fs/f2fs/checkpoint.c
>> >> @@ -757,8 +757,15 @@ static void do_checkpoint(struct f2fs_sb_inf=
o *sbi, bool is_umount)
>> >> f2fs_put_page(cp_page, 1);
>> >>
>> >> /* wait for previous submitted node/meta pages writeback */
>> >> - while (get_pages(sbi, F2FS_WRITEBACK))
>> >> - congestion_wait(BLK_RW_ASYNC, HZ / 50);
>> >> + sbi->cp_task =3D current;
>> >> + while (get_pages(sbi, F2FS_WRITEBACK)) {
>> >> + set_current_state(TASK_UNINTERRUPTIBLE);
>> >> + if (!get_pages(sbi, F2FS_WRITEBACK))
>> >> + break;
>> >> + io_schedule();
>> >> + }
>> >> + __set_current_state(TASK_RUNNING);
>> >> + sbi->cp_task =3D NULL;
>> >>
>> >> filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
>> >> filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
>> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> >> index a955a59..408ace7 100644
>> >> --- a/fs/f2fs/f2fs.h
>> >> +++ b/fs/f2fs/f2fs.h
>> >> @@ -365,6 +365,7 @@ struct f2fs_sb_info {
>> >> struct mutex writepages; /* mutex for writepages() */
>> >> int por_doing; /* recovery is doing or not */
>> >> int on_build_free_nids; /* build_free_nids is doing */
>> >> + struct task_struct *cp_task; /* checkpoint task */
>> >>
>> >> /* for orphan inode management */
>> >> struct list_head orphan_inode_list; /* orphan inode list */
>> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> >> index bd79bbe..3b20359 100644
>> >> --- a/fs/f2fs/segment.c
>> >> +++ b/fs/f2fs/segment.c
>> >> @@ -597,6 +597,10 @@ static void f2fs_end_io_write(struct bio *bi=
o, int err)
>> >>
>> >> if (p->is_sync)
>> >> complete(p->wait);
>> >> +
>> >> + if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
>> >> + wake_up_process(p->sbi->cp_task);
>> >
>> > There is a risk of dereferencing a NULL pointer because here simpl=
y comparing the
>> > cp_task against NULL is not enough to avoid race in multi-thread e=
nvironment.
>> > Another thread could have assigned it to NULL in the window betwee=
n the comparison
>> > and waking up.
>>
>> Can not be that, checkpoint routine is always singleton and protecte=
d by cp_mutex and cp_rwsem.
>>=20
>=20
> The race could happen like this for example:
> On a SMP environment, thread 1 wakes up the checkpoint thread, then
> thread 2 comes to the f2fs_end_io_write, compared the cp_task as not =
NULL,
> but at the same time, the checkpoint thread just assigned the cp_task=
 to NULL.
> When thread 2 gets to the wake_up_process, dereferencing to NULL poin=
ter
> happens.

The case means that two or more IO are going on. If thread 1 wake up ch=
eckpoint, it'll check
get_pages(p->sbi, F2FS_WRITEBACK) before going down to assign the cp_ta=
sk to NULL, so when
thread 2 gets to the wake_up_process the cp_task is still valid.=20
The "while (get_pages(sbi, F2FS_WRITEBACK))" loop is used to avoid this=
 issue.

Thanks,
Gu

>=20
> Jin
>=20
>> Thanks,
>> Gu=20
>>
>> >
>> > Regards,
>> > Jin
>> >> +
>> >> kfree(p);
>> >> bio_put(bio);
>> >> }
>> >> --
>> >> 1.7.7
>> >>
>> >> Regards,
>> >> Gu
>> >>
>> >> >
>> >> >
>> >> >>> This is a problem here, especially, when sync a large number =
of small files or dirs.
>> >> >>> In order to avoid this, a wait_list is introduced,
>> >> >>> the checkpoint thread will be dropped into the wait_list if t=
he pages have not been written back,
>> >> >>> and will be waked up by contrast.
>> >> >
>> >> >> Please pay some attention to the mail form, this mail is out o=
f format in my mail client.
>> >> >
>> >> >> Regards,
>> >> >> Gu
>> >> >
>> >> > Regards,
>> >> > Yuan
>> >> >
>> >> >>>
>> >> >>> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
>> >> >>> ---
>> >> >>> fs/f2fs/checkpoint.c | 3 +--
>> >> >>> fs/f2fs/f2fs.h | 19 +++++++++++++++++++
>> >> >>> fs/f2fs/segment.c | 1 +
>> >> >>> fs/f2fs/super.c | 1 +
>> >> >>> 4 files changed, 22 insertions(+), 2 deletions(-)
>> >> >>>
>> >> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> >> >>> index ca39442..5d69ae0 100644
>> >> >>> --- a/fs/f2fs/checkpoint.c
>> >> >>> +++ b/fs/f2fs/checkpoint.c
>> >> >>> @@ -758,8 +758,7 @@ static void do_checkpoint(struct f2fs_sb_=
info *sbi, bool is_umount)
>> >> >>> f2fs_put_page(cp_page, 1);
>> >> >>>
>> >> >>> /* wait for previous submitted node/meta pages writeback */
>> >> >>> - while (get_pages(sbi, F2FS_WRITEBACK))
>> >> >>> - congestion_wait(BLK_RW_ASYNC, HZ / 50);
>> >> >>> + f2fs_writeback_wait(sbi);
>> >> >>>
>> >> >>> filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_M=
AX);
>> >> >>> filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_M=
AX);
>> >> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> >> >>> index 7fd99d8..4b0d70e 100644
>> >> >>> --- a/fs/f2fs/f2fs.h
>> >> >>> +++ b/fs/f2fs/f2fs.h
>> >> >>> @@ -18,6 +18,8 @@
>> >> >>> #include <linux/crc32.h>
>> >> >>> #include <linux/magic.h>
>> >> >>> #include <linux/kobject.h>
>> >> >>> +#include <linux/wait.h>
>> >> >>> +#include <linux/sched.h>
>> >> >>>
>> >> >>> /*
>> >> >>> * For mount options
>> >> >>> @@ -368,6 +370,7 @@ struct f2fs_sb_info {
>> >> >>> struct mutex fs_lock[NR_GLOBAL_LOCKS]; /* blocking FS operati=
ons */
>> >> >>> struct mutex node_write; /* locking node writes */
>> >> >>> struct mutex writepages; /* mutex for writepages() */
>> >> >>> + wait_queue_head_t writeback_wqh; /* wait_queue for writebac=
k */
>> >> >>> unsigned char next_lock_num; /* round-robin global locks */
>> >> >>> int por_doing; /* recovery is doing or not */
>> >> >>> int on_build_free_nids; /* build_free_nids is doing */
>> >> >>> @@ -961,6 +964,22 @@ static inline int f2fs_readonly(struct s=
uper_block *sb)
>> >> >>> return sb->s_flags & MS_RDONLY;
>> >> >>> }
>> >> >>>
>> >> >>> +static inline void f2fs_writeback_wait(struct f2fs_sb_info *=
sbi)
>> >> >>> +{
>> >> >>> + DEFINE_WAIT(wait);
>> >> >>> +
>> >> >>> + prepare_to_wait(&sbi->writeback_wqh, &wait, TASK_UNINTERRUP=
TIBLE);
>> >> >>> + if (get_pages(sbi, F2FS_WRITEBACK))
>> >> >>> + io_schedule();
>> >> >>> + finish_wait(&sbi->writeback_wqh, &wait);
>> >> >>> +}
>> >> >>> +
>> >> >>> +static inline void f2fs_writeback_wake(struct f2fs_sb_info *=
sbi)
>> >> >>> +{
>> >> >>> + if (!get_pages(sbi, F2FS_WRITEBACK))
>> >> >>> + wake_up_all(&sbi->writeback_wqh);
>> >> >>> +}
>> >> >>> +
>> >> >>> /*
>> >> >>> * file.c
>> >> >>> */
>> >> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> >> >>> index bd79bbe..0708aa9 100644
>> >> >>> --- a/fs/f2fs/segment.c
>> >> >>> +++ b/fs/f2fs/segment.c
>> >> >>> @@ -597,6 +597,7 @@ static void f2fs_end_io_write(struct bio =
*bio, int err)
>> >> >>>
>> >> >>> if (p->is_sync)
>> >> >>> complete(p->wait);
>> >> >>> + f2fs_writeback_wake(p->sbi);
>> >> >>> kfree(p);
>> >> >>> bio_put(bio);
>> >> >>> }
>> >> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> >> >>> index 094ccc6..3ac6d85 100644
>> >> >>> --- a/fs/f2fs/super.c
>> >> >>> +++ b/fs/f2fs/super.c
>> >> >>> @@ -835,6 +835,7 @@ static int f2fs_fill_super(struct super_b=
lock *sb, void *data, int silent)
>> >> >>> mutex_init(&sbi->gc_mutex);
>> >> >>> mutex_init(&sbi->writepages);
>> >> >>> mutex_init(&sbi->cp_mutex);
>> >> >>> + init_waitqueue_head(&sbi->writeback_wqh);
>> >> >>> for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>> >> >>> mutex_init(&sbi->fs_lock[i]);
>> >> >>> mutex_init(&sbi->node_write);N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=
=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=
=B6=17=9B=A1=DC=A8}=A9=9E=B2=C6 z=DA&j:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=
=CA+zf=A3=A2=B7h=9A=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=
=A8=E8=AD=DA&=A2)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C=
0=B6=ECh=AE=0F=E5=92i=7F
>> >>
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-f=
sdevel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsde=
vel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
