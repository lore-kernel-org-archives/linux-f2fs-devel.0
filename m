From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: Data lost in Android app for not write new checkpoint
Date: Fri, 31 Jul 2015 14:18:40 +0800
Message-ID: <01a301d0cb58$dda73db0$98f5b910$@samsung.com>
References: <55BADD52.9060901@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZL3fM-0001MN-JD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 06:19:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZL3fK-0005vr-Er
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 06:19:36 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSC00W7K9K8W2D0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 15:19:27 +0900 (KST)
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
To: 'He YunLei' <heyunlei@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

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

One way to keep data consistent is invoking fsync() after writing, after that, data will be 
recoverable even though there occurs abnormal pow-cut or kernel crash.

So can you help to check whether the camera app *fsync* the photo file to storage for persistence?
If there is no such invoking, our photos may be lost, otherwise there may be a bug in f2fs.

BTW, checkpoint can only keep persistence with FS metadata (data in META/NODE inode), metadata/data
of directory inode and metadata of other inode, but not the data of regular/symlink inode which is
in memory. So seems simply calling a checkpoint doesn't help.

Thanks,

> 	I think this problem is bad for user experience of using Android phone with f2fs.
> How do we deal with such situation? I wish you and other developers in this list could help
> me in a correct way.
> 
> Thanks,
> He



------------------------------------------------------------------------------
