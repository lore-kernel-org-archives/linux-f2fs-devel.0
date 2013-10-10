From: Jin Xu <jinuxstyle@live.com>
Subject: Re: [PATCH v2] f2fs: avoid congestion_wait when
 do_checkpoint for better performance
Date: Thu, 10 Oct 2013 23:54:26 +0000
Message-ID: <BLU175-W378B020AC54C62046132AAB41E0@phx.gbl>
References: <30722427.272521381231813403.JavaMail.weblogic@epml26>,
	<5254D5B9.1040803@cn.fujitsu.com>
	<BLU175-W48D340F1A4D0966D8895D0B41E0@phx.gbl>,
	<52566149.1030702@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1931481854933898389=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinuxstyle@live.com>) id 1VUQ3t-0002jO-7a
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 23:54:33 +0000
Received: from blu0-omc3-s29.blu0.hotmail.com ([65.55.116.104])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VUQ3r-0005Lv-H6 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 23:54:33 +0000
In-Reply-To: <52566149.1030702@cn.fujitsu.com>
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
Cc: shu tan <shu.tan@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

--===============1931481854933898389==
Content-Type: multipart/alternative;
	boundary="_0e85712b-06b3-4f0f-a816-d4da1b7d5bd3_"

--_0e85712b-06b3-4f0f-a816-d4da1b7d5bd3_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> Date: Thu=2C 10 Oct 2013 16:11:53 +0800
> From: guz.fnst@cn.fujitsu.com
> To: jinuxstyle@live.com
> CC: yuan.mark.zhong@samsung.com=3B jaegeuk.kim@samsung.com=3B linux-f2fs-=
devel@lists.sourceforge.net=3B linux-kernel@vger.kernel.org=3B linux-fsdeve=
l@vger.kernel.org=3B shu.tan@samsung.com
> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do_ch=
eckpoint for better performance
>=20
> Hi Jin=2C
>=20
> On 10/10/2013 04:09 PM=2C Jin Xu wrote:
>=20
> > Hi Gu=2C
> >=20
> > I have a comment below.
> >=20
> >> Date: Wed=2C 9 Oct 2013 12:04:09 +0800
> >> From: guz.fnst@cn.fujitsu.com
> >> To: yuan.mark.zhong@samsung.com
> >> CC: jaegeuk.kim@samsung.com=3B linux-f2fs-devel@lists.sourceforge.net=
=3B linux-kernel@vger.kernel.org=3B linux-fsdevel@vger.kernel.org=3B shu.ta=
n@samsung.com
> >> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do=
_checkpoint for better performance
> >>
> >> Hi Yuan=2C
> >> On 10/08/2013 07:30 PM=2C Yuan Zhong wrote:
> >>
> > ...
> >>
> >> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> >> ---
> >> fs/f2fs/checkpoint.c | 11 +++++++++--
> >> fs/f2fs/f2fs.h | 1 +
> >> fs/f2fs/segment.c | 4 ++++
> >> 3 files changed=2C 14 insertions(+)=2C 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index d808827..2a5999d 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -757=2C8 +757=2C15 @@ static void do_checkpoint(struct f2fs_sb_info=
 *sbi=2C bool is_umount)
> >> f2fs_put_page(cp_page=2C 1)=3B
> >>
> >> /* wait for previous submitted node/meta pages writeback */
> >> - while (get_pages(sbi=2C F2FS_WRITEBACK))
> >> - congestion_wait(BLK_RW_ASYNC=2C HZ / 50)=3B
> >> + sbi->cp_task =3D current=3B
> >> + while (get_pages(sbi=2C F2FS_WRITEBACK)) {
> >> + set_current_state(TASK_UNINTERRUPTIBLE)=3B
> >> + if (!get_pages(sbi=2C F2FS_WRITEBACK))
> >> + break=3B
> >> + io_schedule()=3B
> >> + }
> >> + __set_current_state(TASK_RUNNING)=3B
> >> + sbi->cp_task =3D NULL=3B
> >>
> >> filemap_fdatawait_range(sbi->node_inode->i_mapping=2C 0=2C LONG_MAX)=
=3B
> >> filemap_fdatawait_range(sbi->meta_inode->i_mapping=2C 0=2C LONG_MAX)=
=3B
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index a955a59..408ace7 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -365=2C6 +365=2C7 @@ struct f2fs_sb_info {
> >> struct mutex writepages=3B /* mutex for writepages() */
> >> int por_doing=3B /* recovery is doing or not */
> >> int on_build_free_nids=3B /* build_free_nids is doing */
> >> + struct task_struct *cp_task=3B /* checkpoint task */
> >>
> >> /* for orphan inode management */
> >> struct list_head orphan_inode_list=3B /* orphan inode list */
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index bd79bbe..3b20359 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -597=2C6 +597=2C10 @@ static void f2fs_end_io_write(struct bio *bio=
=2C int err)
> >>
> >> if (p->is_sync)
> >> complete(p->wait)=3B
> >> +
> >> + if (!get_pages(p->sbi=2C F2FS_WRITEBACK) && p->sbi->cp_task)
> >> + wake_up_process(p->sbi->cp_task)=3B
> >=20
> > There is a risk of dereferencing a NULL pointer because here simply com=
paring the
> > cp_task against NULL is not enough to avoid race in multi-thread enviro=
nment.
> > Another thread could have assigned it to NULL in the window between the=
 comparison
> > and waking up.
>=20
> Can not be that=2C checkpoint routine is always singleton and protected b=
y cp_mutex and cp_rwsem.
>=20
The race could happen like this for example:On a SMP environment=2C thread =
1 wakes up the checkpoint thread=2C thenthread 2 comes to the f2fs_end_io_w=
rite=2C compared the cp_task as not NULL=2Cbut at the same time=2C the chec=
kpoint thread just assigned the cp_task to NULL.When thread 2 gets to the w=
ake_up_process=2C dereferencing to NULL pointerhappens.
Jin
> Thanks=2C
> Gu=20
>=20
> >=20
> > Regards=2C
> > Jin
> >> +
> >> kfree(p)=3B
> >> bio_put(bio)=3B
> >> }
> >> --
> >> 1.7.7
> >>
> >> Regards=2C
> >> Gu
> >>
> >> >
> >> >
> >> >>> This is a problem here=2C especially=2C when sync a large number o=
f small files or dirs.
> >> >>> In order to avoid this=2C a wait_list is introduced=2C
> >> >>> the checkpoint thread will be dropped into the wait_list if the pa=
ges have not been written back=2C
> >> >>> and will be waked up by contrast.
> >> >
> >> >> Please pay some attention to the mail form=2C this mail is out of f=
ormat in my mail client.
> >> >
> >> >> Regards=2C
> >> >> Gu
> >> >
> >> > Regards=2C
> >> > Yuan
> >> >
> >> >>>
> >> >>> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
> >> >>> ---
> >> >>> fs/f2fs/checkpoint.c | 3 +--
> >> >>> fs/f2fs/f2fs.h | 19 +++++++++++++++++++
> >> >>> fs/f2fs/segment.c | 1 +
> >> >>> fs/f2fs/super.c | 1 +
> >> >>> 4 files changed=2C 22 insertions(+)=2C 2 deletions(-)
> >> >>>
> >> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> >>> index ca39442..5d69ae0 100644
> >> >>> --- a/fs/f2fs/checkpoint.c
> >> >>> +++ b/fs/f2fs/checkpoint.c
> >> >>> @@ -758=2C8 +758=2C7 @@ static void do_checkpoint(struct f2fs_sb_i=
nfo *sbi=2C bool is_umount)
> >> >>> f2fs_put_page(cp_page=2C 1)=3B
> >> >>>
> >> >>> /* wait for previous submitted node/meta pages writeback */
> >> >>> - while (get_pages(sbi=2C F2FS_WRITEBACK))
> >> >>> - congestion_wait(BLK_RW_ASYNC=2C HZ / 50)=3B
> >> >>> + f2fs_writeback_wait(sbi)=3B
> >> >>>
> >> >>> filemap_fdatawait_range(sbi->node_inode->i_mapping=2C 0=2C LONG_MA=
X)=3B
> >> >>> filemap_fdatawait_range(sbi->meta_inode->i_mapping=2C 0=2C LONG_MA=
X)=3B
> >> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> >>> index 7fd99d8..4b0d70e 100644
> >> >>> --- a/fs/f2fs/f2fs.h
> >> >>> +++ b/fs/f2fs/f2fs.h
> >> >>> @@ -18=2C6 +18=2C8 @@
> >> >>> #include <linux/crc32.h>
> >> >>> #include <linux/magic.h>
> >> >>> #include <linux/kobject.h>
> >> >>> +#include <linux/wait.h>
> >> >>> +#include <linux/sched.h>
> >> >>>
> >> >>> /*
> >> >>> * For mount options
> >> >>> @@ -368=2C6 +370=2C7 @@ struct f2fs_sb_info {
> >> >>> struct mutex fs_lock[NR_GLOBAL_LOCKS]=3B /* blocking FS operations=
 */
> >> >>> struct mutex node_write=3B /* locking node writes */
> >> >>> struct mutex writepages=3B /* mutex for writepages() */
> >> >>> + wait_queue_head_t writeback_wqh=3B /* wait_queue for writeback *=
/
> >> >>> unsigned char next_lock_num=3B /* round-robin global locks */
> >> >>> int por_doing=3B /* recovery is doing or not */
> >> >>> int on_build_free_nids=3B /* build_free_nids is doing */
> >> >>> @@ -961=2C6 +964=2C22 @@ static inline int f2fs_readonly(struct su=
per_block *sb)
> >> >>> return sb->s_flags & MS_RDONLY=3B
> >> >>> }
> >> >>>
> >> >>> +static inline void f2fs_writeback_wait(struct f2fs_sb_info *sbi)
> >> >>> +{
> >> >>> + DEFINE_WAIT(wait)=3B
> >> >>> +
> >> >>> + prepare_to_wait(&sbi->writeback_wqh=2C &wait=2C TASK_UNINTERRUPT=
IBLE)=3B
> >> >>> + if (get_pages(sbi=2C F2FS_WRITEBACK))
> >> >>> + io_schedule()=3B
> >> >>> + finish_wait(&sbi->writeback_wqh=2C &wait)=3B
> >> >>> +}
> >> >>> +
> >> >>> +static inline void f2fs_writeback_wake(struct f2fs_sb_info *sbi)
> >> >>> +{
> >> >>> + if (!get_pages(sbi=2C F2FS_WRITEBACK))
> >> >>> + wake_up_all(&sbi->writeback_wqh)=3B
> >> >>> +}
> >> >>> +
> >> >>> /*
> >> >>> * file.c
> >> >>> */
> >> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> >>> index bd79bbe..0708aa9 100644
> >> >>> --- a/fs/f2fs/segment.c
> >> >>> +++ b/fs/f2fs/segment.c
> >> >>> @@ -597=2C6 +597=2C7 @@ static void f2fs_end_io_write(struct bio *=
bio=2C int err)
> >> >>>
> >> >>> if (p->is_sync)
> >> >>> complete(p->wait)=3B
> >> >>> + f2fs_writeback_wake(p->sbi)=3B
> >> >>> kfree(p)=3B
> >> >>> bio_put(bio)=3B
> >> >>> }
> >> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> >>> index 094ccc6..3ac6d85 100644
> >> >>> --- a/fs/f2fs/super.c
> >> >>> +++ b/fs/f2fs/super.c
> >> >>> @@ -835=2C6 +835=2C7 @@ static int f2fs_fill_super(struct super_bl=
ock *sb=2C void *data=2C int silent)
> >> >>> mutex_init(&sbi->gc_mutex)=3B
> >> >>> mutex_init(&sbi->writepages)=3B
> >> >>> mutex_init(&sbi->cp_mutex)=3B
> >> >>> + init_waitqueue_head(&sbi->writeback_wqh)=3B
> >> >>> for (i =3D 0=3B i < NR_GLOBAL_LOCKS=3B i++)
> >> >>> mutex_init(&sbi->fs_lock[i])=3B
> >> >>> mutex_init(&sbi->node_write)=3BN=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=
=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=B6=
=17=9B=A1=DC=A8}=A9=9E=B2=C6 z=DA&j:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=CA+zf=
=A3=A2=B7h=9A=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=A8=E8=AD=
=DA&=A2)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C0=B6=ECh=AE=
=0F=E5=92i=7F
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-fsdeve=
l" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 		 	   		  =

--_0e85712b-06b3-4f0f-a816-d4da1b7d5bd3_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><span style=3D"font-size: 12pt=
=3B">&gt=3B Date: Thu=2C 10 Oct 2013 16:11:53 +0800</span><br><div>&gt=3B F=
rom: guz.fnst@cn.fujitsu.com<br>&gt=3B To: jinuxstyle@live.com<br>&gt=3B CC=
: yuan.mark.zhong@samsung.com=3B jaegeuk.kim@samsung.com=3B linux-f2fs-deve=
l@lists.sourceforge.net=3B linux-kernel@vger.kernel.org=3B linux-fsdevel@vg=
er.kernel.org=3B shu.tan@samsung.com<br>&gt=3B Subject: Re: [f2fs-dev] [PAT=
CH v2] f2fs: avoid congestion_wait when do_checkpoint for better performanc=
e<br>&gt=3B <br>&gt=3B Hi Jin=2C<br>&gt=3B <br>&gt=3B On 10/10/2013 04:09 P=
M=2C Jin Xu wrote:<br>&gt=3B <br>&gt=3B &gt=3B Hi Gu=2C<br>&gt=3B &gt=3B <b=
r>&gt=3B &gt=3B I have a comment below.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B&=
gt=3B Date: Wed=2C 9 Oct 2013 12:04:09 +0800<br>&gt=3B &gt=3B&gt=3B From: g=
uz.fnst@cn.fujitsu.com<br>&gt=3B &gt=3B&gt=3B To: yuan.mark.zhong@samsung.c=
om<br>&gt=3B &gt=3B&gt=3B CC: jaegeuk.kim@samsung.com=3B linux-f2fs-devel@l=
ists.sourceforge.net=3B linux-kernel@vger.kernel.org=3B linux-fsdevel@vger.=
kernel.org=3B shu.tan@samsung.com<br>&gt=3B &gt=3B&gt=3B Subject: Re: [f2fs=
-dev] [PATCH v2] f2fs: avoid congestion_wait when do_checkpoint for better =
performance<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B Hi Yuan=2C<br>&gt=
=3B &gt=3B&gt=3B On 10/08/2013 07:30 PM=2C Yuan Zhong wrote:<br>&gt=3B &gt=
=3B&gt=3B<br>&gt=3B &gt=3B ...<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B Signed-off-by: Gu Zheng &lt=3Bguz.fnst@cn.fujitsu.com&gt=3B<br>&gt=3B &=
gt=3B&gt=3B ---<br>&gt=3B &gt=3B&gt=3B fs/f2fs/checkpoint.c | 11 +++++++++-=
-<br>&gt=3B &gt=3B&gt=3B fs/f2fs/f2fs.h | 1 +<br>&gt=3B &gt=3B&gt=3B fs/f2f=
s/segment.c | 4 ++++<br>&gt=3B &gt=3B&gt=3B 3 files changed=2C 14 insertion=
s(+)=2C 2 deletions(-)<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B diff -=
-git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c<br>&gt=3B &gt=3B&gt=3B i=
ndex d808827..2a5999d 100644<br>&gt=3B &gt=3B&gt=3B --- a/fs/f2fs/checkpoin=
t.c<br>&gt=3B &gt=3B&gt=3B +++ b/fs/f2fs/checkpoint.c<br>&gt=3B &gt=3B&gt=
=3B @@ -757=2C8 +757=2C15 @@ static void do_checkpoint(struct f2fs_sb_info =
*sbi=2C bool is_umount)<br>&gt=3B &gt=3B&gt=3B f2fs_put_page(cp_page=2C 1)=
=3B<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B /* wait for previous subm=
itted node/meta pages writeback */<br>&gt=3B &gt=3B&gt=3B - while (get_page=
s(sbi=2C F2FS_WRITEBACK))<br>&gt=3B &gt=3B&gt=3B - congestion_wait(BLK_RW_A=
SYNC=2C HZ / 50)=3B<br>&gt=3B &gt=3B&gt=3B + sbi-&gt=3Bcp_task =3D current=
=3B<br>&gt=3B &gt=3B&gt=3B + while (get_pages(sbi=2C F2FS_WRITEBACK)) {<br>=
&gt=3B &gt=3B&gt=3B + set_current_state(TASK_UNINTERRUPTIBLE)=3B<br>&gt=3B =
&gt=3B&gt=3B + if (!get_pages(sbi=2C F2FS_WRITEBACK))<br>&gt=3B &gt=3B&gt=
=3B + break=3B<br>&gt=3B &gt=3B&gt=3B + io_schedule()=3B<br>&gt=3B &gt=3B&g=
t=3B + }<br>&gt=3B &gt=3B&gt=3B + __set_current_state(TASK_RUNNING)=3B<br>&=
gt=3B &gt=3B&gt=3B + sbi-&gt=3Bcp_task =3D NULL=3B<br>&gt=3B &gt=3B&gt=3B<b=
r>&gt=3B &gt=3B&gt=3B filemap_fdatawait_range(sbi-&gt=3Bnode_inode-&gt=3Bi_=
mapping=2C 0=2C LONG_MAX)=3B<br>&gt=3B &gt=3B&gt=3B filemap_fdatawait_range=
(sbi-&gt=3Bmeta_inode-&gt=3Bi_mapping=2C 0=2C LONG_MAX)=3B<br>&gt=3B &gt=3B=
&gt=3B diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h<br>&gt=3B &gt=3B&gt=3B =
index a955a59..408ace7 100644<br>&gt=3B &gt=3B&gt=3B --- a/fs/f2fs/f2fs.h<b=
r>&gt=3B &gt=3B&gt=3B +++ b/fs/f2fs/f2fs.h<br>&gt=3B &gt=3B&gt=3B @@ -365=
=2C6 +365=2C7 @@ struct f2fs_sb_info {<br>&gt=3B &gt=3B&gt=3B struct mutex =
writepages=3B /* mutex for writepages() */<br>&gt=3B &gt=3B&gt=3B int por_d=
oing=3B /* recovery is doing or not */<br>&gt=3B &gt=3B&gt=3B int on_build_=
free_nids=3B /* build_free_nids is doing */<br>&gt=3B &gt=3B&gt=3B + struct=
 task_struct *cp_task=3B /* checkpoint task */<br>&gt=3B &gt=3B&gt=3B<br>&g=
t=3B &gt=3B&gt=3B /* for orphan inode management */<br>&gt=3B &gt=3B&gt=3B =
struct list_head orphan_inode_list=3B /* orphan inode list */<br>&gt=3B &gt=
=3B&gt=3B diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c<br>&gt=3B &gt=
=3B&gt=3B index bd79bbe..3b20359 100644<br>&gt=3B &gt=3B&gt=3B --- a/fs/f2f=
s/segment.c<br>&gt=3B &gt=3B&gt=3B +++ b/fs/f2fs/segment.c<br>&gt=3B &gt=3B=
&gt=3B @@ -597=2C6 +597=2C10 @@ static void f2fs_end_io_write(struct bio *b=
io=2C int err)<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B if (p-&gt=3Bis=
_sync)<br>&gt=3B &gt=3B&gt=3B complete(p-&gt=3Bwait)=3B<br>&gt=3B &gt=3B&gt=
=3B +<br>&gt=3B &gt=3B&gt=3B + if (!get_pages(p-&gt=3Bsbi=2C F2FS_WRITEBACK=
) &amp=3B&amp=3B p-&gt=3Bsbi-&gt=3Bcp_task)<br>&gt=3B &gt=3B&gt=3B + wake_u=
p_process(p-&gt=3Bsbi-&gt=3Bcp_task)=3B<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B =
There is a risk of dereferencing a NULL pointer because here simply compari=
ng the<br>&gt=3B &gt=3B cp_task against NULL is not enough to avoid race in=
 multi-thread environment.<br>&gt=3B &gt=3B Another thread could have assig=
ned it to NULL in the window between the comparison<br>&gt=3B &gt=3B and wa=
king up.<br>&gt=3B <br>&gt=3B Can not be that=2C checkpoint routine is alwa=
ys singleton and protected by cp_mutex and cp_rwsem.<br>&gt=3B&nbsp=3B</div=
><div><br></div><div>The race could happen like this for example:</div><div=
>On a SMP environment=2C thread 1 wakes up the checkpoint thread=2C then</d=
iv><div><span style=3D"font-size: 12pt=3B">thread 2 comes to the f2fs_end_i=
o_write=2C compared the cp_task as not NULL=2C</span></div><div><span style=
=3D"font-size: 12pt=3B">but at the same time=2C the checkpoint thread just =
assigned the cp_task to NULL.</span></div><div><span style=3D"font-size: 12=
pt=3B">When thread 2 gets to the wake_up_process=2C dereferencing to NULL p=
ointer</span></div><div><span style=3D"font-size: 12pt=3B">happens.</span><=
/div><div><br></div><div>Jin</div><div><br>&gt=3B Thanks=2C<br>&gt=3B Gu&nb=
sp=3B<br>&gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Regards=2C<br>&gt=3B &g=
t=3B Jin<br>&gt=3B &gt=3B&gt=3B +<br>&gt=3B &gt=3B&gt=3B kfree(p)=3B<br>&gt=
=3B &gt=3B&gt=3B bio_put(bio)=3B<br>&gt=3B &gt=3B&gt=3B }<br>&gt=3B &gt=3B&=
gt=3B --<br>&gt=3B &gt=3B&gt=3B 1.7.7<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=
=3B&gt=3B Regards=2C<br>&gt=3B &gt=3B&gt=3B Gu<br>&gt=3B &gt=3B&gt=3B<br>&g=
t=3B &gt=3B&gt=3B &gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B<br>&gt=3B &gt=3B&gt=
=3B &gt=3B&gt=3B&gt=3B This is a problem here=2C especially=2C when sync a =
large number of small files or dirs.<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B In order to avoid this=2C a wait_list is introduced=2C<br>&gt=3B &gt=3B=
&gt=3B &gt=3B&gt=3B&gt=3B the checkpoint thread will be dropped into the wa=
it_list if the pages have not been written back=2C<br>&gt=3B &gt=3B&gt=3B &=
gt=3B&gt=3B&gt=3B and will be waked up by contrast.<br>&gt=3B &gt=3B&gt=3B =
&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B Please pay some attention to the=
 mail form=2C this mail is out of format in my mail client.<br>&gt=3B &gt=
=3B&gt=3B &gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B Regards=2C<br>&gt=3B &=
gt=3B&gt=3B &gt=3B&gt=3B Gu<br>&gt=3B &gt=3B&gt=3B &gt=3B<br>&gt=3B &gt=3B&=
gt=3B &gt=3B Regards=2C<br>&gt=3B &gt=3B&gt=3B &gt=3B Yuan<br>&gt=3B &gt=3B=
&gt=3B &gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B &gt=3B&gt=3B&gt=3B Signed-off-by: Yuan Zhong &lt=3Byuan.mark.zhong@sams=
ung.com&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B ---<br>&gt=3B &gt=
=3B&gt=3B &gt=3B&gt=3B&gt=3B fs/f2fs/checkpoint.c | 3 +--<br>&gt=3B &gt=3B&=
gt=3B &gt=3B&gt=3B&gt=3B fs/f2fs/f2fs.h | 19 +++++++++++++++++++<br>&gt=3B =
&gt=3B&gt=3B &gt=3B&gt=3B&gt=3B fs/f2fs/segment.c | 1 +<br>&gt=3B &gt=3B&gt=
=3B &gt=3B&gt=3B&gt=3B fs/f2fs/super.c | 1 +<br>&gt=3B &gt=3B&gt=3B &gt=3B&=
gt=3B&gt=3B 4 files changed=2C 22 insertions(+)=2C 2 deletions(-)<br>&gt=3B=
 &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B =
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c<br>&gt=3B &gt=3B&g=
t=3B &gt=3B&gt=3B&gt=3B index ca39442..5d69ae0 100644<br>&gt=3B &gt=3B&gt=
=3B &gt=3B&gt=3B&gt=3B --- a/fs/f2fs/checkpoint.c<br>&gt=3B &gt=3B&gt=3B &g=
t=3B&gt=3B&gt=3B +++ b/fs/f2fs/checkpoint.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&g=
t=3B&gt=3B @@ -758=2C8 +758=2C7 @@ static void do_checkpoint(struct f2fs_sb=
_info *sbi=2C bool is_umount)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B f2f=
s_put_page(cp_page=2C 1)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br>&g=
t=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B /* wait for previous submitted node/me=
ta pages writeback */<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B - while (ge=
t_pages(sbi=2C F2FS_WRITEBACK))<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B -=
 congestion_wait(BLK_RW_ASYNC=2C HZ / 50)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&=
gt=3B&gt=3B + f2fs_writeback_wait(sbi)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=
=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B filemap_fdatawait_range=
(sbi-&gt=3Bnode_inode-&gt=3Bi_mapping=2C 0=2C LONG_MAX)=3B<br>&gt=3B &gt=3B=
&gt=3B &gt=3B&gt=3B&gt=3B filemap_fdatawait_range(sbi-&gt=3Bmeta_inode-&gt=
=3Bi_mapping=2C 0=2C LONG_MAX)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B=
 diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h<br>&gt=3B &gt=3B&gt=3B &gt=3B=
&gt=3B&gt=3B index 7fd99d8..4b0d70e 100644<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=
=3B&gt=3B --- a/fs/f2fs/f2fs.h<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B ++=
+ b/fs/f2fs/f2fs.h<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B @@ -18=2C6 +18=
=2C8 @@<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B #include &lt=3Blinux/crc3=
2.h&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B #include &lt=3Blinux/ma=
gic.h&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B #include &lt=3Blinux/=
kobject.h&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +#include &lt=3Bl=
inux/wait.h&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +#include &lt=
=3Blinux/sched.h&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B =
&gt=3B&gt=3B &gt=3B&gt=3B&gt=3B /*<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B * For mount options<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B @@ -368=
=2C6 +370=2C7 @@ struct f2fs_sb_info {<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&=
gt=3B struct mutex fs_lock[NR_GLOBAL_LOCKS]=3B /* blocking FS operations */=
<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B struct mutex node_write=3B /* lo=
cking node writes */<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B struct mutex=
 writepages=3B /* mutex for writepages() */<br>&gt=3B &gt=3B&gt=3B &gt=3B&g=
t=3B&gt=3B + wait_queue_head_t writeback_wqh=3B /* wait_queue for writeback=
 */<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B unsigned char next_lock_num=
=3B /* round-robin global locks */<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B int por_doing=3B /* recovery is doing or not */<br>&gt=3B &gt=3B&gt=3B =
&gt=3B&gt=3B&gt=3B int on_build_free_nids=3B /* build_free_nids is doing */=
<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B @@ -961=2C6 +964=2C22 @@ static =
inline int f2fs_readonly(struct super_block *sb)<br>&gt=3B &gt=3B&gt=3B &gt=
=3B&gt=3B&gt=3B return sb-&gt=3Bs_flags &amp=3B MS_RDONLY=3B<br>&gt=3B &gt=
=3B&gt=3B &gt=3B&gt=3B&gt=3B }<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br=
>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +static inline void f2fs_writeback_=
wait(struct f2fs_sb_info *sbi)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +{=
<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + DEFINE_WAIT(wait)=3B<br>&gt=3B=
 &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B + prepare_to_wait(&amp=3Bsbi-&gt=3Bwriteback_wqh=2C &amp=3Bwait=2C TASK=
_UNINTERRUPTIBLE)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + if (get_pa=
ges(sbi=2C F2FS_WRITEBACK))<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + io_=
schedule()=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + finish_wait(&amp=
=3Bsbi-&gt=3Bwriteback_wqh=2C &amp=3Bwait)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B=
&gt=3B&gt=3B +}<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +<br>&gt=3B &gt=
=3B&gt=3B &gt=3B&gt=3B&gt=3B +static inline void f2fs_writeback_wake(struct=
 f2fs_sb_info *sbi)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +{<br>&gt=3B =
&gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + if (!get_pages(sbi=2C F2FS_WRITEBACK))<br=
>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + wake_up_all(&amp=3Bsbi-&gt=3Bwrit=
eback_wqh)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +}<br>&gt=3B &gt=3B=
&gt=3B &gt=3B&gt=3B&gt=3B +<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B /*<br=
>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B * file.c<br>&gt=3B &gt=3B&gt=3B &gt=
=3B&gt=3B&gt=3B */<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B diff --git a/f=
s/f2fs/segment.c b/fs/f2fs/segment.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B index bd79bbe..0708aa9 100644<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B=
 --- a/fs/f2fs/segment.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +++ b/fs=
/f2fs/segment.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B @@ -597=2C6 +597=
=2C7 @@ static void f2fs_end_io_write(struct bio *bio=2C int err)<br>&gt=3B=
 &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B =
if (p-&gt=3Bis_sync)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B complete(p-&=
gt=3Bwait)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B + f2fs_writeback_wa=
ke(p-&gt=3Bsbi)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B kfree(p)=3B<br=
>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B bio_put(bio)=3B<br>&gt=3B &gt=3B&gt=
=3B &gt=3B&gt=3B&gt=3B }<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B diff --g=
it a/fs/f2fs/super.c b/fs/f2fs/super.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&=
gt=3B index 094ccc6..3ac6d85 100644<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=
=3B --- a/fs/f2fs/super.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B +++ b/f=
s/f2fs/super.c<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B @@ -835=2C6 +835=
=2C7 @@ static int f2fs_fill_super(struct super_block *sb=2C void *data=2C =
int silent)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B mutex_init(&amp=3Bsbi=
-&gt=3Bgc_mutex)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B mutex_init(&a=
mp=3Bsbi-&gt=3Bwritepages)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B mut=
ex_init(&amp=3Bsbi-&gt=3Bcp_mutex)=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&g=
t=3B + init_waitqueue_head(&amp=3Bsbi-&gt=3Bwriteback_wqh)=3B<br>&gt=3B &gt=
=3B&gt=3B &gt=3B&gt=3B&gt=3B for (i =3D 0=3B i &lt=3B NR_GLOBAL_LOCKS=3B i+=
+)<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B mutex_init(&amp=3Bsbi-&gt=3Bfs=
_lock[i])=3B<br>&gt=3B &gt=3B&gt=3B &gt=3B&gt=3B&gt=3B mutex_init(&amp=3Bsb=
i-&gt=3Bnode_write)=3BN=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7=
v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=B6=17=9B=A1=DC=A8}=A9=
=9E=B2=C6 z=DA&amp=3Bj:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=CA+zf=A3=A2=B7h=9A=
=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=A8=E8=AD=DA&amp=3B=A2=
)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C0=B6=ECh=AE=0F=E5=
=92i=7F<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=3B<br>&gt=3B &gt=3B&gt=
=3B --<br>&gt=3B &gt=3B&gt=3B To unsubscribe from this list: send the line =
"unsubscribe linux-fsdevel" in<br>&gt=3B &gt=3B&gt=3B the body of a message=
 to majordomo@vger.kernel.org<br>&gt=3B &gt=3B&gt=3B More majordomo info at=
 http://vger.kernel.org/majordomo-info.html<br>&gt=3B <br>&gt=3B <br>&gt=3B=
 --<br>&gt=3B To unsubscribe from this list: send the line "unsubscribe lin=
ux-fsdevel" in<br>&gt=3B the body of a message to majordomo@vger.kernel.org=
<br>&gt=3B More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml<br></div> 		 	   		  </div></body>
</html>=

--_0e85712b-06b3-4f0f-a816-d4da1b7d5bd3_--


--===============1931481854933898389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
--===============1931481854933898389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============1931481854933898389==--
