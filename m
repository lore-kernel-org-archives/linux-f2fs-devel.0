From: He YunLei <heyunlei@huawei.com>
Subject: Data lost in Android app for not write new checkpoint
Date: Fri, 31 Jul 2015 10:28:34 +0800
Message-ID: <55BADD52.9060901@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZL04O-0001sV-G7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 02:29:12 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZL04K-0007YQ-4p
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Jul 2015 02:29:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>

Hi all,
	Recently I did some test with f2fs on my Android phone, and found a problem
which I didn't know how to tackle it.
	I use my Android phone with /data partition formatted  by mkfs.f2fs. When the
phone just started, I check the f2fs status by reading the file /sys/kernel/debug/f2fs/status
in debugfs.
	
CP calls: 10
GC calls: 19 (BG: 19)
   - data segments : 19 (19)
   - node segments : 0 (0)

	We can see /data partition has done 10 times write_checkpoint since f2fs is mounted
on the phone, it also has triggered 19 times background GC.

******

Here I took some photos consecutively, and check the file /sys/kernel/debug/f2fs/status again

******

CP calls: 10
GC calls: 20 (BG: 20)
   - data segments : 20 (20)
   - node segments : 0 (0)
	
	there is no change in CP calls number and background GC doesn't write new checkpoint.
if then a sudden power failure or system crash occur, the photos will be lost when the phone
restart, and a sync before crash will avoid the data lost.
	I think this problem is bad for user experience of using Android phone with f2fs.
How do we deal with such situation? I wish you and other developers in this list could help
me in a correct way.

Thanks,
He



------------------------------------------------------------------------------
