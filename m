From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH 5/7] f2fs: enhance multithread dio write
	performance
Date: Thu, 17 Sep 2015 08:39:55 +0800
Message-ID: <55FA0BDB.5090104@huawei.com>
References: <000001d0ec5d$0bbd1880$23374980$@samsung.com>
	<20150915212044.GA84514@jaegeuk-mac02.mot.com>
	<000a01d0f068$c46012c0$4d203840$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZcNFS-0003t9-B0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 00:40:26 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZcNFN-0003QS-Fx
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 00:40:26 +0000
In-Reply-To: <000a01d0f068$c46012c0$4d203840$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2015/9/16 18:15, Chao Yu wrote:
> Hi Jaegeuk,
>
>> -----Original Message-----
>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>> Sent: Wednesday, September 16, 2015 5:21 AM
>> To: Chao Yu
>> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 5/7] f2fs: enhance multithread dio write performance
>>
>> Hi Chao,
>>
>> On Fri, Sep 11, 2015 at 02:41:53PM +0800, Chao Yu wrote:
>>> When dio writes perform concurrently, our performace will be low because of
>>> Thread A's allocation of multi continuous blocks will be break by Thread B,
>>> there are two cases as below:
>>>   - In Thread B, we may change current segment to a new segment for LFS
>>>     allocation if we dio write in the beginning of the file.
>>>   - In Thread B, we may allocate blocks in the middle of Thread A's
>>>     allocation, which make blocks which allocated in Thread A being
>>>     discontinuous.
>>>
>>> This patch adds writepages mutex lock to make block allocation in dio write
>>> atomic to avoid above issues.
>>>
>>> Test environment:
>>> ubuntu os with linux kernel 4.2+, intel i7-3770, 16g memory,
>>> 32g kingston sd card.
>>>
>>> fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs
>> --filesize=256m --size=16m --bs=2m --direct=1
>>> --numjobs=10
>>>
>>> before:
>>>    WRITE: io=163840KB, aggrb=3145KB/s, minb=314KB/s, maxb=411KB/s, mint=39836msec,
>> maxt=52083msec
>>>
>>> patched:
>>>    WRITE: io=163840KB, aggrb=10033KB/s, minb=1003KB/s, maxb=1124KB/s, mint=14565msec,
>> maxt=16329msec
>>>
>>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>>> ---
>>>   fs/f2fs/data.c | 13 ++++++++++---
>>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index a737ca5..a0a5849 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1536,7 +1536,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>   	struct file *file = iocb->ki_filp;
>>>   	struct address_space *mapping = file->f_mapping;
>>>   	struct inode *inode = mapping->host;
>>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>   	size_t count = iov_iter_count(iter);
>>> +	int rw = iov_iter_rw(iter);
>>>   	int err;
>>>
>>>   	/* we don't need to use inline_data strictly */
>>> @@ -1555,12 +1557,17 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter
>> *iter,
>>>
>>>   	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
>>>
>>> -	if (iov_iter_rw(iter) == WRITE)
>>> +	if (rw == WRITE) {
>>> +		mutex_lock(&sbi->writepages);
>>
>> Why do we have to share sbi->writepages?
>
> The root cause of this issue is that: in f2fs, we have no suitable
> dispatcher which can do the following things as an atomic operation:
> a) allocate position(s) in flash device for current block(s);
> b) submit user data in allocated position(s) in block layer.
>
> Without the dispatcher, we will suffer performance issue in following
> scenario:
> Thread A		Thread B		Thread C
> allocate pos+1
> 			allocate pos+2
> 						allocate pos+3
> submit pos+1
> 						submit pos+3
> 			submit pos+2
>
> Our final submitting series will: pos+1, pos+3, pos+2, this makes f2fs
> running into non-LFS mode, therefore resulting in bad performance.
>
> writepages mutex lock supply us with a good solution for above issue.
> It not only make the allocating and submitting pair executing atomically,
> but also reduce the fragmentation for one file since we submit blocks
> belong to single inode as continuous as possible.
>
> So here I choose to use writepages mutex lock to fix the performance
> issue caused by both dio write vs dio write and dio write vs buffered
> write.
>
> If I'm missing something, please correct me.
>
>>
>>>   		__allocate_data_blocks(inode, offset, count);
>>
>> If the problem lies on the misaligned blocks, how about calling mutex_unlock
>> here?
>
> When changing to unlock here, I got regression when testing with following command:
> fio --name seqw --ioengine=sync --invalidate=1 --rw=write --directory=/mnt/f2fs --filesize=256m --size=4m --bs=64k --direct=1
> --numjobs=20
>
> unlock here:
>    WRITE: io=81920KB, aggrb=5802KB/s, minb=290KB/s, maxb=292KB/s, mint=14010msec, maxt=14119msec
> unlock after dio finished:
>    WRITE: io=81920KB, aggrb=6088KB/s, minb=304KB/s, maxb=1081KB/s, mint=3786msec, maxt=13454msec
>
> So how about keep it in original place in this patch?

Does share writepages mutex lock have an effect on cache write? Here is AndroBench result on my phone:

Before patch:
				1R1W               8R8W               16R16W
Sequential Write               161.31             163.85              154.67
Random  Write                   9.48               17.66               18.09


After patch:
				1R1W               8R8W               16R16W
Sequential Write               159.61             157.24              160.11
Random  Write                   9.17               8.51                8.8

Unit:Mb/s, File size: 64M, Buffer size: 4k

>
> Thanks,
>>
>> Thanks,
>>
>>> +	}
>>>
>>>   	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
>>> -	if (err < 0 && iov_iter_rw(iter) == WRITE)
>>> -		f2fs_write_failed(mapping, offset + count);
>>> +	if (rw == WRITE) {
>>> +		mutex_unlock(&sbi->writepages);
>>> +		if (err)
>>> +			f2fs_write_failed(mapping, offset + count);
>>> +	}
>>>
>>>   	trace_f2fs_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), err);
>>>
>>> --
>>> 2.4.2
>
>
> ------------------------------------------------------------------------------
> Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
> Get real-time metrics from all of your servers, apps and tools
> in one place.
> SourceForge users - Click here to start your Free Trial of Datadog now!
> http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> .
>


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
