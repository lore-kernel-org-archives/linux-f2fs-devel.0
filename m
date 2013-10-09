From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do_checkpoint
 for better performance
Date: Wed, 09 Oct 2013 12:04:09 +0800
Message-ID: <5254D5B9.1040803@cn.fujitsu.com>
References: <30722427.272521381231813403.JavaMail.weblogic@epml26>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30722427.272521381231813403.JavaMail.weblogic@epml26>
Sender: linux-kernel-owner@vger.kernel.org
To: yuan.mark.zhong@samsung.com
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, shu tan <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yuan,
On 10/08/2013 07:30 PM, Yuan Zhong wrote:

> Hi Gu,
>=20
>> Hi Yuan,
>> On 10/08/2013 04:30 PM, Yuan Zhong wrote:
>=20
>>> Previously, do_checkpoint() will call congestion_wait() for waiting=
 the pages (previous submitted node/meta/data pages) to be written back=
=2E
>>> Because congestion_wait() will set a regular period (e.g. HZ / 50 )=
 for waiting.
>>> For this reason, there is a situation that after the pages have bee=
n written back,=20
>>> but the checkpoint thread still wait for congestion_wait to exit.
>=20
>> How do you confirm this issue?=20
>=20
>   I traced the execution path.
>   In f2fs_end_io_write, dec_page_count(p->sbi, F2FS_WRITEBACK) will b=
e called.
>   And I found that, when pages of F2FS_WRITEBACK has been zero, but
>   checkpoint thread still congestion_wait for pages of F2FS_WRITEBACK=
 to be zero.

Yes, it maybe. Congestion_wait add the task to a global wait queue whic=
h related to
all back devices, so if F2FS_WRITEBACK has been zero, but other io may =
be still going on.
Anyway, using a private wait queue to hold is a better choose.:)

=09
>   So, I think this point could be improved.
>   And I wrote a simple test case and tested on Micro-SD card, the ste=
ps as following:
>       (a) create a fixed-size file (4KB)
>       (b) go on to sync the file=20
>       (c) go back to step #a (fixed numbers of cycling:1024)=09
>    The results indicated that the execution time is reduced greatly b=
y using this patch.

Yes, the change is an improvement if the issue is existent.

 =20
>=20
>=20
>> I suspect that the block-core does not have a wake-up mechanism
>> when the back device is uncongested.
>=20
>=20
>   Yes, you are right.
>   So I wake up the checkpoint thread by myself, when pages of F2FS_WR=
ITEBACK to be zero.
>   In f2fs_end_io_write, f2fs_writeback_wait is called.
>   you cloud find this code in my patch.=20

Saw it.:)
But one problem is that the checkpoint routine always is singleton, so =
the wait queue just
services only one body, it seems not very worthy. How about just schedu=
le and wake up it
directly? See the following one.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   11 +++++++++--
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/segment.c    |    4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d808827..2a5999d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -757,8 +757,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi=
, bool is_umount)
 	f2fs_put_page(cp_page, 1);
=20
 	/* wait for previous submitted node/meta pages writeback */
-	while (get_pages(sbi, F2FS_WRITEBACK))
-		congestion_wait(BLK_RW_ASYNC, HZ / 50);
+	sbi->cp_task =3D current;
+	while (get_pages(sbi, F2FS_WRITEBACK)) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!get_pages(sbi, F2FS_WRITEBACK))
+			break;
+		io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	sbi->cp_task =3D NULL;
=20
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
 	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a955a59..408ace7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -365,6 +365,7 @@ struct f2fs_sb_info {
 	struct mutex writepages;		/* mutex for writepages() */
 	int por_doing;				/* recovery is doing or not */
 	int on_build_free_nids;			/* build_free_nids is doing */
+	struct task_struct *cp_task;		/* checkpoint task */
=20
 	/* for orphan inode management */
 	struct list_head orphan_inode_list;	/* orphan inode list */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bd79bbe..3b20359 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -597,6 +597,10 @@ static void f2fs_end_io_write(struct bio *bio, int=
 err)
=20
 	if (p->is_sync)
 		complete(p->wait);
+
+	if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
+		wake_up_process(p->sbi->cp_task);
+
 	kfree(p);
 	bio_put(bio);
 }
--=20
1.7.7

Regards,
Gu=20

>=20
>=20
>>> This is a problem here, especially, when sync a large number of sma=
ll files or dirs.
>>> In order to avoid this, a wait_list is introduced,=20
>>> the checkpoint thread will be dropped into the wait_list if the pag=
es have not been written back,=20
>>> and will be waked up by contrast.
>=20
>> Please pay some attention to the mail form, this mail is out of form=
at in my mail client.
>=20
>> Regards,
>> Gu
>=20
> Regards,
> Yuan
>=20
>>>
>>> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
>>> --- =20
>>>  fs/f2fs/checkpoint.c |    3 +--
>>>  fs/f2fs/f2fs.h       |   19 +++++++++++++++++++
>>>  fs/f2fs/segment.c    |    1 +
>>>  fs/f2fs/super.c      |    1 +
>>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index ca39442..5d69ae0 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -758,8 +758,7 @@ static void do_checkpoint(struct f2fs_sb_info *=
sbi, bool is_umount)
>>>  	f2fs_put_page(cp_page, 1);
>>> =20
>>>  	/* wait for previous submitted node/meta pages writeback */
>>> -	while (get_pages(sbi, F2FS_WRITEBACK))
>>> -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
>>> +	f2fs_writeback_wait(sbi);
>>> =20
>>>  	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
>>>  	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 7fd99d8..4b0d70e 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -18,6 +18,8 @@
>>>  #include <linux/crc32.h>
>>>  #include <linux/magic.h>
>>>  #include <linux/kobject.h>
>>> +#include <linux/wait.h>
>>> +#include <linux/sched.h>
>>> =20
>>>  /*
>>>   * For mount options
>>> @@ -368,6 +370,7 @@ struct f2fs_sb_info {
>>>  	struct mutex fs_lock[NR_GLOBAL_LOCKS];	/* blocking FS operations =
*/
>>>  	struct mutex node_write;		/* locking node writes */
>>>  	struct mutex writepages;		/* mutex for writepages() */
>>> +	wait_queue_head_t writeback_wqh;	/* wait_queue for writeback */
>>>  	unsigned char next_lock_num;		/* round-robin global locks */
>>>  	int por_doing;				/* recovery is doing or not */
>>>  	int on_build_free_nids;			/* build_free_nids is doing */
>>> @@ -961,6 +964,22 @@ static inline int f2fs_readonly(struct super_b=
lock *sb)
>>>  	return sb->s_flags & MS_RDONLY;
>>>  }
>>> =20
>>> +static inline void f2fs_writeback_wait(struct f2fs_sb_info *sbi)
>>> +{
>>> +	DEFINE_WAIT(wait);
>>> +
>>> +	prepare_to_wait(&sbi->writeback_wqh, &wait, TASK_UNINTERRUPTIBLE)=
;
>>> +	if (get_pages(sbi, F2FS_WRITEBACK))
>>> +		io_schedule();
>>> +	finish_wait(&sbi->writeback_wqh, &wait);
>>> +}
>>> +
>>> +static inline void f2fs_writeback_wake(struct f2fs_sb_info *sbi)
>>> +{
>>> +	if (!get_pages(sbi, F2FS_WRITEBACK))
>>> +		wake_up_all(&sbi->writeback_wqh);
>>> +}
>>> +
>>>  /*
>>>   * file.c
>>>   */
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index bd79bbe..0708aa9 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -597,6 +597,7 @@ static void f2fs_end_io_write(struct bio *bio, =
int err)
>>> =20
>>>  	if (p->is_sync)
>>>  		complete(p->wait);
>>> +	f2fs_writeback_wake(p->sbi);
>>>  	kfree(p);
>>>  	bio_put(bio);
>>>  }
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 094ccc6..3ac6d85 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -835,6 +835,7 @@ static int f2fs_fill_super(struct super_block *=
sb, void *data, int silent)
>>>  	mutex_init(&sbi->gc_mutex);
>>>  	mutex_init(&sbi->writepages);
>>>  	mutex_init(&sbi->cp_mutex);
>>> +	init_waitqueue_head(&sbi->writeback_wqh);
>>>  	for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>>>  		mutex_init(&sbi->fs_lock[i]);
>>>  	mutex_init(&sbi->node_write);N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8=
b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=B6=
=17=9B=A1=DC=A8}=A9=9E=B2=C6 z=DA&j:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=CA=
+zf=A3=A2=B7h=9A=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=A8=
=E8=AD=DA&=A2)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C0=
=B6=ECh=AE=0F=E5=92i=7F
