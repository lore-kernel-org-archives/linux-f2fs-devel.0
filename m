From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [RFC PATCH 2/2] f2fs: export a threshold in sysfs for
 controlling dio serialization
Date: Wed, 13 Jan 2016 14:57:37 +0800
Message-ID: <00d901d14dcf$c737d8b0$55a78a10$@samsung.com>
References: <006e01d14157$68bc0dd0$3a342970$@samsung.com>
 <20151228225204.GB61500@jaegeuk.local>
 <00c701d14203$b85f1830$291d4890$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <00c701d14203$b85f1830$291d4890$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Tuesday, December 29, 2015 2:39 PM
> To: 'Jaegeuk Kim'
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [RFC PATCH 2/2] f2fs: export a threshold in sysfs for controlling dio
> serialization
> 
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, December 29, 2015 6:52 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 2/2] f2fs: export a threshold in sysfs for controlling dio serialization
> >
> > Hi Chao,
> >
> > On Mon, Dec 28, 2015 at 06:05:45PM +0800, Chao Yu wrote:
> > > As Yunlei He reported when he test with the patch ("f2fs: enhance
> > > multithread dio write performance"):
> > > "Does share writepages mutex lock have an effect on cache write?
> > > Here is AndroBench result on my phone:
> > >
> > > Before patch:
> > > 			1R1W		8R8W		16R16W
> > > Sequential Write	161.31		163.85		154.67
> > > Random  Write		9.48		17.66		18.09
> > >
> > > After patch:
> > > 			1R1W		8R8W		16R16W
> > > Sequential Write	159.61		157.24		160.11
> > > Random  Write		9.17		8.51		8.8
> > >
> > > Unit:Mb/s, File size: 64M, Buffer size: 4k"
> > >
> > > The turth is androidbench uses single thread with dio write to test performance
> > > of sequential write, and use multi-threads with dio write to test performance
> > > of random write. so we can not see any improvement in sequentail write test
> > > since serializing dio page allocation can only improve performance in
> > > multi-thread scenario, and there is a regression in multi-thread test with 4k
> > > dio write, this is because grabbing sbi->writepages lock for serializing block
> > > allocation stop the concurrency, so that less small dio bios could be merged,
> > > moreover, when there are huge number of small dio writes, grabbing mutex lock
> > > per dio increases the overhead.
> > >
> > > After all, serializing dio could only be used for concurrent scenario of
> > > big dio, so this patch introduces a threshold in sysfs to provide user the
> > > interface of defining 'a big dio' with specified page number, which could
> > > be used to control wthether serialize or not that kind of dio with specified
> > > page number.
> >
> > Can you merge two patches together?
> 
> OK.
> 
> >
> > And, if this is correct, can we investigate the lock effect in
> > f2fs_write_data_pages too?
> >
> > What if we add a condition for the lock like this?
> >
> > 	if (get_dirty_pages(inode) > serialzed_pages)
> > 		mutex_lock();
> 
> Agreed, I will investigate it.

Sorry for the delay.

I have did some tests with following modification as you mentioned, but
sadly it causes a performance regression.

As blktrace & blkiomon shows, there are more small size reqs submitted from
block layer if we do not serialize IOs, I guess that would be the main reason
of regression.

a) OPU
Test #1:
Environmemt: note4 emmc
fio --name randw --ioengine=sync --invalidate=1 --rw=randwrite --randseed=2015 --directory=/data/test/dir/ --filesize=256m
--size=16m --bsrang=32k-1024k --direct=0 --numjobs=32 --fsync=1 --end_fsync=1

		serialize all		serialize partial	serialize none
threshold	0 			64			256
1		27121			24922			23491
2		25664			25165			22828
3		27426			24916			24609
4		31871			25046			22410
5		26304			25747			22410
average		27677.2			25159.2			23149.6

Unit: KB/s

Test #2:
Environmemt: 4GB zram
time fs_mark  -t  16  -L  1  -s  8192  -S  1  -d  /mnt/f2fs/

-s		threshold	no serialization	serialization
4096		1		1.582			1.547
8192 		2		1.632			1.669
16384		4		1.577			1.491
32768		8		1.560			1.551
65536		16		1.984			1.849
131072		32		3.590			3.347
262144		64		6.360			5.352
524288		128		6.502			4.668
1048576		256		6.518			4.488
2097152		512		6.422			4.717

Unit: second

b) IPU
fio --name randw --ioengine=sync --invalidate=1 --rw=randwrite --randseed=2015 --directory=/data/test/dir/ --filesize=16m --size=16m
--bsrang=32k-1024k --direct=0 --numjobs=32 --fdatasync=1 --end_fsync=1
fio --name randw --ioengine=sync --invalidate=1 --rw=write --directory=/data/test/dir/ --filesize=16m --size=16m --bs=2m --direct=0
--numjobs=32

		serialize all		serialize partial	serialize none
threshold	0 			64			256
1		35763			33649			33124
2		39304			35097			33326
3		35731			33956			32405
4		33855			33943			36890
5		33857			33881			35128
average		35702			34105.2			34174.6

Unit: KB/s

---
 fs/f2fs/data.c  | 6 ++++--
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/super.c | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1c5c5c3..29f2a91 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1365,8 +1365,10 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	diff = nr_pages_to_write(sbi, DATA, wbc);
 
 	if (!S_ISDIR(inode->i_mode)) {
-		mutex_lock(&sbi->writepages);
-		locked = true;
+		if (get_dirty_pages(inode) > sbi->serialized_buf_pages) {
+			mutex_lock(&sbi->writepages);
+			locked = true;
+		}
 	}
 	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
 	f2fs_submit_merged_bio(sbi, DATA, WRITE);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4a89f19..e608c62 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -336,6 +336,7 @@ enum {
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
 #define DEF_SERIALIZED_DIO_PAGES	64	/* default serialized dio pages */
+#define DEF_SERIALIZED_BUF_PAGES	64	/* default serialized buf pages */
 
 /* vector size for gang look-up from extent cache that consists of radix tree */
 #define EXT_TREE_VEC_SIZE	64
@@ -798,6 +799,7 @@ struct f2fs_sb_info {
 	int active_logs;			/* # of active logs */
 	int dir_level;				/* directory level */
 	int serialized_dio_pages;		/* serialized direct IO pages */
+	int serialized_buf_pages;		/* serialized buffered IO pages */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9e0e80d..f7d8e51c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -221,6 +221,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, serialized_dio_pages, serialized_dio_pages);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, serialized_buf_pages, serialized_buf_pages);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -237,6 +238,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(serialized_dio_pages),
+	ATTR_LIST(serialized_buf_pages),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
 	ATTR_LIST(cp_interval),
@@ -1129,6 +1131,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
 	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
 	sbi->serialized_dio_pages = DEF_SERIALIZED_DIO_PAGES;
+	sbi->serialized_buf_pages = DEF_SERIALIZED_BUF_PAGES;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	INIT_LIST_HEAD(&sbi->s_list);
-- 
2.6.3

Then I did a quick test in zram by using fs_mark with following method:
1) use blk_plug in ->writepages;
2) decrease granularity of sbi->writepages: for user defined small IOs, we
move sbi->writepages into do_write_page.

Unfortunately, also cause a regression. So I'm still looking for the right
way to improve concurrency with small impaction on performance.

BTW, for IPU, no serialization affects lesser on performance, maybe we could
try:

if (!need_ipu || holes_exist_in_file)
	mutex_lock(&sbi->writepages);

Thanks,

> 
> Thanks,
> 
> >
> > Thanks,
> >
> > >
> > > Though, this is only RFC patch since the optimization works in rare scenario.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
> > >  fs/f2fs/data.c                          |  3 ++-
> > >  fs/f2fs/f2fs.h                          |  3 +++
> > >  fs/f2fs/super.c                         |  3 +++
> > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs
> > b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > index 0345f2d..560a4f1 100644
> > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > @@ -92,3 +92,15 @@ Date:		October 2015
> > >  Contact:	"Chao Yu" <chao2.yu@samsung.com>
> > >  Description:
> > >  		 Controls the count of nid pages to be readaheaded.
> > > +
> > > +What:		/sys/fs/f2fs/<disk>/serialized_dio_pages
> > > +Date:		December 2015
> > > +Contact:	"Chao Yu" <chao2.yu@samsung.com>
> > > +Description:
> > > +		 It is a threshold with the unit of page size.
> > > +                 If DIO page count is equal or big than the threshold,
> > > +                 whole process of block address allocation of dio pages
> > > +                 will become atomic like buffered write.
> > > +                 It is used to maximize bandwidth utilization in the
> > > +                 scenario of concurrent write with dio vs buffered or
> > > +                 dio vs dio.
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 6b24446..abcd100 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1660,7 +1660,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter,
> > >  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
> > >
> > >  	if (rw == WRITE) {
> > > -		bool serialized = (F2FS_BYTES_TO_BLK(count) >= 64);
> > > +		bool serialized = (F2FS_BYTES_TO_BLK(count) >=
> > > +						sbi->serialized_dio_pages);
> > >
> > >  		if (serialized)
> > >  			mutex_lock(&sbi->writepages);
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 3406e99..8f35dd7 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -333,6 +333,8 @@ enum {
> > >
> > >  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
> > >
> > > +#define DEF_SERIALIZED_DIO_PAGES	64	/* default serialized dio pages */
> > > +
> > >  /* vector size for gang look-up from extent cache that consists of radix tree */
> > >  #define EXT_TREE_VEC_SIZE	64
> > >
> > > @@ -784,6 +786,7 @@ struct f2fs_sb_info {
> > >  	unsigned int total_valid_inode_count;	/* valid inode count */
> > >  	int active_logs;			/* # of active logs */
> > >  	int dir_level;				/* directory level */
> > > +	int serialized_dio_pages;		/* serialized direct IO pages */
> > >
> > >  	block_t user_block_count;		/* # of user blocks */
> > >  	block_t total_valid_block_count;	/* # of valid blocks */
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 75704d9..ebe9bd4 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -218,6 +218,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
> > >  F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, serialized_dio_pages, serialized_dio_pages);
> > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
> > >
> > >  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> > > @@ -234,6 +235,7 @@ static struct attribute *f2fs_attrs[] = {
> > >  	ATTR_LIST(min_fsync_blocks),
> > >  	ATTR_LIST(max_victim_search),
> > >  	ATTR_LIST(dir_level),
> > > +	ATTR_LIST(serialized_dio_pages),
> > >  	ATTR_LIST(ram_thresh),
> > >  	ATTR_LIST(ra_nid_pages),
> > >  	ATTR_LIST(cp_interval),
> > > @@ -1125,6 +1127,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
> > >  		atomic_set(&sbi->nr_pages[i], 0);
> > >
> > >  	sbi->dir_level = DEF_DIR_LEVEL;
> > > +	sbi->serialized_dio_pages = DEF_SERIALIZED_DIO_PAGES;
> > >  	sbi->cp_interval = DEF_CP_INTERVAL;
> > >  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
> > >
> > > --
> > > 2.6.3
> > >
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
