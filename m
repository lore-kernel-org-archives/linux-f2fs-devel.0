From: Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH] f2fs: Add offset check routine before
 punch_hole() in f2fs_fallocate()
Date: Tue, 21 Apr 2015 15:44:21 +0900
Message-ID: <CAMArcTU5gicMwEk2C+X4=MwamBz6z5M+UrgWd44mKAm659hAEg@mail.gmail.com>
References: <1429519574-5110-1-git-send-email-ap420073@gmail.com>
	<00db01d07bf5$89385a00$9ba90e00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ap420073@gmail.com>) id 1YkRv2-0002y6-AP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Apr 2015 06:44:28 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YkRv1-0007n5-3b
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Apr 2015 06:44:28 +0000
Received: by widdi4 with SMTP id di4so126511417wid.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Apr 2015 23:44:21 -0700 (PDT)
In-Reply-To: <00db01d07bf5$89385a00$9ba90e00$@samsung.com>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

2015-04-21 14:38 GMT+09:00 Chao Yu <chao2.yu@samsung.com>:
> Hi Taehee,
>
>> -----Original Message-----
>> From: Taehee Yoo [mailto:ap420073@gmail.com]
>> Sent: Monday, April 20, 2015 4:46 PM
>> To: jaegeuk@kernel.org; cm224.lee@samsung.com; linux-f2fs-devel@lists.sourceforge.net
>> Subject: [f2fs-dev] [PATCH] f2fs: Add offset check routine before punch_hole() in
>> f2fs_fallocate()
>>
>> In the punch_hole(), if offset bigger than inode size, it returns SUCCESS.
>> Then f2fs_fallocate() will update time and dirty mark.
>> In that case, inode has not been modified actually.
>> So I have added offset check routine that prevent to call the punch_hole().
>
> Nice catch!
>
> This patch makes size verification in punch_hole() redundant, how about removing
> it?
>
> Thanks,
>
>>
>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>> ---
>>  fs/f2fs/file.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index a6f3f61..6470831 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -830,15 +830,19 @@ static long f2fs_fallocate(struct file *file, int mode,
>>                               loff_t offset, loff_t len)
>>  {
>>       struct inode *inode = file_inode(file);
>> -     long ret;
>> +     long ret = 0;
>>
>>       if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>               return -EOPNOTSUPP;
>>
>>       mutex_lock(&inode->i_mutex);
>>
>> -     if (mode & FALLOC_FL_PUNCH_HOLE)
>> +     if (mode & FALLOC_FL_PUNCH_HOLE) {
>> +             if (offset >= inode->i_size)
>> +                     goto out;
>> +
>>               ret = punch_hole(inode, offset, len);
>> +     }
>>       else
>>               ret = expand_inode_data(inode, offset, len, mode);
>>
>> @@ -847,6 +851,7 @@ static long f2fs_fallocate(struct file *file, int mode,
>>               mark_inode_dirty(inode);
>>       }
>>
>> +out:
>>       mutex_unlock(&inode->i_mutex);
>>
>>       trace_f2fs_fallocate(inode, mode, offset, len, ret);
>> --
>> 1.9.1
>>
>
>

I agree with your idea. and I will send V2 patch soon.

Thanks a lot for your review!

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
