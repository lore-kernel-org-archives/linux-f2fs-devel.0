From: He YunLei <heyunlei@huawei.com>
Subject: Re: Dwrite with non-aligned offset and size
Date: Thu, 16 Jul 2015 10:57:55 +0800
Message-ID: <55A71DB3.30102@huawei.com>
References: <556C481C.1050400@huawei.com>
	<20150601230155.GB28650@jaegeuk-mac02.mot.com>
	<556D2F38.4040304@huawei.com>
	<000901d0b566$aeed8e00$0cc8aa00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZFZP3-00033F-PI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 03:00:05 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZFZOz-0001tB-LG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jul 2015 03:00:05 +0000
In-Reply-To: <000901d0b566$aeed8e00$0cc8aa00$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2015/7/3 16:02, Chao Yu wrote:
> Hi Yunlei,
>
> Sorry for the long delay.
>
>> -----Original Message-----
>> From: He YunLei [mailto:heyunlei@huawei.com]
>> Sent: Tuesday, June 02, 2015 12:21 PM
>> To: Jaegeuk Kim
>> Cc: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Subject: Re: [f2fs-dev] Dwrite with non-aligned offset and size
>>
>> On 2015/6/2 7:01, Jaegeuk Kim wrote:
>>> On Mon, Jun 01, 2015 at 07:55:08PM +0800, He YunLei wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> We run ltp testcase with f2fs and obtain a TFAIL in diotest4, the result in detail is
>>>> as fallow:
>>>>
>>>> dio04
>>>>
>>>> <<<test_start>>>
>>>> tag=dio04 stime=1432278894
>>>> cmdline="diotest4"
>>>> contacts=""
>>>> analysis=exit
>>>> <<<test_output>>>
>>>> diotest4    1  TPASS  :  Negative Offset
>>>> diotest4    2  TPASS  :  removed
>>>> diotest4    3  TFAIL  :  diotest4.c:129: write allows odd count.returns 1: Success
>>>> diotest4    4  TFAIL  :  diotest4.c:183: Odd count of read and write
>>>> diotest4    5  TPASS  :  Read beyond the file size
>>>> ......
>>>>
>>>> the result of ext4 with same environment:
>>>>
>>>> dio04
>>>>
>>>> <<<test_start>>>
>>>> tag=dio04 stime=1432259643
>>>> cmdline="diotest4"
>>>> contacts=""
>>>> analysis=exit
>>>> <<<test_output>>>
>>>> diotest4    1  TPASS  :  Negative Offset
>>>> diotest4    2  TPASS  :  removed
>>>> diotest4    3  TPASS  :  Odd count of read and write
>>>> diotest4    4  TPASS  :  Read beyond the file size
>>>> ......
>>>>
>>>> Does f2fs allow dwrite with non-aligned offset and size? I check the code and found
>>>> dwrite with non-aligned offset and size will turn into buffered write. Whether it will
>>>> have some impact on user layer applications?
>>>
>>> It's not a big deal to return -EINVAL.
>>> When I take a look at other filesystem behaviors, it seems there is no restriction.
>>>
>>
>> Ext4 do a check in the function do_blockdev_direct_IO:
>>
>>            if (align & blocksize_mask) {
>>                if (bdev)
>>                    blkbits = blksize_bits(bdev_logical_block_size(bdev));
>>                blocksize_mask = (1 << blkbits) - 1;
>>                if (align & blocksize_mask)
>>                    goto out;
>>            }
>>
>> It will return -EINVAL if the alignment is not satisfied.
>
> I think we can get hint from the error case description in write(2) manual:
>
> "EINVAL  fd is attached to an object which is unsuitable for writing; or the file
> was  opened with the O_DIRECT flag, and either the address specified in buf, the
> value specified in count, or the current file offset is not suitably aligned."
>
> So if the alignment is not satisfied, we should return '-EINVAL' instead of
> letting user fall back to buffered write.
>
> Do you have time to make and send us a patch for fixing this issue?
>
> Thanks,
>
In man page of open(2)
	
The O_DIRECT flag may impose alignment restrictions on the length and
address of user-space buffers and the file offset of I/Os.  In Linux
alignment restrictions vary by filesystem and kernel version and
might be absent entirely.  However there is currently no
filesystem-independent interface for an application to discover these
restrictions for a given file or filesystem.

So now I don't know which one is better, falling back to buffered write or not?
>>
>> In f2fs, it do the check by check_direct_IO() before blockdev_direct_IO().
>> The difference between the two methods is whether turn dwrite with non-aligned
>> offset and size into buffered write. I am not very clear which one is better!
>>
>> Thanks,
>> He
>>
>>>>
>>>> I wrote a patch, not well tested, how do you think of it?
>>>
>>> Returning the error number would be good to me.
>>> Could you write and sumbit a complete one?
>>>
>>> Thanks,
>>>
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 9bedfa8..ba5d94c 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -2010,8 +2010,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>>           if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
>>>>                   return 0;
>>>>
>>>> -       if (check_direct_IO(inode, iter, offset))
>>>> -               return 0;
>>>> +       err = check_direct_IO(inode, iter, offset)
>>>> +       if (err)
>>>> +               return -EINVAL;
>>>>
>>>>           trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
>>>>
>>>> I wish you and other developers in this list could help me in a correct way.
>>>>
>>>> Thanks,
>>>> He
>>>
>>> .
>>>
>>
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
>
> .
>


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
