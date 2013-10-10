From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] f2fs: avoid congestion_wait when
 do_checkpoint for better performance
Date: Thu, 10 Oct 2013 16:11:53 +0800
Message-ID: <52566149.1030702@cn.fujitsu.com>
References: <30722427.272521381231813403.JavaMail.weblogic@epml26>,
	<5254D5B9.1040803@cn.fujitsu.com>
	<BLU175-W48D340F1A4D0966D8895D0B41E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VUBek-0001hp-VB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 08:31:39 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VUBei-0005iN-SC for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 08:31:38 +0000
In-Reply-To: <BLU175-W48D340F1A4D0966D8895D0B41E0@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jin Xu <jinuxstyle@live.com>
Cc: shu tan <shu.tan@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

Hi Jin,

On 10/10/2013 04:09 PM, Jin Xu wrote:

> Hi Gu,
> =

> I have a comment below.
> =

>> Date: Wed, 9 Oct 2013 12:04:09 +0800
>> From: guz.fnst@cn.fujitsu.com
>> To: yuan.mark.zhong@samsung.com
>> CC: jaegeuk.kim@samsung.com; linux-f2fs-devel@lists.sourceforge.net; lin=
ux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; shu.tan@samsung.c=
om
>> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do_c=
heckpoint for better performance
>>
>> Hi Yuan,
>> On 10/08/2013 07:30 PM, Yuan Zhong wrote:
>>
> ...
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> ---
>> fs/f2fs/checkpoint.c | 11 +++++++++--
>> fs/f2fs/f2fs.h | 1 +
>> fs/f2fs/segment.c | 4 ++++
>> 3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index d808827..2a5999d 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -757,8 +757,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi,=
 bool is_umount)
>> f2fs_put_page(cp_page, 1);
>>
>> /* wait for previous submitted node/meta pages writeback */
>> - while (get_pages(sbi, F2FS_WRITEBACK))
>> - congestion_wait(BLK_RW_ASYNC, HZ / 50);
>> + sbi->cp_task =3D current;
>> + while (get_pages(sbi, F2FS_WRITEBACK)) {
>> + set_current_state(TASK_UNINTERRUPTIBLE);
>> + if (!get_pages(sbi, F2FS_WRITEBACK))
>> + break;
>> + io_schedule();
>> + }
>> + __set_current_state(TASK_RUNNING);
>> + sbi->cp_task =3D NULL;
>>
>> filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
>> filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a955a59..408ace7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -365,6 +365,7 @@ struct f2fs_sb_info {
>> struct mutex writepages; /* mutex for writepages() */
>> int por_doing; /* recovery is doing or not */
>> int on_build_free_nids; /* build_free_nids is doing */
>> + struct task_struct *cp_task; /* checkpoint task */
>>
>> /* for orphan inode management */
>> struct list_head orphan_inode_list; /* orphan inode list */
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index bd79bbe..3b20359 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -597,6 +597,10 @@ static void f2fs_end_io_write(struct bio *bio, int =
err)
>>
>> if (p->is_sync)
>> complete(p->wait);
>> +
>> + if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
>> + wake_up_process(p->sbi->cp_task);
> =

> There is a risk of dereferencing a NULL pointer because here simply compa=
ring the
> cp_task against NULL is not enough to avoid race in multi-thread environm=
ent.
> Another thread could have assigned it to NULL in the window between the c=
omparison
> and waking up.

Can not be that, checkpoint routine is always singleton and protected by cp=
_mutex and cp_rwsem.

Thanks,
Gu

> =

> Regards,
> Jin
>> +
>> kfree(p);
>> bio_put(bio);
>> }
>> --
>> 1.7.7
>>
>> Regards,
>> Gu
>>
>> >
>> >
>> >>> This is a problem here, especially, when sync a large number of smal=
l files or dirs.
>> >>> In order to avoid this, a wait_list is introduced,
>> >>> the checkpoint thread will be dropped into the wait_list if the page=
s have not been written back,
>> >>> and will be waked up by contrast.
>> >
>> >> Please pay some attention to the mail form, this mail is out of forma=
t in my mail client.
>> >
>> >> Regards,
>> >> Gu
>> >
>> > Regards,
>> > Yuan
>> >
>> >>>
>> >>> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
>> >>> ---
>> >>> fs/f2fs/checkpoint.c | 3 +--
>> >>> fs/f2fs/f2fs.h | 19 +++++++++++++++++++
>> >>> fs/f2fs/segment.c | 1 +
>> >>> fs/f2fs/super.c | 1 +
>> >>> 4 files changed, 22 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> >>> index ca39442..5d69ae0 100644
>> >>> --- a/fs/f2fs/checkpoint.c
>> >>> +++ b/fs/f2fs/checkpoint.c
>> >>> @@ -758,8 +758,7 @@ static void do_checkpoint(struct f2fs_sb_info *s=
bi, bool is_umount)
>> >>> f2fs_put_page(cp_page, 1);
>> >>>
>> >>> /* wait for previous submitted node/meta pages writeback */
>> >>> - while (get_pages(sbi, F2FS_WRITEBACK))
>> >>> - congestion_wait(BLK_RW_ASYNC, HZ / 50);
>> >>> + f2fs_writeback_wait(sbi);
>> >>>
>> >>> filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
>> >>> filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
>> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> >>> index 7fd99d8..4b0d70e 100644
>> >>> --- a/fs/f2fs/f2fs.h
>> >>> +++ b/fs/f2fs/f2fs.h
>> >>> @@ -18,6 +18,8 @@
>> >>> #include <linux/crc32.h>
>> >>> #include <linux/magic.h>
>> >>> #include <linux/kobject.h>
>> >>> +#include <linux/wait.h>
>> >>> +#include <linux/sched.h>
>> >>>
>> >>> /*
>> >>> * For mount options
>> >>> @@ -368,6 +370,7 @@ struct f2fs_sb_info {
>> >>> struct mutex fs_lock[NR_GLOBAL_LOCKS]; /* blocking FS operations */
>> >>> struct mutex node_write; /* locking node writes */
>> >>> struct mutex writepages; /* mutex for writepages() */
>> >>> + wait_queue_head_t writeback_wqh; /* wait_queue for writeback */
>> >>> unsigned char next_lock_num; /* round-robin global locks */
>> >>> int por_doing; /* recovery is doing or not */
>> >>> int on_build_free_nids; /* build_free_nids is doing */
>> >>> @@ -961,6 +964,22 @@ static inline int f2fs_readonly(struct super_bl=
ock *sb)
>> >>> return sb->s_flags & MS_RDONLY;
>> >>> }
>> >>>
>> >>> +static inline void f2fs_writeback_wait(struct f2fs_sb_info *sbi)
>> >>> +{
>> >>> + DEFINE_WAIT(wait);
>> >>> +
>> >>> + prepare_to_wait(&sbi->writeback_wqh, &wait, TASK_UNINTERRUPTIBLE);
>> >>> + if (get_pages(sbi, F2FS_WRITEBACK))
>> >>> + io_schedule();
>> >>> + finish_wait(&sbi->writeback_wqh, &wait);
>> >>> +}
>> >>> +
>> >>> +static inline void f2fs_writeback_wake(struct f2fs_sb_info *sbi)
>> >>> +{
>> >>> + if (!get_pages(sbi, F2FS_WRITEBACK))
>> >>> + wake_up_all(&sbi->writeback_wqh);
>> >>> +}
>> >>> +
>> >>> /*
>> >>> * file.c
>> >>> */
>> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> >>> index bd79bbe..0708aa9 100644
>> >>> --- a/fs/f2fs/segment.c
>> >>> +++ b/fs/f2fs/segment.c
>> >>> @@ -597,6 +597,7 @@ static void f2fs_end_io_write(struct bio *bio, i=
nt err)
>> >>>
>> >>> if (p->is_sync)
>> >>> complete(p->wait);
>> >>> + f2fs_writeback_wake(p->sbi);
>> >>> kfree(p);
>> >>> bio_put(bio);
>> >>> }
>> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> >>> index 094ccc6..3ac6d85 100644
>> >>> --- a/fs/f2fs/super.c
>> >>> +++ b/fs/f2fs/super.c
>> >>> @@ -835,6 +835,7 @@ static int f2fs_fill_super(struct super_block *s=
b, void *data, int silent)
>> >>> mutex_init(&sbi->gc_mutex);
>> >>> mutex_init(&sbi->writepages);
>> >>> mutex_init(&sbi->cp_mutex);
>> >>> + init_waitqueue_head(&sbi->writeback_wqh);
>> >>> for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>> >>> mutex_init(&sbi->fs_lock[i]);
>> >>> mutex_init(&sbi->node_write);N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=
=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=B6=17=
=9B=A1=DC=A8}=A9=9E=B2=C6 z=DA&j:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=CA+zf=A3=
=A2=B7h=9A=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=A8=E8=AD=DA=
&=A2)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C0=B6=ECh=AE=0F=
=E5=92i=7F
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html



---------------------------------------------------------------------------=
---
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most fr=
om =

the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=3D60134071&iu=3D/4140/ostg.cl=
ktrk
