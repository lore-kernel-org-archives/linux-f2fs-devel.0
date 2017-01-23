From: Alex <ambroxa@yahoo.it>
Subject: f2fs_gc read and write continuously
Date: Mon, 23 Jan 2017 18:00:25 +0000 (UTC)
Message-ID: <1382755060.19135192.1485194425207@mail.yahoo.com>
References: <1382755060.19135192.1485194425207.ref@mail.yahoo.com>
Reply-To: Alex <ambroxa@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ambroxa@yahoo.it>) id 1cVjQW-0003M5-Lj
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jan 2017 18:33:14 +0000
Received: from omp1048.mail.ir2.yahoo.com ([212.82.98.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cVjQT-0004yC-BW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jan 2017 18:33:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Some days ago I've installed in my Raspberry PI 3 (a small board armhf based) a Debian Jessie distro ("Raspbian") with kernel 4.4.38

I've installed the O.S. in a microSD card, a 32GB Samsung EVO+ formatted with F2FS
Before this, the same system was running for 1 month with another microSD card (Sandisk Ultra) formatted with EXT4, without ANY problem. 
Now I would like to see if F2FS can bring me some benefit.

Using a Linux PC, I've simply copied with  rsync -axv  my Raspbian Jessie installation from old microSD to the new Samsung EVO+As said before, I've formatted the new root partition with F2FS instead of EXT4.
All works very fine and the new Samsung EVO+ is really very very fast. I'm very happy with it.

But I've a strange issue that, I think, involves F2FS
Raspberry board is equipped with a green LED that show microSD access. And now this green LED blink every second, like a metronome.

I've disabled all daemons and running  iotop -a  for 30 minutes. Every 1 minute f2fs_gc process increase DISK_READ and DISK_WRITE counter about 2 MBytes.
Swap is totally disabled.

Example after about 10 minutes:
  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    COMMAND                                                                                                                                                                        
  210 be/4 root         27.04 M     33.77 M  0.00 %  0.30 % [f2fs_gc-179:2]
 1048 be/4 root          0.00 B    584.00 K  0.00 %  0.10 % [kworker/u8:2]
 1475 be/4 root          4.00 K      0.00 B  0.00 %  0.00 % -bash
    1 be/4 root          0.00 B      0.00 B  0.00 %  0.00 % init
    2 be/4 root          0.00 B      0.00 B  0.00 %  0.00 % [kthreadd]
    3 be/4 root          0.00 B      0.00 B  0.00 %  0.00 % [ksoftirqd/0]
    5 be/0 root          0.00 B      0.00 B  0.00 %  0.00 % [kworker/0:0H]
 1030 be/0 root          0.00 B      0.00 B  0.00 %  0.00 % [kworker/0:1H]
    7 be/4 root          0.00 B      0.00 B  0.00 %  0.00 % [rcu_sched]
    8 be/4 root          0.00 B      0.00 B  0.00 %  0.00 % [rcu_bh]

NO processes are running and I expect no data are written or read to/from microSD

I've also disconnected for a while the ethernet network cable, but f2fs_gc still again to read and write without any reason.
I've reinstalled the old microSD and made a iotop comparison: with EXT4 there are no accesses to the card and green LED is not blinking.
Old and new system are identical except for root filesystem.


I've tried to disable F2FS garbage collect modifying my /etc/fstab as:

/dev/mmcblk0p2  /               f2fs    defaults,relatime,background_gc=off      0       1

without any success. Nothing change. iotop show a lot of I/O activity by f2fs_gc process.



Are iotop values dummy ? Are these real read/write to microSD  or not ?
I'm very confused. Any suggestion or idea ?


Thanks in advance for any infos.

Best regards.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
