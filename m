From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: support revoking atomic written pages
Date: Wed, 30 Dec 2015 11:41:02 -0800
Message-ID: <20151230194102.GD28564@jaegeuk.local>
References: <00a901d141e6$e42ec950$ac8c5bf0$@samsung.com>
 <20151230000513.GA13809@jaegeuk.local>
 <00dc01d142a2$5920ec00$0b62c400$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00dc01d142a2$5920ec00$0b62c400$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

On Wed, Dec 30, 2015 at 09:34:40AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, December 30, 2015 8:05 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] f2fs: support revoking atomic written pages
> > 
> > Hi Chao,
> > 
> > On Tue, Dec 29, 2015 at 11:12:36AM +0800, Chao Yu wrote:
> > > f2fs support atomic write with following semantics:
> > > 1. open db file
> > > 2. ioctl start atomic write
> > > 3. (write db file) * n
> > > 4. ioctl commit atomic write
> > > 5. close db file
> > >
> > > With this flow we can avoid file becoming corrupted when abnormal power
> > > cut, because we hold data of transaction in referenced pages linked in
> > > inmem_pages list of inode, but without setting them dirty, so these data
> > > won't be persisted unless we commit them in step 4.
> > >
> > > But we should still hold journal db file in memory by using volatile write,
> > > because our semantics of 'atomic write support' is not full, in step 4, we
> > > could be fail to submit all dirty data of transaction, once partial dirty
> > > data was committed in storage, db file should be corrupted, in this case,
> > > we should use journal db to recover the original data in db file.
> > 
> > Originally, IOC_ABORT_VOLATILE_WRITE was supposed to handle commit failures,
> > since database should get its error literally.
> > 
> > So, the only thing that we need to do is keeping journal data for further db
> > recovery.
> 
> IMO, if we really support *atomic* interface, we don't need any journal data
> kept by user, because f2fs already have it in its storage since we always
> trigger OPU for pages written in atomic-write opened file, f2fs can easily try
> to revoke (replace old to new in metadata) when any failure exist in atomic
> write process.

Yeah, so current design does not fully support atomic writes. IOWs, volatile
writes for journal files should be used together to minimize sqlite change as
much as possible.

> But in current design, we still hold journal data in memory for recovering for
> *rare* failure case. I think there are several issues:
> a) most of time, we are in concurrent scenario, so if large number of journal
> db files were opened simultaneously, we are under big memory pressure.

In current android, I've seen that this is not a big concern. Even there is
memory pressure, f2fs flushes volatile pages.

> b) If we are out of memory, reclaimer tries to write page of journal db into
> disk, it will destroy db file.

I don't understand. Could you elaborate why journal writes can corrupt db?

> c) Though, we have journal db file, we will face failure of recovering db file
> from journal db due to ENOMEM or EIO, then db file will be corrupted.

Do you mean the failure of recovering db with a complete journal?
Why do we have to handle that? That's a database stuff, IMO.

> d) Recovery flow will make data page dirty, triggering both data stream and
> metadata stream, there should be more IOs than in inner revoking in
> atomic-interface.

Well, do you mean there is no need to recover db after revoking?

> e) Moreover, there should be a hole between 1) commit fail and 2) abort write &
> recover, checkpoint will persist the corrupt data in db file, following abnormal
> power-cut will leave that data in disk.

Yes, in that case, database should recover corrupted db with its journal file.

> With revoking supported design, we can not solve all above issues, we will still
> face the same issue like c), but it will be a big improve if we can apply this
> in our interface, since it provide a way to fix the issue a) b) d). And also for
> e) case, we try to rescue data in first time that our revoking operation would be
> protected by f2fs_lock_op to avoid checkpoint + power-cut.
> 
> If you don't want to have a big change in this interface or recovery flow, how
> about keep them both, and add a mount option to control inner recovery flow?

Hmm, okay. I believe the current design is fine for sqlite in android.
For other databases, I can understand that they can use atomic_write without
journal control, which is a sort of stand-alone atomic_write.

It'd better to add a new ioctl for that, but before adding it, can we find
any usecase for this feature? (e.g., postgresql, mysql, mariadb, couchdb?)
Then, I expect that we can define a more appropriate and powerful ioctl.

Thanks,

> 
> How do you think? :)
> 
> Thanks,
> 
> > But, unfortunately, it seems that something is missing in the
> > current implementation.
> > 
> > So simply how about this?
> > 
> > A possible flow would be:
> > 1. write journal data to volatile space
> > 2. write db data to atomic space
> > 3. in the error case, call ioc_abort_volatile_writes for both journal and db
> >  - flush/fsync journal data to disk
> >  - drop atomic data, and will be recovered by database with journal
> > 
> > From cb33fc8bc30981c370ec70fe68871130109793ec Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 29 Dec 2015 15:46:33 -0800
> > Subject: [PATCH] f2fs: fix f2fs_ioc_abort_volatile_write
> > 
> > There are two rules to handle aborting volatile or atomic writes.
> > 
> > 1. drop atomic writes
> >  - we don't need to keep any stale db data.
> > 
> > 2. write journal data
> >  - we should keep the journal data with fsync for db recovery.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 91f576a..d16438a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1433,9 +1433,16 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
> >  	if (ret)
> >  		return ret;
> > 
> > -	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> > -	clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
> > -	commit_inmem_pages(inode, true);
> > +	if (f2fs_is_atomic_file(inode)) {
> > +		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> > +		commit_inmem_pages(inode, true);
> > +	}
> > +	if (f2fs_is_volatile_file(inode)) {
> > +		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
> > +		ret = commit_inmem_pages(inode, false);
> > +		if (!ret)
> > +			ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
> > +	}
> > 
> >  	mnt_drop_write_file(filp);
> >  	return ret;
> > --
> > 2.6.3
> 
