From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: f2fs space usage
Date: Thu, 23 Jan 2014 17:32:47 +0800
Message-ID: <52E0E1BF.9090409@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris.ruehl@gtsys.com.hk>) id 1W6Gtf-00082S-MA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 09:48:27 +0000
Received: from [202.130.89.98] (helo=fpa01n0.fpasia.hk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W6Gtb-0003Zp-I5 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 09:48:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net

Hi Kim,

I recently work with f2fs and wondering about the system usage.
I have a NAND flash 128MB on my SoC used for uBoot and a root
partion (f2fs)

when I install the busybox binaries I nearly run out of space
busybox binary

root@gtsir24:/mnt# du -sh /mnt/.
4.8M    /mnt/.

but df -h show a 97% usage

root@gtsir24:/mnt# df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          3.6G  574M  2.8G  17% /
/dev/root       3.6G  574M  2.8G  17% /
devtmpfs        125M     0  125M   0% /dev
tmpfs            25M  156K   25M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs            50M     0   50M   0% /run/shm
/dev/mtdblock4  119M  101M  3.3M  97% /mnt

I'm running a next-20140115.

Can you comment please.
Chris

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
