From: Marc Lehmann <schmorp@schmorp.de>
Subject: SMR drive test 3: full 8TB partition, mount problems,
 fsck error after delete
Date: Tue, 22 Sep 2015 22:22:02 +0200
Message-ID: <20150922202202.GA2456@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZeU4q-00020l-Q1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 20:22:12 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZeU4n-0006nL-Rj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 20:22:12 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZeU4g-0000wp-SI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 20:22:02 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZeU4g-0000n2-Mv
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 20:22:02 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZeU4g-0000fL-M2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 22:22:02 +0200
Content-Disposition: inline
In-Reply-To: <20150921095806.GA6809@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Third test, using the full device, on linux 4.2.1

   mkfs.f2fs -l COLD1 -o1 -a0 -d1 -s128 /dev/mapper/xmnt-cold1
   mount -tf2fs -onoatime,flush_merge,active_logs=2,no_heap /dev/mapper/xmnt-cold1 /cold1

Unfortunately, mount failed with. The kernel showed that a high order
allocation could not be satisfied:

   mount: page allocation failure: order:7, mode:0x40d0
   ...
   F2FS-fs (dm-18): Failed to initialize F2FS segment manager
   (http://data.plan9.de/f2fs-mount-failure.txt)

I think this memory management is a real problem - the server was booted
about 20 minutes earlier and had 23GB free ram (used for cache). I was able
to mount it by dropping the page cache, but clearly this shouldn't be
neccessary.

After this, df showed 185GB in use, which is more like 3%, not 1% - again
overprovisioning seems to be out of bounds.

I started copying files with tar|tar, after 10GB, I restarted, which started
to overwrite the existing 10GB files.

Unfortunately, this time the GC kicked in every 10-20 seconds, slowing down
writing times. I don't know what triggered it this time, but I am quite sure
at less than 1% utilisation it shouldn't feel the need to gc while the disk
is busy writing.

After 90GB were written, I decided to simulate a disk problem by deleting
the device (to avoid any corruption issues the disk itself might have):

   echo 1 >/sys/block/sde/device/delete

After rescanning the device, I used fsck.f2fs on it, and it failed quickly:

   Info: superblock features = 0 : 
   Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
   Info: total FS sectors = 15628050432 (7630884 MB)
   Info: CKPT version = 2
   [ASSERT] (restore_node_summary: 688) ret >= 0
   [Exit 255] 

Re-running it with -f failed differently, but also quickly:

   Info: superblock features = 0 : 
   Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
   Info: total FS sectors = 15628050432 (7630884 MB)
   Info: CKPT version = 2
   [ASSERT] (get_current_sit_page: 803) ret >= 0
   [Exit 255] 

I'll reformat and try without any simulated problems.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
