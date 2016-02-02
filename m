From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: support revoking atomic written pages
Date: Tue, 02 Feb 2016 18:19:06 +0800
Message-ID: <00e601d15da3$3d7c6530$b8752f90$@samsung.com>
References: <20151230194102.GD28564@jaegeuk.local>
 <011701d143ac$183be770$48b3b650$@samsung.com>
 <20160101035024.GB6673@jaegeuk.local> <56866D6F.7040509@kernel.org>
 <005701d14a0d$030ed8f0$092c8ad0$@samsung.com>
 <20160108194306.GA17518@jaegeuk.aosp> <20160113011742.GA44670@jaegeuk.gateway>
 <00d801d14dc0$0ccb1370$26613a50$@samsung.com>
 <20160115000318.GA56929@jaegeuk.gateway>
 <004701d15cd8$08befa40$1a3ceec0$@samsung.com>
 <20160202023645.GC86978@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160202023645.GC86978@jaegeuk.gateway>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, February 02, 2016 10:37 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support revoking atomic written pages
> 
> Hi Chao,
> 
> On Mon, Feb 01, 2016 at 06:04:13PM +0800, Chao Yu wrote:
> > Ping,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Friday, January 15, 2016 8:03 AM
> > > To: Chao Yu
> > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support revoking atomic written pages
> > >
> > > Hi Chao,
> > >
> > > On Wed, Jan 13, 2016 at 01:05:01PM +0800, Chao Yu wrote:
> > > > Hi Jaegeuk,
> > > >
> > > > > -----Original Message-----
> > > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > > Sent: Wednesday, January 13, 2016 9:18 AM
> > > > > To: Chao Yu
> > > > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > > > Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support revoking atomic written pages
> > > > >
> > > > > Hi Chao,
> > > > >
> > > > > I just injected -EIO for one page among two pages in total into database file.
> > > > > Then, I tested valid and invalid journal file to see how sqlite recovers the
> > > > > transaction.
> > > > >
> > > > > Interestingly, if journal is valid, database file is recovered, as I could see
> > > > > the transaction result even after it shows EIO.
> > > > > But, in the invalid journal case, somehow it drops database changes.
> > > >
> > > > If journal has valid data in its header and corrupted data in its body, sqlite will
> > > > recover db file from corrupted journal file, then db file will be corrupted.
> > > > So what you mean is: after recovery, db file still be fine? or sqlite fails to
> > > > recover due to drop data in journal since the header of journal is not valid?
> > >
> > > In the above case, I think I made broken journal header. At the same time, I
> > > broke database file too, but I could see that database file is recovered
> > > likewise roll-back. I couldn't find corruption of database.
> > >
> > > Okay, I'll test again by corrupting journal body with valid header.
> 
> Hmm, it's quite difficult to produce any corruption case.
> 
> I tried the below tests, but in all the cases, sqlite did rollback successfully.

As you saw valid db file at final, I suspect that:
a) db file was recovered by f2fs: after we fail in atomic commit, if
   checkpoint isn't be triggered to persist partial pages of one
   transaction, db file will be recovered to last transaction after an
   abnormal power-cut by f2fs.
b) or db file was recovered by sqlite: sqlite will try to do the
   revoking after it detects failure of atomic commit. Similarly, db
   file will be recovered.

> 
>  - -EIO for one db write with valid header + valid body in journal
>  - -EIO for one db write with valid header + invalid body in journal
>  - -EIO for one db write with invalid header + valid body in journal
> 
> Note that, I checked both integrity_check and table contents after each tests.
> 
> I suspect that journal uses checksums to validate its contents?

Yes, there is one checksum after each 4K-size journal page.

IMO, it's better to just destroy last one or two journal pages to make
corrupted journal file. For example, if there are 10 pages in journal, let
kworker writebacks [0-7] pages include partial old pages of transaction
and journal header, and holds [8-9] pages in memory, so in disk, [8-9]
pages were invalid to sqlite due to wrong checksum, and other pages will
be judged as valid for recovery. Note that, pages after first invalid
page were also be judged as invalid by sqlite.

Thanks,

> 
> Thanks,
> 
> > >
> > > Thanks,
> > >
> > > >
> > > > Thanks,
> > > >
> > > > > I'm not sure it was because I just skip second page write of database file tho.
> > > > > (I added random bytes into journal pages.)
> > > > > I'll break the database file with more random bytes likewise what I did for
> > > > > journal.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > On Fri, Jan 08, 2016 at 11:43:06AM -0800, Jaegeuk Kim wrote:
> > > > > > On Fri, Jan 08, 2016 at 08:05:52PM +0800, Chao Yu wrote:
> > > > > > > Hi Jaegeuk,
> > > > > > >
> > > > > > > Any progress on this patch?
> > > > > >
> > > > > > Swamped. Will do.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Chao Yu [mailto:chao@kernel.org]
> > > > > > > > Sent: Friday, January 01, 2016 8:14 PM
> > > > > > > > To: Jaegeuk Kim
> > > > > > > > Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > > > > > > Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support revoking atomic written pages
> > > > > > > >
> > > > > > > > Hi Jaegeuk,
> > > > > > > >
> > > > > > > > On 1/1/16 11:50 AM, Jaegeuk Kim wrote:
> > > > > > > > > Hi Chao,
> > > > > > > > >
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > >>>>> On Tue, Dec 29, 2015 at 11:12:36AM +0800, Chao Yu wrote:
> > > > > > > > >>>>>> f2fs support atomic write with following semantics:
> > > > > > > > >>>>>> 1. open db file
> > > > > > > > >>>>>> 2. ioctl start atomic write
> > > > > > > > >>>>>> 3. (write db file) * n
> > > > > > > > >>>>>> 4. ioctl commit atomic write
> > > > > > > > >>>>>> 5. close db file
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> With this flow we can avoid file becoming corrupted when abnormal power
> > > > > > > > >>>>>> cut, because we hold data of transaction in referenced pages linked in
> > > > > > > > >>>>>> inmem_pages list of inode, but without setting them dirty, so these data
> > > > > > > > >>>>>> won't be persisted unless we commit them in step 4.
> > > > > > > > >>>>>>
> > > > > > > > >>>>>> But we should still hold journal db file in memory by using volatile write,
> > > > > > > > >>>>>> because our semantics of 'atomic write support' is not full, in step 4,
> we
> > > > > > > > >>>>>> could be fail to submit all dirty data of transaction, once partial dirty
> > > > > > > > >>>>>> data was committed in storage, db file should be corrupted, in this case,
> > > > > > > > >>>>>> we should use journal db to recover the original data in db file.
> > > > > > > > >>>>>
> > > > > > > > >>>>> Originally, IOC_ABORT_VOLATILE_WRITE was supposed to handle commit failures,
> > > > > > > > >>>>> since database should get its error literally.
> > > > > > > > >>>>>
> > > > > > > > >>>>> So, the only thing that we need to do is keeping journal data for further
> db
> > > > > > > > >>>>> recovery.
> > > > > > > > >>>>
> > > > > > > > >>>> IMO, if we really support *atomic* interface, we don't need any journal data
> > > > > > > > >>>> kept by user, because f2fs already have it in its storage since we always
> > > > > > > > >>>> trigger OPU for pages written in atomic-write opened file, f2fs can easily
> try
> > > > > > > > >>>> to revoke (replace old to new in metadata) when any failure exist in atomic
> > > > > > > > >>>> write process.
> > > > > > > > >>>
> > > > > > > > >>> Yeah, so current design does not fully support atomic writes. IOWs, volatile
> > > > > > > > >>> writes for journal files should be used together to minimize sqlite change
> as
> > > > > > > > >>> much as possible.
> > > > > > > > >>>
> > > > > > > > >>>> But in current design, we still hold journal data in memory for recovering
> for
> > > > > > > > >>>> *rare* failure case. I think there are several issues:
> > > > > > > > >>>> a) most of time, we are in concurrent scenario, so if large number of journal
> > > > > > > > >>>> db files were opened simultaneously, we are under big memory pressure.
> > > > > > > > >>>
> > > > > > > > >>> In current android, I've seen that this is not a big concern. Even there is
> > > > > > > > >>> memory pressure, f2fs flushes volatile pages.
> > > > > > > > >>
> > > > > > > > >> When I change to redirty all volatile pages in ->writepage, android seems go
> > > > > > > > >> into an infinite loop when doing recovery flow of f2fs data partition in startup.
> > > > > > > > >>
> > > > > > > > >> if (f2fs_is_volatile_file(inode))
> > > > > > > > >> 	goto redirty_out;
> > > > > > > > >
> > > > > > > > > Where did you put this? It doesn't flush at all? Why?
> > > > > > > >
> > > > > > > > Original place in ->writepage, just remove two other conditions.
> > > > > > > >
> > > > > > > > To avoid potential random writebacking of dirty page in journal which
> > > > > > > > cause unpredicted corrupting in journal.
> > > > > > > >
> > > > > > > > > Practically, the peak amount of journal writes depend on how many transactions
> > > > > > > > > are processing concurrently.
> > > > > > > > > I mean, in-memory pages are dropped at the end of every transaction.
> > > > > > > > > You can check the number of pages through f2fs_stat on your phone.
> > > > > > > > >
> > > > > > > > >> I didn't dig details, but I think there may be a little risk for this design.
> > > > > > > > >>
> > > > > > > > >>>
> > > > > > > > >>>> b) If we are out of memory, reclaimer tries to write page of journal db into
> > > > > > > > >>>> disk, it will destroy db file.
> > > > > > > > >>>
> > > > > > > > >>> I don't understand. Could you elaborate why journal writes can corrupt db?
> > > > > > > > >>
> > > > > > > > >> Normally, we keep pages of journal in memory, but partial page in journal
> > > > > > > > >> will be write out to device by reclaimer when out of memory. So this journal
> > > > > > > > >> may have valid data in its log head, but with corrupted data, then after
> > > > > > > > >> abnormal powe-cut, recovery with this journal before a transaction will
> > > > > > > > >> destroy db. Right?
> > > > > > > > >
> > > > > > > > > Just think about sqlite without this feature.
> > > > > > > > > Broken journal is pretty normal case for sqlite.
> > > > > > > >
> > > > > > > > Maybe, if it is caused by bug or design issue of software, no matter db system
> > > > > > > > or filesystem, we should try our best to fix it to avoid generating broken journals.
> > > > > > > >
> > > > > > > > >
> > > > > > > > >>>
> > > > > > > > >>>> c) Though, we have journal db file, we will face failure of recovering db
> file
> > > > > > > > >>>> from journal db due to ENOMEM or EIO, then db file will be corrupted.
> > > > > > > > >>>
> > > > > > > > >>> Do you mean the failure of recovering db with a complete journal?
> > > > > > > > >>> Why do we have to handle that? That's a database stuff, IMO.
> > > > > > > > >>
> > > > > > > > >> Yes, just list for indicating we will face the same issue which is hard to
> > > > > > > > >> handle both in original design and new design, so the inner revoking failure
> > > > > > > > >> issue would not be a weak point or flaw of new design.
> > > > > > > > >>
> > > > > > > > >>>
> > > > > > > > >>>> d) Recovery flow will make data page dirty, triggering both data stream and
> > > > > > > > >>>> metadata stream, there should be more IOs than in inner revoking in
> > > > > > > > >>>> atomic-interface.
> > > > > > > > >>>
> > > > > > > > >>> Well, do you mean there is no need to recover db after revoking?
> > > > > > > > >>
> > > > > > > > >> Yes, revoking make the same effect like the recovery of sqlite, so after
> > > > > > > > >> revoking, recovery is no need.
> > > > > > > > >
> > > > > > > > > Logically, it doesn't make sense. If there is a valid journal file, it should
> > > > > > > > > redo the previous transaction. No?
> > > > > > > >
> > > > > > > > As we know, in sqlite, before we commit a transaction, we will use journal to
> > > > > > > > record original data of pages which will be updated in following transaction,
> so
> > > > > > > > in following if a) abnormal power-cut, b) commit error, c) redo command was
> > > > > > > > triggered by user, we will recover db with journal.
> > > > > > > >
> > > > > > > > Ideally, if we support atomic write interface, in there should always return two
> > > > > > > > status in atomic write interface: success or fail. If success, transaction was
> > > > > > > > committed, otherwise, it looks like nothing happened, user will be told
> > > > > > > > transaction was failed. Then, journals in sqlite could no longer be used,
> > > > > > > > eventually no journal, no recovery.
> > > > > > > >
> > > > > > > > The only thing we should concern is inner failure (e.g. ENOMEM, ENOSPC) of
> > > > > > > > revoking in commit interface since it could destroy db file permanently w/o
> > > > > > > > journal. IMO, some optimization could be done for these cases:
> > > > > > > > 1. ENOMEM: enable retrying or mark accessed flag in page in advance.
> > > > > > > > 2. ENOSPC: preallocate blocks for node blocks and data blocks.
> > > > > > > >
> > > > > > > > These optimizations couldn't guarantee no failure in revoking operation
> > > > > > > > completely, luckily, those are not common cases, and they also happen in sqlite
> > > > > > > > w/o atomic feature.
> > > > > > > >
> > > > > > > > One more possible proposal is: if we support reflink feature like ocfs2/xfs, I
> > > > > > > > guess we can optimize DB like:
> > > > > > > > 1. reflink db to db.ref
> > > > > > > > 2. do transaction in db.ref
> > > > > > > >    - failed, rm db.ref
> > > > > > > >    - power-cut rm db.ref
> > > > > > > > 3. rename db.ref to db
> > > > > > > >
> > > > > > > > >
> > > > > > > > >> One more case is that user can send a command to abort current transaction,
> > > > > > > > >> it should be happened before atomic_commit operation, which could easily
> > > > > > > > >> handle with abort_commit ioctl.
> > > > > > > > >>
> > > > > > > > >>>
> > > > > > > > >>>> e) Moreover, there should be a hole between 1) commit fail and 2) abort write
> > > &
> > > > > > > > >>>> recover, checkpoint will persist the corrupt data in db file, following abnormal
> > > > > > > > >>>> power-cut will leave that data in disk.
> > > > > > > > >>>
> > > > > > > > >>> Yes, in that case, database should recover corrupted db with its journal file.
> > > > > > > > >>
> > > > > > > > >> Journal could be corrupted as I descripted in b).
> > > > > > > > >
> > > > > > > > > Okay, so what I'm thinking is like this.
> > > > > > > > > It seems there are two corruption cases after journal writes.
> > > > > > > > >
> > > > > > > > > 1. power cut during atomic writes
> > > > > > > > >  - broken journal file and clean db file -> give up
> > > > > > > > >  - luckily, valid journal file and clean db file -> recover db
> > > > > > > > >
> > > > > > > > > 2. error during atomic writes
> > > > > > > > >  a. power-cut before abort completion
> > > > > > > > >   - broken journal file and broken db file -> revoking is needed!
> > > > > > > > >
> > > > > > > > >  b. after abort
> > > > > > > > >   - valid journal file and broken db file -> recover db (likewise plain sqlite)
> > > > > > > > >
> > > > > > > > > Indeed, in the 2.a. case, we need revoking; I guess that's what you mentioned.
> > > > > > > > > But, I think, even if revoking is done, we should notify an error to abort and
> > > > > > > > > recover db by 2.b.
> > > > > > > > >
> > > > > > > > > Something like this after successful revoking.
> > > > > > > > >
> > > > > > > > > 1. power cut during atomic writes
> > > > > > > > >  - broken journal file and clean db file -> give up
> > > > > > > > >  - luckily, valid journal file and clean db file -> recover db
> > > > > > > > >
> > > > > > > > > 2. error during atomic writes w/ revoking
> > > > > > > > >  a. power-cut before abort completion
> > > > > > > > >   - broken journal file and clean db file -> give up
> > > > > > > > >   - luckily, valid journal file and clean db file -> recover db
> > > > > > > > >
> > > > > > > > >  b. after abort
> > > > > > > > >   - valid journal file and clean db file -> recover db
> > > > > > > >
> > > > > > > > That's right.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Let me verify these scenarios first. :)
> > > > > > > >
> > > > > > > > OK. :)
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > >>>
> > > > > > > > >>>> With revoking supported design, we can not solve all above issues, we will
> still
> > > > > > > > >>>> face the same issue like c), but it will be a big improve if we can apply
> this
> > > > > > > > >>>> in our interface, since it provide a way to fix the issue a) b) d). And also
> > > for
> > > > > > > > >>>> e) case, we try to rescue data in first time that our revoking operation
> would
> > > be
> > > > > > > > >>>> protected by f2fs_lock_op to avoid checkpoint + power-cut.
> > > > > > > > >>>>
> > > > > > > > >>>> If you don't want to have a big change in this interface or recovery flow,
> how
> > > > > > > > >>>> about keep them both, and add a mount option to control inner recovery flow?
> > > > > > > > >>>
> > > > > > > > >>> Hmm, okay. I believe the current design is fine for sqlite in android.
> > > > > > > > >>
> > > > > > > > >> I believe new design will enhance in memory usage and error handling of sqlite
> > > > > > > > >> in android, and hope this can be applied. But, I can understand that if you
> > > > > > > > >> were considerring about risk control and backward compatibility, since this
> > > > > > > > >> change affects all atomic related ioctls.
> > > > > > > > >>
> > > > > > > > >>> For other databases, I can understand that they can use atomic_write without
> > > > > > > > >>> journal control, which is a sort of stand-alone atomic_write.
> > > > > > > > >>>
> > > > > > > > >>> It'd better to add a new ioctl for that, but before adding it, can we find
> > > > > > > > >>> any usecase for this feature? (e.g., postgresql, mysql, mariadb, couchdb?)
> > > > > > > > >>
> > > > > > > > >> You mean investigating or we can only start when there is a clear commercial
> > > > > > > > >> demand ?
> > > > > > > > >>
> > > > > > > > >>> Then, I expect that we can define a more appropriate and powerful ioctl.
> > > > > > > > >>
> > > > > > > > >> Agreed :)
> > > > > > > > >>
> > > > > > > > >> Thanks,
> > > > > > > > >>
> > > > > > > > >>>
> > > > > > > > >>> Thanks,
> > > > > > > > >>>
> > > > > > > > >>>>
> > > > > > > > >>>> How do you think? :)
> > > > > > > > >>>>
> > > > > > > > >>>> Thanks,
> > > > > > > > >>>>
> > > > > > > > >>>>> But, unfortunately, it seems that something is missing in the
> > > > > > > > >>>>> current implementation.
> > > > > > > > >>>>>
> > > > > > > > >>>>> So simply how about this?
> > > > > > > > >>>>>
> > > > > > > > >>>>> A possible flow would be:
> > > > > > > > >>>>> 1. write journal data to volatile space
> > > > > > > > >>>>> 2. write db data to atomic space
> > > > > > > > >>>>> 3. in the error case, call ioc_abort_volatile_writes for both journal and
> db
> > > > > > > > >>>>>  - flush/fsync journal data to disk
> > > > > > > > >>>>>  - drop atomic data, and will be recovered by database with journal
> > > > > > > > >>>>>
> > > > > > > > >>>>> From cb33fc8bc30981c370ec70fe68871130109793ec Mon Sep 17 00:00:00 2001
> > > > > > > > >>>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > > >>>>> Date: Tue, 29 Dec 2015 15:46:33 -0800
> > > > > > > > >>>>> Subject: [PATCH] f2fs: fix f2fs_ioc_abort_volatile_write
> > > > > > > > >>>>>
> > > > > > > > >>>>> There are two rules to handle aborting volatile or atomic writes.
> > > > > > > > >>>>>
> > > > > > > > >>>>> 1. drop atomic writes
> > > > > > > > >>>>>  - we don't need to keep any stale db data.
> > > > > > > > >>>>>
> > > > > > > > >>>>> 2. write journal data
> > > > > > > > >>>>>  - we should keep the journal data with fsync for db recovery.
> > > > > > > > >>>>>
> > > > > > > > >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > > >>>>> ---
> > > > > > > > >>>>>  fs/f2fs/file.c | 13 ++++++++++---
> > > > > > > > >>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > > > > > >>>>>
> > > > > > > > >>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > > > >>>>> index 91f576a..d16438a 100644
> > > > > > > > >>>>> --- a/fs/f2fs/file.c
> > > > > > > > >>>>> +++ b/fs/f2fs/file.c
> > > > > > > > >>>>> @@ -1433,9 +1433,16 @@ static int f2fs_ioc_abort_volatile_write(struct file
> > > *filp)
> > > > > > > > >>>>>  	if (ret)
> > > > > > > > >>>>>  		return ret;
> > > > > > > > >>>>>
> > > > > > > > >>>>> -	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> > > > > > > > >>>>> -	clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
> > > > > > > > >>>>> -	commit_inmem_pages(inode, true);
> > > > > > > > >>>>> +	if (f2fs_is_atomic_file(inode)) {
> > > > > > > > >>>>> +		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
> > > > > > > > >>>>> +		commit_inmem_pages(inode, true);
> > > > > > > > >>>>> +	}
> > > > > > > > >>>>> +	if (f2fs_is_volatile_file(inode)) {
> > > > > > > > >>>>> +		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
> > > > > > > > >>>>> +		ret = commit_inmem_pages(inode, false);
> > > > > > > > >>>>> +		if (!ret)
> > > > > > > > >>>>> +			ret = f2fs_sync_file(filp, 0, LLONG_MAX, 0);
> > > > > > > > >>>>> +	}
> > > > > > > > >>>>>
> > > > > > > > >>>>>  	mnt_drop_write_file(filp);
> > > > > > > > >>>>>  	return ret;
> > > > > > > > >>>>> --
> > > > > > > > >>>>> 2.6.3
> > > > > > > > >>>>
> > > > > > > > >
> > > > > > > > > ------------------------------------------------------------------------------
> > > > > > > > > _______________________________________________
> > > > > > > > > Linux-f2fs-devel mailing list
> > > > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > > > > >
> > > > > > > >
> > > > > > > > ------------------------------------------------------------------------------
> > > > > > > > _______________________________________________
> > > > > > > > Linux-f2fs-devel mailing list
> > > > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > > >
> > > > > > ------------------------------------------------------------------------------
> > > > > > Site24x7 APM Insight: Get Deep Visibility into Application Performance
> > > > > > APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> > > > > > Monitor end-to-end web transactions and take corrective actions now
> > > > > > Troubleshoot faster and improve end-user experience. Signup Now!
> > > > > > http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> > > > > > _______________________________________________
> > > > > > Linux-f2fs-devel mailing list
> > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
