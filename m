From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: remove stale inode entry before
 eviction from gdirty_list
Date: Mon, 19 Nov 2018 13:03:40 -0800
Message-ID: <20181119210340.GA33805@jaegeuk-macbookpro.roam.corp.google.com>
References: <1542607377-25446-1-git-send-email-riteshh@codeaurora.org>
 <0a2feb36-8f71-67a0-381c-2e487d658145@huawei.com>
 <c5387fdb-6b20-ed3d-e9a5-ae55b5dbdd37@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gOqhz-0004ZV-3n
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 21:03:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOqhx-009WXf-Ko
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 21:03:51 +0000
Content-Disposition: inline
In-Reply-To: <c5387fdb-6b20-ed3d-e9a5-ae55b5dbdd37@codeaurora.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 11/19, Ritesh Harjani wrote:
> Hi Chao,
> =

> On 11/19/2018 12:09 PM, Chao Yu wrote:
> > Hi Ritesh,
> > =

> > On 2018/11/19 14:02, Ritesh Harjani wrote:
> > > This is seen when CP_ERROR_FLAG is not set & FS may be corrupted.
> > > There is a case observed where dirty stale inode pointer data is still
> > > present in the gdirty_list causing panic on access while doing
> > > checkpoint operation.
> > > =

> > > WARNING: CPU: 3 PID: 1827 at
> > > kernel/msm-4.14/fs/f2fs/inode.c:567
> > > f2fs_evict_inode+0x364/0x37c
> > > <...>
> > > [42246.776289] BUG: spinlock bad magic on CPU#4, 1245
> > > [42246.782674] Unable to handle kernel paging request at virtual addr=
ess 6b6b6b6b6b713b
> > > <...>
> > > [42246.896370] task: ffffffc0f0434080 task.stack: ffffff8023ea0000
> > > [42246.902465] pc : spin_bug+0x80/0xb8
> > > [42246.906055] lr : spin_bug+0x64/0xb8
> > > <...>
> > > [42247.122346] Call trace:
> > > [42247.124876]  spin_bug+0x80/0xb8
> > > [42247.128110]  do_raw_spin_lock+0xe8/0x118
> > > [42247.132144]  _raw_spin_lock+0x24/0x30
> > > [42247.135916]  igrab+0x20/0x6c
> > > [42247.138894]  f2fs_sync_inode_meta+0x58/0xc0
> > > [42247.143199]  write_checkpoint+0x1c4/0xecc
> > > [42247.147322]  f2fs_sync_fs+0x118/0x170
> > > [42247.151096]  f2fs_do_sync_file+0x4f0/0x798
> > > [42247.155311]  f2fs_sync_file+0x54/0x6c
> > > [42247.159087]  vfs_fsync_range+0x90/0xac
> > > [42247.162950]  vfs_fsync+0x2c/0x38
> > > [42247.166278]  do_fsync+0x3c/0x78
> > > [42247.169515]  SyS_fdatasync+0x20/0x30
> > > =

> > > Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> > > ---
> > >   fs/f2fs/inode.c | 10 ++++++----
> > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > > =

> > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > index 91ceee0..c57f636 100644
> > > --- a/fs/f2fs/inode.c
> > > +++ b/fs/f2fs/inode.c
> > > @@ -702,11 +702,13 @@ void f2fs_evict_inode(struct inode *inode)
> > >   	stat_dec_inline_dir(inode);
> > >   	stat_dec_inline_inode(inode);
> > > -	if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG) &&
> > > -				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > > -		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
> > > -	else
> > > +	if (unlikely(is_inode_flag_set(inode, FI_DIRTY_INODE))) {
> > >   		f2fs_inode_synced(inode);
> > > +		f2fs_msg(sbi->sb, KERN_WARNING,
> > > +			 "inconsistent dirty inode:%u entry found during eviction\n",
> > > +			 inode->i_ino);
> > > +		f2fs_bug_on(sbi, 1);
> > IIRC, Jaegeuk added below condition to avoid f2fs_bug_on during doing t=
est
> > w/ checkpoint error injection, if we remove this, we may still encounter
> > such problem.
> > =

> > if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG)))
> Ok, agreed. Does below sounds good then?
> The idea is to go ahead and call f2fs_inode_synced(inode) when the inode
> FI_DIRTY_INODE flag is set irrespective of CP_ERROR_FLAG set or not. Beca=
use
> otherwise there is a stale inode entry which will
> remain in gdirty_list =3D> causing kernel panic in checkpoint path.
> =

> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 91ceee0..00915c2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -702,11 +702,15 @@ void f2fs_evict_inode(struct inode *inode)
> =A0=A0=A0=A0=A0=A0=A0 stat_dec_inline_dir(inode);
> =A0=A0=A0=A0=A0=A0=A0 stat_dec_inline_inode(inode);
> =

> -=A0=A0=A0=A0=A0=A0 if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG) &&
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs_bug_on(sbi, is_inode_fla=
g_set(inode, FI_DIRTY_INODE));
> -=A0=A0=A0=A0=A0=A0 else
> +=A0=A0=A0=A0=A0=A0 if (unlikely(is_inode_flag_set(inode, FI_DIRTY_INODE)=
)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs_inode_synced(inode);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs_msg(sbi->sb, KERN_WARNIN=
G,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "i=
nconsistent dirty inode:%u entry found during
> eviction\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in=
ode->i_ino);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((!is_set_ckpt_flags(sbi, =
CP_ERROR_FLAG) &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs_=
bug_on(sbi, 1);
> +=A0=A0=A0=A0=A0=A0 }
> =

> > =

> > So I'd like to know what kind of case can make dirty inode during evict=
(),
> > can you explain more?
> Yes, we also could not get exact path about when this can happen. But bel=
ow
> are the parallel ongoing contexts when the issue is seen:-
> We do suspect that there is something already wrong in the FS even before
> when this issue occurred (due to "inconsistent node block" logs). This co=
uld
> be due to some other underlying storage driver issue.
> Not sure though.
> =

> 1. unlinkat operation causing f2fs_evict_inode causing a warning (as
> mentioned in the commit text).
> 2. echo 3 > /proc/sys/vm/drop_caches.
> 3. Rename operation on some file.
> 4. vfs_fsync -> doing checkpointing =3D> this causes a kernel panic since
> stale inode entry is still present which got freed from f2fs_evict_inode
> path.
> =

> Some error logs which were seen long before this issue occurred.
> [42219.089810]=A0F2FS-fs=A0(mmcblk0p75):=A0inconsistent=A0node=A0block,=
=A0nid:50018,=A0node_footer[nid:50327,ino:50327,ofs:0,cpver:121465059962827=
73182,blkaddr:515484]
> [42219.104281]=A0F2FS-fs=A0(mmcblk0p75):=A0inconsistent=A0node=A0block,=
=A0nid:49836,=A0node_footer[nid:50228,ino:50228,ofs:0,cpver:102302472942569=
61017,blkaddr:1496346]
> [42219.118723]=A0F2FS-fs=A0(mmcblk0p75):=A0inconsistent=A0node=A0block,=
=A0nid:50327,=A0node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]
> [42219.130782]=A0F2FS-fs=A0(mmcblk0p75):=A0inconsistent=A0node=A0block,=
=A0nid:50228,=A0node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]

I've concerned that this patch hides the bug and makes the partition being =
more
corrupted. We have to figure out where such the node block were generated.
How many patches have you cherry-picked? Which kernel version are you using?
Have you enabled ICE?

Thanks,


> =

> Thanks,
> =

> > =

> > Thanks,
> > =

> > > +	}
> > >   	/* ino =3D=3D 0, if f2fs_new_inode() was failed t*/
> > >   	if (inode->i_ino)
> > > =

> =
