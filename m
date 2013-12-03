From: Younger Liu <younger.liucn@gmail.com>
Subject: Re: [PATCH 0/2] f2fs: remove debufs dir if
 debugfs_create_file() failed
Date: Tue, 03 Dec 2013 19:50:34 +0800
Message-ID: <529DC58A.4010604@gmail.com>
References: <001001ceefeb$86ebb3b0$94c31b10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <younger.liucn@gmail.com>) id 1VnoV4-0004db-0A
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 11:50:46 +0000
Received: from mail-pa0-f50.google.com ([209.85.220.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VnoV2-0006EE-MT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Dec 2013 11:50:45 +0000
Received: by mail-pa0-f50.google.com with SMTP id kl14so2850359pab.37
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 03 Dec 2013 03:50:39 -0800 (PST)
In-Reply-To: <001001ceefeb$86ebb3b0$94c31b10$@samsung.com>
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
Cc: 'fs-devel' <linux-fsdevel@vger.kernel.org>, 'kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>


On 2013/12/3 13:49, Chao Yu wrote:
> Hi Liu,
>
> You're right, we should release it instead of holding the resource
> with no use. And here are some comments as following.
>
> BTW, your patch is out of format. You'd better not let remote
> terminal or editor to instead tab with blanks in the patch.
>
> Thanks,
> Yu
  Hi Yu,
  thanks for your review. I will modify the patch
and resent in a moment.
>> -----Original Message-----
>> From: Younger Liu [mailto:younger.liucn@gmail.com]
>> Sent: Monday, December 02, 2013 9:16 PM
>> To: Jaegeuk Kim
>> Cc: fs-devel; kernel; f2fs
>> Subject: [f2fs-dev] [PATCH 0/2] f2fs: remove debufs dir if debugfs_create_file() failed
>>
>> From: Younger Liu <liuyiyang@hisense.com>
>>
>> When debugfs_create_file() failed in f2fs_create_root_stats(),
>> debugfs_root should be removed.
>>
>> Signed-off-by: Younger Liu <liuyiyang@hisense.com>
>> Cc: Younger Liu <younger.liucn@gmail.com>
>> Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
>> ---
>>  fs/f2fs/debug.c |   20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
>> index a84b0a8..d27b689 100644
>> --- a/fs/f2fs/debug.c
>> +++ b/fs/f2fs/debug.c
>> @@ -340,10 +340,24 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
>>
>>  void __init f2fs_create_root_stats(void)
>>  {
>> +    struct dentry *file;
>> +
>>      debugfs_root = debugfs_create_dir("f2fs", NULL);
>> -    if (debugfs_root)
>> -        debugfs_create_file("status", S_IRUGO, debugfs_root,
>> -                     NULL, &stat_fops);
>> +    if (!debugfs_root)
>> +        goto bail;
>> +
>> +    file = debugfs_create_file("status", S_IRUGO,
>> +            debugfs_root, NULL, &stat_fops);
>> +    if (!file)
>> +        goto free_debugfs_dir;
>> +
>> +    return;
>> +
>> +free_debugfs_dir:
>> +    debugfs_remove(debugfs_root);
> debugfs_root = NULL;
>
>> +
>> +bail:
>> +    return;
>>  }
>>
>>  void f2fs_destroy_root_stats(void)
> You should judge debugfs_root value in f2fs_destroy_root_stats
> to decide free or not.
>
>> --
>> 1.7.9.5
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Rapidly troubleshoot problems before they affect your business. Most IT
>> organizations don't have a clear picture of how application performance
>> affects their revenue. With AppDynamics, you get 100% visibility into your
>> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
>> http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT 
> organizations don't have a clear picture of how application performance 
> affects their revenue. With AppDynamics, you get 100% visibility into your 
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
>

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
