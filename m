From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: Data lost in Android app for not write new checkpoint
Date: Fri, 31 Jul 2015 18:49:46 +0800
Message-ID: <01a401d0cb7e$bc483130$34d89390$@samsung.com>
References: <55BADD52.9060901@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZL7th-0002qc-I3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 10:50:41 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZL7tf-0006jY-L0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 10:50:41 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSC00NGRM439Q00@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 19:50:31 +0900 (KST)
In-reply-to: <55BADD52.9060901@huawei.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Bintian' <bintian.wang@huawei.com>, 'He YunLei' <heyunlei@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Bintian,

> -----Original Message-----
> From: He YunLei [mailto:heyunlei@huawei.com]
> Sent: Friday, July 31, 2015 10:29 AM
> To: linux-f2fs-devel@lists.sourceforge.net; Jaegeuk Kim
> Cc: Chao Yu; cm224.lee@samsung.com; Bintian
> Subject: [f2fs-dev] Data lost in Android app for not write new checkpoint
> 
> Hi all,
> 	Recently I did some test with f2fs on my Android phone, and found a problem
> which I didn't know how to tackle it.
> 	I use my Android phone with /data partition formatted  by mkfs.f2fs. When the
> phone just started, I check the f2fs status by reading the file /sys/kernel/debug/f2fs/status
> in debugfs.
> 
> CP calls: 10
> GC calls: 19 (BG: 19)
>    - data segments : 19 (19)
>    - node segments : 0 (0)
> 
> 	We can see /data partition has done 10 times write_checkpoint since f2fs is mounted
> on the phone, it also has triggered 19 times background GC.
> 
> ******
> 
> Here I took some photos consecutively, and check the file /sys/kernel/debug/f2fs/status again
> 
> ******
> 
> CP calls: 10
> GC calls: 20 (BG: 20)
>    - data segments : 20 (20)
>    - node segments : 0 (0)
> 
> 	there is no change in CP calls number and background GC doesn't write new checkpoint.
> if then a sudden power failure or system crash occur, the photos will be lost when the phone
> restart, and a sync before crash will avoid the data lost.
> 	I think this problem is bad for user experience of using Android phone with f2fs.
> How do we deal with such situation? I wish you and other developers in this list could help
> me in a correct way.

IMO, it's better to figure out whether this is a bug of f2fs first or not.

You can enable some traces in f2fs to see whether fsync is called or not.

enable trace by:
echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_sync_file_enter/enable
echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_sync_file_exit/enable
print trace by:
cat /sys/kernel/debug/tracing/trace

If fsync is not be called, I think in ext4 there must be the same problem,
but I guess fortunately journal commit thread save its data since it commit
transaction per 5 second by default. You can try to configure (commit=nrsec)
it with larger value for verification the issue with ext4 filesystem.

As a quick thought, maybe we can add one commit data thread, periodically
writebacking user data written by user previously, then do checkpoint for
persistence.

So by this way, at most, we just lose our data for last configured time of
commit period.

Thanks,

> 
> Thanks,
> He



------------------------------------------------------------------------------
